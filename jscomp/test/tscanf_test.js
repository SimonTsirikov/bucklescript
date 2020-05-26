'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var Curry = require("../../lib/js/curry.js");
var Scanf = require("../../lib/js/scanf.js");
var $$Buffer = require("../../lib/js/buffer.js");
var Printf = require("../../lib/js/printf.js");
var $$String = require("../../lib/js/string.js");
var Testing = require("./testing.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Mt_global = require("./mt_global.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_int64 = require("../../lib/js/caml_int64.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_format = require("../../lib/js/caml_format.js");
var Caml_string = require("../../lib/js/caml_string.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end

function test(loc, b) do
  return eq(loc, --[ tuple ]--[
              b,
              true
            ]);
end

function id(x) do
  return x;
end

function test0(param) do
  return ((((Curry._2(Scanf.sscanf("", --[ Format ]--[
                          --[ End_of_format ]--0,
                          ""
                        ]), id, 1) + Curry._2(Scanf.sscanf("", --[ Format ]--[
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ End_of_format ]--0
                            ]),
                          " "
                        ]), id, 2) | 0) + Curry._2(Scanf.sscanf(" ", --[ Format ]--[
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ End_of_format ]--0
                          ]),
                        " "
                      ]), id, 3) | 0) + Curry._2(Scanf.sscanf("\t", --[ Format ]--[
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ End_of_format ]--0
                        ]),
                      " "
                    ]), id, 4) | 0) + Curry._2(Scanf.sscanf("\n", --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ End_of_format ]--0
                      ]),
                    " "
                  ]), id, 5) | 0) + Curry._1(Scanf.sscanf("\n\t 6", --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_d ]--0,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  " %d"
                ]), id) | 0;
end

test("File \"tscanf_test.ml\", line 42, characters 5-12", test0(--[ () ]--0) == 21);

function test1(param) do
  return (((Curry._1(Scanf.sscanf("1", --[ Format ]--[
                        --[ Int ]--Block.__(4, [
                            --[ Int_d ]--0,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ End_of_format ]--0
                          ]),
                        "%d"
                      ]), id) + Curry._1(Scanf.sscanf(" 2", --[ Format ]--[
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Int ]--Block.__(4, [
                                --[ Int_d ]--0,
                                --[ No_padding ]--0,
                                --[ No_precision ]--0,
                                --[ End_of_format ]--0
                              ])
                          ]),
                        " %d"
                      ]), id) | 0) + Curry._1(Scanf.sscanf(" -2", --[ Format ]--[
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Int ]--Block.__(4, [
                              --[ Int_d ]--0,
                              --[ No_padding ]--0,
                              --[ No_precision ]--0,
                              --[ End_of_format ]--0
                            ])
                        ]),
                      " %d"
                    ]), id) | 0) + Curry._1(Scanf.sscanf(" +2", --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ Int ]--Block.__(4, [
                            --[ Int_d ]--0,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    " %d"
                  ]), id) | 0) + Curry._1(Scanf.sscanf(" 2a ", --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_d ]--0,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "a" ]--97,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  " %da"
                ]), id) | 0;
end

test("File \"tscanf_test.ml\", line 54, characters 5-12", test1(--[ () ]--0) == 5);

function test2(param) do
  return (Curry._1(Scanf.sscanf("123", --[ Format ]--[
                    --[ Int ]--Block.__(4, [
                        --[ Int_i ]--3,
                        --[ Lit_padding ]--Block.__(0, [
                            --[ Right ]--1,
                            2
                          ]),
                        --[ No_precision ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%2i"
                  ]), id) + Curry._1(Scanf.sscanf("245", --[ Format ]--[
                    --[ Int ]--Block.__(4, [
                        --[ Int_d ]--0,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%d"
                  ]), id) | 0) + Curry._1(Scanf.sscanf(" 2a ", --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_d ]--0,
                          --[ Lit_padding ]--Block.__(0, [
                              --[ Right ]--1,
                              1
                            ]),
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "a" ]--97,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  " %1da"
                ]), id) | 0;
end

test("File \"tscanf_test.ml\", line 63, characters 5-12", test2(--[ () ]--0) == 259);

function test3(param) do
  return ((Curry._1(Scanf.sscanf("0xff", --[ Format ]--[
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ Lit_padding ]--Block.__(0, [
                              --[ Right ]--1,
                              3
                            ]),
                          --[ No_precision ]--0,
                          --[ End_of_format ]--0
                        ]),
                      "%3i"
                    ]), id) + Curry._1(Scanf.sscanf("0XEF", --[ Format ]--[
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ Lit_padding ]--Block.__(0, [
                              --[ Right ]--1,
                              3
                            ]),
                          --[ No_precision ]--0,
                          --[ End_of_format ]--0
                        ]),
                      "%3i"
                    ]), id) | 0) + Curry._1(Scanf.sscanf("x=-245", --[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        " x = ",
                        --[ Int ]--Block.__(4, [
                            --[ Int_d ]--0,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    " x = %d"
                  ]), id) | 0) + Curry._1(Scanf.sscanf(" 2a ", --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_d ]--0,
                          --[ Lit_padding ]--Block.__(0, [
                              --[ Right ]--1,
                              1
                            ]),
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "a" ]--97,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  " %1da"
                ]), id) | 0;
end

test("File \"tscanf_test.ml\", line 73, characters 5-12", test3(--[ () ]--0) == -214);

function test4(param) do
  if (Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("-1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == -1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("+1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1."), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string(".1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 0.1;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("-.1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == -0.1;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("+.1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 0.1;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("+1."), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("-1."), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]), (function (b0) do
            return b0 == -1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("0 1. 1.3"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Float ]--Block.__(8, [
                          --[ Float_f ]--0,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Float ]--Block.__(8, [
                                  --[ Float_f ]--0,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              "%f %f %f"
            ]), (function (b0, b1, b2) do
            return b0 == 0.0 and b1 == 1.0 and b2 == 1.3 or false;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("0.113"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      4
                    ]),
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%4f"
            ]), (function (b0) do
            return b0 == 0.11;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("0.113"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      5
                    ]),
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%5f"
            ]), (function (b0) do
            return b0 == 0.113;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("000.113"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      15
                    ]),
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%15f"
            ]), (function (b0) do
            return b0 == 0.113;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("+000.113"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      15
                    ]),
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%15f"
            ]), (function (b0) do
            return b0 == 0.113;
          end))) then do
    return Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("-000.113"), --[ Format ]--[
                    --[ Float ]--Block.__(8, [
                        --[ Float_f ]--0,
                        --[ Lit_padding ]--Block.__(0, [
                            --[ Right ]--1,
                            15
                          ]),
                        --[ No_precision ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%15f"
                  ]), (function (b0) do
                  return b0 == -0.113;
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 110, characters 5-12", test4(--[ () ]--0));

function test5(param) do
  if (Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1e1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_e ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%e"
            ]), (function (b) do
            return b == 10.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1e+1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_e ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%e"
            ]), (function (b) do
            return b == 10.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("10e-1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_e ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%e"
            ]), (function (b) do
            return b == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("10.e-1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_e ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%e"
            ]), (function (b) do
            return b == 1.0;
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1e1 1.e+1 1.3e-1"), --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_e ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Float ]--Block.__(8, [
                          --[ Float_e ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Float ]--Block.__(8, [
                                  --[ Float_e ]--3,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              "%e %e %e"
            ]), (function (b1, b2, b3) do
            return b1 == 10.0 and b2 == b1 and b3 == 0.13 or false;
          end))) then do
    return Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("1 1.1 0e+1 1.3e-1"), --[ Format ]--[
                    --[ Float ]--Block.__(8, [
                        --[ Float_g ]--9,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Float ]--Block.__(8, [
                                --[ Float_g ]--9,
                                --[ No_padding ]--0,
                                --[ No_precision ]--0,
                                --[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ Float ]--Block.__(8, [
                                        --[ Float_g ]--9,
                                        --[ No_padding ]--0,
                                        --[ No_precision ]--0,
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ " " ]--32,
                                            --[ Float ]--Block.__(8, [
                                                --[ Float_g ]--9,
                                                --[ No_padding ]--0,
                                                --[ No_precision ]--0,
                                                --[ End_of_format ]--0
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "%g %g %g %g"
                  ]), (function (b1, b2, b3, b4) do
                  if (b1 == 1.0 and b2 == 1.1 and b3 == 0.0) then do
                    return b4 == 0.13;
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 133, characters 5-12", test5(--[ () ]--0));

function test6(param) do
  if (Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("truetrue"), --[ Format ]--[
              --[ Bool ]--Block.__(9, [
                  --[ No_padding ]--0,
                  --[ Bool ]--Block.__(9, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%B%B"
            ]), (function (b1, b2) do
            return Caml_obj.caml_equal(--[ tuple ]--[
                        b1,
                        b2
                      ], --[ tuple ]--[
                        true,
                        true
                      ]);
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("truefalse"), --[ Format ]--[
              --[ Bool ]--Block.__(9, [
                  --[ No_padding ]--0,
                  --[ Bool ]--Block.__(9, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%B%B"
            ]), (function (b1, b2) do
            return Caml_obj.caml_equal(--[ tuple ]--[
                        b1,
                        b2
                      ], --[ tuple ]--[
                        true,
                        false
                      ]);
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("falsetrue"), --[ Format ]--[
              --[ Bool ]--Block.__(9, [
                  --[ No_padding ]--0,
                  --[ Bool ]--Block.__(9, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%B%B"
            ]), (function (b1, b2) do
            return Caml_obj.caml_equal(--[ tuple ]--[
                        b1,
                        b2
                      ], --[ tuple ]--[
                        false,
                        true
                      ]);
          end)) and Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("falsefalse"), --[ Format ]--[
              --[ Bool ]--Block.__(9, [
                  --[ No_padding ]--0,
                  --[ Bool ]--Block.__(9, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%B%B"
            ]), (function (b1, b2) do
            return Caml_obj.caml_equal(--[ tuple ]--[
                        b1,
                        b2
                      ], --[ tuple ]--[
                        false,
                        false
                      ]);
          end))) then do
    return Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("true false"), --[ Format ]--[
                    --[ Bool ]--Block.__(9, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Bool ]--Block.__(9, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "%B %B"
                  ]), (function (b1, b2) do
                  return Caml_obj.caml_equal(--[ tuple ]--[
                              b1,
                              b2
                            ], --[ tuple ]--[
                              true,
                              false
                            ]);
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 150, characters 5-12", test6(--[ () ]--0));

function test7(param) do
  if (Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("'a' '\n' '\t' '\0' ' '"), --[ Format ]--[
              --[ Caml_char ]--Block.__(1, [--[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Caml_char ]--Block.__(1, [--[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Caml_char ]--Block.__(1, [--[ Char_literal ]--Block.__(12, [
                                      --[ " " ]--32,
                                      --[ Caml_char ]--Block.__(1, [--[ Char_literal ]--Block.__(12, [
                                              --[ " " ]--32,
                                              --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0])
                                            ])])
                                    ])])
                            ])])
                    ])]),
              "%C %C %C %C %C"
            ]), (function (c1, c2, c3, c4, c5) do
            return c1 == --[ "a" ]--97 and c2 == --[ "\n" ]--10 and c3 == --[ "\t" ]--9 and c4 == --[ "\000" ]--0 and c5 == --[ " " ]--32 or false;
          end))) then do
    return Curry._1(Scanf.bscanf(Scanf.Scanning.from_string("a \n \t \0  b"), --[ Format ]--[
                    --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                                            --[ " " ]--32,
                                            --[ End_of_format ]--0
                                          ])])
                                  ])])
                          ])]),
                    "%c %c %c "
                  ]), (function (c1, c2, c3) do
                  if (c1 == --[ "a" ]--97 and c2 == --[ "\000" ]--0) then do
                    return c3 == --[ "b" ]--98;
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 168, characters 5-12", test7(--[ () ]--0));

function verify_read(c) do
  var s = Curry._1(Printf.sprintf(--[ Format ]--[
            --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0]),
            "%C"
          ]), c);
  var ib = Scanf.Scanning.from_string(s);
  if (Curry._1(Scanf.bscanf(ib, --[ Format ]--[
              --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0]),
              "%C"
            ]), id) == c) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "tscanf_test.ml",
            174,
            2
          ]
        ];
  end end 
