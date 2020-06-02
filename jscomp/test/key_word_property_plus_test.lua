--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Global_mangles = require "./global_mangles.lua";

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

eq("File \"key_word_property_plus_test.ml\", line 10, characters 5-12", [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14
      ].reduce((function (prim, prim$1) do
            return prim + prim$1 | 0;
          end end), 0), ((((((((((((Global_mangles.$$__dirname + Global_mangles.$$__filename | 0) + Global_mangles.$$clearImmediate | 0) + Global_mangles.$$clearInterval | 0) + Global_mangles.$$clearTimeout | 0) + Global_mangles.$$console | 0) + Global_mangles.$$exports | 0) + Global_mangles.$$global | 0) + Global_mangles._module | 0) + Global_mangles.$$process | 0) + Global_mangles.$$require | 0) + Global_mangles.$$setImmediate | 0) + Global_mangles.$$setInterval | 0) + Global_mangles.$$setTimeout | 0);

Mt.from_pair_suites("Key_word_property_plus_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
