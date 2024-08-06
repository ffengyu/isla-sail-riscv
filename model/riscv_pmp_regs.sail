/*=======================================================================================*/
/*  This Sail RISC-V architecture model, comprising all files and                        */
/*  directories except where otherwise noted is subject the BSD                          */
/*  two-clause license in the LICENSE file.                                              */
/*                                                                                       */
/*  SPDX-License-Identifier: BSD-2-Clause                                                */
/*=======================================================================================*/

/* PMP configuration entries */

enum PmpAddrMatchType = {OFF, TOR, NA4, NAPOT}

val pmpAddrMatchType_of_bits : bits(2) -> PmpAddrMatchType
function pmpAddrMatchType_of_bits(bs) = {
  match bs {
    0b00 => OFF,
    0b01 => TOR,
    0b10 => NA4,
    0b11 => NAPOT
  }
}

val pmpAddrMatchType_to_bits : PmpAddrMatchType -> bits(2)
function pmpAddrMatchType_to_bits(bs) = {
  match bs {
    OFF   => 0b00,
    TOR   => 0b01,
    NA4   => 0b10,
    NAPOT => 0b11
  }
}

bitfield Pmpcfg_ent : bits(8) = {
  L : 7,        /* locking */
  A : 4 .. 3,   /* address match type, encoded as above */

  /* permissions */
  X : 2,        /* execute */
  W : 1,        /* write */
  R : 0         /* read */
}

bitfield Mseccfg_ent : xlenbits = {
  RLB  : 2,       /* Rule Locking Bypass */
  MMWP : 1,       /* Machine Mode Whitelist Policy */
  MML  : 0        /* Machine Mode Lockdown */
}

register mseccfg  : Mseccfg_ent
register mseccfgh : bits(32)

register pmpaddr_n : vector(64, dec, xlenbits)

