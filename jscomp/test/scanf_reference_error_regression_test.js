'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Scanf = require("../../lib/js/scanf.js");
Printf = require("../../lib/js/printf.js");
Mt_global = require("./mt_global.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end

function scan_rest(ib, accu) do
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
                  ib$1 = ib;
                  accu$1 = accu;
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
                                ib$2 = ib$1;
                                accu$2 = --[ :: ]--[
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
                                                    return scan_rest(ib$2, accu$2);end end end 
                                                 if ___conditional___ = "]" then do
                                                    return accu$2;end end end 
                                                 do
                                                else do
                                                  s = Printf.sprintf(--[ Format ]--[
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

function scan_int_list(ib) do
  Curry._1(Scanf.bscanf(ib, --[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                " [ ",
                --[ End_of_format ]--0
              ]),
            " [ "
          ]), --[ () ]--0);
  return List.rev(scan_rest(ib, --[ [] ]--0));
end

eq("File \"scanf_reference_error_regression_test.ml\", line 36, characters 5-12", --[ tuple ]--[
      scan_int_list(Scanf.Scanning.from_string("[]")),
      --[ [] ]--0
    ]);

Mt.from_pair_suites("Scanf_reference_error_regression_test", suites.contents);

--[  Not a pure module ]--