end

function verify_scan_Chars(param) do
  for(var i = 0; i <= 255; ++i)do
    verify_read(Pervasives.char_of_int(i));
  end
  return --[ () ]--0;
end

function test8(param) do
  return verify_scan_Chars(--[ () ]--0) == --[ () ]--0;
end

test("File \"tscanf_test.ml\", line 183, characters 5-12", verify_scan_Chars(--[ () ]--0) == --[ () ]--0);

function unit(fmt, s) do
  var ib = Scanf.Scanning.from_string(Curry._1(Printf.sprintf(--[ Format ]--[
                --[ Caml_string ]--Block.__(3, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%S"
              ]), s));
  return Curry._1(Scanf.bscanf(ib, fmt), id);
end

function test_fmt(fmt, s) do
  return unit(fmt, s) == s;
end

var test9_string = "\xef\xbb\xbf";

var partial_arg = --[ Format ]--[
  --[ Caml_string ]--Block.__(3, [
      --[ No_padding ]--0,
      --[ End_of_format ]--0
    ]),
  "%S"
];

function test_S(param) do
  return test_fmt(partial_arg, param);
end

function test9(param) do
  if (test_S("poi") and test_S("a\"b") and test_S("a\nb") and test_S("a\nb") and test_S("a\\\nb \\\nc\n\\\nb") and test_S("a\\\n\\\n\\\nb \\\nc\n\\\nb") and test_S("\xef") and test_S("\\xef") and Curry._1(Scanf.sscanf("\"\\xef\"", --[ Format ]--[
              --[ Caml_string ]--Block.__(3, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%S"
            ]), (function (s) do
            return s;
          end)) == "\xef" and Curry._1(Scanf.sscanf("\"\\xef\\xbb\\xbf\"", --[ Format ]--[
              --[ Caml_string ]--Block.__(3, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%S"
            ]), (function (s) do
            return s;
          end)) == test9_string and Curry._1(Scanf.sscanf("\"\\xef\\xbb\\xbf\"", --[ Format ]--[
              --[ Caml_string ]--Block.__(3, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%S"
            ]), (function (s) do
            return s;
          end)) == "\xef\xbb\xbf" and Curry._1(Scanf.sscanf("\"\xef\xbb\xbf\"", --[ Format ]--[
              --[ Caml_string ]--Block.__(3, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%S"
            ]), (function (s) do
            return s;
          end)) == test9_string and Curry._1(Scanf.sscanf("\"\\\\xef\\\\xbb\\\\xbf\"", --[ Format ]--[
              --[ Caml_string ]--Block.__(3, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%S"
            ]), (function (s) do
            return s;
          end)) == "\\xef\\xbb\\xbf") then do
    return Curry._1(Scanf.sscanf("\" \"", --[ Format ]--[
                    --[ Caml_string ]--Block.__(3, [
                        --[ No_padding ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%S"
                  ]), (function (s) do
                  return s;
                end)) == " ";
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 230, characters 5-12", test9(--[ () ]--0));

function test10(param) do
  var unit = function (s) do
    var ib = Scanf.Scanning.from_string(s);
    return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                    --[ Caml_string ]--Block.__(3, [
                        --[ No_padding ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%S"
                  ]), id);
  end;
  var res = Curry._1(Scanf.sscanf("Une chaine: \"celle-ci\" et \"celle-la\"!", --[ Format ]--[
            --[ String ]--Block.__(2, [
                --[ No_padding ]--0,
                --[ Char_literal ]--Block.__(12, [
                    --[ " " ]--32,
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Caml_string ]--Block.__(3, [
                                --[ No_padding ]--0,
                                --[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ " " ]--32,
                                            --[ Caml_string ]--Block.__(3, [
                                                --[ No_padding ]--0,
                                                --[ Char_literal ]--Block.__(12, [
                                                    --[ " " ]--32,
                                                    --[ String ]--Block.__(2, [
                                                        --[ No_padding ]--0,
                                                        --[ End_of_format ]--0
                                                      ])
                                                  ])
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ])
              ]),
            "%s %s %S %s %S %s"
          ]), (function (s1, s2, s3, s4, s5, s6) do
          return s1 .. (s2 .. (s3 .. (s4 .. (s5 .. s6))));
        end));
  if (res == "Unechaine:celle-cietcelle-la!" and unit("\"a\\\n  b\"") == "ab" and unit("\"\\\n  ab\"") == "ab" and unit("\"\n\\\n  ab\"") == "\nab" and unit("\"\n\\\n  a\nb\"") == "\na\nb" and unit("\"\n\\\n  \\\n  a\nb\"") == "\na\nb" and unit("\"\n\\\n  a\n\\\nb\\\n\"") == "\na\nb") then do
    return unit("\"a\\\n  \"") == "a";
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 254, characters 5-12", test10(--[ () ]--0));

function test11(param) do
  if (Curry._1(Scanf.sscanf("Pierre\tWeis\t70", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              "%s %s %s"
            ]), (function (prenom, nom, poids) do
            return prenom == "Pierre" and nom == "Weis" and Caml_format.caml_int_of_string(poids) == 70 or false;
          end)) and Curry._1(Scanf.sscanf("Jean-Luc\tde Leage\t68", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\xff\xfd\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Scan_char_set ]--Block.__(20, [
                          undefined,
                          "\xff\xfd\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Int ]--Block.__(4, [
                                  --[ Int_d ]--0,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              "%[^\t] %[^\t] %d"
            ]), (function (prenom, nom, poids) do
            return prenom == "Jean-Luc" and nom == "de Leage" and poids == 68 or false;
          end))) then do
    return Curry._1(Scanf.sscanf("Daniel\tde Rauglaudre\t66", --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Scan_indic ]--Block.__(2, [--[ "\t" ]--9]),
                            --[ Char_literal ]--Block.__(12, [
                                --[ " " ]--32,
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ Formatting_lit ]--Block.__(17, [
                                        --[ Scan_indic ]--Block.__(2, [--[ "\t" ]--9]),
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ " " ]--32,
                                            --[ Int ]--Block.__(4, [
                                                --[ Int_d ]--0,
                                                --[ No_padding ]--0,
                                                --[ No_precision ]--0,
                                                --[ End_of_format ]--0
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "%s@\t %s@\t %d"
                  ]), (function (prenom, nom, poids) do
                  if (prenom == "Daniel" and nom == "de Rauglaudre") then do
                    return poids == 66;
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

function test110(param) do
  if (Curry._2(Scanf.sscanf("", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ End_of_format ]--0
                ]),
              " "
            ]), (function (x) do
            return x;
          end), "") == "" and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%s"
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s%s"
            ]), (function (x, y) do
            return x == "" and y == "" or false;
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s "
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              " %s"
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              " %s "
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\xff\xfb\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                  --[ End_of_format ]--0
                ]),
              "%[^\n]"
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\xff\xfb\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%[^\n] "
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%s"
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s%s"
            ]), (function (x, y) do
            return x == "" and y == "" or false;
          end)) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              " %s "
            ]), (function (x) do
            return x == "";
          end)) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              " %s %s"
            ]), (function (x, y) do
            return x == "" and x == y or false;
          end)) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Break ]--Block.__(0, [
                              "@ ",
                              1,
                              0
                            ]),
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              " %s@ %s"
            ]), (function (x, y) do
            return x == "" and x == y or false;
          end)) and Curry._1(Scanf.sscanf(" poi !", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Break ]--Block.__(0, [
                              "@ ",
                              1,
                              0
                            ]),
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Formatting_lit ]--Block.__(17, [
                                  --[ Flush_newline ]--4,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              " %s@ %s@."
            ]), (function (x, y) do
            return x == "poi" and y == "!" or false;
          end))) then do
    return Curry._1(Scanf.sscanf(" poi !", --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Break ]--Block.__(0, [
                                "@ ",
                                1,
                                0
                              ]),
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ Formatting_lit ]--Block.__(17, [
                                    --[ Flush_newline ]--4,
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ]),
                    "%s@ %s@."
                  ]), (function (x, y) do
                  if (x == "") then do
                    return y == "poi !";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

function test111(param) do
  return Curry._1(Scanf.sscanf("", --[ Format ]--[
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\xff\xfb\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Force_newline ]--3,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "%[^\n]@\n"
                ]), (function (x) do
                return x == "";
              end));
end

test("File \"tscanf_test.ml\", line 293, characters 5-12", test11(--[ () ]--0) and test110(--[ () ]--0) and test111(--[ () ]--0));

function ib(param) do
  return Scanf.Scanning.from_string("[1;2;3;4; ]");
end

function f(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " [",
                --[ End_of_format ]--0
              ]),
            " ["
          ]), --[ () ]--0);
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ ";" ]--59,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  " %i;"
                ]), (function (i) do
                return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                --[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ Int ]--Block.__(4, [
                                        --[ Int_i ]--3,
                                        --[ No_padding ]--0,
                                        --[ No_precision ]--0,
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ ";" ]--59,
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ]),
                                " %i;"
                              ]), (function (j) do
                              return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                              --[ Char_literal ]--Block.__(12, [
                                                  --[ " " ]--32,
                                                  --[ Int ]--Block.__(4, [
                                                      --[ Int_i ]--3,
                                                      --[ No_padding ]--0,
                                                      --[ No_precision ]--0,
                                                      --[ Char_literal ]--Block.__(12, [
                                                          --[ ";" ]--59,
                                                          --[ End_of_format ]--0
                                                        ])
                                                    ])
                                                ]),
                                              " %i;"
                                            ]), (function (k) do
                                            return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                                            --[ Char_literal ]--Block.__(12, [
                                                                --[ " " ]--32,
                                                                --[ Int ]--Block.__(4, [
                                                                    --[ Int_i ]--3,
                                                                    --[ No_padding ]--0,
                                                                    --[ No_precision ]--0,
                                                                    --[ Char_literal ]--Block.__(12, [
                                                                        --[ ";" ]--59,
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ]),
                                                            " %i;"
                                                          ]), (function (l) do
                                                          Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        " ]",
                                                                        --[ End_of_format ]--0
                                                                      ]),
                                                                    " ]"
                                                                  ]), --[ () ]--0);
                                                          return --[ :: ]--[
                                                                  i,
                                                                  --[ :: ]--[
                                                                    j,
                                                                    --[ :: ]--[
                                                                      k,
                                                                      --[ :: ]--[
                                                                        l,
                                                                        --[ [] ]--0
                                                                      ]
                                                                    ]
                                                                  ]
                                                                ];
                                                        end));
                                          end));
                            end));
              end));
end

function test12(param) do
  return Caml_obj.caml_equal(f(Scanf.Scanning.from_string("[1;2;3;4; ]")), --[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ]);
end

test("File \"tscanf_test.ml\", line 311, characters 5-12", test12(--[ () ]--0));

