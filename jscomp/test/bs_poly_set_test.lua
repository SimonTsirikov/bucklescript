console = {log = print};

Mt = require "./mt";
Belt_Id = require "../../lib/js/belt_Id";
Belt_Set = require "../../lib/js/belt_Set";
Caml_obj = require "../../lib/js/caml_obj";
Belt_List = require "../../lib/js/belt_List";
Belt_Array = require "../../lib/js/belt_Array";
Belt_SetDict = require "../../lib/js/belt_SetDict";
Belt_SortArray = require "../../lib/js/belt_SortArray";
Caml_primitive = require "../../lib/js/caml_primitive";
Array_data_util = require "./array_data_util";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function t(loc, x) do
  return Mt.throw_suites(test_id, suites, loc, x);
end end

IntCmp = Belt_Id.comparable(Caml_primitive.caml_int_compare);

u0 = Belt_Set.fromArray(Array_data_util.range(0, 30), IntCmp);

u1 = Belt_Set.remove(u0, 0);

u2 = Belt_Set.remove(u1, 0);

u3 = Belt_Set.remove(u2, 30);

u4 = Belt_Set.remove(u3, 20);

r = Array_data_util.randomRange(0, 30);

u5 = Belt_Set.add(u4, 3);

u6 = Belt_Set.removeMany(u5, r);

u7 = Belt_Set.mergeMany(u6, {
      0,
      1,
      2,
      0
    });

u8 = Belt_Set.removeMany(u7, {
      0,
      1,
      2,
      3
    });

u9 = Belt_Set.mergeMany(u8, Array_data_util.randomRange(0, 20000));

u10 = Belt_Set.mergeMany(u9, Array_data_util.randomRange(0, 200));

u11 = Belt_Set.removeMany(u10, Array_data_util.randomRange(0, 200));

u12 = Belt_Set.removeMany(u11, Array_data_util.randomRange(0, 1000));

u13 = Belt_Set.removeMany(u12, Array_data_util.randomRange(0, 1000));

u14 = Belt_Set.removeMany(u13, Array_data_util.randomRange(1000, 10000));

u15 = Belt_Set.removeMany(u14, Array_data_util.randomRange(10000, 19999));

u16 = Belt_Set.removeMany(u15, Array_data_util.randomRange(20000, 21000));

b("File \"bs_poly_set_test.ml\", line 35, characters 4-11", u0 ~= u1);

b("File \"bs_poly_set_test.ml\", line 36, characters 4-11", u2 == u1);

eq("File \"bs_poly_set_test.ml\", line 37, characters 5-12", Belt_SetDict.size(u4.data), 28);

b("File \"bs_poly_set_test.ml\", line 38, characters 4-11", 29 == Belt_SetDict.maxUndefined(u4.data));

b("File \"bs_poly_set_test.ml\", line 39, characters 4-11", 1 == Belt_SetDict.minUndefined(u4.data));

b("File \"bs_poly_set_test.ml\", line 40, characters 4-11", u4 == u5);

b("File \"bs_poly_set_test.ml\", line 41, characters 4-11", Belt_SetDict.isEmpty(u6.data));

eq("File \"bs_poly_set_test.ml\", line 42, characters 6-13", Belt_SetDict.size(u7.data), 3);

b("File \"bs_poly_set_test.ml\", line 43, characters 4-11", not Belt_SetDict.isEmpty(u7.data));

b("File \"bs_poly_set_test.ml\", line 44, characters 4-11", Belt_SetDict.isEmpty(u8.data));

b("File \"bs_poly_set_test.ml\", line 47, characters 4-11", Belt_Set.has(u10, 20));

b("File \"bs_poly_set_test.ml\", line 48, characters 4-11", Belt_Set.has(u10, 21));

eq("File \"bs_poly_set_test.ml\", line 49, characters 5-12", Belt_SetDict.size(u10.data), 20001);

eq("File \"bs_poly_set_test.ml\", line 50, characters 5-12", Belt_SetDict.size(u11.data), 19800);

eq("File \"bs_poly_set_test.ml\", line 51, characters 5-12", Belt_SetDict.size(u12.data), 19000);

eq("File \"bs_poly_set_test.ml\", line 53, characters 5-12", Belt_SetDict.size(u13.data), Belt_SetDict.size(u12.data));

