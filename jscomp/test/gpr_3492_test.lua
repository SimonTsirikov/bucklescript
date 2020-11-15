__console = {log = print};

Mt = require "..mt";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function foo(a){return a()}
;

function fn(param) do
  __console.log("hi");
  return 1;
end end

eq("File \"gpr_3492_test.ml\", line 14, characters 6-13", foo((function() do
            __console.log("hi");
            return 1;
          end end)), 1);

Mt.from_pair_suites("gpr_3492_test.ml", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fn = fn;
return exports;
--[[  Not a pure module ]]