register pmp0cfg : Pmpcfg_ent
register pmp1cfg : Pmpcfg_ent
register pmp2cfg : Pmpcfg_ent
register pmp3cfg : Pmpcfg_ent
register pmp4cfg : Pmpcfg_ent
register pmp5cfg : Pmpcfg_ent
register pmp6cfg : Pmpcfg_ent
register pmp7cfg : Pmpcfg_ent
register pmp8cfg : Pmpcfg_ent
register pmp9cfg : Pmpcfg_ent
register pmp10cfg : Pmpcfg_ent
register pmp11cfg : Pmpcfg_ent
register pmp12cfg : Pmpcfg_ent
register pmp13cfg : Pmpcfg_ent
register pmp14cfg : Pmpcfg_ent
register pmp15cfg : Pmpcfg_ent
register pmp16cfg : Pmpcfg_ent
register pmp17cfg : Pmpcfg_ent
register pmp18cfg : Pmpcfg_ent
register pmp19cfg : Pmpcfg_ent
register pmp20cfg : Pmpcfg_ent
register pmp21cfg : Pmpcfg_ent
register pmp22cfg : Pmpcfg_ent
register pmp23cfg : Pmpcfg_ent
register pmp24cfg : Pmpcfg_ent
register pmp25cfg : Pmpcfg_ent
register pmp26cfg : Pmpcfg_ent
register pmp27cfg : Pmpcfg_ent
register pmp28cfg : Pmpcfg_ent
register pmp29cfg : Pmpcfg_ent
register pmp30cfg : Pmpcfg_ent
register pmp31cfg : Pmpcfg_ent
register pmp32cfg : Pmpcfg_ent
register pmp33cfg : Pmpcfg_ent
register pmp34cfg : Pmpcfg_ent
register pmp35cfg : Pmpcfg_ent
register pmp36cfg : Pmpcfg_ent
register pmp37cfg : Pmpcfg_ent
register pmp38cfg : Pmpcfg_ent
register pmp39cfg : Pmpcfg_ent
register pmp40cfg : Pmpcfg_ent
register pmp41cfg : Pmpcfg_ent
register pmp42cfg : Pmpcfg_ent
register pmp43cfg : Pmpcfg_ent
register pmp44cfg : Pmpcfg_ent
register pmp45cfg : Pmpcfg_ent
register pmp46cfg : Pmpcfg_ent
register pmp47cfg : Pmpcfg_ent
register pmp48cfg : Pmpcfg_ent
register pmp49cfg : Pmpcfg_ent
register pmp50cfg : Pmpcfg_ent
register pmp51cfg : Pmpcfg_ent
register pmp52cfg : Pmpcfg_ent
register pmp53cfg : Pmpcfg_ent
register pmp54cfg : Pmpcfg_ent
register pmp55cfg : Pmpcfg_ent
register pmp56cfg : Pmpcfg_ent
register pmp57cfg : Pmpcfg_ent
register pmp58cfg : Pmpcfg_ent
register pmp59cfg : Pmpcfg_ent
register pmp60cfg : Pmpcfg_ent
register pmp61cfg : Pmpcfg_ent
register pmp62cfg : Pmpcfg_ent
register pmp63cfg : Pmpcfg_ent
let zero_pmpcfgreg : Pmpcfg_ent = Mk_Pmpcfg_ent(zero_extend(0x0))
type pmpcfgregno ('n : Int), 0 <= 'n < 64 = int('n)
val rPmpcfg : forall 'n, 0 <= 'n < 64. pmpcfgregno('n) -> Pmpcfg_ent
function rPmpcfg r = {
  let v : Pmpcfg_ent =
    match r {
      0 => pmp0cfg,
      1 => pmp1cfg,
      2 => pmp2cfg,
      3 => pmp3cfg,
      4 => pmp4cfg,
      5 => pmp5cfg,
      6 => pmp6cfg,
      7 => pmp7cfg,
      8 => pmp8cfg,
      9 => pmp9cfg,
      10 => pmp10cfg,
      11 => pmp11cfg,
      12 => pmp12cfg,
      13 => pmp13cfg,
      14 => pmp14cfg,
      15 => pmp15cfg,
      16 => pmp16cfg,
      17 => pmp17cfg,
      18 => pmp18cfg,
      19 => pmp19cfg,
      20 => pmp20cfg,
      21 => pmp21cfg,
      22 => pmp22cfg,
      23 => pmp23cfg,
      24 => pmp24cfg,
      25 => pmp25cfg,
      26 => pmp26cfg,
      27 => pmp27cfg,
      28 => pmp28cfg,
      29 => pmp29cfg,
      30 => pmp30cfg,
      31 => pmp31cfg,
      32 => pmp32cfg,
      33 => pmp33cfg,
      34 => pmp34cfg,
      35 => pmp35cfg,
      36 => pmp36cfg,
      37 => pmp37cfg,
      38 => pmp38cfg,
      39 => pmp39cfg,
      40 => pmp40cfg,
      41 => pmp41cfg,
      42 => pmp42cfg,
      43 => pmp43cfg,
      44 => pmp44cfg,
      45 => pmp45cfg,
      46 => pmp46cfg,
      47 => pmp47cfg,
      48 => pmp48cfg,
      49 => pmp49cfg,
      50 => pmp50cfg,
      51 => pmp51cfg,
      52 => pmp52cfg,
      53 => pmp53cfg,
      54 => pmp54cfg,
      55 => pmp55cfg,
      56 => pmp56cfg,
      57 => pmp57cfg,
      58 => pmp58cfg,
      59 => pmp59cfg,
      60 => pmp60cfg,
      61 => pmp61cfg,
      62 => pmp62cfg,
      63 => pmp63cfg,
      _  => {assert(false, "invalid register number"); zero_pmpcfgreg}
    };
    v
}
val wPmpcfg : forall 'n, 0 <= 'n < 64. (pmpcfgregno('n), Pmpcfg_ent) -> unit
function wPmpcfg (r, v) = {
  match r {
    0  => pmp0cfg = v,
    1  => pmp1cfg = v,
    2  => pmp2cfg = v,
    3  => pmp3cfg = v,
    4  => pmp4cfg = v,
    5  => pmp5cfg = v,
    6  => pmp6cfg = v,
    7  => pmp7cfg = v,
    8  => pmp8cfg = v,
    9  => pmp9cfg = v,
    10 => pmp10cfg = v,
    11 => pmp11cfg = v,
    12 => pmp12cfg = v,
    13 => pmp13cfg = v,
    14 => pmp14cfg = v,
    15 => pmp15cfg = v,
    16 => pmp16cfg = v,
    17 => pmp17cfg = v,
    18 => pmp18cfg = v,
    19 => pmp19cfg = v,
    20 => pmp20cfg = v,
    21 => pmp21cfg = v,
    22 => pmp22cfg = v,
    23 => pmp23cfg = v,
    24 => pmp24cfg = v,
    25 => pmp25cfg = v,
    26 => pmp26cfg = v,
    27 => pmp27cfg = v,
    28 => pmp28cfg = v,
    29 => pmp29cfg = v,
    30 => pmp30cfg = v,
    31 => pmp31cfg = v,
    32 => pmp32cfg = v,
    33 => pmp33cfg = v,
    34 => pmp34cfg = v,
    35 => pmp35cfg = v,
    36 => pmp36cfg = v,
    37 => pmp37cfg = v,
    38 => pmp38cfg = v,
    39 => pmp39cfg = v,
    40 => pmp40cfg = v,
    41 => pmp41cfg = v,
    42 => pmp42cfg = v,
    43 => pmp43cfg = v,
    44 => pmp44cfg = v,
    45 => pmp45cfg = v,
    46 => pmp46cfg = v,
    47 => pmp47cfg = v,
    48 => pmp48cfg = v,
    49 => pmp49cfg = v,
    50 => pmp50cfg = v,
    51 => pmp51cfg = v,
    52 => pmp52cfg = v,
    53 => pmp53cfg = v,
    54 => pmp54cfg = v,
    55 => pmp55cfg = v,
    56 => pmp56cfg = v,
    57 => pmp57cfg = v,
    58 => pmp58cfg = v,
    59 => pmp59cfg = v,
    60 => pmp60cfg = v,
    61 => pmp61cfg = v,
    62 => pmp62cfg = v,
    63 => pmp63cfg = v,
    _  => assert(false, "invalid register number")
  }
}

overload Pmpcfg = {rPmpcfg, wPmpcfg}

register pmpaddr0 : xlenbits
register pmpaddr1 : xlenbits
register pmpaddr2 : xlenbits
register pmpaddr3 : xlenbits
register pmpaddr4 : xlenbits
register pmpaddr5 : xlenbits
register pmpaddr6 : xlenbits
register pmpaddr7 : xlenbits
register pmpaddr8 : xlenbits
register pmpaddr9 : xlenbits
register pmpaddr10 : xlenbits
register pmpaddr11 : xlenbits
register pmpaddr12 : xlenbits
register pmpaddr13 : xlenbits
register pmpaddr14 : xlenbits
register pmpaddr15 : xlenbits
register pmpaddr16 : xlenbits
register pmpaddr17 : xlenbits
register pmpaddr18 : xlenbits
register pmpaddr19 : xlenbits
register pmpaddr20 : xlenbits
register pmpaddr21 : xlenbits
register pmpaddr22 : xlenbits
register pmpaddr23 : xlenbits
register pmpaddr24 : xlenbits
register pmpaddr25 : xlenbits
register pmpaddr26 : xlenbits
register pmpaddr27 : xlenbits
register pmpaddr28 : xlenbits
register pmpaddr29 : xlenbits
register pmpaddr30 : xlenbits
register pmpaddr31 : xlenbits
register pmpaddr32 : xlenbits
register pmpaddr33 : xlenbits
register pmpaddr34 : xlenbits
register pmpaddr35 : xlenbits
register pmpaddr36 : xlenbits
register pmpaddr37 : xlenbits
register pmpaddr38 : xlenbits
register pmpaddr39 : xlenbits
register pmpaddr40 : xlenbits
register pmpaddr41 : xlenbits
register pmpaddr42 : xlenbits
register pmpaddr43 : xlenbits
register pmpaddr44 : xlenbits
register pmpaddr45 : xlenbits
register pmpaddr46 : xlenbits
register pmpaddr47 : xlenbits
register pmpaddr48 : xlenbits
register pmpaddr49 : xlenbits
register pmpaddr50 : xlenbits
register pmpaddr51 : xlenbits
register pmpaddr52 : xlenbits
register pmpaddr53 : xlenbits
register pmpaddr54 : xlenbits
register pmpaddr55 : xlenbits
register pmpaddr56 : xlenbits
register pmpaddr57 : xlenbits
register pmpaddr58 : xlenbits
register pmpaddr59 : xlenbits
register pmpaddr60 : xlenbits
register pmpaddr61 : xlenbits
register pmpaddr62 : xlenbits
register pmpaddr63 : xlenbits
let zero_pmpaddrreg : xlenbits = zero_extend(0x0)
type pmpaddrregno ('n : Int), 0 <= 'n < 64 = int('n)
val rPmpaddr : forall 'n, 0 <= 'n < 64. pmpaddrregno('n) -> xlenbits
function rPmpaddr r = {
  let v : xlenbits =
    match r {
      0 => pmpaddr0,
      1 => pmpaddr1,
      2 => pmpaddr2,
      3 => pmpaddr3,
      4 => pmpaddr4,
      5 => pmpaddr5,
      6 => pmpaddr6,
      7 => pmpaddr7,
      8 => pmpaddr8,
      9 => pmpaddr9,
      10 => pmpaddr10,
      11 => pmpaddr11,
      12 => pmpaddr12,
      13 => pmpaddr13,
      14 => pmpaddr14,
      15 => pmpaddr15,
      16 => pmpaddr16,
      17 => pmpaddr17,
      18 => pmpaddr18,
      19 => pmpaddr19,
      20 => pmpaddr20,
      21 => pmpaddr21,
      22 => pmpaddr22,
      23 => pmpaddr23,
      24 => pmpaddr24,
      25 => pmpaddr25,
      26 => pmpaddr26,
      27 => pmpaddr27,
      28 => pmpaddr28,
      29 => pmpaddr29,
      30 => pmpaddr30,
      31 => pmpaddr31,
      32 => pmpaddr32,
      33 => pmpaddr33,
      34 => pmpaddr34,
      35 => pmpaddr35,
      36 => pmpaddr36,
      37 => pmpaddr37,
      38 => pmpaddr38,
      39 => pmpaddr39,
      40 => pmpaddr40,
      41 => pmpaddr41,
      42 => pmpaddr42,
      43 => pmpaddr43,
      44 => pmpaddr44,
      45 => pmpaddr45,
      46 => pmpaddr46,
      47 => pmpaddr47,
      48 => pmpaddr48,
      49 => pmpaddr49,
      50 => pmpaddr50,
      51 => pmpaddr51,
      52 => pmpaddr52,
      53 => pmpaddr53,
      54 => pmpaddr54,
      55 => pmpaddr55,
      56 => pmpaddr56,
      57 => pmpaddr57,
      58 => pmpaddr58,
      59 => pmpaddr59,
      60 => pmpaddr60,
      61 => pmpaddr61,
      62 => pmpaddr62,
      63 => pmpaddr63,
      _  => {assert(false, "invalid register number"); zero_pmpaddrreg}
    };
    v
}
val wPmpaddr : forall 'n, 0 <= 'n < 64. (pmpaddrregno('n), xlenbits) -> unit
function wPmpaddr (r, v) = {
  match r {
    0  => pmpaddr0 = v,
    1  => pmpaddr1 = v,
    2  => pmpaddr2 = v,
    3  => pmpaddr3 = v,
    4  => pmpaddr4 = v,
    5  => pmpaddr5 = v,
    6  => pmpaddr6 = v,
    7  => pmpaddr7 = v,
    8  => pmpaddr8 = v,
    9  => pmpaddr9 = v,
    10 => pmpaddr10 = v,
    11 => pmpaddr11 = v,
    12 => pmpaddr12 = v,
    13 => pmpaddr13 = v,
    14 => pmpaddr14 = v,
    15 => pmpaddr15 = v,
    16 => pmpaddr16 = v,
    17 => pmpaddr17 = v,
    18 => pmpaddr18 = v,
    19 => pmpaddr19 = v,
    20 => pmpaddr20 = v,
    21 => pmpaddr21 = v,
    22 => pmpaddr22 = v,
    23 => pmpaddr23 = v,
    24 => pmpaddr24 = v,
    25 => pmpaddr25 = v,
    26 => pmpaddr26 = v,
    27 => pmpaddr27 = v,
    28 => pmpaddr28 = v,
    29 => pmpaddr29 = v,
    30 => pmpaddr30 = v,
    31 => pmpaddr31 = v,
    32 => pmpaddr32 = v,
    33 => pmpaddr33 = v,
    34 => pmpaddr34 = v,
    35 => pmpaddr35 = v,
    36 => pmpaddr36 = v,
    37 => pmpaddr37 = v,
    38 => pmpaddr38 = v,
    39 => pmpaddr39 = v,
    40 => pmpaddr40 = v,
    41 => pmpaddr41 = v,
    42 => pmpaddr42 = v,
    43 => pmpaddr43 = v,
    44 => pmpaddr44 = v,
    45 => pmpaddr45 = v,
    46 => pmpaddr46 = v,
    47 => pmpaddr47 = v,
    48 => pmpaddr48 = v,
    49 => pmpaddr49 = v,
    50 => pmpaddr50 = v,
    51 => pmpaddr51 = v,
    52 => pmpaddr52 = v,
    53 => pmpaddr53 = v,
    54 => pmpaddr54 = v,
    55 => pmpaddr55 = v,
    56 => pmpaddr56 = v,
    57 => pmpaddr57 = v,
    58 => pmpaddr58 = v,
    59 => pmpaddr59 = v,
    60 => pmpaddr60 = v,
    61 => pmpaddr61 = v,
    62 => pmpaddr62 = v,
    63 => pmpaddr63 = v,
    _  => assert(false, "invalid register number")
  }
}

overload Pmpaddr = {rPmpaddr, wPmpaddr}
/* Packing and unpacking pmpcfg regs for xlen-width accesses */

function pmpReadCfgReg(n : range(0, 15)) -> xlenbits = {
  if sizeof(xlen) == 32
  then {
    Pmpcfg(n*4 + 3).bits @
    Pmpcfg(n*4 + 2).bits @
    Pmpcfg(n*4 + 1).bits @
    Pmpcfg(n*4 + 0).bits
  }
  else {
    assert(n % 2 == 0, "Unexpected pmp config reg read");
    Pmpcfg(n*4 + 7).bits @
    Pmpcfg(n*4 + 6).bits @
    Pmpcfg(n*4 + 5).bits @
    Pmpcfg(n*4 + 4).bits @
    Pmpcfg(n*4 + 3).bits @
    Pmpcfg(n*4 + 2).bits @
    Pmpcfg(n*4 + 1).bits @
    Pmpcfg(n*4 + 0).bits
  }
}

function pmpReadAddrReg(n : range(0, 63)) -> xlenbits = {
  let G = sys_pmp_grain();
  let match_type = Pmpcfg(n).A();
  let addr = Pmpaddr(n);

  match match_type[1] {
    bitone if G >= 2 => {
      // [G-2..0] read as all ones to form mask, therefore we need G-1 bits.
      let mask : xlenbits = zero_extend(ones(min(G - 1, sizeof(xlen))));
      addr | mask
    },

    bitzero if G >= 1 => {
      // [G-1..0] read as all zeros to form mask, therefore we need G bits.
      let mask : xlenbits = zero_extend(ones(min(G , sizeof(xlen))));
      addr & ~(mask)
    },

    _ => addr,
  }
}

/* Helpers to handle locked entries */
function pmpLockBit(cfg: Pmpcfg_ent) -> bool = cfg.L() == 0b1

// YIQUN: change field accessor syntax to from field() to field[].
function pmpLocked(cfg: Pmpcfg_ent) -> bool = (cfg.L() == 0b1) & (mseccfg.RLB() == 0b0)

function pmpTORLocked(cfg: Pmpcfg_ent) -> bool = pmpLocked(cfg) & (pmpAddrMatchType_of_bits(cfg.A()) == TOR)

// YIQUN: different with PR
function pmpWriteCfg(n: range(0, 63), cfg: Pmpcfg_ent, v: bits(8)) -> Pmpcfg_ent = {
  // Constructing legal Pmpcfg_ent by making bit 5 and 6 zero
  let legal_v : Pmpcfg_ent = Mk_Pmpcfg_ent(v & 0x9f);
  // YIQUN: RW=01 is reserved when MML = 0.
  // In this implementation if R=0 and W=1 then R, W and X are all set to 0.
  // This is the least risky option from a security perspective.
  let legal_v : Pmpcfg_ent = match (mseccfg.MML(), legal_v.R(), legal_v.W()) {
    (0b0, 0b0, 0b1) => [legal_v with X = 0b0, W = 0b0, R = 0b0],
    (_, _, _)       => legal_v
  };
  // If locked then configuration is unchanged
  if pmpLocked(cfg)
  then cfg
  /* To prevent adding a rule with execution privileges if MML is enabled unless RLB is set */
  // YIQUN: It this the least risky option from a security perspective?
  else if (mseccfg.MML() == 0b1 & mseccfg.RLB() == 0b0 & legal_v.L() == 0b1)
  then {
    match (legal_v.R(), legal_v.W(), legal_v.X()) {
      (0b0, 0b0, 0b1) => cfg,
      (0b0, 0b1, 0b0) => cfg,
      (0b0, 0b1, 0b1) => cfg,
      (0b1, 0b0, 0b1) => cfg,
      (_, _, _)       => legal_v
    }
  }
  else if (sys_pmp_grain() >= 1 & pmpAddrMatchType_of_bits(cfg.A()) == NA4)
  // "When G >= 1, the NA4 mode is not selectable."
  // In this implementation we set it to OFF if NA4 is selected.
  // This is the least risky option from a security perspective.
  then [legal_v with A = pmpAddrMatchType_to_bits(OFF)]
  else legal_v
}

function pmpWriteCfgReg(n : range(0, 15), v : xlenbits) -> unit = {
  if sizeof(xlen) == 32
  then {
    foreach (i from 0 to 3) {
      let idx = n*4 + i;
      Pmpcfg(idx)  = pmpWriteCfg(idx,  Pmpcfg(idx),  v[8*i+7 .. 8*i]);
    }
  }
  else {
    assert(n % 2 == 0, "Unexpected pmp config reg write");
    foreach (i from 0 to 7) {
      let idx = n*4 + i;
      Pmpcfg(idx)  = pmpWriteCfg(idx,  Pmpcfg(idx),  v[8*i+7 .. 8*i]);
    }
  }
}

function pmpWriteAddr(locked: bool, tor_locked: bool, reg: xlenbits, v: xlenbits) -> xlenbits =
  if   sizeof(xlen) == 32
  then { if (locked | tor_locked) then reg else v }
  else { if (locked | tor_locked) then reg else zero_extend(v[53..0]) }

function pmpWriteAddrReg(n : range(0, 63), v : xlenbits) -> unit = {
  Pmpaddr(n) = pmpWriteAddr(
    pmpLocked(Pmpcfg(n)),
    if n + 1 < 64 then pmpTORLocked(Pmpcfg(n + 1)) else false,
    Pmpaddr(n),
    v,
  );
}

function mseccfgWrite(reg: Mseccfg_ent, v: xlenbits) -> Mseccfg_ent = {
  let legal_v : Mseccfg_ent = Mk_Mseccfg_ent(zero_extend(v[2 .. 0]));
  // YIQUN: different with PR. Not hard-coded.
  let reg : Mseccfg_ent = match (reg.RLB(), legal_v.RLB()) {                   /* to set RLB, need to check PMPCFG_L */
    (0b0, 0b1) => {
      var setL : bool = false;
      let num = sys_pmp_count();
      foreach (i from 0 to (num - 1))
        setL = setL | (Pmpcfg(i).L() == 0b1);
      if setL
      then reg
      else [reg with RLB = legal_v.RLB()]
    },
    (_, _)     => [reg with RLB = legal_v.RLB()]
  };

  let reg : Mseccfg_ent = match (reg.MML(), reg.MMWP()) {                      /* Implements stickiness of MML and MMWP bits, if once set remains set */
    (0b0, 0b0) => [reg with MML = legal_v.MML(), MMWP = legal_v.MMWP()],
    (0b0, 0b1) => [reg with MML = legal_v.MML()],
    (0b1, 0b0) => [reg with MMWP = legal_v.MMWP()],
    (0b1, 0b1) => reg
  };
  reg
}
