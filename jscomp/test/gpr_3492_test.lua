console = {log = print};

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

function foo(a){return a()}
;

function fn(param) do
  console.log("hi");
  return 1;
end end

eq("File \"gpr_3492_test.ml\", line 14, characters 6-13", foo((function() do
            console.log("hi");
            return 1;
          end end)), 1);

Mt.from_pair_suites("gpr_3492_test.ml", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fn = fn;
--[[  Not a pure module ]]
