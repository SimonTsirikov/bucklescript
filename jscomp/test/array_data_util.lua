'use strict';

Belt_Array = require("../../lib/js/belt_Array.lua");

function range(i, j) do
  return Belt_Array.makeBy((j - i | 0) + 1 | 0, (function (k) do
                return k + i | 0;
              end end));
end end

function randomRange(i, j) do
  v = Belt_Array.makeBy((j - i | 0) + 1 | 0, (function (k) do
          return k + i | 0;
        end end));
  Belt_Array.shuffleInPlace(v);
  return v;
end end

A = --[[ alias ]]0;

exports.A = A;
exports.range = range;
exports.randomRange = randomRange;
--[[ No side effect ]]
