console = {log = print};

Mt = require "./mt";
Belt_Id = require "../../lib/js/belt_Id";
Belt_List = require "../../lib/js/belt_List";
Belt_Array = require "../../lib/js/belt_Array";
Caml_primitive = require "../../lib/js/caml_primitive";
Array_data_util = require "./array_data_util";
Belt_MutableSet = require "../../lib/js/belt_MutableSet";
Belt_internalAVLset = require "../../lib/js/belt_internalAVLset";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

IntCmp = Belt_Id.comparable(Caml_primitive.caml_int_compare);

function fromArray(param) do
  return Belt_MutableSet.fromArray(param, IntCmp);
end end

function empty(param) do
  return do
          cmp: IntCmp.cmp,
          data: nil
        end;
end end

u = fromArray(Array_data_util.range(0, 30));

b("File \"bs_poly_mutable_set_test.ml\", line 18, characters 4-11", Belt_MutableSet.removeCheck(u, 0));

b("File \"bs_poly_mutable_set_test.ml\", line 19, characters 4-11", not Belt_MutableSet.removeCheck(u, 0));

b("File \"bs_poly_mutable_set_test.ml\", line 20, characters 4-11", Belt_MutableSet.removeCheck(u, 30));

b("File \"bs_poly_mutable_set_test.ml\", line 21, characters 4-11", Belt_MutableSet.removeCheck(u, 20));

eq("File \"bs_poly_mutable_set_test.ml\", line 22, characters 5-12", Belt_internalAVLset.size(u.data), 28);

r = Array_data_util.randomRange(0, 30);

b("File \"bs_poly_mutable_set_test.ml\", line 24, characters 4-11", 29 == Belt_internalAVLset.maxUndefined(u.data));

b("File \"bs_poly_mutable_set_test.ml\", line 25, characters 4-11", 1 == Belt_internalAVLset.minUndefined(u.data));

Belt_MutableSet.add(u, 3);

for i = 0 , #r - 1 | 0 , 1 do
  Belt_MutableSet.remove(u, r[i]);
end

b("File \"bs_poly_mutable_set_test.ml\", line 30, characters 4-11", Belt_MutableSet.isEmpty(u));

Belt_MutableSet.add(u, 0);

Belt_MutableSet.add(u, 1);

Belt_MutableSet.add(u, 2);

Belt_MutableSet.add(u, 0);

eq("File \"bs_poly_mutable_set_test.ml\", line 35, characters 5-12", Belt_internalAVLset.size(u.data), 3);

b("File \"bs_poly_mutable_set_test.ml\", line 36, characters 4-11", not Belt_MutableSet.isEmpty(u));

for i_1 = 0 , 3 , 1 do
  Belt_MutableSet.remove(u, i_1);
end

b("File \"bs_poly_mutable_set_test.ml\", line 40, characters 4-11", Belt_MutableSet.isEmpty(u));

Belt_MutableSet.mergeMany(u, Array_data_util.randomRange(0, 20000));

Belt_MutableSet.mergeMany(u, Array_data_util.randomRange(0, 200));

eq("File \"bs_poly_mutable_set_test.ml\", line 43, characters 5-12", Belt_internalAVLset.size(u.data), 20001);

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(0, 200));

eq("File \"bs_poly_mutable_set_test.ml\", line 45, characters 5-12", Belt_internalAVLset.size(u.data), 19800);

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(0, 1000));

eq("File \"bs_poly_mutable_set_test.ml\", line 47, characters 5-12", Belt_internalAVLset.size(u.data), 19000);

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(0, 1000));

eq("File \"bs_poly_mutable_set_test.ml\", line 49, characters 5-12", Belt_internalAVLset.size(u.data), 19000);

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(1000, 10000));

eq("File \"bs_poly_mutable_set_test.ml\", line 51, characters 5-12", Belt_internalAVLset.size(u.data), 10000);

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(10000, 19999));

eq("File \"bs_poly_mutable_set_test.ml\", line 53, characters 5-12", Belt_internalAVLset.size(u.data), 1);

b("File \"bs_poly_mutable_set_test.ml\", line 54, characters 4-11", Belt_MutableSet.has(u, 20000));

Belt_MutableSet.removeMany(u, Array_data_util.randomRange(10000, 30000));

b("File \"bs_poly_mutable_set_test.ml\", line 56, characters 4-11", Belt_MutableSet.isEmpty(u));

v = fromArray(Array_data_util.randomRange(1000, 2000));

bs = Belt_Array.map(Array_data_util.randomRange(500, 1499), (function(x) do
        return Belt_MutableSet.removeCheck(v, x);
      end end));

indeedRemoved = Belt_Array.reduce(bs, 0, (function(acc, x) do
        if (x) then do
          return acc + 1 | 0;
        end else do
          return acc;
        end end 
      end end));

