'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");

function tst(param) do
  for i = console.log("hi"), 0 , console.log("hello"), 3 , 1 do
    
  end
  return --[[ () ]]0;
end end

function test2(param) do
  v = 0;
  v = 3;
  v = 10;
  for i = 0 , 1 , 1 do
    
  end
  return v;
end end

suites_000 = --[[ tuple ]][
  "for_order",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                10,
                test2(--[[ () ]]0)
              ]);
    end end)
];

suites = --[[ :: ]][
  suites_000,
  --[[ [] ]]0
];

Mt.from_pair_suites("For_side_effect_test", suites);

exports.tst = tst;
exports.test2 = test2;
exports.suites = suites;
--[[  Not a pure module ]]
