--[['use strict';]]

Mt = require "./mt.lua";
Belt_Id = require "../../lib/js/belt_Id.lua";
Belt_Map = require "../../lib/js/belt_Map.lua";
Belt_Set = require "../../lib/js/belt_Set.lua";
Belt_Array = require "../../lib/js/belt_Array.lua";
Belt_MapDict = require "../../lib/js/belt_MapDict.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";
Array_data_util = require "./array_data_util.lua";

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

Icmp = Belt_Id.comparable(Caml_primitive.caml_int_compare);

function mapOfArray(x) do
  return Belt_Map.fromArray(x, Icmp);
end end

function setOfArray(x) do
  return Belt_Set.fromArray(x, Icmp);
end end

function emptyMap(param) do
  return do
          cmp: Icmp.cmp,
          data: Belt_MapDict.empty
        end;
end end

function mergeInter(s1, s2) do
  m = Belt_Map.merge(s1, s2, (function (k, v1, v2) do
          if (v1 ~= undefined and v2 ~= undefined) then do
            return --[[ () ]]0;
          end
           end 
        end end));
  x = Belt_MapDict.keysToArray(m.data);
  return Belt_Set.fromArray(x, Icmp);
end end

function mergeUnion(s1, s2) do
  m = Belt_Map.merge(s1, s2, (function (k, v1, v2) do
          if (v1 ~= undefined or v2 ~= undefined) then do
            return --[[ () ]]0;
          end
           end 
        end end));
  x = Belt_MapDict.keysToArray(m.data);
  return Belt_Set.fromArray(x, Icmp);
end end

function mergeDiff(s1, s2) do
  m = Belt_Map.merge(s1, s2, (function (k, v1, v2) do
          if (v1 ~= undefined and v2 == undefined) then do
            return --[[ () ]]0;
          end
           end 
        end end));
  x = Belt_MapDict.keysToArray(m.data);
  return Belt_Set.fromArray(x, Icmp);
end end

function randomRange(i, j) do
  return Belt_Array.map(Array_data_util.randomRange(i, j), (function (x) do
                return --[[ tuple ]][
                        x,
                        x
                      ];
              end end));
end end

x = randomRange(0, 100);

u0 = Belt_Map.fromArray(x, Icmp);

x$1 = randomRange(30, 120);

u1 = Belt_Map.fromArray(x$1, Icmp);

x$2 = Array_data_util.range(30, 100);

b("File \"bs_poly_map_test.ml\", line 48, characters 4-11", Belt_Set.eq(mergeInter(u0, u1), Belt_Set.fromArray(x$2, Icmp)));

x$3 = Array_data_util.range(0, 120);

b("File \"bs_poly_map_test.ml\", line 49, characters 4-11", Belt_Set.eq(mergeUnion(u0, u1), Belt_Set.fromArray(x$3, Icmp)));

x$4 = Array_data_util.range(0, 29);

b("File \"bs_poly_map_test.ml\", line 50, characters 4-11", Belt_Set.eq(mergeDiff(u0, u1), Belt_Set.fromArray(x$4, Icmp)));

x$5 = Array_data_util.range(101, 120);

b("File \"bs_poly_map_test.ml\", line 51, characters 4-11", Belt_Set.eq(mergeDiff(u1, u0), Belt_Set.fromArray(x$5, Icmp)));

x$6 = randomRange(0, 10);

a0 = Belt_Map.fromArray(x$6, Icmp);

a1 = Belt_Map.set(a0, 3, 33);

a2 = Belt_Map.remove(a1, 3);

a3 = Belt_Map.update(a2, 3, (function (k) do
        if (k ~= undefined) then do
          return k + 1 | 0;
        end else do
          return 11;
        end end 
      end end));

a4 = Belt_Map.update(a2, 3, (function (k) do
        if (k ~= undefined) then do
          return k + 1 | 0;
        end
         end 
      end end));

a5 = Belt_Map.remove(a0, 3);

a6 = Belt_Map.remove(a5, 3);

b("File \"bs_poly_map_test.ml\", line 70, characters 4-11", a5 == a6);

b("File \"bs_poly_map_test.ml\", line 71, characters 4-11", Belt_Map.has(a0, 3));

b("File \"bs_poly_map_test.ml\", line 72, characters 4-11", not Belt_Map.has(a5, 3));

b("File \"bs_poly_map_test.ml\", line 73, characters 4-11", 3 == Belt_Map.getUndefined(a0, 3));

b("File \"bs_poly_map_test.ml\", line 74, characters 4-11", 33 == Belt_Map.getUndefined(a1, 3));

b("File \"bs_poly_map_test.ml\", line 75, characters 4-11", Belt_Map.getUndefined(a2, 3) == undefined);

b("File \"bs_poly_map_test.ml\", line 77, characters 4-11", 11 == Belt_Map.getUndefined(a3, 3));

b("File \"bs_poly_map_test.ml\", line 78, characters 4-11", Belt_Map.getUndefined(a4, 3) == undefined);

a7 = Belt_Map.removeMany(a0, [
      7,
      8,
      0,
      1,
      3,
      2,
      4,
      922,
      4,
      5,
      6
    ]);

eq("File \"bs_poly_map_test.ml\", line 81, characters 5-12", Belt_MapDict.keysToArray(a7.data), [
      9,
      10
    ]);

a8 = Belt_Map.removeMany(a7, Array_data_util.randomRange(0, 100));

b("File \"bs_poly_map_test.ml\", line 83, characters 4-11", Belt_MapDict.isEmpty(a8.data));

x$7 = randomRange(0, 100);

u0$1 = Belt_Map.fromArray(x$7, Icmp);

u1$1 = Belt_Map.set(u0$1, 3, 32);