eq("File \"bs_poly_set_test.ml\", line 54, characters 5-12", Belt_SetDict.size(u14.data), 10000);

eq("File \"bs_poly_set_test.ml\", line 55, characters 5-12", Belt_SetDict.size(u15.data), 1);

b("File \"bs_poly_set_test.ml\", line 56, characters 4-11", Belt_Set.has(u15, 20000));

b("File \"bs_poly_set_test.ml\", line 57, characters 4-11", not Belt_Set.has(u15, 2000));

b("File \"bs_poly_set_test.ml\", line 58, characters 4-11", Belt_SetDict.isEmpty(u16.data));

u17 = Belt_Set.fromArray(Array_data_util.randomRange(0, 100), IntCmp);

u18 = Belt_Set.fromArray(Array_data_util.randomRange(59, 200), IntCmp);

u19 = Belt_Set.union(u17, u18);

u20 = Belt_Set.fromArray(Array_data_util.randomRange(0, 200), IntCmp);

u21 = Belt_Set.intersect(u17, u18);

u22 = Belt_Set.diff(u17, u18);

u23 = Belt_Set.diff(u18, u17);

u24 = Belt_Set.union(u18, u17);

u25 = Belt_Set.add(u22, 59);

u26 = Belt_Set.add({
      cmp = IntCmp.cmp,
      data = Belt_SetDict.empty
    }, 3);

ss = Belt_Array.makeByAndShuffle(100, (function(i) do
        return (i << 1);
      end end));

u27 = Belt_Set.fromArray(ss, IntCmp);

u28 = Belt_Set.union(u27, u26);

u29 = Belt_Set.union(u26, u27);

b("File \"bs_poly_set_test.ml\", line 72, characters 4-11", Belt_Set.eq(u28, u29));

b("File \"bs_poly_set_test.ml\", line 73, characters 4-11", Caml_obj.caml_equal(Belt_SetDict.toArray(u29.data), Belt_SortArray.stableSortBy(Belt_Array.concat(ss, {3}), Caml_primitive.caml_int_compare)));

b("File \"bs_poly_set_test.ml\", line 74, characters 4-11", Belt_Set.eq(u19, u20));

eq("File \"bs_poly_set_test.ml\", line 75, characters 5-12", Belt_SetDict.toArray(u21.data), Array_data_util.range(59, 100));

eq("File \"bs_poly_set_test.ml\", line 76, characters 5-12", Belt_SetDict.toArray(u22.data), Array_data_util.range(0, 58));

b("File \"bs_poly_set_test.ml\", line 77, characters 4-11", Belt_Set.eq(u24, u19));

eq("File \"bs_poly_set_test.ml\", line 78, characters 5-12", Belt_SetDict.toArray(u23.data), Array_data_util.range(101, 200));

b("File \"bs_poly_set_test.ml\", line 79, characters 4-11", Belt_Set.subset(u23, u18));

b("File \"bs_poly_set_test.ml\", line 80, characters 4-11", not Belt_Set.subset(u18, u23));

b("File \"bs_poly_set_test.ml\", line 81, characters 4-11", Belt_Set.subset(u22, u17));

b("File \"bs_poly_set_test.ml\", line 82, characters 4-11", Belt_Set.subset(u21, u17) and Belt_Set.subset(u21, u18));

b("File \"bs_poly_set_test.ml\", line 83, characters 4-11", 47 == Belt_Set.getUndefined(u22, 47));

b("File \"bs_poly_set_test.ml\", line 84, characters 4-11", Caml_obj.caml_equal(47, Belt_Set.get(u22, 47)));

b("File \"bs_poly_set_test.ml\", line 85, characters 4-11", Belt_Set.getUndefined(u22, 59) == undefined);

b("File \"bs_poly_set_test.ml\", line 86, characters 4-11", undefined == Belt_Set.get(u22, 59));

eq("File \"bs_poly_set_test.ml\", line 88, characters 5-12", Belt_SetDict.size(u25.data), 60);

m = {
  cmp = IntCmp.cmp,
  data = Belt_SetDict.empty
};

b("File \"bs_poly_set_test.ml\", line 89, characters 4-11", Belt_SetDict.minimum(m.data) == undefined);

