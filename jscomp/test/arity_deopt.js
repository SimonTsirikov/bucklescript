'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

function f0(x, y, z) do
  return (x + y | 0) + z | 0;
end end

function f1(x) do
  return (function (y, z) do
      return (x + y | 0) + z | 0;
    end end);
end end

function f2(x, y) do
  return (function (z) do
      return (x + y | 0) + z | 0;
    end end);
end end

function f3(x) do
  return (function (y, z) do
      return (x + y | 0) + z | 0;
    end end);
end end

eq("File \"arity_deopt.ml\", line 45, characters 7-14", 6, f0(1, 2, 3));

eq("File \"arity_deopt.ml\", line 46, characters 11-18", 6, (function (y, z) do
          return (1 + y | 0) + z | 0;
        end end)(2, 3));

eq("File \"arity_deopt.ml\", line 47, characters 15-22", 6, Curry._1(f2(1, 2), 3));

eq("File \"arity_deopt.ml\", line 48, characters 15-22", 6, (function (y, z) do
          return (1 + y | 0) + z | 0;
        end end)(2, 3));

Mt.from_pair_suites("Arity_deopt", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f0 = f0;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
--[[  Not a pure module ]]