function scan_elems(ib, accu) do
  try do
    return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ Int ]--Block.__(4, [
                            --[ Int_i ]--3,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ ";" ]--59,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    " %i;"
                  ]), (function (i) do
                  return scan_elems(ib, --[ :: ]--[
                              i,
                              accu
                            ]);
                end));
  end
  catch (exn)do
    return accu;
  end
end

function g(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  return List.rev(scan_elems(ib, --[ [] ]--0));
end

function test13(param) do
  return Caml_obj.caml_equal(g(Scanf.Scanning.from_string("[1;2;3;4; ]")), --[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ]);
end

test("File \"tscanf_test.ml\", line 324, characters 5-12", test13(--[ () ]--0));

function scan_int_list(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems(ib, --[ [] ]--0);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

function test14(param) do
  return Caml_obj.caml_equal(scan_int_list(Scanf.Scanning.from_string("[1;2;3;4; ]")), --[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ]);
end

test("File \"tscanf_test.ml\", line 337, characters 5-12", test14(--[ () ]--0));

function scan_elems$1(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Char ]--Block.__(0, [--[ End_of_format ]--0])
                            ])
                        ])
                    ]),
                  " %i %c"
                ]), (function (i, c) do
                if (c ~= 59) then do
                  if (c ~= 93) then do
                    throw [
                          Caml_builtin_exceptions.failure,
                          "scan_elems"
                        ];
                  end
                   end 
                  return List.rev(--[ :: ]--[
                              i,
                              accu
                            ]);
                end else do
                  return scan_elems$1(ib, --[ :: ]--[
                              i,
                              accu
                            ]);
                end end 
              end));
end

function scan_int_list$1(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  return scan_elems$1(ib, --[ [] ]--0);
end

function test15(param) do
  return Caml_obj.caml_equal(scan_int_list$1(Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ]);
end

test("File \"tscanf_test.ml\", line 357, characters 5-12", test15(--[ () ]--0));

function scan_elems$2(ib, accu) do
  try do
    return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                    --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Int ]--Block.__(4, [
                                --[ Int_i ]--3,
                                --[ No_padding ]--0,
                                --[ No_precision ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])]),
                    "%c %i"
                  ]), (function (c, i) do
                  if (c >= 91) then do
                    if (c < 94) then do
                      local ___conditional___=(c - 91 | 0);
                      do
                         if ___conditional___ = 0 then do
                            if (accu == --[ [] ]--0) then do
                              return scan_elems$2(ib, --[ :: ]--[
                                          i,
                                          accu
                                        ]);
                            end
                             end end else 
                         if ___conditional___ = 1
                         or ___conditional___ = 2 then do
                            return List.rev(--[ :: ]--[
                                        i,
                                        accu
                                      ]);end end end 
                         do end
                        
                      end
                    end
                     end 
                  end else if (c == 59) then do
                    return scan_elems$2(ib, --[ :: ]--[
                                i,
                                accu
                              ]);
                  end
                   end  end 
                  console.log(Caml_bytes.bytes_to_string(Bytes.make(1, c)));
                  throw [
                        Caml_builtin_exceptions.failure,
                        "scan_elems"
                      ];
                end));
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Scanf.Scan_failure) then do
      Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                --[ Char_literal ]--Block.__(12, [
                    --[ "]" ]--93,
                    --[ End_of_format ]--0
                  ]),
                "]"
              ]), --[ () ]--0);
      return accu;
    end else if (exn == Caml_builtin_exceptions.end_of_file) then do
      return accu;
    end else do
      throw exn;
    end end  end 
  end
end

function test16(param) do
  if (Caml_obj.caml_equal(scan_elems$2(Scanf.Scanning.from_string("[]"), --[ [] ]--0), List.rev(--[ [] ]--0)) and Caml_obj.caml_equal(scan_elems$2(Scanf.Scanning.from_string("[1;2;3;4]"), --[ [] ]--0), List.rev(--[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ])) and Caml_obj.caml_equal(scan_elems$2(Scanf.Scanning.from_string("[1;2;3;4; ]"), --[ [] ]--0), List.rev(--[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ]))) then do
    return Caml_obj.caml_equal(scan_elems$2(Scanf.Scanning.from_string("[1;2;3;4"), --[ [] ]--0), List.rev(--[ :: ]--[
                    1,
                    --[ :: ]--[
                      2,
                      --[ :: ]--[
                        3,
                        --[ :: ]--[
                          4,
                          --[ [] ]--0
                        ]
                      ]
                    ]
                  ]));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 383, characters 5-12", test16(--[ () ]--0));

function scan_elems$3(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Scan_char_set ]--Block.__(20, [
                              undefined,
                              "\0&\0\0\x01\0\0\b\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  " %i%[]; \t\n\r]"
                ]), (function (i, s) do
                local ___conditional___=(s);
                do
                   if ___conditional___ = ";" then do
                      return scan_elems$3(ib, --[ :: ]--[
                                  i,
                                  accu
                                ]);end end end 
                   if ___conditional___ = "]" then do
                      return List.rev(--[ :: ]--[
                                  i,
                                  accu
                                ]);end end end 
                   do
                  else do
                    return List.rev(--[ :: ]--[
                                i,
                                accu
                              ]);
                    end end
                    
                end
              end));
end

function scan_int_list$2(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " [",
                --[ End_of_format ]--0
              ]),
            " ["
          ]), --[ () ]--0);
  return scan_elems$3(ib, --[ [] ]--0);
end

function test17(param) do
  if (Caml_obj.caml_equal(scan_int_list$2(Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ]) and Caml_obj.caml_equal(scan_int_list$2(Scanf.Scanning.from_string("[1;2;3;4; ]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_int_list$2(Scanf.Scanning.from_string("[1;2;3;4 5]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 406, characters 5-12", test17(--[ () ]--0));

function scan_rest(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ End_of_format ]--0
                            ])])
                    ]),
                  " %c "
                ]), (function (c) do
                if (c ~= 59) then do
                  if (c ~= 93) then do
                    throw [
                          Caml_builtin_exceptions.failure,
                          "scan_rest"
                        ];
                  end
                   end 
                  return accu;
                end else do
                  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                  --[ Scan_char_set ]--Block.__(20, [
                                      undefined,
                                      "\0\0\0\0\0\0\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                      --[ End_of_format ]--0
                                    ]),
                                  "%[]]"
                                ]), (function (param) do
                                if (param == "]") then do
                                  return accu;
                                end else do
                                  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ " " ]--32,
                                                      --[ Int ]--Block.__(4, [
                                                          --[ Int_i ]--3,
                                                          --[ No_padding ]--0,
                                                          --[ No_precision ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ " " ]--32,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ]),
                                                  " %i "
                                                ]), (function (i) do
                                                return scan_rest(ib, --[ :: ]--[
                                                            i,
                                                            accu
                                                          ]);
                                              end));
                                end end 
                              end));
                end end 
              end));
end

function scan_elems$4(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ End_of_format ]--0
                            ])])
                    ]),
                  " %c "
                ]), (function (c) do
                if (c ~= 91) then do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "scan_elems"
                      ];
                end
                 end 
                if (accu == --[ [] ]--0) then do
                  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                  --[ Scan_char_set ]--Block.__(20, [
                                      undefined,
                                      "\0\0\0\0\0\0\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                      --[ End_of_format ]--0
                                    ]),
                                  "%[]]"
                                ]), (function (param) do
                                if (param == "]") then do
                                  return accu;
                                end else do
                                  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ " " ]--32,
                                                      --[ Int ]--Block.__(4, [
                                                          --[ Int_i ]--3,
                                                          --[ No_padding ]--0,
                                                          --[ No_precision ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ " " ]--32,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ]),
                                                  " %i "
                                                ]), (function (i) do
                                                return scan_rest(ib, --[ :: ]--[
                                                            i,
                                                            accu
                                                          ]);
                                              end));
                                end end 
                              end));
                end else do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "scan_elems"
                      ];
                end end 
              end));
end

function scan_int_list$3(ib) do
  return List.rev(scan_elems$4(ib, --[ [] ]--0));
end

function test18(param) do
  var ib = Scanf.Scanning.from_string("[]");
  if (List.rev(scan_elems$4(ib, --[ [] ]--0)) == --[ [] ]--0) then do
    var ib$1 = Scanf.Scanning.from_string("[ ]");
    if (List.rev(scan_elems$4(ib$1, --[ [] ]--0)) == --[ [] ]--0) then do
      var ib$2 = Scanf.Scanning.from_string("[1;2;3;4]");
      if (Caml_obj.caml_equal(List.rev(scan_elems$4(ib$2, --[ [] ]--0)), --[ :: ]--[
              1,
              --[ :: ]--[
                2,
                --[ :: ]--[
                  3,
                  --[ :: ]--[
                    4,
                    --[ [] ]--0
                  ]
                ]
              ]
            ])) then do
        var ib$3 = Scanf.Scanning.from_string("[1;2;3;4; ]");
        return Caml_obj.caml_equal(List.rev(scan_elems$4(ib$3, --[ [] ]--0)), --[ :: ]--[
                    1,
                    --[ :: ]--[
                      2,
                      --[ :: ]--[
                        3,
                        --[ :: ]--[
                          4,
                          --[ [] ]--0
                        ]
                      ]
                    ]
                  ]);
      end else do
        return false;
      end end 
    end else do
      return false;
    end end 
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 446, characters 5-12", test18(--[ () ]--0));

function test19(param) do
  return Testing.failure_test(scan_int_list$3, Scanf.Scanning.from_string("[1;2;3;4 5]"), "scan_rest");
end

test19(--[ () ]--0);

function test20(param) do
  return Testing.scan_failure_test(scan_int_list$3, Scanf.Scanning.from_string("[1;2;3;4;; 5]"));
end

test20(--[ () ]--0);

function test21(param) do
  return Testing.scan_failure_test(scan_int_list$3, Scanf.Scanning.from_string("[1;2;3;4;;"));
end

test21(--[ () ]--0);

function scan_rest$1(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\0\0\0\0\0\0\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[ End_of_format ]--0
                    ]),
                  "%[]]"
                ]), (function (param) do
                if (param == "]") then do
                  return accu;
                end else do
                  var ib$1 = ib;
                  var accu$1 = accu;
                  return Curry._1(Scanf.bscanf(ib$1, --[ Format ]--[
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ " " ]--32,
                                      --[ Int ]--Block.__(4, [
                                          --[ Int_i ]--3,
                                          --[ No_padding ]--0,
                                          --[ No_precision ]--0,
                                          --[ Char_literal ]--Block.__(12, [
                                              --[ " " ]--32,
                                              --[ End_of_format ]--0
                                            ])
                                        ])
                                    ]),
                                  " %i "
                                ]), (function (i) do
                                var ib$2 = ib$1;
                                var accu$2 = --[ :: ]--[
                                  i,
                                  accu$1
                                ];
                                return Curry._1(Scanf.bscanf(ib$2, --[ Format ]--[
                                                --[ Scan_char_set ]--Block.__(20, [
                                                    1,
                                                    "\0\0\0\0\0\0\0\b\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                                    --[ End_of_format ]--0
                                                  ]),
                                                "%1[];]"
                                              ]), (function (param) do
                                              local ___conditional___=(param);
                                              do
                                                 if ___conditional___ = ";" then do
                                                    return scan_rest$1(ib$2, accu$2);end end end 
                                                 if ___conditional___ = "]" then do
                                                    return accu$2;end end end 
                                                 do
                                                else do
                                                  var s = Printf.sprintf(--[ Format ]--[
                                                        --[ String_literal ]--Block.__(11, [
                                                            "scan_int_list",
                                                            --[ End_of_format ]--0
                                                          ]),
                                                        "scan_int_list"
                                                      ]);
                                                  throw [
                                                        Caml_builtin_exceptions.failure,
                                                        s
                                                      ];
                                                  end end
                                                  
                                              end
                                            end));
                              end));
                end end 
              end));
