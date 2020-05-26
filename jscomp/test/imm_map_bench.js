'use strict';

Immutable = require("immutable");
Belt_Array = require("../../lib/js/belt_Array.js");
Belt_MapInt = require("../../lib/js/belt_MapInt.js");

empty = new Immutable.OrderedMap();

function fromArray(kvs) do
  v = empty;
  for i = 0 , #kvs - 1 | 0 , 1 do
    match = kvs[i];
    v = v.set(match[0], match[1]);
  end
  return v;
end

function should(b) do
  if (b) then do
    return 0;
  end else do
    throw new Error("impossible");
  end end 
end

shuffledDataAdd = Belt_Array.makeByAndShuffle(1000001, (function (i) do
        return --[ tuple ]--[
                i,
                i
              ];
      end));

function test(param) do
  v = fromArray(shuffledDataAdd);
  for j = 0 , 1000000 , 1 do
    should(v.has(j));
  end
  return --[ () ]--0;
end

function test2(param) do
  v = Belt_MapInt.fromArray(shuffledDataAdd);
  for j = 0 , 1000000 , 1 do
    should(Belt_MapInt.has(v, j));
  end
  return --[ () ]--0;
end

console.time("test/imm_map_bench.ml 44");

test(--[ () ]--0);

console.timeEnd("test/imm_map_bench.ml 44");

console.time("test/imm_map_bench.ml 45");

test2(--[ () ]--0);

console.timeEnd("test/imm_map_bench.ml 45");

A = --[ alias ]--0;

count = 1000000;

M = --[ alias ]--0;

exports.A = A;
exports.empty = empty;
exports.fromArray = fromArray;
exports.should = should;
exports.count = count;
exports.shuffledDataAdd = shuffledDataAdd;
exports.test = test;
exports.M = M;
exports.test2 = test2;
--[ empty Not a pure module ]--