eq("File \"bs_poly_mutable_set_test.ml\", line 63, characters 5-12", indeedRemoved, 500);

eq("File \"bs_poly_mutable_set_test.ml\", line 64, characters 5-12", Belt_internalAVLset.size(v.data), 501);

cs = Belt_Array.map(Array_data_util.randomRange(500, 2000), (function(x) do
        return Belt_MutableSet.addCheck(v, x);
      end end));

indeedAded = Belt_Array.reduce(cs, 0, (function(acc, x) do
        if (x) then do
          return acc + 1 | 0;
        end else do
          return acc;
        end end 
      end end));

eq("File \"bs_poly_mutable_set_test.ml\", line 67, characters 5-12", indeedAded, 1000);

eq("File \"bs_poly_mutable_set_test.ml\", line 68, characters 5-12", Belt_internalAVLset.size(v.data), 1501);

b("File \"bs_poly_mutable_set_test.ml\", line 69, characters 4-11", Belt_MutableSet.isEmpty(do
          cmp: IntCmp.cmp,
          data: nil
        end));

eq("File \"bs_poly_mutable_set_test.ml\", line 70, characters 5-12", Belt_internalAVLset.minimum(v.data), 500);

eq("File \"bs_poly_mutable_set_test.ml\", line 71, characters 5-12", Belt_internalAVLset.maximum(v.data), 2000);

eq("File \"bs_poly_mutable_set_test.ml\", line 72, characters 5-12", Belt_internalAVLset.minUndefined(v.data), 500);

eq("File \"bs_poly_mutable_set_test.ml\", line 73, characters 5-12", Belt_internalAVLset.maxUndefined(v.data), 2000);

eq("File \"bs_poly_mutable_set_test.ml\", line 74, characters 5-12", Belt_MutableSet.reduce(v, 0, (function(x, y) do
            return x + y | 0;
          end end)), 1876250);

b("File \"bs_poly_mutable_set_test.ml\", line 75, characters 4-11", Belt_List.eq(Belt_internalAVLset.toList(v.data), Belt_List.makeBy(1501, (function(i) do
                return i + 500 | 0;
              end end)), (function(x, y) do
            return x == y;
          end end)));

eq("File \"bs_poly_mutable_set_test.ml\", line 76, characters 5-12", Belt_internalAVLset.toArray(v.data), Array_data_util.range(500, 2000));

Belt_internalAVLset.checkInvariantInternal(v.data);

eq("File \"bs_poly_mutable_set_test.ml\", line 78, characters 5-12", Belt_MutableSet.get(v, 3), undefined);

eq("File \"bs_poly_mutable_set_test.ml\", line 79, characters 5-12", Belt_MutableSet.get(v, 1200), 1200);

match = Belt_MutableSet.split(v, 1000);

match_1 = match[0];

bb = match_1[1];

aa = match_1[0];

b("File \"bs_poly_mutable_set_test.ml\", line 81, characters 4-11", match[1]);

b("File \"bs_poly_mutable_set_test.ml\", line 82, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(aa.data), Array_data_util.range(500, 999), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_poly_mutable_set_test.ml\", line 83, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(bb.data), Array_data_util.range(1001, 2000), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_poly_mutable_set_test.ml\", line 84, characters 5-12", Belt_MutableSet.subset(aa, v));

b("File \"bs_poly_mutable_set_test.ml\", line 85, characters 4-11", Belt_MutableSet.subset(bb, v));

b("File \"bs_poly_mutable_set_test.ml\", line 86, characters 4-11", Belt_MutableSet.isEmpty(Belt_MutableSet.intersect(aa, bb)));

c = Belt_MutableSet.removeCheck(v, 1000);

b("File \"bs_poly_mutable_set_test.ml\", line 88, characters 4-11", c);

match_2 = Belt_MutableSet.split(v, 1000);

match_3 = match_2[0];

bb_1 = match_3[1];

aa_1 = match_3[0];

b("File \"bs_poly_mutable_set_test.ml\", line 90, characters 4-11", not match_2[1]);

b("File \"bs_poly_mutable_set_test.ml\", line 91, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(aa_1.data), Array_data_util.range(500, 999), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_poly_mutable_set_test.ml\", line 92, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(bb_1.data), Array_data_util.range(1001, 2000), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_poly_mutable_set_test.ml\", line 93, characters 5-12", Belt_MutableSet.subset(aa_1, v));

b("File \"bs_poly_mutable_set_test.ml\", line 94, characters 4-11", Belt_MutableSet.subset(bb_1, v));

b("File \"bs_poly_mutable_set_test.ml\", line 95, characters 4-11", Belt_MutableSet.isEmpty(Belt_MutableSet.intersect(aa_1, bb_1)));

