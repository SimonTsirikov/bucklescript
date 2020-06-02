console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Belt_Array = require "../../lib/js/belt_Array";
Belt_SetInt = require "../../lib/js/belt_SetInt";
Array_data_util = require "./array_data_util";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, v) do
  return Mt.bool_suites(test_id, suites, loc, v);
end end

function $eq$tilde(s, i) do
  return Belt_SetInt.eq(Belt_SetInt.fromArray(i), s);
end end

function $eq$star(a, b) do
  return Belt_SetInt.eq(Belt_SetInt.fromArray(a), Belt_SetInt.fromArray(b));
end end

b("File \"bs_set_int_test.ml\", line 17, characters 4-11", $eq$star({
          1,
          2,
          3
        }, {
          3,
          2,
          1
        }));

u = Belt_SetInt.intersect(Belt_SetInt.fromArray({
          1,
          2,
          3
        }), Belt_SetInt.fromArray({
          3,
          4,
          5
        }));

b("File \"bs_set_int_test.ml\", line 23, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray({3}), u));

function range(i, j) do
  return __Array.init((j - i | 0) + 1 | 0, (function(k) do
                return k + i | 0;
              end end));
end end

function revRange(i, j) do
  return __Array.of_list(List.rev(__Array.to_list(__Array.init((j - i | 0) + 1 | 0, (function(k) do
                            return k + i | 0;
                          end end)))));
end end

v = Belt_SetInt.fromArray(__Array.append(range(100, 1000), revRange(400, 1500)));

i = range(100, 1500);

b("File \"bs_set_int_test.ml\", line 36, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray(i), v));

match = Belt_SetInt.partition(v, (function(x) do
        return x % 3 == 0;
      end end));

l = Belt_SetInt.empty;

r = Belt_SetInt.empty;

for i_1 = 100 , 1500 , 1 do
  if (i_1 % 3 == 0) then do
    l = Belt_SetInt.add(l, i_1);
  end else do
    r = Belt_SetInt.add(r, i_1);
  end end 
end

nl = l;

nr = r;

b("File \"bs_set_int_test.ml\", line 47, characters 4-11", Belt_SetInt.eq(match[0], nl));

b("File \"bs_set_int_test.ml\", line 48, characters 4-11", Belt_SetInt.eq(match[1], nr));

i_2 = range(50, 100);

s = Belt_SetInt.intersect(Belt_SetInt.fromArray(range(1, 100)), Belt_SetInt.fromArray(range(50, 200)));

b("File \"bs_set_int_test.ml\", line 51, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray(i_2), s));

i_3 = range(1, 200);

s_1 = Belt_SetInt.union(Belt_SetInt.fromArray(range(1, 100)), Belt_SetInt.fromArray(range(50, 200)));

b("File \"bs_set_int_test.ml\", line 54, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray(i_3), s_1));

i_4 = range(1, 49);

s_2 = Belt_SetInt.diff(Belt_SetInt.fromArray(range(1, 100)), Belt_SetInt.fromArray(range(50, 200)));

b("File \"bs_set_int_test.ml\", line 57, characters 6-13", Belt_SetInt.eq(Belt_SetInt.fromArray(i_4), s_2));

i_5 = revRange(50, 100);

s_3 = Belt_SetInt.intersect(Belt_SetInt.fromArray(revRange(1, 100)), Belt_SetInt.fromArray(revRange(50, 200)));

b("File \"bs_set_int_test.ml\", line 60, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray(i_5), s_3));

i_6 = revRange(1, 200);

s_4 = Belt_SetInt.union(Belt_SetInt.fromArray(revRange(1, 100)), Belt_SetInt.fromArray(revRange(50, 200)));

b("File \"bs_set_int_test.ml\", line 63, characters 4-11", Belt_SetInt.eq(Belt_SetInt.fromArray(i_6), s_4));

i_7 = revRange(1, 49);

s_5 = Belt_SetInt.diff(Belt_SetInt.fromArray(revRange(1, 100)), Belt_SetInt.fromArray(revRange(50, 200)));

b("File \"bs_set_int_test.ml\", line 66, characters 6-13", Belt_SetInt.eq(Belt_SetInt.fromArray(i_7), s_5));

ss = {
  1,
  222,
  3,
  4,
  2,
  0,
  33,
  -1
};

v_1 = Belt_SetInt.fromArray({
      1,
      222,
      3,
      4,
      2,
      0,
      33,
      -1
    });

minv = Belt_SetInt.minUndefined(v_1);

maxv = Belt_SetInt.maxUndefined(v_1);

function approx(loc, x, y) do
  return b(loc, x == y);
end end

eq("File \"bs_set_int_test.ml\", line 74, characters 5-12", Belt_SetInt.reduce(v_1, 0, (function(x, y) do
            return x + y | 0;
          end end)), Belt_Array.reduce(ss, 0, (function(prim, prim_1) do
            return prim + prim_1 | 0;
          end end)));

approx("File \"bs_set_int_test.ml\", line 75, characters 9-16", -1, minv);

approx("File \"bs_set_int_test.ml\", line 76, characters 9-16", 222, maxv);

v_2 = Belt_SetInt.remove(v_1, 3);

minv_1 = Belt_SetInt.minimum(v_2);

maxv_1 = Belt_SetInt.maximum(v_2);

eq("File \"bs_set_int_test.ml\", line 79, characters 5-12", minv_1, -1);

eq("File \"bs_set_int_test.ml\", line 80, characters 5-12", maxv_1, 222);

v_3 = Belt_SetInt.remove(v_2, 222);

minv_2 = Belt_SetInt.minimum(v_3);

maxv_2 = Belt_SetInt.maximum(v_3);

eq("File \"bs_set_int_test.ml\", line 83, characters 5-12", minv_2, -1);

eq("File \"bs_set_int_test.ml\", line 84, characters 5-12", maxv_2, 33);

v_4 = Belt_SetInt.remove(v_3, -1);

minv_3 = Belt_SetInt.minimum(v_4);

maxv_3 = Belt_SetInt.maximum(v_4);

eq("File \"bs_set_int_test.ml\", line 87, characters 5-12", minv_3, 0);

eq("File \"bs_set_int_test.ml\", line 88, characters 5-12", maxv_3, 33);

v_5 = Belt_SetInt.remove(v_4, 0);

v_6 = Belt_SetInt.remove(v_5, 33);

v_7 = Belt_SetInt.remove(v_6, 2);

v_8 = Belt_SetInt.remove(v_7, 3);

v_9 = Belt_SetInt.remove(v_8, 4);

v_10 = Belt_SetInt.remove(v_9, 1);

b("File \"bs_set_int_test.ml\", line 95, characters 4-11", Belt_SetInt.isEmpty(v_10));

v_11 = Belt_Array.makeByAndShuffle(1000000, (function(i) do
        return i;
      end end));

u_1 = Belt_SetInt.fromArray(v_11);

Belt_SetInt.checkInvariantInternal(u_1);

firstHalf = Belt_Array.slice(v_11, 0, 2000);

xx = Belt_Array.reduce(firstHalf, u_1, Belt_SetInt.remove);

Belt_SetInt.checkInvariantInternal(u_1);

b("File \"bs_set_int_test.ml\", line 106, characters 4-11", Belt_SetInt.eq(Belt_SetInt.union(Belt_SetInt.fromArray(firstHalf), xx), u_1));

aa = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 100));

bb = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 200));

cc = Belt_SetInt.fromArray(Array_data_util.randomRange(120, 200));

dd = Belt_SetInt.union(aa, cc);

b("File \"bs_set_int_test.ml\", line 113, characters 4-11", Belt_SetInt.subset(aa, bb));

b("File \"bs_set_int_test.ml\", line 114, characters 4-11", Belt_SetInt.subset(dd, bb));

b("File \"bs_set_int_test.ml\", line 115, characters 4-11", Belt_SetInt.subset(Belt_SetInt.add(dd, 200), bb));

b("File \"bs_set_int_test.ml\", line 116, characters 4-11", Belt_SetInt.add(dd, 200) == dd);

b("File \"bs_set_int_test.ml\", line 117, characters 4-11", Belt_SetInt.add(dd, 0) == dd);

b("File \"bs_set_int_test.ml\", line 118, characters 4-11", not Belt_SetInt.subset(Belt_SetInt.add(dd, 201), bb));

aa_1 = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 100));

