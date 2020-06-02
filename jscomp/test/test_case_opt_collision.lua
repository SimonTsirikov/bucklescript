--[['use strict';]]

Mt = require "./mt";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function f(xOpt, y) do
  x = xOpt ~= undefined and xOpt or 3;
  xOpt$1 = x + 2 | 0;
  console.log(xOpt$1);
  return xOpt$1 + y | 0;
end end

console.log(f(undefined, 2));

eq("File \"test_case_opt_collision.ml\", line 15, characters 6-13", f(undefined, 2), 7);

eq("File \"test_case_opt_collision.ml\", line 17, characters 6-13", f(4, 2), 8);

Mt.from_pair_suites("test_case_opt_collision.ml", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
--[[  Not a pure module ]]
