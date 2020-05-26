'use strict';

Mt = require("./mt.js");
Belt_Array = require("../../lib/js/belt_Array.js");
Belt_SetInt = require("../../lib/js/belt_SetInt.js");
Array_data_util = require("./array_data_util.js");
Belt_HashSetInt = require("../../lib/js/belt_HashSetInt.js");
Belt_SortArrayInt = require("../../lib/js/belt_SortArrayInt.js");
Belt_internalBucketsType = require("../../lib/js/belt_internalBucketsType.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end

function add(x, y) do
  return x + y | 0;
end

function sum2(h) do
  v = do
    contents: 0
  end;
  Belt_HashSetInt.forEach(h, (function (x) do
          v.contents = v.contents + x | 0;
          return --[ () ]--0;
        end));
  return v.contents;
end

u = Belt_Array.concat(Array_data_util.randomRange(30, 100), Array_data_util.randomRange(40, 120));

v = Belt_HashSetInt.fromArray(u);

eq("File \"bs_hashset_int_test.ml\", line 19, characters 5-12", v.size, 91);

xs = Belt_SetInt.toArray(Belt_SetInt.fromArray(Belt_HashSetInt.toArray(v)));

eq("File \"bs_hashset_int_test.ml\", line 21, characters 5-12", xs, Array_data_util.range(30, 120));

eq("File \"bs_hashset_int_test.ml\", line 23, characters 5-12", Belt_HashSetInt.reduce(v, 0, add), 6825);

eq("File \"bs_hashset_int_test.ml\", line 24, characters 5-12", sum2(v), 6825);

u$1 = Belt_Array.concat(Array_data_util.randomRange(0, 100000), Array_data_util.randomRange(0, 100));

v$1 = Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, 40);

Belt_HashSetInt.mergeMany(v$1, u$1);

eq("File \"bs_hashset_int_test.ml\", line 30, characters 5-12", v$1.size, 100001);

for i = 0 , 1000 , 1 do
  Belt_HashSetInt.remove(v$1, i);
end

eq("File \"bs_hashset_int_test.ml\", line 34, characters 5-12", v$1.size, 99000);

for i$1 = 0 , 2000 , 1 do
  Belt_HashSetInt.remove(v$1, i$1);
end

eq("File \"bs_hashset_int_test.ml\", line 38, characters 5-12", v$1.size, 98000);

u0 = Belt_HashSetInt.fromArray(Array_data_util.randomRange(0, 100000));

u1 = Belt_HashSetInt.copy(u0);

eq("File \"bs_hashset_int_test.ml\", line 46, characters 5-12", Belt_HashSetInt.toArray(u0), Belt_HashSetInt.toArray(u1));

for i$2 = 0 , 2000 , 1 do
  Belt_HashSetInt.remove(u1, i$2);
end

for i$3 = 0 , 1000 , 1 do
  Belt_HashSetInt.remove(u0, i$3);
end

v0 = Belt_Array.concat(Array_data_util.range(0, 1000), Belt_HashSetInt.toArray(u0));

v1 = Belt_Array.concat(Array_data_util.range(0, 2000), Belt_HashSetInt.toArray(u1));

Belt_SortArrayInt.stableSortInPlace(v0);

Belt_SortArrayInt.stableSortInPlace(v1);

eq("File \"bs_hashset_int_test.ml\", line 57, characters 5-12", v0, v1);

h = Belt_HashSetInt.fromArray(Array_data_util.randomRange(0, 1000000));

histo = Belt_HashSetInt.getBucketHistogram(h);

b("File \"bs_hashset_int_test.ml\", line 62, characters 4-11", #histo <= 10);

Mt.from_pair_suites("Bs_hashset_int_test", suites.contents);

N = --[ alias ]--0;

S = --[ alias ]--0;

I = --[ alias ]--0;

$plus$plus = Belt_Array.concat;

A = --[ alias ]--0;

SI = --[ alias ]--0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.N = N;
exports.S = S;
exports.I = I;
exports.$plus$plus = $plus$plus;
exports.add = add;
exports.sum2 = sum2;
exports.A = A;
exports.SI = SI;
--[ u Not a pure module ]--