bb_1 = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 100));

cc_1 = Belt_SetInt.add(bb_1, 101);

dd_1 = Belt_SetInt.remove(bb_1, 99);

ee = Belt_SetInt.add(dd_1, 101);

b("File \"bs_set_int_test.ml\", line 127, characters 4-11", Belt_SetInt.eq(aa_1, bb_1));

b("File \"bs_set_int_test.ml\", line 128, characters 4-11", not Belt_SetInt.eq(aa_1, cc_1));

b("File \"bs_set_int_test.ml\", line 129, characters 4-11", not Belt_SetInt.eq(dd_1, cc_1));

b("File \"bs_set_int_test.ml\", line 130, characters 4-11", not Belt_SetInt.eq(bb_1, ee));

a1 = Belt_SetInt.mergeMany(Belt_SetInt.empty, Array_data_util.randomRange(0, 100));

a2 = Belt_SetInt.removeMany(a1, Array_data_util.randomRange(40, 100));

a3 = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 39));

match_1 = Belt_SetInt.split(a1, 40);

match_2 = match_1[0];

a5 = match_2[1];

a4 = match_2[0];

b("File \"bs_set_int_test.ml\", line 138, characters 4-11", Belt_SetInt.eq(a1, Belt_SetInt.fromArray(Array_data_util.randomRange(0, 100))));

