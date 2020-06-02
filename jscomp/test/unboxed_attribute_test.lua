--[['use strict';]]

Mt = require "./mt.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function make(x) do
  return x;
end end

function get(param) do
  return param;
end end

x = "foo";

eq("File \"unboxed_attribute_test.ml\", line 18, characters 3-10", x, x);

x$1 = "foo";

eq("File \"unboxed_attribute_test.ml\", line 26, characters 3-10", x$1, x$1);

x$2 = "foo";

eq("File \"unboxed_attribute_test.ml\", line 33, characters 3-10", x$2, x$2);

y = [];

y[0] = y;

Mt.from_pair_suites("unboxed_attribute_test.ml", suites.contents);

v0 = 3;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v0 = v0;
exports.make = make;
exports.get = get;
exports.y = y;
--[[  Not a pure module ]]