end

function scan_int_list$4(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " [ ",
                --[ End_of_format ]--0
              ]),
            " [ "
          ]), --[ () ]--0);
  return List.rev(scan_rest$1(ib, --[ [] ]--0));
end

function test22(param) do
  if (scan_int_list$4(Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and scan_int_list$4(Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_int_list$4(Scanf.Scanning.from_string("[1]")), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_int_list$4(Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_int_list$4(Scanf.Scanning.from_string("[1;2;3;4;]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 506, characters 5-12", test22(--[ () ]--0));

function scan_elems$5(ib, scan_elem, accu) do
  try do
    return Curry._2(scan_elem, ib, (function (i, s) do
                  var accu$1 = --[ :: ]--[
                    i,
                    accu
                  ];
                  if (s == "") then do
                    return accu$1;
                  end else do
                    return scan_elems$5(ib, scan_elem, accu$1);
                  end end 
                end));
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Scanf.Scan_failure) then do
      return accu;
    end else do
      throw exn;
    end end 
  end
end

function scan_list(scan_elem, ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems$5(ib, scan_elem, --[ [] ]--0);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

function scan_int_elem(ib) do
  return Scanf.bscanf(ib, --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ Int ]--Block.__(4, [
                      --[ Int_i ]--3,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Scan_char_set ]--Block.__(20, [
                              1,
                              "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              " %i %1[;]"
            ]);
end

function scan_int_list$5(param) do
  return scan_list(scan_int_elem, param);
end

function test23(param) do
  if (scan_list(scan_int_elem, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and scan_list(scan_int_elem, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_list(scan_int_elem, Scanf.Scanning.from_string("[1]")), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_list(scan_int_elem, Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_list(scan_int_elem, Scanf.Scanning.from_string("[1;2;3;4;]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 562, characters 5-12", test23(--[ () ]--0));

function test24(param) do
  return Testing.scan_failure_test(scan_int_list$5, Scanf.Scanning.from_string("[1;2;3;4 5]"));
end

function test25(param) do
  return Testing.scan_failure_test(scan_int_list$5, Scanf.Scanning.from_string("[1;2;3;4;;"));
end

function test26(param) do
  return Testing.scan_failure_test(scan_int_list$5, Scanf.Scanning.from_string("[1;2;3;4;; 5]"));
end

function test27(param) do
  return Testing.scan_failure_test(scan_int_list$5, Scanf.Scanning.from_string("[1;2;3;4;; 23]"));
end

test24(--[ () ]--0) and test25(--[ () ]--0) and test26(--[ () ]--0) and test27(--[ () ]--0);

function scan_string_elem(ib) do
  return Scanf.bscanf(ib, --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  " \"",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Scan_indic ]--Block.__(2, [--[ "\"" ]--34]),
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Scan_char_set ]--Block.__(20, [
                                  1,
                                  "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ])
                ]),
              " \"%s@\" %1[;]"
            ]);
end

function scan_String_elem(ib) do
  return Scanf.bscanf(ib, --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ Caml_string ]--Block.__(3, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Scan_char_set ]--Block.__(20, [
                              1,
                              "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              " %S %1[;]"
            ]);
end

function scan_String_list(param) do
  return scan_list(scan_String_elem, param);
end

function test28(param) do
  if (scan_list(scan_string_elem, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_list(scan_string_elem, Scanf.Scanning.from_string("[\"Le\"]")), --[ :: ]--[
          "Le",
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_list(scan_string_elem, Scanf.Scanning.from_string("[\"Le\";\"langage\";\"Objective\";\"Caml\"]")), --[ :: ]--[
          "Le",
          --[ :: ]--[
            "langage",
            --[ :: ]--[
              "Objective",
              --[ :: ]--[
                "Caml",
                --[ [] ]--0
              ]
            ]
          ]
        ]) and Caml_obj.caml_equal(scan_list(scan_string_elem, Scanf.Scanning.from_string("[\"Le\";\"langage\";\"Objective\";\"Caml\"; ]")), --[ :: ]--[
          "Le",
          --[ :: ]--[
            "langage",
            --[ :: ]--[
              "Objective",
              --[ :: ]--[
                "Caml",
                --[ [] ]--0
              ]
            ]
          ]
        ]) and scan_String_list(Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_String_list(Scanf.Scanning.from_string("[\"Le\"]")), --[ :: ]--[
          "Le",
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_String_list(Scanf.Scanning.from_string("[\"Le\";\"langage\";\"Objective\";\"Caml\"]")), --[ :: ]--[
          "Le",
          --[ :: ]--[
            "langage",
            --[ :: ]--[
              "Objective",
              --[ :: ]--[
                "Caml",
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_String_list(Scanf.Scanning.from_string("[\"Le\";\"langage\";\"Objective\";\"Caml\"; ]")), --[ :: ]--[
                "Le",
                --[ :: ]--[
                  "langage",
                  --[ :: ]--[
                    "Objective",
                    --[ :: ]--[
                      "Caml",
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 609, characters 5-12", test28(--[ () ]--0));

function scan_elems$6(ib, scan_elem, accu) do
  return Curry._3(scan_elem, ib, (function (i, s) do
                var accu$1 = --[ :: ]--[
                  i,
                  accu
                ];
                if (s == "") then do
                  return accu$1;
                end else do
                  return scan_elems$6(ib, scan_elem, accu$1);
                end end 
              end), (function (ib, exc) do
                return accu;
              end));
end

function scan_list$1(scan_elem, ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems$6(ib, scan_elem, --[ [] ]--0);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

function scan_int_elem$1(ib, f, ek) do
  return Curry._1(Scanf.kscanf(ib, ek, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Scan_char_set ]--Block.__(20, [
                                  1,
                                  "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  " %i %1[;]"
                ]), f);
end

function test29(param) do
  if (scan_list$1(scan_int_elem$1, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and scan_list$1(scan_int_elem$1, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_list$1(scan_int_elem$1, Scanf.Scanning.from_string("[1]")), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_list$1(scan_int_elem$1, Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_list$1(scan_int_elem$1, Scanf.Scanning.from_string("[1;2;3;4;]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 639, characters 5-12", test29(--[ () ]--0));

function scan_string_elem$1(ib, f, ek) do
  return Curry._1(Scanf.kscanf(ib, ek, --[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Caml_string ]--Block.__(3, [
                          --[ No_padding ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ " " ]--32,
                              --[ Scan_char_set ]--Block.__(20, [
                                  1,
                                  "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  " %S %1[;]"
                ]), f);
end

function test30(param) do
  if (scan_list$1(scan_string_elem$1, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and scan_list$1(scan_string_elem$1, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(scan_list$1(scan_string_elem$1, Scanf.Scanning.from_string("[ \"1\" ]")), --[ :: ]--[
          "1",
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(scan_list$1(scan_string_elem$1, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\"]")), --[ :: ]--[
          "1",
          --[ :: ]--[
            "2",
            --[ :: ]--[
              "3",
              --[ :: ]--[
                "4",
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(scan_list$1(scan_string_elem$1, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\";]")), --[ :: ]--[
                "1",
                --[ :: ]--[
                  "2",
                  --[ :: ]--[
                    "3",
                    --[ :: ]--[
                      "4",
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 656, characters 5-12", test30(--[ () ]--0));

function scan_elem(fmt, ib, f, ek) do
  return Curry._1(Scanf.kscanf(ib, ek, fmt), f);
end

function scan_elems$7(ib, scan_elem, accu) do
  return Curry._3(scan_elem, ib, (function (i) do
                var accu$1 = --[ :: ]--[
                  i,
                  accu
                ];
                return Curry._1(Scanf.kscanf(ib, (function (ib, exc) do
                                  return accu$1;
                                end), --[ Format ]--[
                                --[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ Scan_char_set ]--Block.__(20, [
                                        1,
                                        "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                        --[ End_of_format ]--0
                                      ])
                                  ]),
                                " %1[;]"
                              ]), (function (s) do
                              if (s == "") then do
                                return accu$1;
                              end else do
                                return scan_elems$7(ib, scan_elem, accu$1);
                              end end 
                            end));
              end), (function (ib, exc) do
                return accu;
              end));
end

function scan_list$2(scan_elem, ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems$7(ib, scan_elem, --[ [] ]--0);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

var partial_arg$1 = --[ Format ]--[
  --[ Char_literal ]--Block.__(12, [
      --[ " " ]--32,
      --[ Int ]--Block.__(4, [
          --[ Int_i ]--3,
          --[ No_padding ]--0,
          --[ No_precision ]--0,
          --[ End_of_format ]--0
        ])
    ]),
  " %i"
];

function partial_arg$2(param, param$1, param$2) do
  return scan_elem(partial_arg$1, param, param$1, param$2);
end

function scan_int_list$6(param) do
  return scan_list$2(partial_arg$2, param);
end

var partial_arg$3 = --[ Format ]--[
  --[ Char_literal ]--Block.__(12, [
      --[ " " ]--32,
      --[ Caml_string ]--Block.__(3, [
          --[ No_padding ]--0,
          --[ End_of_format ]--0
        ])
    ]),
  " %S"
];

function partial_arg$4(param, param$1, param$2) do
  return scan_elem(partial_arg$3, param, param$1, param$2);
end

function scan_string_list(param) do
  return scan_list$2(partial_arg$4, param);
end

function test31(param) do
  if (Curry._1(scan_int_list$6, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Curry._1(scan_int_list$6, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(Curry._1(scan_int_list$6, Scanf.Scanning.from_string("[1]")), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(Curry._1(scan_int_list$6, Scanf.Scanning.from_string("[1;2;3;4]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(Curry._1(scan_int_list$6, Scanf.Scanning.from_string("[1;2;3;4;]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 714, characters 5-12", test31(--[ () ]--0));

function test32(param) do
  if (Curry._1(scan_string_list, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Curry._1(scan_string_list, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(Curry._1(scan_string_list, Scanf.Scanning.from_string("[ \"1\" ]")), --[ :: ]--[
          "1",
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(Curry._1(scan_string_list, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\"]")), --[ :: ]--[
          "1",
          --[ :: ]--[
            "2",
            --[ :: ]--[
              "3",
              --[ :: ]--[
                "4",
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(Curry._1(scan_string_list, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\";]")), --[ :: ]--[
                "1",
                --[ :: ]--[
                  "2",
                  --[ :: ]--[
                    "3",
                    --[ :: ]--[
                      "4",
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 728, characters 5-12", test32(--[ () ]--0));

function scan_elems$8(ib, scan_elem_fmt, accu) do
  return Curry._1(Scanf.kscanf(ib, (function (ib, exc) do
                    return accu;
                  end), scan_elem_fmt), (function (i) do
                var accu$1 = --[ :: ]--[
                  i,
                  accu
                ];
                return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                --[ Char_literal ]--Block.__(12, [
                                    --[ " " ]--32,
                                    --[ Scan_char_set ]--Block.__(20, [
                                        1,
                                        "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ " " ]--32,
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ]),
                                " %1[;] "
                              ]), (function (param) do
                              if (param == "") then do
                                return accu$1;
                              end else do
                                return scan_elems$8(ib, scan_elem_fmt, accu$1);
                              end end 
                            end));
              end));
end

function scan_list$3(scan_elem_fmt, ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems$8(ib, scan_elem_fmt, --[ [] ]--0);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

var partial_arg$5 = --[ Format ]--[
  --[ Int ]--Block.__(4, [
      --[ Int_i ]--3,
      --[ No_padding ]--0,
      --[ No_precision ]--0,
      --[ End_of_format ]--0
    ]),
  "%i"
];

function scan_int_list$7(param) do
  return scan_list$3(partial_arg$5, param);
end

var partial_arg$6 = --[ Format ]--[
  --[ Caml_string ]--Block.__(3, [
      --[ No_padding ]--0,
      --[ End_of_format ]--0
    ]),
  "%S"
];

function scan_string_list$1(param) do
  return scan_list$3(partial_arg$6, param);
end

function test33(param) do
  if (Curry._1(scan_int_list$7, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Curry._1(scan_int_list$7, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(Curry._1(scan_int_list$7, Scanf.Scanning.from_string("[ 1 ]")), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(Curry._1(scan_int_list$7, Scanf.Scanning.from_string("[ 1; 2; 3; 4 ]")), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(Curry._1(scan_int_list$7, Scanf.Scanning.from_string("[1;2;3;4;]")), --[ :: ]--[
                1,
                --[ :: ]--[
                  2,
                  --[ :: ]--[
                    3,
                    --[ :: ]--[
                      4,
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 773, characters 5-12", test33(--[ () ]--0));

function test34(param) do
  if (Curry._1(scan_string_list$1, Scanf.Scanning.from_string("[]")) == --[ [] ]--0 and Curry._1(scan_string_list$1, Scanf.Scanning.from_string("[ ]")) == --[ [] ]--0 and Caml_obj.caml_equal(Curry._1(scan_string_list$1, Scanf.Scanning.from_string("[ \"1\" ]")), --[ :: ]--[
          "1",
          --[ [] ]--0
        ]) and Caml_obj.caml_equal(Curry._1(scan_string_list$1, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\"]")), --[ :: ]--[
          "1",
          --[ :: ]--[
            "2",
            --[ :: ]--[
              "3",
              --[ :: ]--[
                "4",
                --[ [] ]--0
              ]
            ]
          ]
        ])) then do
    return Caml_obj.caml_equal(Curry._1(scan_string_list$1, Scanf.Scanning.from_string("[\"1\"; \"2\"; \"3\"; \"4\";]")), --[ :: ]--[
                "1",
                --[ :: ]--[
                  "2",
                  --[ :: ]--[
                    "3",
                    --[ :: ]--[
                      "4",
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 787, characters 5-12", test34(--[ () ]--0));

function scan_elems$9(scan_elem, accu, ib) do
  return Curry._2(Scanf.kscanf(ib, (function (ib, exc) do
                    return accu;
                  end), --[ Format ]--[
                  --[ Reader ]--Block.__(19, [--[ End_of_format ]--0]),
                  "%r"
                ]), (function (ib) do
                return Curry._2(scan_elem, ib, (function (elem) do
                              var accu$1 = --[ :: ]--[
                                elem,
                                accu
                              ];
                              return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                              --[ Char_literal ]--Block.__(12, [
                                                  --[ " " ]--32,
                                                  --[ Scan_char_set ]--Block.__(20, [
                                                      1,
                                                      "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                                      --[ Char_literal ]--Block.__(12, [
                                                          --[ " " ]--32,
                                                          --[ End_of_format ]--0
                                                        ])
                                                    ])
                                                ]),
                                              " %1[;] "
                                            ]), (function (param) do
                                            if (param == "") then do
                                              return accu$1;
                                            end else do
                                              return scan_elems$9(scan_elem, accu$1, ib);
                                            end end 
                                          end));
                            end));
              end), (function (l) do
                return l;
              end));
end

function scan_list$4(scan_elem, ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[ ",
                --[ End_of_format ]--0
              ]),
            "[ "
          ]), --[ () ]--0);
  var accu = scan_elems$9(scan_elem, --[ [] ]--0, ib);
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " ]",
                --[ End_of_format ]--0
              ]),
            " ]"
          ]), --[ () ]--0);
  return List.rev(accu);
end

function scan_float(ib) do
  return Scanf.bscanf(ib, --[ Format ]--[
              --[ Float ]--Block.__(8, [
                  --[ Float_f ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%f"
            ]);
end

function scan_int_list$8(param) do
  return scan_list$4((function (ib) do
                return Scanf.bscanf(ib, --[ Format ]--[
                            --[ Int ]--Block.__(4, [
                                --[ Int_i ]--3,
                                --[ No_padding ]--0,
                                --[ No_precision ]--0,
                                --[ End_of_format ]--0
                              ]),
                            "%i"
                          ]);
              end), param);
end

function scan_string_list$2(param) do
  return scan_list$4((function (ib) do
                return Scanf.bscanf(ib, --[ Format ]--[
                            --[ Caml_string ]--Block.__(3, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ]),
                            "%S"
                          ]);
              end), param);
end

function scan_bool_list(param) do
  return scan_list$4((function (ib) do
                return Scanf.bscanf(ib, --[ Format ]--[
                            --[ Bool ]--Block.__(9, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ]),
                            "%B"
                          ]);
              end), param);
end

function scan_char_list(param) do
  return scan_list$4((function (ib) do
                return Scanf.bscanf(ib, --[ Format ]--[
                            --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0]),
                            "%C"
                          ]);
              end), param);
end

function scan_float_list_list(param) do
  return scan_list$4((function (ib, k) do
                return Curry._1(k, scan_list$4(scan_float, ib));
              end), param);
end

function test340(param) do
  return Caml_obj.caml_equal(scan_float_list_list(Scanf.Scanning.from_string("[[1.0] ; []; [2.0; 3; 5.0; 6.];]")), --[ :: ]--[
              --[ :: ]--[
                1,
                --[ [] ]--0
              ],
              --[ :: ]--[
                --[ [] ]--0,
                --[ :: ]--[
                  --[ :: ]--[
                    2,
                    --[ :: ]--[
                      3,
                      --[ :: ]--[
                        5,
                        --[ :: ]--[
                          6,
                          --[ [] ]--0
                        ]
                      ]
                    ]
                  ],
                  --[ [] ]--0
                ]
              ]
            ]);
end

function scan_list_list(scan_elems, ib) do
  return scan_list$4((function (ib, k) do
                return Curry._1(k, Curry._1(scan_elems, ib));
              end), ib);
end

function scan_float_item(ib, k) do
  return Curry._1(k, Curry._1(scan_float(ib), (function (x) do
                    return x;
                  end)));
end

function scan_float_list(ib, k) do
  return Curry._1(k, scan_list$4(scan_float_item, ib));
end

function scan_float_list_list$1(ib, k) do
  return Curry._1(k, scan_list$4(scan_float_list, ib));
end

function test35(param) do
  if (Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Scan_get_counter ]--Block.__(21, [
                  --[ Token_counter ]--2,
                  --[ End_of_format ]--0
                ]),
              "%N"
            ]), (function (x) do
            return x;
          end)) == 0 and Curry._1(Scanf.sscanf("456", --[ Format ]--[
              --[ Scan_get_counter ]--Block.__(21, [
                  --[ Token_counter ]--2,
                  --[ End_of_format ]--0
                ]),
              "%N"
            ]), (function (x) do
            return x;
          end)) == 0 and Caml_obj.caml_equal(Curry._1(Scanf.sscanf("456", --[ Format ]--[
                  --[ Int ]--Block.__(4, [
                      --[ Int_d ]--0,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Scan_get_counter ]--Block.__(21, [
                          --[ Token_counter ]--2,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "%d%N"
                ]), (function (x, y) do
                return --[ tuple ]--[
                        x,
                        y
                      ];
              end)), --[ tuple ]--[
          456,
          1
        ])) then do
    return Caml_obj.caml_equal(Curry._1(Scanf.sscanf(" ", --[ Format ]--[
                        --[ Scan_get_counter ]--Block.__(21, [
                            --[ Token_counter ]--2,
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ Scan_get_counter ]--Block.__(21, [
                                    --[ Token_counter ]--2,
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ]),
                        "%N%s%N"
                      ]), (function (x, s, y) do
                      return --[ tuple ]--[
                              x,
                              s,
                              y
                            ];
                    end)), --[ tuple ]--[
                0,
                "",
                1
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 940, characters 5-12", test340(--[ () ]--0) and test35(--[ () ]--0));

function read_elems(read_elem, accu, ib) do
  return Curry._2(Scanf.kscanf(ib, (function (ib, exc) do
                    return accu;
                  end), --[ Format ]--[
                  --[ Reader ]--Block.__(19, [--[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Scan_char_set ]--Block.__(20, [
                              1,
                              "\0\0\0\0\0\0\0\b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                              --[ Char_literal ]--Block.__(12, [
                                  --[ " " ]--32,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])]),
                  "%r %1[;] "
                ]), Curry._1(read_elem, (function (elem) do
                    return --[ :: ]--[
                            elem,
                            accu
                          ];
                  end)), (function (accu, s) do
                if (s == "") then do
                  return accu;
                end else do
                  return read_elems(read_elem, accu, ib);
                end end 
              end));
end

function read_list(read_elem, ib) do
  return Curry._2(Scanf.bscanf(ib, --[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "[ ",
                      --[ Reader ]--Block.__(19, [--[ String_literal ]--Block.__(11, [
                              " ]",
                              --[ End_of_format ]--0
                            ])])
                    ]),
                  "[ %r ]"
                ]), (function (param) do
                return read_elems(read_elem, --[ [] ]--0, param);
              end), List.rev);
end

function make_read_elem(fmt, f, ib) do
  return Curry._1(Scanf.bscanf(ib, fmt), f);
end

function scan_List(fmt) do
  return (function (param) do
      return read_list((function (param, param$1) do
                    return Curry._1(Scanf.bscanf(param$1, fmt), param);
                  end), param);
    end);
end

function test36(param) do
  if (Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Scan_get_counter ]--Block.__(21, [
                  --[ Char_counter ]--1,
                  --[ End_of_format ]--0
                ]),
              "%n"
            ]), (function (x) do
            return x;
          end)) == 0 and Curry._1(Scanf.sscanf("456", --[ Format ]--[
              --[ Scan_get_counter ]--Block.__(21, [
                  --[ Char_counter ]--1,
                  --[ End_of_format ]--0
                ]),
              "%n"
            ]), (function (x) do
            return x;
          end)) == 0 and Caml_obj.caml_equal(Curry._1(Scanf.sscanf("456", --[ Format ]--[
                  --[ Int ]--Block.__(4, [
                      --[ Int_d ]--0,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Scan_get_counter ]--Block.__(21, [
                          --[ Char_counter ]--1,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "%d%n"
                ]), (function (x, y) do
                return --[ tuple ]--[
                        x,
                        y
                      ];
              end)), --[ tuple ]--[
          456,
          3
        ])) then do
    return Caml_obj.caml_equal(Curry._1(Scanf.sscanf(" ", --[ Format ]--[
                        --[ Scan_get_counter ]--Block.__(21, [
                            --[ Char_counter ]--1,
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ Scan_get_counter ]--Block.__(21, [
                                    --[ Char_counter ]--1,
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ]),
                        "%n%s%n"
                      ]), (function (x, s, y) do
                      return --[ tuple ]--[
                              x,
                              s,
                              y
                            ];
                    end)), --[ tuple ]--[
                0,
                "",
                0
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 995, characters 5-12", test36(--[ () ]--0));

function test37(param) do
  if (Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ End_of_format ]--0,
              ""
            ]), true) and Curry._2(Scanf.sscanf("", --[ Format ]--[
              --[ End_of_format ]--0,
              ""
            ]), (function (x) do
            return x;
          end), 1) == 1) then do
    return Curry._2(Scanf.sscanf("123", --[ Format ]--[
                    --[ End_of_format ]--0,
                    ""
                  ]), (function (x) do
                  return x;
                end), 1) == 1;
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1005, characters 5-12", test37(--[ () ]--0));

function test38(param) do
  if (Curry._1(Scanf.sscanf("a", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ "a" ]--97,
                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                ]),
              "a%!"
            ]), true) and Curry._1(Scanf.sscanf("a", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ "a" ]--97,
                  --[ Flush ]--Block.__(10, [--[ Flush ]--Block.__(10, [--[ End_of_format ]--0])])
                ]),
              "a%!%!"
            ]), true) and Curry._1(Scanf.sscanf(" a", --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  " a",
                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                ]),
              " a%!"
            ]), true) and Curry._1(Scanf.sscanf("a ", --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "a ",
                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                ]),
              "a %!"
            ]), true) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Flush ]--Block.__(10, [--[ End_of_format ]--0]),
              "%!"
            ]), true) and Curry._1(Scanf.sscanf(" ", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                ]),
              " %!"
            ]), true) and Curry._1(Scanf.sscanf("", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ " " ]--32,
                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                ]),
              " %!"
            ]), true)) then do
    return Curry._1(Scanf.sscanf("", --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ Flush ]--Block.__(10, [--[ Flush ]--Block.__(10, [--[ End_of_format ]--0])])
                      ]),
                    " %!%!"
                  ]), true);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1020, characters 5-12", test38(--[ () ]--0));

function test39(param) do
  var is_empty_buff = function (ib) do
    if (Scanf.Scanning.beginning_of_input(ib)) then do
      return Scanf.Scanning.end_of_input(ib);
    end else do
      return false;
    end end 
  end;
  var ib = Scanf.Scanning.from_string("");
  if (is_empty_buff(ib)) then do
    return is_empty_buff(ib);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1036, characters 5-12", test39(--[ () ]--0));

function test40(param) do
  var ib = Scanf.Scanning.from_string("cba");
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf9\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ]),
                  "%[^ab]%s%!"
                ]), (function (s1, s2) do
                if (s1 == "c") then do
                  return s2 == "ba";
                end else do
                  return false;
                end end 
              end));
end

test("File \"tscanf_test.ml\", line 1046, characters 5-12", test40(--[ () ]--0));

function test41(param) do
  var ib = Scanf.Scanning.from_string("cba");
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf1\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                      --[ Scan_char_set ]--Block.__(20, [
                          undefined,
                          "\0\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ]),
                  "%[^abc]%[cba]%!"
                ]), (function (s1, s2) do
                if (s1 == "") then do
                  return s2 == "cba";
                end else do
                  return false;
                end end 
              end));
end

test("File \"tscanf_test.ml\", line 1055, characters 5-12", test41(--[ () ]--0));

function test42(param) do
  var s = "defcbaaghi";
  var ib = Scanf.Scanning.from_string(s);
  if (Curry._1(Scanf.bscanf(ib, --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf1\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\0\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ])
                ]),
              "%[^abc]%[abc]%s%!"
            ]), (function (s1, s2, s3) do
            if (s1 == "def" and s2 == "cbaa") then do
              return s3 == "ghi";
            end else do
              return false;
            end end 
          end))) then do
    var ib$1 = Scanf.Scanning.from_string(s);
    return Curry._1(Scanf.bscanf(ib$1, --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Scan_indic ]--Block.__(2, [--[ "\t" ]--9]),
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "%s@\t"
                  ]), (function (s) do
                  return s == "defcbaaghi";
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1067, characters 5-12", test42(--[ () ]--0));

var ib$1 = Scanf.Scanning.from_string("");

function test43(param) do
  return Curry._1(Scanf.bscanf(ib$1, --[ Format ]--[
                  --[ Int ]--Block.__(4, [
                      --[ Int_i ]--3,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                    ]),
                  "%i%!"
                ]), (function (i) do
                return i;
              end));
end

function test44(param) do
  return Curry._1(Scanf.bscanf(ib$1, --[ Format ]--[
                  --[ Flush ]--Block.__(10, [--[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ End_of_format ]--0
                        ])]),
                  "%!%i"
                ]), (function (i) do
                return i;
              end));
end

Testing.test_raises_this_exc(Caml_builtin_exceptions.end_of_file)(test43, --[ () ]--0) and Testing.test_raises_this_exc(Caml_builtin_exceptions.end_of_file)(test44, --[ () ]--0);

function test45(param) do
  var ib = Scanf.Scanning.from_string("12.2");
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\0\0\0\0\0\0\xff\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[ Char_literal ]--Block.__(12, [
                          --[ "." ]--46,
                          --[ Scan_char_set ]--Block.__(20, [
                              undefined,
                              "\0\0\0\0\0\0\xff\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                                ])
                            ])
                        ])
                    ]),
                  "%[0-9].%[0-9]%s%!"
                ]), (function (s1, s2, s3) do
                if (s1 == "12" and s2 == "2") then do
                  return s3 == "";
                end else do
                  return false;
                end end 
              end));
end

test("File \"tscanf_test.ml\", line 1090, characters 5-12", test45(--[ () ]--0));

function test46(param) do
  return Curry._3(Printf.sprintf(--[ Format ]--[
                  --[ Int ]--Block.__(4, [
                      --[ Int_i ]--3,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Format_subst ]--Block.__(14, [
                              undefined,
                              --[ String_ty ]--Block.__(1, [--[ End_of_fmtty ]--0]),
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "." ]--46,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  "%i %(%s%)."
                ]), 1, --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "spells one, ",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "spells one, %s"
            ], "in english");
end

function test47(param) do
  return Curry._3(Printf.sprintf(--[ Format ]--[
                  --[ Int ]--Block.__(4, [
                      --[ Int_i ]--3,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ " " ]--32,
                          --[ Format_arg ]--Block.__(13, [
                              undefined,
                              --[ String_ty ]--Block.__(1, [--[ End_of_fmtty ]--0]),
                              --[ String_literal ]--Block.__(11, [
                                  ", ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ Char_literal ]--Block.__(12, [
                                          --[ "." ]--46,
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "%i %{%s%}, %s."
                ]), 1, --[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "spells one ",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "spells one %s"
            ], "in english");
end

test("File \"tscanf_test.ml\", line 1104, characters 5-12", test46(--[ () ]--0) == "1 spells one, in english.");

test("File \"tscanf_test.ml\", line 1106, characters 5-12", test47(--[ () ]--0) == "1 %s, in english.");

function test48(param) do
  var test_meta_read = function (s, fmt, efmt) do
    return Caml_obj.caml_equal(Scanf.format_from_string(s, fmt), efmt);
  end;
  var fmt = --[ Format ]--[
    --[ Int ]--Block.__(4, [
        --[ Int_i ]--3,
        --[ No_padding ]--0,
        --[ No_precision ]--0,
        --[ End_of_format ]--0
      ]),
    "%i"
  ];
  if (test_meta_read("%i", fmt, fmt) and test_meta_read("%i", --[ Format ]--[
          --[ Int ]--Block.__(4, [
              --[ Int_d ]--0,
              --[ No_padding ]--0,
              --[ No_precision ]--0,
              --[ End_of_format ]--0
            ]),
          "%d"
        ], --[ Format ]--[
          --[ Int ]--Block.__(4, [
              --[ Int_i ]--3,
              --[ No_padding ]--0,
              --[ No_precision ]--0,
              --[ End_of_format ]--0
            ]),
          "%i"
        ]) and Curry._1(Scanf.sscanf("12 \"%i\"89 ", --[ Format ]--[
              --[ Int ]--Block.__(4, [
                  --[ Int_i ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ Format_arg ]--Block.__(13, [
                          undefined,
                          --[ Int_ty ]--Block.__(2, [--[ End_of_fmtty ]--0]),
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ " " ]--32,
                                  --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                                ])
                            ])
                        ])
                    ])
                ]),
              "%i %{%d%}%s %!"
            ]), (function (i, f, s) do
            if (i == 12 and Caml_obj.caml_equal(f, --[ Format ]--[
                    --[ Int ]--Block.__(4, [
                        --[ Int_i ]--3,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%i"
                  ])) then do
              return s == "89";
            end else do
              return false;
            end end 
          end))) then do
    var k = function (s) do
      return Curry._1(Scanf.sscanf(s, --[ Format ]--[
                      --[ Format_subst ]--Block.__(14, [
                          undefined,
                          --[ Float_ty ]--Block.__(6, [--[ End_of_fmtty ]--0]),
                          --[ End_of_format ]--0
                        ]),
                      "%(%f%)"
                    ]), (function (_fmt, i) do
                    return i;
                  end));
    end;
    if (k("\" : %1f\": 987654321") == 9.0 and k("\" : %2f\": 987654321") == 98.0 and k("\" : %3f\": 9.87654321") == 9.8 and k("\" : %4f\": 9.87654321") == 9.87) then do
      var h = function (s) do
        return Curry._1(Scanf.sscanf(s, --[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "Read integers with ",
                            --[ Format_subst ]--Block.__(14, [
                                undefined,
                                --[ Int_ty ]--Block.__(2, [--[ End_of_fmtty ]--0]),
                                --[ End_of_format ]--0
                              ])
                          ]),
                        "Read integers with %(%i%)"
                      ]), (function (_fmt, i) do
                      return i;
                    end));
      end;
      if (h("Read integers with \"%1d\"987654321") == 9 and h("Read integers with \"%2d\"987654321") == 98 and h("Read integers with \"%3u\"987654321") == 987 and h("Read integers with \"%4x\"987654321") == 39030) then do
        var i = function (s) do
          return Curry._1(Scanf.sscanf(s, --[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "with ",
                              --[ Format_subst ]--Block.__(14, [
                                  undefined,
                                  --[ Int_ty ]--Block.__(2, [--[ String_ty ]--Block.__(1, [--[ End_of_fmtty ]--0])]),
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "with %(%i %s%)"
                        ]), (function (_fmt, amount, currency) do
                        return --[ tuple ]--[
                                amount,
                                currency
                              ];
                      end));
        end;
        if (Caml_obj.caml_equal(i("with \" : %d %s\" :        21 euros"), --[ tuple ]--[
                21,
                "euros"
              ]) and Caml_obj.caml_equal(i("with \" : %d %s\" : 987654321 dollars"), --[ tuple ]--[
                987654321,
                "dollars"
              ]) and Caml_obj.caml_equal(i("with \" : %u %s\" :     54321 pounds"), --[ tuple ]--[
                54321,
                "pounds"
              ]) and Caml_obj.caml_equal(i("with \" : %x %s\" :       321 yens"), --[ tuple ]--[
                801,
                "yens"
              ])) then do
          var j = function (s) do
            return Curry._1(Scanf.sscanf(s, --[ Format ]--[
                            --[ String_literal ]--Block.__(11, [
                                "with ",
                                --[ Format_subst ]--Block.__(14, [
                                    undefined,
                                    --[ Int_ty ]--Block.__(2, [--[ String_ty ]--Block.__(1, [--[ End_of_fmtty ]--0])]),
                                    --[ End_of_format ]--0
                                  ])
                              ]),
                            "with %(%i %_s %s%)"
                          ]), (function (_fmt, amount, currency) do
                          return --[ tuple ]--[
                                  amount,
                                  currency
                                ];
                        end));
          end;
          if (Caml_obj.caml_equal(j("with \" : %1d %_s %s\" : 987654321 euros"), --[ tuple ]--[
                  9,
                  "euros"
                ]) and Caml_obj.caml_equal(j("with \" : %2d %_s %s\" : 987654321 dollars"), --[ tuple ]--[
                  98,
                  "dollars"
                ]) and Caml_obj.caml_equal(j("with \" : %3u %_s %s\" : 987654321 pounds"), --[ tuple ]--[
                  987,
                  "pounds"
                ])) then do
            return Caml_obj.caml_equal(j("with \" : %4x %_s %s\" : 987654321 yens"), --[ tuple ]--[
                        39030,
                        "yens"
                      ]);
          end else do
            return false;
          end end 
        end else do
          return false;
        end end 
      end else do
        return false;
      end end 
    end else do
      return false;
    end end 
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1157, characters 5-12", test48(--[ () ]--0));

function test49(param) do
  if (Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ End_of_format ]--0
                ]),
              "%[\\]"
            ]), (function (s) do
            return s == "";
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%[\\]%s"
            ]), (function (s, t) do
            return s == "" and t == "as" or false;
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                    ])
                ]),
              "%[\\]%s%!"
            ]), (function (s, t) do
            return s == "" and t == "as" or false;
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0@\0\0\0\0\0\0\x02\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ End_of_format ]--0
                ]),
              "%[a..z]"
            ]), (function (s) do
            return s == "a";
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\0\0\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ End_of_format ]--0
                ]),
              "%[a-z]"
            ]), (function (s) do
            return s == "as";
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0@\0\0\0\0\0\0\x02\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%[a..z]%s"
            ]), (function (s, t) do
            return s == "a" and t == "s" or false;
          end)) and Curry._1(Scanf.sscanf("as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\0\0\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%[a-z]%s"
            ]), (function (s, t) do
            return s == "as" and t == "" or false;
          end)) and Curry._1(Scanf.sscanf("-as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0 \0\0\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ End_of_format ]--0
                ]),
              "%[-a-z]"
            ]), (function (s) do
            return s == "-as";
          end)) and Curry._1(Scanf.sscanf("-as", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0 \0\0\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Scan_indic ]--Block.__(2, [--[ "s" ]--115]),
                      --[ End_of_format ]--0
                    ])
                ]),
              "%[-a-z]@s"
            ]), (function (s) do
            return s == "-a";
          end)) and Curry._1(Scanf.sscanf("-as", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ "-" ]--45,
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Scan_indic ]--Block.__(2, [--[ "s" ]--115]),
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "-%[a]@s"
            ]), (function (s) do
            return s == "a";
          end)) and Curry._1(Scanf.sscanf("-asb", --[ Format ]--[
              --[ Char_literal ]--Block.__(12, [
                  --[ "-" ]--45,
                  --[ Scan_char_set ]--Block.__(20, [
                      undefined,
                      "\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Scan_indic ]--Block.__(2, [--[ "s" ]--115]),
                          --[ Char_literal ]--Block.__(12, [
                              --[ "b" ]--98,
                              --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                            ])
                        ])
                    ])
                ]),
              "-%[a]@sb%!"
            ]), (function (s) do
            return s == "a";
          end))) then do
    return Curry._1(Scanf.sscanf("-asb", --[ Format ]--[
                    --[ Char_literal ]--Block.__(12, [
                        --[ "-" ]--45,
                        --[ Scan_char_set ]--Block.__(20, [
                            undefined,
                            "\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                            --[ Formatting_lit ]--Block.__(17, [
                                --[ Scan_indic ]--Block.__(2, [--[ "s" ]--115]),
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ]),
                    "-%[a]@s%s"
                  ]), (function (s, t) do
                  if (s == "a") then do
                    return t == "b";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1176, characters 5-12", test49(--[ () ]--0));

function next_char(ob, param) do
  var s = $$Buffer.contents(ob);
  var len = #s;
  if (len == 0) then do
    throw Caml_builtin_exceptions.end_of_file;
  end
   end 
  var c = Caml_string.get(s, 0);
  ob.position = 0;
  $$Buffer.add_string(ob, $$String.sub(s, 1, len - 1 | 0));
  return c;
end

function send_string(ob, s) do
  $$Buffer.add_string(ob, s);
  return $$Buffer.add_char(ob, --[ "\n" ]--10);
end

function send_int(ob, i) do
  return send_string(ob, String(i));
end

function writer(ib, ob) do
  return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\n" ]--10,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "%s\n"
                ]), (function (s) do
                local ___conditional___=(s);
                do
                   if ___conditional___ = "start" then do
                      send_string(ob, "Hello World!");
                      return reader(ib, ob);end end end 
                   if ___conditional___ = "stop" then do
                      return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                                      --[ Int ]--Block.__(4, [
                                          --[ Int_i ]--3,
                                          --[ No_padding ]--0,
                                          --[ No_precision ]--0,
                                          --[ End_of_format ]--0
                                        ]),
                                      "%i"
                                    ]), (function (i) do
                                    return i;
                                  end));end end end 
                   do
                  else do
                    var i = Caml_format.caml_int_of_string(s);
                    send_string(ob, String(i));
                    return reader(ib, ob);
                    end end
                    
                end
              end));
