/*=======================================================================================*/
/*  This Sail RISC-V architecture model, comprising all files and                        */
/*  directories except where otherwise noted is subject the BSD                          */
/*  two-clause license in the LICENSE file.                                              */
/*                                                                                       */
/*  SPDX-License-Identifier: BSD-2-Clause                                                */
/*=======================================================================================*/

/* address ranges */

// [min, max) of the matching range, in units of 4 bytes.
type pmp_addr_range_in_words = option((xlenbits, xlenbits))

function pmpAddrRange(cfg: Pmpcfg_ent, pmpaddr: xlenbits, prev_pmpaddr: xlenbits) -> pmp_addr_range_in_words = {
  match pmpAddrMatchType_of_bits(cfg[A]) {
    OFF   => None(),
    TOR   => { Some ((prev_pmpaddr, pmpaddr)) },
    NA4   => {
               // NA4 is not selectable when the PMP grain G >= 1. See pmpWriteCfg().
               assert(sys_pmp_grain() < 1, "NA4 cannot be selected when PMP grain G >= 1.");
               let lo = pmpaddr;
               Some((lo, lo + 4))
             },
    NAPOT => {
               // Example pmpaddr: 0b00010101111
               //                          ^--- last 0 dictates region size & alignment
               let mask = pmpaddr ^ (pmpaddr + 1);
               // pmpaddr + 1:     0b00010110000
               // mask:            0b00000011111
               // ~mask:           0b11111100000
               let lo   = pmpaddr & (~ (mask));
               // mask + 1:        0b00000100000
               let len  = mask + 1;
               Some((lo, (lo + len)))
             }
  }
}

/* permission checks */

val pmpCheckRWX: (Pmpcfg_ent, AccessType(ext_access_type)) -> bool
function pmpCheckRWX(ent, acc) = {
  match acc {
    Read(_)      => ent[R] == 0b1,
    Write(_)     => ent[W] == 0b1,
    ReadWrite(_) => ent[R] == 0b1 & ent[W] == 0b1,
    Execute()    => ent[X] == 0b1
  }
}

/* this needs to be called with the effective current privilege */
// YIQUN: different with PR
// YIQUN: meaning of effect {rreg} and can be removed cuz
// Since Sail 0.15 (released Nov 2022), effects have had no effect.
// They now generate a deprecation warning. This commit removes all the
// effect annotations from the model, thus fixing the compiler warnings.
val pmpCheckPerms: (Pmpcfg_ent, AccessType(ext_access_type), Privilege) -> bool
function pmpCheckPerms(ent, acc, priv) = {
  match mseccfg.MML() {
    0b1 =>
      match (ent.L(), ent.R(), ent.W(), ent.X()) {
        (0b1, 0b0, 0b1, _) =>
          match acc {
            Execute(_) => true,
            Read(_)    => priv == Machine & ent.X() == 0b1,
            _          => false
          },
        (0b0, 0b0, 0b1, _) =>
          match acc {
            Read(_)  => true,
            Write(_) => priv == Machine | ent.X() == 0b1,
            _        => false
          },
        (0b1, 0b1, 0b1, 0b1) =>
          match acc {
            Read(_) => true,
            _       => false
          },
        (_, _, _, _) =>
          if (priv == Machine) == pmpLockBit(ent)
          then pmpCheckRWX(ent, acc)
          else false
      },
    0b0 =>
      match priv {
        Machine =>
          if pmpLockBit(ent)
          then pmpCheckRWX(ent, acc)
          else true,
        _       => pmpCheckRWX(ent, acc)
      }
  }
}

/* matching logic */

enum pmpAddrMatch = {PMP_NoMatch, PMP_PartialMatch, PMP_Match}

function pmpMatchAddr(addr: xlenbits, width: xlenbits, rng: pmp_addr_range_in_words) -> pmpAddrMatch = {
  match rng {
    None()         => PMP_NoMatch,
    Some((lo, hi)) => {
      // Convert to integers.
      let addr  = unsigned(addr);
      let width = unsigned(width);
      // These are in units of 4 bytes.
      let lo = unsigned(lo) * 4;
      let hi = unsigned(hi) * 4;

      if   hi <= lo   /* to handle mis-configuration */
      then PMP_NoMatch
      else {
        if      (addr + width <= lo) | (hi <= addr)
        then    PMP_NoMatch
        else if (lo <= addr) & (addr + width <= hi)
        then    PMP_Match
        else    PMP_PartialMatch
      }
    },
  }
}

enum pmpMatch = {PMP_Success, PMP_Continue, PMP_Fail}

function pmpMatchEntry(addr: xlenbits, width: xlenbits, acc: AccessType(ext_access_type), priv: Privilege,
                       ent: Pmpcfg_ent, pmpaddr: xlenbits, prev_pmpaddr: xlenbits) -> pmpMatch = {
  let rng = pmpAddrRange(ent, pmpaddr, prev_pmpaddr);
  match pmpMatchAddr(addr, width, rng) {
    PMP_NoMatch      => PMP_Continue,
    PMP_PartialMatch => PMP_Fail,
    PMP_Match        => if   pmpCheckPerms(ent, acc, priv)
                        then PMP_Success
                        else PMP_Fail
  }
}

/* priority checks */

function accessToFault(acc : AccessType(ext_access_type)) -> ExceptionType =
  match acc {
    Read(_)      => E_Load_Access_Fault(),
    Write(_)     => E_SAMO_Access_Fault(),
    ReadWrite(_) => E_SAMO_Access_Fault(),
    Execute()    => E_Fetch_Access_Fault(),
  }

function pmpCheck forall 'n, 'n > 0. (addr: xlenbits, width: int('n), acc: AccessType(ext_access_type), priv: Privilege)
                  -> option(ExceptionType) = {
  let width : xlenbits = to_bits(sizeof(xlen), width);

  foreach (i from 0 to 63) {
    let prev_pmpaddr = (if i > 0 then pmpReadAddrReg(i - 1) else zeros());
    match pmpMatchEntry(addr, width, acc, priv, Pmpcfg(i), pmpReadAddrReg(i), prev_pmpaddr) {
      PMP_Success  => { return None(); },
      PMP_Fail     => { return Some(accessToFault(acc)); },
      // YIQUN: different with PR
      PMP_Continue => ()
    }
  };
  match priv {
    Machine =>
      if mseccfg.MMWP() == 0b1                /* Make Read, Write and execute denied by default, if condition meets for M mode */
      then Some(accessToFault(acc))
      else if mseccfg.MML() == 0b1            /* Make execute denied, if condition meets for M mode */
      then match acc {
             Execute(_) => Some(accessToFault(acc)),
             _          => None()
           }
      else None(),
    _       => Some(accessToFault(acc))       /* Make Read, Write and execute denied by default for S/U mode */
  }
}

function init_pmp() -> unit = {
  assert(
    sys_pmp_count() == 0 | sys_pmp_count() == 16 | sys_pmp_count() == 64,
    "sys_pmp_count() must be 0, 16, or 64"
  );

  mseccfg->RLB() = 0b0;
  mseccfg->MML() = 0b0;
  mseccfg->MMWP() = 0b0;
  mseccfgh = zero_extend(0b0);

  foreach (i from 0 to 63) {
    // On reset the PMP register's A and L bits are set to 0 unless the plaform
    // mandates a different value.
    Pmpcfg(i) = [Pmpcfg(i) with A = pmpAddrMatchType_to_bits(OFF), L = 0b0];
  };
}