m_1 = {
  cmp = IntCmp.cmp,
  data = Belt_SetDict.empty
};

b("File \"bs_poly_set_test.ml\", line 90, characters 4-11", Belt_SetDict.maximum(m_1.data) == undefined);

m_2 = {
  cmp = IntCmp.cmp,
  data = Belt_SetDict.empty
};

b("File \"bs_poly_set_test.ml\", line 91, characters 4-11", Belt_SetDict.minUndefined(m_2.data) == undefined);

m_3 = {
  cmp = IntCmp.cmp,
  data = Belt_SetDict.empty
};

b("File \"bs_poly_set_test.ml\", line 92, characters 4-11", Belt_SetDict.maxUndefined(m_3.data) == undefined);

function testIterToList(xs) do
  v = {
    contents = --[[ [] ]]0
  };
  Belt_Set.forEach(xs, (function(x) do
          v.contents = --[[ :: ]]{
            x,
            v.contents
          };
          return --[[ () ]]0;
        end end));
  return Belt_List.reverse(v.contents);
end end

function testIterToList2(xs) do
  v = {
    contents = --[[ [] ]]0
  };
  Belt_SetDict.forEach(xs.data, (function(x) do
          v.contents = --[[ :: ]]{
            x,
            v.contents
          };
          return --[[ () ]]0;
        end end));
  return Belt_List.reverse(v.contents);
end end

u0_1 = Belt_Set.fromArray(Array_data_util.randomRange(0, 20), IntCmp);

u1_1 = Belt_Set.remove(u0_1, 17);

u2_1 = Belt_Set.add(u1_1, 33);

b("File \"bs_poly_set_test.ml\", line 109, characters 4-11", Belt_List.every2(testIterToList(u0_1), Belt_List.makeBy(21, (function(i) do
                return i;
              end end)), (function(x, y) do
            return x == y;
          end end)));

b("File \"bs_poly_set_test.ml\", line 110, characters 4-11", Belt_List.every2(testIterToList2(u0_1), Belt_List.makeBy(21, (function(i) do
                return i;
              end end)), (function(x, y) do
            return x == y;
          end end)));

b("File \"bs_poly_set_test.ml\", line 111, characters 4-11", Belt_List.every2(testIterToList(u0_1), Belt_SetDict.toList(u0_1.data), (function(x, y) do
            return x == y;
          end end)));

b("File \"bs_poly_set_test.ml\", line 112, characters 4-11", Belt_Set.some(u0_1, (function(x) do
            return x == 17;
          end end)));

b("File \"bs_poly_set_test.ml\", line 113, characters 4-11", not Belt_Set.some(u1_1, (function(x) do
            return x == 17;
          end end)));

b("File \"bs_poly_set_test.ml\", line 114, characters 4-11", Belt_Set.every(u0_1, (function(x) do
            return x < 24;
          end end)));

b("File \"bs_poly_set_test.ml\", line 115, characters 4-11", Belt_SetDict.every(u0_1.data, (function(x) do
            return x < 24;
          end end)));

b("File \"bs_poly_set_test.ml\", line 116, characters 4-11", not Belt_Set.every(u2_1, (function(x) do
            return x < 24;
          end end)));

b("File \"bs_poly_set_test.ml\", line 117, characters 4-11", not Belt_Set.every(Belt_Set.fromArray({
              1,
              2,
              3
            }, IntCmp), (function(x) do
            return x == 2;
          end end)));

b("File \"bs_poly_set_test.ml\", line 118, characters 4-11", Belt_Set.cmp(u1_1, u0_1) < 0);

b("File \"bs_poly_set_test.ml\", line 119, characters 4-11", Belt_Set.cmp(u0_1, u1_1) > 0);

a0 = Belt_Set.fromArray(Array_data_util.randomRange(0, 1000), IntCmp);

a1 = Belt_Set.keep(a0, (function(x) do
        return x % 2 == 0;
      end end));

a2 = Belt_Set.keep(a0, (function(x) do
        return x % 2 ~= 0;
      end end));

match = Belt_Set.partition(a0, (function(x) do
        return x % 2 == 0;
      end end));

a4 = match[1];

a3 = match[0];

