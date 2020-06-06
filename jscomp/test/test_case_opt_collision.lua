console = {log = print};

Mt = require "./mt";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function f(xOpt, y) do
  x = xOpt ~= nil and xOpt or 3;
  xOpt_1 = x + 2 | 0;
  console.log(xOpt_1);
  return xOpt_1 + y | 0;
end end

console.log(f(nil, 2));

eq("File \"test_case_opt_collision.ml\", line 15, characters 6-13", f(nil, 2), 7);

eq("File \"test_case_opt_collision.ml\", line 17, characters 6-13", f(4, 2), 8);

Mt.from_pair_suites("test_case_opt_collision.ml", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
--[[  Not a pure module ]]
