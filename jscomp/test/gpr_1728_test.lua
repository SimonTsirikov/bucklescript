--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_format = require "../../lib/js/caml_format.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function foo(x) do
  return Caml_format.caml_int_of_string(x) ~= 3;
end end

function badInlining(obj) do
  x = obj.field;
  Caml_format.caml_int_of_string(x) ~= 3;
  return --[[ () ]]0;
end end

eq("File \"gpr_1728_test.ml\", line 17, characters 6-13", badInlining(do
          field: "3"
        end), --[[ () ]]0);

eq("File \"gpr_1728_test.ml\", line 19, characters 6-13", Caml_format.caml_int_of_string("-13"), -13);

eq("File \"gpr_1728_test.ml\", line 20, characters 6-13", Caml_format.caml_int_of_string("+13"), 13);

eq("File \"gpr_1728_test.ml\", line 21, characters 6-13", Caml_format.caml_int_of_string("13"), 13);

eq("File \"gpr_1728_test.ml\", line 22, characters 6-13", Caml_format.caml_int_of_string("0u32"), 32);

eq("File \"gpr_1728_test.ml\", line 23, characters 6-13", Caml_format.caml_int_of_string("-0u32"), -32);

eq("File \"gpr_1728_test.ml\", line 24, characters 6-13", Caml_format.caml_int_of_string("+0u32"), 32);

eq("File \"gpr_1728_test.ml\", line 25, characters 6-13", Caml_format.caml_int_of_string("+0x32"), 50);

eq("File \"gpr_1728_test.ml\", line 26, characters 6-13", Caml_format.caml_int_of_string("-0x32"), -50);

eq("File \"gpr_1728_test.ml\", line 27, characters 6-13", Caml_format.caml_int_of_string("0x32"), 50);

Mt.from_pair_suites("Gpr_1728_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.foo = foo;
exports.badInlining = badInlining;
--[[  Not a pure module ]]
