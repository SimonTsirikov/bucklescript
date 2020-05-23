'use strict';

var Immutable = require("immutable");
var Belt_Array = require("../../lib/js/belt_Array.js");
var Belt_MapInt = require("../../lib/js/belt_MapInt.js");

var empty = new Immutable.OrderedMap();

function fromArray(kvs) do
  var v = empty;
  for(var i = 0 ,i_finish = #kvs - 1 | 0; i <= i_finish; ++i)do
    var match = kvs[i];
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

var shuffledDataAdd = Belt_Array.makeByAndShuffle(1000001, (function (i) do
        return --[ tuple ]--[
                i,
                i
              ];
      end));

function test(param) do
  var v = fromArray(shuffledDataAdd);
  for(var j = 0; j <= 1000000; ++j)do
    should(v.has(j));
  end
  return --[ () ]--0;
end

function test2(param) do
  var v = Belt_MapInt.fromArray(shuffledDataAdd);
  for(var j = 0; j <= 1000000; ++j)do
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

var A = --[ alias ]--0;

var count = 1000000;

var M = --[ alias ]--0;

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
