__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Gpr_1423_nav = require "..gpr_1423_nav";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
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

function foo(f) do
  __console.log(Curry._2(f, "a1", --[[ () ]]0));
  return --[[ () ]]0;
end end

foo((function(param) do
        return (function(param_1) do
            return Gpr_1423_nav.busted(param, "a2", param_1);
          end end);
      end end));

function foo2(f) do
  return Curry._2(f, "a1", --[[ () ]]0);
end end

eq("File \"gpr_1423_app_test.ml\", line 18, characters 7-14", Curry._1((function(param) do
              return (function(param_1) do
                  return Gpr_1423_nav.busted(param, "a2", param_1);
                end end);
            end end)("a1"), --[[ () ]]0), "a1a2");

Mt.from_pair_suites("Gpr_1423_app_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.foo = foo;
exports.foo2 = foo2;
return exports;
--[[  Not a pure module ]]