eq("File \"bs_poly_map_test.ml\", line 90, characters 5-12", Belt_Map.get(u1$1, 3), 32);

eq("File \"bs_poly_map_test.ml\", line 91, characters 5-12", Belt_Map.get(u0$1, 3), 3);

function acc(m, is) do
  return Belt_Array.reduce(is, m, (function (a, i) do
                m = a;
                i$1 = i;
                return Belt_Map.update(m, i$1, (function (n) do
                              if (n ~= undefined) then do
                                return n + 1 | 0;
                              end else do
                                return 1;
                              end end 
                            end end));
              end end));
end end

m = do
  cmp: Icmp.cmp,
  data: Belt_MapDict.empty
end;

m1 = acc(m, Belt_Array.concat(Array_data_util.randomRange(0, 20), Array_data_util.randomRange(10, 30)));

x$8 = Belt_Array.makeBy(31, (function (i) do
        return --[[ tuple ]][
                i,
                i >= 10 and i <= 20 and 2 or 1
              ];
      end end));

b("File \"bs_poly_map_test.ml\", line 103, characters 4-11", Belt_Map.eq(m1, Belt_Map.fromArray(x$8, Icmp), (function (x, y) do
            return x == y;
          end end)));

v0 = do
  cmp: Icmp.cmp,
  data: Belt_MapDict.empty
end;

v1 = Belt_Map.mergeMany(v0, Belt_Array.map(Array_data_util.randomRange(0, 10000), (function (x) do
            return --[[ tuple ]][
                    x,
                    x
                  ];
          end end)));

x$9 = Belt_Array.map(Array_data_util.randomRange(0, 10000), (function (x) do
        return --[[ tuple ]][
                x,
                x
              ];
      end end));

v2 = Belt_Map.fromArray(x$9, Icmp);

b("File \"bs_poly_map_test.ml\", line 117, characters 4-11", Belt_Map.eq(v1, v2, (function (x, y) do
            return x == y;
          end end)));

function inc(x) do
  if (x ~= undefined) then do
    return x + 1 | 0;
  end else do
    return 0;
  end end 
end end

v3 = Belt_Map.update(v1, 10, inc);

v4 = Belt_Map.update(v3, -10, inc);

match = Belt_Map.split(v3, 5000);

pres = match[1];

match$1 = match[0];

match$2 = Belt_Map.get(v3, 10);

b("File \"bs_poly_map_test.ml\", line 126, characters 4-11", match$2 ~= undefined and match$2 == 11 or false);

match$3 = Belt_Map.get(v3, -10);

b("File \"bs_poly_map_test.ml\", line 127, characters 4-11", match$3 == undefined);

match$4 = Belt_Map.get(v4, -10);

b("File \"bs_poly_map_test.ml\", line 128, characters 4-11", match$4 ~= undefined and match$4 == 0 or false);

map = Belt_Map.remove(do
      cmp: Icmp.cmp,
      data: Belt_MapDict.empty
    end, 0);

b("File \"bs_poly_map_test.ml\", line 129, characters 4-11", Belt_MapDict.isEmpty(map.data));

map$1 = Belt_Map.removeMany(do
      cmp: Icmp.cmp,
      data: Belt_MapDict.empty
    end, [0]);

b("File \"bs_poly_map_test.ml\", line 130, characters 4-11", Belt_MapDict.isEmpty(map$1.data));

b("File \"bs_poly_map_test.ml\", line 131, characters 4-11", pres ~= undefined and pres == 5000 or false);

b("File \"bs_poly_map_test.ml\", line 132, characters 4-11", Belt_Array.eq(Belt_MapDict.keysToArray(match$1[0].data), Belt_Array.makeBy(5000, (function (i) do
                return i;
              end end)), (function (prim, prim$1) do
            return prim == prim$1;
          end end)));

b("File \"bs_poly_map_test.ml\", line 133, characters 4-11", Belt_Array.eq(Belt_MapDict.keysToArray(match$1[1].data), Belt_Array.makeBy(5000, (function (i) do
                return 5001 + i | 0;
              end end)), (function (prim, prim$1) do
            return prim == prim$1;
          end end)));

v7 = Belt_Map.remove(v3, 5000);

match$5 = Belt_Map.split(v7, 5000);

match$6 = match$5[0];

b("File \"bs_poly_map_test.ml\", line 137, characters 4-11", match$5[1] == undefined);

b("File \"bs_poly_map_test.ml\", line 138, characters 4-11", Belt_Array.eq(Belt_MapDict.keysToArray(match$6[0].data), Belt_Array.makeBy(5000, (function (i) do
                return i;
              end end)), (function (prim, prim$1) do
            return prim == prim$1;
          end end)));

b("File \"bs_poly_map_test.ml\", line 139, characters 4-11", Belt_Array.eq(Belt_MapDict.keysToArray(match$6[1].data), Belt_Array.makeBy(5000, (function (i) do
                return 5001 + i | 0;
              end end)), (function (prim, prim$1) do
            return prim == prim$1;
          end end)));

Mt.from_pair_suites("Bs_poly_map_test", suites.contents);

M = --[[ alias ]]0;

N = --[[ alias ]]0;

A = --[[ alias ]]0;

I = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Icmp = Icmp;
exports.M = M;
exports.N = N;
exports.A = A;
exports.I = I;
exports.mapOfArray = mapOfArray;
exports.setOfArray = setOfArray;
exports.emptyMap = emptyMap;
exports.mergeInter = mergeInter;
exports.mergeUnion = mergeUnion;
exports.mergeDiff = mergeDiff;
exports.randomRange = randomRange;
exports.acc = acc;
--[[ Icmp Not a pure module ]]
