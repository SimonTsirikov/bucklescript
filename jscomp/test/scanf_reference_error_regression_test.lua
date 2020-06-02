console.log = print;

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Scanf = require "../../lib/js/scanf";
Printf = require "../../lib/js/printf";
Mt_global = require "./mt_global";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end end

function scan_rest(ib, accu) do
  return Curry._1(Scanf.bscanf(ib, --[[ Format ]]{
                  --[[ Scan_char_set ]]Block.__(20, {
                      undefined,
                      "\0\0\0\0\0\0\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                      --[[ End_of_format ]]0
                    }),
                  "%[]]"
                }), (function (param) do
                if (param == "]") then do
                  return accu;
                end else do
                  ib_1 = ib;
                  accu_1 = accu;
                  return Curry._1(Scanf.bscanf(ib_1, --[[ Format ]]{
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ " " ]]32,
                                      --[[ Int ]]Block.__(4, {
                                          --[[ Int_i ]]3,
                                          --[[ No_padding ]]0,
                                          --[[ No_precision ]]0,
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ " " ]]32,
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    }),
                                  " %i "
                                }), (function (i) do
                                ib_2 = ib_1;
                                accu_2 = --[[ :: ]]{
                                  i,
                                  accu_1
                                };
                                return Curry._1(Scanf.bscanf(ib_2, --[[ Format ]]{
                                                --[[ Scan_char_set ]]Block.__(20, {
                                                    1,
                                                    "\0\0\0\0\0\0\0\b\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
                                                    --[[ End_of_format ]]0
                                                  }),
                                                "%1[];]"
                                              }), (function (param) do
                                              local ___conditional___=(param);
                                              do
                                                 if ___conditional___ = ";" then do
                                                    return scan_rest(ib_2, accu_2);end end end 
                                                 if ___conditional___ = "]" then do
                                                    return accu_2;end end end 
                                                 do
                                                else do
                                                  s = Printf.sprintf(--[[ Format ]]{
                                                        --[[ String_literal ]]Block.__(11, {
                                                            "scan_int_list",
                                                            --[[ End_of_format ]]0
                                                          }),
                                                        "scan_int_list"
                                                      });
                                                  error({
                                                    Caml_builtin_exceptions.failure,
                                                    s
                                                  })
                                                  end end
                                                  
                                              end
                                            end end));
                              end end));
                end end 
              end end));
end end

function scan_int_list(ib) do
  Curry._1(Scanf.bscanf(ib, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                " [ ",
                --[[ End_of_format ]]0
              }),
            " [ "
          }), --[[ () ]]0);
  return List.rev(scan_rest(ib, --[[ [] ]]0));
end end

eq("File \"scanf_reference_error_regression_test.ml\", line 36, characters 5-12", --[[ tuple ]]{
      scan_int_list(Scanf.Scanning.from_string("[]")),
      --[[ [] ]]0
    });

Mt.from_pair_suites("Scanf_reference_error_regression_test", suites.contents);

--[[  Not a pure module ]]
