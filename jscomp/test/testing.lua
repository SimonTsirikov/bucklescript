__console = {log = print};

Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Scanf = require "......lib.js.scanf";
Printf = require "......lib.js.printf";
Caml_io = require "......lib.js.caml_io";
Caml_obj = require "......lib.js.caml_obj";
Pervasives = require "......lib.js.pervasives";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

all_tests_ok = {
  contents = true
};

function finish(param) do
  match = all_tests_ok.contents;
  if (match) then do
    __console.log("\nAll tests succeeded.");
    return --[[ () ]]0;
  end else do
    __console.log("\n\n********* Test suite failed. ***********\n");
    return --[[ () ]]0;
  end end 
end end

Pervasives.at_exit(finish);

test_num = {
  contents = -1
};

function print_test_number(param) do
  Pervasives.print_string(" ");
  Pervasives.print_int(test_num.contents);
  return Caml_io.caml_ml_flush(Pervasives.stdout);
end end

function print_failure_test_fail(param) do
  all_tests_ok.contents = false;
  return Pervasives.print_string(Curry._1(Printf.sprintf(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "\n********* Failure Test number ",
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_i ]]3,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " incorrectly failed ***********\n",
                                  --[[ End_of_format ]]0
                                })
                            })
                        }),
                      "\n********* Failure Test number %i incorrectly failed ***********\n"
                    }), test_num.contents));
end end

function print_failure_test_succeed(param) do
  all_tests_ok.contents = false;
  return Pervasives.print_string(Curry._1(Printf.sprintf(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "\n********* Failure Test number ",
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_i ]]3,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " failed to fail ***********\n",
                                  --[[ End_of_format ]]0
                                })
                            })
                        }),
                      "\n********* Failure Test number %i failed to fail ***********\n"
                    }), test_num.contents));
end end

function test(b) do
  test_num.contents = test_num.contents + 1 | 0;
  print_test_number(--[[ () ]]0);
  if (b) then do
    return 0;
  end else do
    all_tests_ok.contents = false;
    return Pervasives.print_string(Curry._1(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "\n********* Test number ",
                            --[[ Int ]]Block.__(4, {
                                --[[ Int_i ]]3,
                                --[[ No_padding ]]0,
                                --[[ No_precision ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " failed ***********\n",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          }),
                        "\n********* Test number %i failed ***********\n"
                      }), test_num.contents));
  end end 
end end

function test_raises_exc_p(pred, f, x) do
  test_num.contents = test_num.contents + 1 | 0;
  print_test_number(--[[ () ]]0);
  xpcall(function() do
    Curry._1(f, x);
    print_failure_test_succeed(--[[ () ]]0);
    return false;
  end end,function(raw_x) do
    x_1 = Caml_js_exceptions.internalToOCamlException(raw_x);
    if (Curry._1(pred, x_1)) then do
      return true;
    end else do
      print_failure_test_fail(--[[ () ]]0);
      return false;
    end end 
  end end)
end end

function test_raises_some_exc(f) do
  return (function(param) do
      return test_raises_exc_p((function(param) do
                    return true;
                  end end), f, param);
    end end);
end end

function test_raises_this_exc(exc) do
  return (function(param, param_1) do
      return test_raises_exc_p((function(x) do
                    return Caml_obj.caml_equal(x, exc);
                  end end), param, param_1);
    end end);
end end

function failure_test(f, x, s) do
  s_1 = s;
  f_1 = f;
  x_1 = x;
  return test_raises_exc_p((function(x) do
                return Caml_obj.caml_equal(x, {
                            Caml_builtin_exceptions.failure,
                            s_1
                          });
              end end), f_1, x_1);
end end

function scan_failure_test(f, x) do
  return test_raises_exc_p((function(param) do
                return param[1] == Scanf.Scan_failure;
              end end), f, x);
end end

exports = {};
exports.test = test;
exports.failure_test = failure_test;
exports.test_raises_some_exc = test_raises_some_exc;
exports.test_raises_this_exc = test_raises_this_exc;
exports.test_raises_exc_p = test_raises_exc_p;
exports.scan_failure_test = scan_failure_test;
return exports;
--[[  Not a pure module ]]