end

var count = do
  contents: 0
end;

function reader(ib, ob) do
  if (Scanf.Scanning.beginning_of_input(ib)) then do
    count.contents = 0;
    send_string(ob, "start");
    return writer(ib, ob);
  end else do
    return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                    --[ Scan_char_set ]--Block.__(20, [
                        undefined,
                        "\xff\xfb\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                        --[ Char_literal ]--Block.__(12, [
                            --[ "\n" ]--10,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "%[^\n]\n"
                  ]), (function (s) do
                  if (s == "stop") then do
                    send_string(ob, "stop");
                    return writer(ib, ob);
                  end else do
                    var l = #s;
                    count.contents = l + count.contents | 0;
                    if (count.contents >= 100) then do
                      send_string(ob, "stop");
                      send_string(ob, String(count.contents));
                    end else do
                      send_string(ob, String(l));
                    end end 
                    return writer(ib, ob);
                  end end 
                end));
  end end 
end

function go(param) do
  var ob = $$Buffer.create(17);
  var ib = Scanf.Scanning.from_function((function (param) do
          return next_char(ob, param);
        end));
  return reader(ib, ob);
end

function test50(param) do
  return go(--[ () ]--0) == 100;
end

test("File \"tscanf_test.ml\", line 1228, characters 5-12", go(--[ () ]--0) == 100);

