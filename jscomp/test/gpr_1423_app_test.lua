--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Gpr_1423_nav = require "./gpr_1423_nav.lua";

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

function foo(f) do
  console.log(Curry._2(f, "a1", --[[ () ]]0));
  return --[[ () ]]0;
end end

foo((function (param) do
        return (function (param$1) do
            return Gpr_1423_nav.busted(param, "a2", param$1);
          end end);
      end end));

function foo2(f) do
  return Curry._2(f, "a1", --[[ () ]]0);
end end

eq("File \"gpr_1423_app_test.ml\", line 18, characters 7-14", Curry._1((function (param) do
              return (function (param$1) do
                  return Gpr_1423_nav.busted(param, "a2", param$1);
                end end);
            end end)("a1"), --[[ () ]]0), "a1a2");

Mt.from_pair_suites("Gpr_1423_app_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.foo = foo;
exports.foo2 = foo2;
--[[  Not a pure module ]]