b("File \"bs_set_int_test.ml\", line 139, characters 4-11", Belt_SetInt.eq(a2, a3));

b("File \"bs_set_int_test.ml\", line 140, characters 4-11", match_1[1]);

b("File \"bs_set_int_test.ml\", line 141, characters 4-11", Belt_SetInt.eq(a3, a4));

a6 = Belt_SetInt.remove(Belt_SetInt.removeMany(a1, Array_data_util.randomRange(0, 39)), 40);

b("File \"bs_set_int_test.ml\", line 143, characters 4-11", Belt_SetInt.eq(a5, a6));

a7 = Belt_SetInt.remove(a1, 40);

match_3 = Belt_SetInt.split(a7, 40);

match_4 = match_3[0];

a9 = match_4[1];

b("File \"bs_set_int_test.ml\", line 146, characters 4-11", not match_3[1]);

b("File \"bs_set_int_test.ml\", line 147, characters 4-11", Belt_SetInt.eq(a4, match_4[0]));

b("File \"bs_set_int_test.ml\", line 148, characters 4-11", Belt_SetInt.eq(a5, a9));

a10 = Belt_SetInt.removeMany(a9, Array_data_util.randomRange(42, 2000));

eq("File \"bs_set_int_test.ml\", line 150, characters 5-12", Belt_SetInt.size(a10), 1);

a11 = Belt_SetInt.removeMany(a9, Array_data_util.randomRange(0, 2000));

b("File \"bs_set_int_test.ml\", line 152, characters 4-11", Belt_SetInt.isEmpty(a11));

match_5 = Belt_SetInt.split(Belt_SetInt.empty, 0);

match_6 = match_5[0];

b("File \"bs_set_int_test.ml\", line 156, characters 4-11", Belt_SetInt.isEmpty(match_6[0]));

b("File \"bs_set_int_test.ml\", line 157, characters 4-11", Belt_SetInt.isEmpty(match_6[1]));

b("File \"bs_set_int_test.ml\", line 158, characters 4-11", not match_5[1]);

v_12 = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 2000));

v0 = Belt_SetInt.fromArray(Array_data_util.randomRange(0, 2000));

v1 = Belt_SetInt.fromArray(Array_data_util.randomRange(1, 2001));

v2 = Belt_SetInt.fromArray(Array_data_util.randomRange(3, 2002));

v3 = Belt_SetInt.removeMany(v2, {
      2002,
      2001
    });

us = Belt_Array.map(Array_data_util.randomRange(1000, 3000), (function(x) do
        return Belt_SetInt.has(v_12, x);
      end end));

counted = Belt_Array.reduce(us, 0, (function(acc, x) do
        if (x) then do
          return acc + 1 | 0;
        end else do
          return acc;
        end end 
      end end));

eq("File \"bs_set_int_test.ml\", line 168, characters 5-12", counted, 1001);

b("File \"bs_set_int_test.ml\", line 169, characters 4-11", Belt_SetInt.eq(v_12, v0));

b("File \"bs_set_int_test.ml\", line 170, characters 4-11", Belt_SetInt.cmp(v_12, v0) == 0);

b("File \"bs_set_int_test.ml\", line 171, characters 4-11", Belt_SetInt.cmp(v_12, v1) < 0);

b("File \"bs_set_int_test.ml\", line 172, characters 4-11", Belt_SetInt.cmp(v_12, v2) > 0);

b("File \"bs_set_int_test.ml\", line 173, characters 4-11", Belt_SetInt.subset(v3, v0));

b("File \"bs_set_int_test.ml\", line 174, characters 4-11", not Belt_SetInt.subset(v1, v0));

eq("File \"bs_set_int_test.ml\", line 175, characters 5-12", Belt_SetInt.get(v_12, 30), 30);

eq("File \"bs_set_int_test.ml\", line 176, characters 5-12", Belt_SetInt.get(v_12, 3000), undefined);

Mt.from_pair_suites("Bs_set_int_test", suites.contents);

N = --[[ alias ]]0;

I = --[[ alias ]]0;

A = --[[ alias ]]0;

ofA = Belt_SetInt.fromArray;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.N = N;
exports.I = I;
exports.A = A;
exports.$eq$tilde = $eq$tilde;
exports.$eq$star = $eq$star;
exports.ofA = ofA;
exports.u = u;
exports.range = range;
exports.revRange = revRange;
--[[  Not a pure module ]]