function test51(param) do
  if (Curry._1(Scanf.sscanf("Hello", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ End_of_format ]--0
                ]),
              "%s"
            ]), id) == "Hello" and Curry._1(Scanf.sscanf("Hello\n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s\n"
            ]), id) == "Hello" and Curry._1(Scanf.sscanf("Hello\n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\n" ]--10,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s%s\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ])
                ]),
              "%s\n%s%!"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld!", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s\n%s"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World!" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s@\n%s"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end))) then do
    return Curry._1(Scanf.sscanf("Hello \n", --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Formatting_lit ]--Block.__(17, [
                            --[ Force_newline ]--3,
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "%s@\n%s"
                  ]), (function (s1, s2) do
                  if (s1 == "Hello ") then do
                    return s2 == "";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1248, characters 5-12", test51(--[ () ]--0));

function test52(param) do
  if (Curry._1(Scanf.sscanf("Hello\n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s@\n"
            ]), id) == "Hello" and Curry._1(Scanf.sscanf("Hello", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%s@\n"
            ]), id) == "Hello" and Curry._1(Scanf.sscanf("Hello", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Force_newline ]--3,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s%s@\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ])
                ]),
              "%s@\n%s%!"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld!", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Formatting_lit ]--Block.__(17, [
                              --[ Force_newline ]--3,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              "%s@\n%s@\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World!" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Force_newline ]--3,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s@\n%s"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end)) and Curry._1(Scanf.sscanf("Hello \n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Formatting_lit ]--Block.__(17, [
                          --[ Force_newline ]--3,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s%s@\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == " " or false;
          end)) and Curry._1(Scanf.sscanf("Hello \n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Ignored_param ]--Block.__(23, [
                          --[ Ignored_scan_char_set ]--Block.__(10, [
                              1,
                              "\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
                            ]),
                          --[ Char_literal ]--Block.__(12, [
                              --[ "\n" ]--10,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              "%s%s%_1[ ]\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end)) and Curry._1(Scanf.sscanf("Hello \n", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Ignored_param ]--Block.__(23, [
                      --[ Ignored_scan_char_set ]--Block.__(10, [
                          1,
                          "\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
                        ]),
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "\n" ]--10,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ]),
              "%s%_1[ ]%s\n"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ])
                ]),
              "%s\n%s%!"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld!", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                        ])
                    ])
                ]),
              "%s\n%s%!"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World!" or false;
          end)) and Curry._1(Scanf.sscanf("Hello\nWorld!", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ "\n" ]--10,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Formatting_lit ]--Block.__(17, [
                              --[ Scan_indic ]--Block.__(2, [--[ "!" ]--33]),
                              --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                            ])
                        ])
                    ])
                ]),
              "%s\n%s@!%!"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "World" or false;
          end)) and Curry._1(Scanf.sscanf("Hello{foo}", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_gen ]--Block.__(18, [
                      --[ Open_tag ]--Block.__(0, [--[ Format ]--[
                            --[ End_of_format ]--0,
                            ""
                          ]]),
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s@{%s"
            ]), (function (s1, s2) do
            return s1 == "Hello" and s2 == "foo}" or false;
          end))) then do
    return Curry._1(Scanf.sscanf("Hello[foo]", --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Formatting_gen ]--Block.__(18, [
                            --[ Open_box ]--Block.__(1, [--[ Format ]--[
                                  --[ End_of_format ]--0,
                                  ""
                                ]]),
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "%s@[%s"
                  ]), (function (s1, s2) do
                  if (s1 == "Hello") then do
                    return s2 == "foo]";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1286, characters 5-12", test52(--[ () ]--0));

function test53(param) do
  if (Curry._1(Scanf.sscanf("123", --[ Format ]--[
              --[ Nativeint ]--Block.__(6, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%nd"
            ]), id) == 123 and Curry._1(Scanf.sscanf("124", --[ Format ]--[
              --[ Nativeint ]--Block.__(6, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%nd"
            ]), (function (i) do
            return i - 1 == 123;
          end)) and Curry._1(Scanf.sscanf("123", --[ Format ]--[
              --[ Int32 ]--Block.__(5, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%ld"
            ]), id) == 123 and Curry._1(Scanf.sscanf("124", --[ Format ]--[
              --[ Int32 ]--Block.__(5, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ End_of_format ]--0
                ]),
              "%ld"
            ]), (function (i) do
            return (i + 1 | 0) == 125;
          end)) and Caml_int64.eq(Curry._1(Scanf.sscanf("123", --[ Format ]--[
                  --[ Int64 ]--Block.__(7, [
                      --[ Int_d ]--0,
                      --[ No_padding ]--0,
                      --[ No_precision ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%Ld"
                ]), id), --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--123
        ])) then do
    return Curry._1(Scanf.sscanf("124", --[ Format ]--[
                    --[ Int64 ]--Block.__(7, [
                        --[ Int_d ]--0,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ End_of_format ]--0
                      ]),
                    "%Ld"
                  ]), (function (i) do
                  return Caml_int64.eq(Caml_int64.sub(i, --[ int64 ]--[
                                  --[ hi ]--0,
                                  --[ lo ]--1
                                ]), --[ int64 ]--[
                              --[ hi ]--0,
                              --[ lo ]--123
                            ]);
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1301, characters 5-12", test53(--[ () ]--0));

function test56(param) do
  var g = function (s) do
    return Curry._1(Scanf.sscanf(s, --[ Format ]--[
                    --[ Int ]--Block.__(4, [
                        --[ Int_d ]--0,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ Scan_get_counter ]--Block.__(21, [
                            --[ Char_counter ]--1,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "%d%n"
                  ]), (function (i, n) do
                  return --[ tuple ]--[
                          i,
                          n
                        ];
                end));
  end;
  if (Caml_obj.caml_equal(g("99"), --[ tuple ]--[
          99,
          2
        ]) and Caml_obj.caml_equal(g("99 syntaxes all in a row"), --[ tuple ]--[
          99,
          2
        ])) then do
    return Caml_obj.caml_equal(g("-20 degrees Celsius"), --[ tuple ]--[
                -20,
                3
              ]);
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1316, characters 5-12", test56(--[ () ]--0));

function test57(param) do
  var test_format_scan = function (s, fmt, efmt) do
    return Caml_obj.caml_equal(Scanf.format_from_string(s, fmt), efmt);
  end;
  if (test_format_scan(" %i ", --[ Format ]--[
          --[ Int ]--Block.__(4, [
              --[ Int_i ]--3,
              --[ No_padding ]--0,
              --[ No_precision ]--0,
              --[ End_of_format ]--0
            ]),
          "%i"
        ], --[ Format ]--[
          --[ Char_literal ]--Block.__(12, [
              --[ " " ]--32,
              --[ Int ]--Block.__(4, [
                  --[ Int_i ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ Char_literal ]--Block.__(12, [
                      --[ " " ]--32,
                      --[ End_of_format ]--0
                    ])
                ])
            ]),
          " %i "
        ]) and test_format_scan("%i", --[ Format ]--[
          --[ Int ]--Block.__(4, [
              --[ Int_d ]--0,
              --[ No_padding ]--0,
              --[ No_precision ]--0,
              --[ End_of_format ]--0
            ]),
          "%d"
        ], --[ Format ]--[
          --[ Int ]--Block.__(4, [
              --[ Int_i ]--3,
              --[ No_padding ]--0,
              --[ No_precision ]--0,
              --[ End_of_format ]--0
            ]),
          "%i"
        ]) and test_format_scan("Read an int %i then a string %s.", --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Spec",
              --[ Int ]--Block.__(4, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      "ifi",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              "cation",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Spec%difi%scation"
        ], --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Read an int ",
              --[ Int ]--Block.__(4, [
                  --[ Int_i ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      " then a string ",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "." ]--46,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Read an int %i then a string %s."
        ]) and test_format_scan("Read an int %i then a string \"%s\".", --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Spec",
              --[ Int ]--Block.__(4, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      "ifi",
                      --[ Caml_string ]--Block.__(3, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              "cation",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Spec%difi%Scation"
        ], --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Read an int ",
              --[ Int ]--Block.__(4, [
                  --[ Int_i ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      " then a string \"",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              "\".",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Read an int %i then a string \"%s\"."
        ]) and test_format_scan("Read an int %i then a string \"%s\".", --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Spec",
              --[ Int ]--Block.__(4, [
                  --[ Int_d ]--0,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      "ifi",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              "cation",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Spec%difi%scation"
        ], --[ Format ]--[
          --[ String_literal ]--Block.__(11, [
              "Read an int ",
              --[ Int ]--Block.__(4, [
                  --[ Int_i ]--3,
                  --[ No_padding ]--0,
                  --[ No_precision ]--0,
                  --[ String_literal ]--Block.__(11, [
                      " then a string \"",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              "\".",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ])
                ])
            ]),
          "Read an int %i then a string \"%s\"."
        ])) then do
    return Curry._1(Scanf.sscanf("12 \"%i\"89 ", --[ Format ]--[
                    --[ Int ]--Block.__(4, [
                        --[ Int_i ]--3,
                        --[ No_padding ]--0,
                        --[ No_precision ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ " " ]--32,
                            --[ Format_arg ]--Block.__(13, [
                                undefined,
                                --[ Int_ty ]--Block.__(2, [--[ End_of_fmtty ]--0]),
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ Char_literal ]--Block.__(12, [
                                        --[ " " ]--32,
                                        --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "%i %{%d%}%s %!"
                  ]), (function (i, f, s) do
                  if (i == 12 and Caml_obj.caml_equal(f, --[ Format ]--[
                          --[ Int ]--Block.__(4, [
                              --[ Int_i ]--3,
                              --[ No_padding ]--0,
                              --[ No_precision ]--0,
                              --[ End_of_format ]--0
                            ]),
                          "%i"
                        ])) then do
                    return s == "89";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1357, characters 5-12", test57(--[ () ]--0));

function test58(param) do
  if (Curry._1(Scanf.sscanf("string1%string2", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Escaped_percent ]--6,
                      --[ Char_literal ]--Block.__(12, [
                          --[ "s" ]--115,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s@%%s"
            ]), id) == "string1" and Curry._1(Scanf.sscanf("string1%string2", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ No_padding ]--0,
                  --[ Formatting_lit ]--Block.__(17, [
                      --[ Escaped_percent ]--6,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%s@%%%s"
            ]), (function (prim, prim$1) do
            return prim .. prim$1;
          end)) == "string1string2" and Curry._1(Scanf.sscanf("string1@string2", --[ Format ]--[
              --[ Scan_char_set ]--Block.__(20, [
                  undefined,
                  "\0\0\0\0\0\0\xff\x03\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                  --[ Char_literal ]--Block.__(12, [
                      --[ "@" ]--64,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "%[a-z0-9]@%s"
            ]), (function (prim, prim$1) do
            return prim .. prim$1;
          end)) == "string1string2") then do
    return Curry._1(Scanf.sscanf("string1@%string2", --[ Format ]--[
                    --[ Scan_char_set ]--Block.__(20, [
                        undefined,
                        "\0\0\0\0\0\0\xff\x03\0\0\0\0\xfe\xff\xff\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                        --[ Char_literal ]--Block.__(12, [
                            --[ "@" ]--64,
                            --[ Char_literal ]--Block.__(12, [
                                --[ "%" ]--37,
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ]),
                    "%[a-z0-9]%@%%%s"
                  ]), (function (prim, prim$1) do
                  return prim .. prim$1;
                end)) == "string1string2";
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1367, characters 5-12", test58(--[ () ]--0));

test("File \"tscanf_test.ml\", line 1371, characters 14-21", true);

function test60(param) do
  if (Curry._1(Scanf.sscanf("abc", --[ Format ]--[
              --[ Scan_next_char ]--Block.__(22, [--[ Scan_next_char ]--Block.__(22, [--[ Char ]--Block.__(0, [--[ Scan_get_counter ]--Block.__(21, [
                              --[ Char_counter ]--1,
                              --[ End_of_format ]--0
                            ])])])]),
              "%0c%0c%c%n"
            ]), (function (c1, c2, c3, n) do
            return c1 == --[ "a" ]--97 and c2 == --[ "a" ]--97 and c3 == --[ "a" ]--97 and n == 1 or false;
          end)) and Curry._1(Scanf.sscanf("abc", --[ Format ]--[
              --[ String ]--Block.__(2, [
                  --[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      0
                    ]),
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ])
                ]),
              "%0s%s"
            ]), (function (s1, s2) do
            return s1 == "" and s2 == "abc" or false;
          end))) then do
    return Curry._1(Scanf.sscanf("abc", --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ Lit_padding ]--Block.__(0, [
                            --[ Right ]--1,
                            1
                          ]),
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "%1s%s"
                  ]), (function (s1, s2) do
                  if (s1 == "a") then do
                    return s2 == "bc";
                  end else do
                    return false;
                  end end 
                end));
  end else do
    return false;
  end end 
end

test("File \"tscanf_test.ml\", line 1414, characters 5-12", test60(--[ () ]--0));

Mt.from_pair_suites("Tscanf_test", suites.contents);

var tscanf_data_file_lines = --[ :: ]--[
  --[ tuple ]--[
    "Objective",
    "Caml"
  ],
  --[ [] ]--0
];

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.test = test;
exports.id = id;
exports.test0 = test0;
exports.test1 = test1;
exports.test2 = test2;
exports.test3 = test3;
exports.test4 = test4;
exports.test5 = test5;
exports.test6 = test6;
exports.test7 = test7;
exports.verify_read = verify_read;
exports.verify_scan_Chars = verify_scan_Chars;
exports.test8 = test8;
exports.unit = unit;
exports.test_fmt = test_fmt;
exports.test9_string = test9_string;
exports.test_S = test_S;
exports.test9 = test9;
exports.test10 = test10;
exports.test11 = test11;
exports.test110 = test110;
exports.test111 = test111;
exports.ib = ib;
exports.f = f;
exports.test12 = test12;
exports.g = g;
exports.test13 = test13;
exports.test14 = test14;
exports.test15 = test15;
exports.test16 = test16;
exports.test17 = test17;
exports.test18 = test18;
exports.test19 = test19;
exports.test20 = test20;
exports.test21 = test21;
exports.scan_rest = scan_rest$1;
exports.test22 = test22;
exports.test23 = test23;
exports.test24 = test24;
exports.test25 = test25;
exports.test26 = test26;
exports.test27 = test27;
exports.scan_String_elem = scan_String_elem;
exports.scan_String_list = scan_String_list;
exports.test28 = test28;
exports.scan_int_elem = scan_int_elem$1;
exports.test29 = test29;
exports.scan_string_elem = scan_string_elem$1;
exports.test30 = test30;
exports.scan_elem = scan_elem;
exports.test31 = test31;
exports.test32 = test32;
exports.test33 = test33;
exports.test34 = test34;
exports.scan_elems = scan_elems$9;
exports.scan_list = scan_list$4;
exports.scan_float = scan_float;
exports.scan_int_list = scan_int_list$8;
exports.scan_string_list = scan_string_list$2;
exports.scan_bool_list = scan_bool_list;
exports.scan_char_list = scan_char_list;
exports.test340 = test340;
exports.scan_list_list = scan_list_list;
exports.scan_float_item = scan_float_item;
exports.scan_float_list = scan_float_list;
exports.scan_float_list_list = scan_float_list_list$1;
exports.test35 = test35;
exports.read_elems = read_elems;
exports.read_list = read_list;
exports.make_read_elem = make_read_elem;
exports.scan_List = scan_List;
exports.test36 = test36;
exports.test37 = test37;
exports.test38 = test38;
exports.test39 = test39;
exports.test40 = test40;
exports.test41 = test41;
exports.test42 = test42;
exports.test43 = test43;
exports.test44 = test44;
exports.test45 = test45;
exports.test46 = test46;
exports.test47 = test47;
exports.test48 = test48;
exports.test49 = test49;
exports.next_char = next_char;
exports.send_string = send_string;
exports.send_int = send_int;
exports.reader = reader;
exports.writer = writer;
exports.go = go;
exports.test50 = test50;
exports.test51 = test51;
exports.test52 = test52;
exports.test53 = test53;
exports.test56 = test56;
exports.tscanf_data_file_lines = tscanf_data_file_lines;
exports.test57 = test57;
exports.test58 = test58;
exports.test60 = test60;
--[  Not a pure module ]--
