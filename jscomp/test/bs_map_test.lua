'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Belt_Array = require("../../lib/js/belt_Array.lua");
Belt_MapInt = require("../../lib/js/belt_MapInt.lua");
Belt_SetInt = require("../../lib/js/belt_SetInt.lua");

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

function b(loc, v) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Ok ]]Block.__(4, [v]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

mapOfArray = Belt_MapInt.fromArray;

setOfArray = Belt_SetInt.fromArray;

function emptyMap(param) do
  return Belt_MapInt.empty;
end end

v = Belt_Array.makeByAndShuffle(1000000, (function (i) do
        return --[[ tuple ]][
                i,
                i
              ];
      end end));

u = Belt_MapInt.fromArray(v);

Belt_MapInt.checkInvariantInternal(u);

firstHalf = Belt_Array.slice(v, 0, 2000);

xx = Belt_Array.reduce(firstHalf, u, (function (acc, param) do
        return Belt_MapInt.remove(acc, param[0]);
      end end));

Belt_MapInt.checkInvariantInternal(u);

Belt_MapInt.checkInvariantInternal(xx);

Mt.from_pair_suites("Bs_map_test", suites.contents);

M = --[[ alias ]]0;

N = --[[ alias ]]0;

A = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.M = M;
exports.N = N;
exports.A = A;
exports.mapOfArray = mapOfArray;
exports.setOfArray = setOfArray;
exports.emptyMap = emptyMap;
--[[ v Not a pure module ]]