aa_2 = fromArray(Array_data_util.randomRange(0, 100));

bb_2 = fromArray(Array_data_util.randomRange(40, 120));

cc = Belt_MutableSet.union(aa_2, bb_2);

b("File \"bs_poly_mutable_set_test.ml\", line 104, characters 4-11", Belt_MutableSet.eq(cc, fromArray(Array_data_util.randomRange(0, 120))));

b("File \"bs_poly_mutable_set_test.ml\", line 106, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.union(fromArray(Array_data_util.randomRange(0, 20)), fromArray(Array_data_util.randomRange(21, 40))), fromArray(Array_data_util.randomRange(0, 40))));

dd = Belt_MutableSet.intersect(aa_2, bb_2);

b("File \"bs_poly_mutable_set_test.ml\", line 111, characters 4-11", Belt_MutableSet.eq(dd, fromArray(Array_data_util.randomRange(40, 100))));

b("File \"bs_poly_mutable_set_test.ml\", line 112, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.intersect(fromArray(Array_data_util.randomRange(0, 20)), fromArray(Array_data_util.randomRange(21, 40))), do
          cmp: IntCmp.cmp,
          data: nil
        end));

b("File \"bs_poly_mutable_set_test.ml\", line 118, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.intersect(fromArray(Array_data_util.randomRange(21, 40)), fromArray(Array_data_util.randomRange(0, 20))), do
          cmp: IntCmp.cmp,
          data: nil
        end));

b("File \"bs_poly_mutable_set_test.ml\", line 124, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.intersect(fromArray({
                  1,
                  3,
                  4,
                  5,
                  7,
                  9
                }), fromArray({
                  2,
                  4,
                  5,
                  6,
                  8,
                  10
                })), fromArray({
              4,
              5
            })));

b("File \"bs_poly_mutable_set_test.ml\", line 130, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.diff(aa_2, bb_2), fromArray(Array_data_util.randomRange(0, 39))));

b("File \"bs_poly_mutable_set_test.ml\", line 132, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.diff(bb_2, aa_2), fromArray(Array_data_util.randomRange(101, 120))));

b("File \"bs_poly_mutable_set_test.ml\", line 134, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.diff(fromArray(Array_data_util.randomRange(21, 40)), fromArray(Array_data_util.randomRange(0, 20))), fromArray(Array_data_util.randomRange(21, 40))));

b("File \"bs_poly_mutable_set_test.ml\", line 140, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.diff(fromArray(Array_data_util.randomRange(0, 20)), fromArray(Array_data_util.randomRange(21, 40))), fromArray(Array_data_util.randomRange(0, 20))));

b("File \"bs_poly_mutable_set_test.ml\", line 147, characters 4-11", Belt_MutableSet.eq(Belt_MutableSet.diff(fromArray(Array_data_util.randomRange(0, 20)), fromArray(Array_data_util.randomRange(0, 40))), fromArray(Array_data_util.randomRange(0, -1))));

a0 = fromArray(Array_data_util.randomRange(0, 1000));

a1 = Belt_MutableSet.keep(a0, (function(x) do
        return x % 2 == 0;
      end end));

a2 = Belt_MutableSet.keep(a0, (function(x) do
        return x % 2 ~= 0;
      end end));

match_4 = Belt_MutableSet.partition(a0, (function(x) do
        return x % 2 == 0;
      end end));

a4 = match_4[1];

a3 = match_4[0];

b("File \"bs_poly_mutable_set_test.ml\", line 162, characters 4-11", Belt_MutableSet.eq(a1, a3));

b("File \"bs_poly_mutable_set_test.ml\", line 163, characters 4-11", Belt_MutableSet.eq(a2, a4));

Belt_List.forEach(--[[ :: ]]{
      a0,
      --[[ :: ]]{
        a1,
        --[[ :: ]]{
          a2,
          --[[ :: ]]{
            a3,
            --[[ :: ]]{
              a4,
              --[[ [] ]]0
            }
          }
        }
      }
    }, (function(x) do
        return Belt_internalAVLset.checkInvariantInternal(x.data);
      end end));

Mt.from_pair_suites("Bs_poly_mutable_set_test", suites.contents);

N = --[[ alias ]]0;

I = --[[ alias ]]0;

A = --[[ alias ]]0;

L = --[[ alias ]]0;

$plus$plus = Belt_MutableSet.union;

f = fromArray;

$eq$tilde = Belt_MutableSet.eq;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.N = N;
exports.I = I;
exports.A = A;
exports.IntCmp = IntCmp;
exports.L = L;
exports.fromArray = fromArray;
exports.empty = empty;
exports.$plus$plus = $plus$plus;
exports.f = f;
exports.$eq$tilde = $eq$tilde;
--[[ IntCmp Not a pure module ]]