b("File \"bs_poly_set_test.ml\", line 129, characters 4-11", Belt_Set.eq(a1, a3));

b("File \"bs_poly_set_test.ml\", line 130, characters 4-11", Belt_Set.eq(a2, a4));

eq("File \"bs_poly_set_test.ml\", line 131, characters 5-12", Belt_Set.getExn(a0, 3), 3);

eq("File \"bs_poly_set_test.ml\", line 132, characters 5-12", Belt_Set.getExn(a0, 4), 4);

t("File \"bs_poly_set_test.ml\", line 133, characters 4-11", (function(param) do
        Belt_Set.getExn(a0, 1002);
        return --[[ () ]]0;
      end end));

t("File \"bs_poly_set_test.ml\", line 134, characters 4-11", (function(param) do
        Belt_Set.getExn(a0, -1);
        return --[[ () ]]0;
      end end));

eq("File \"bs_poly_set_test.ml\", line 135, characters 5-12", Belt_SetDict.size(a0.data), 1001);

b("File \"bs_poly_set_test.ml\", line 136, characters 4-11", not Belt_SetDict.isEmpty(a0.data));

match_1 = Belt_Set.split(a0, 200);

match_2 = match_1[0];

b("File \"bs_poly_set_test.ml\", line 138, characters 4-11", match_1[1]);

eq("File \"bs_poly_set_test.ml\", line 139, characters 5-12", Belt_SetDict.toArray(match_2[0].data), Belt_Array.makeBy(200, (function(i) do
            return i;
          end end)));

eq("File \"bs_poly_set_test.ml\", line 140, characters 5-12", Belt_SetDict.toList(match_2[1].data), Belt_List.makeBy(800, (function(i) do
            return i + 201 | 0;
          end end)));

a7 = Belt_Set.remove(a0, 200);

match_3 = Belt_Set.split(a7, 200);

match_4 = match_3[0];

a9 = match_4[1];

a8 = match_4[0];

b("File \"bs_poly_set_test.ml\", line 143, characters 4-11", not match_3[1]);

eq("File \"bs_poly_set_test.ml\", line 144, characters 5-12", Belt_SetDict.toArray(a8.data), Belt_Array.makeBy(200, (function(i) do
            return i;
          end end)));

eq("File \"bs_poly_set_test.ml\", line 145, characters 5-12", Belt_SetDict.toList(a9.data), Belt_List.makeBy(800, (function(i) do
            return i + 201 | 0;
          end end)));

eq("File \"bs_poly_set_test.ml\", line 146, characters 5-12", Belt_SetDict.minimum(a8.data), 0);

eq("File \"bs_poly_set_test.ml\", line 147, characters 5-12", Belt_SetDict.minimum(a9.data), 201);

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
        return Belt_SetDict.checkInvariantInternal(x.data);
      end end));

a = Belt_Set.fromArray({}, IntCmp);

m_4 = Belt_Set.keep(a, (function(x) do
        return x % 2 == 0;
      end end));

b("File \"bs_poly_set_test.ml\", line 153, characters 4-11", Belt_SetDict.isEmpty(m_4.data));

match_5 = Belt_Set.split({
      cmp = IntCmp.cmp,
      data = Belt_SetDict.empty
    }, 0);

match_6 = match_5[0];

b("File \"bs_poly_set_test.ml\", line 157, characters 4-11", Belt_SetDict.isEmpty(match_6[0].data));

b("File \"bs_poly_set_test.ml\", line 158, characters 4-11", Belt_SetDict.isEmpty(match_6[1].data));

b("File \"bs_poly_set_test.ml\", line 159, characters 4-11", not match_5[1]);

Mt.from_pair_suites("Bs_poly_set_test", suites.contents);

N = --[[ alias ]]0;

D = --[[ alias ]]0;

I = --[[ alias ]]0;

A = --[[ alias ]]0;

S = --[[ alias ]]0;

L = --[[ alias ]]0;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.t = t;
exports.N = N;
exports.D = D;
exports.I = I;
exports.A = A;
exports.S = S;
exports.IntCmp = IntCmp;
exports.L = L;
exports.testIterToList = testIterToList;
exports.testIterToList2 = testIterToList2;
--[[ IntCmp Not a pure module ]]
