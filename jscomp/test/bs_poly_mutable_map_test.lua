console.log = print;

Mt = require "./mt";
Belt_Id = require "../../lib/js/belt_Id";
Belt_Set = require "../../lib/js/belt_Set";
Belt_Array = require "../../lib/js/belt_Array";
Caml_primitive = require "../../lib/js/caml_primitive";
Array_data_util = require "./array_data_util";
Belt_MutableMap = require "../../lib/js/belt_MutableMap";
Belt_internalAVLtree = require "../../lib/js/belt_internalAVLtree";

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

function f(x) do
  return Belt_MutableMap.fromArray(x, Icmp);
end end

function ff(x) do
  return Belt_Set.fromArray(x, Icmp);
end end

function randomRange(i, j) do
  return Belt_Array.map(Array_data_util.randomRange(i, j), (function (x) do
                return --[[ tuple ]]{
                        x,
                        x
                      };
              end end));
end end

x = randomRange(0, 10);

a0 = Belt_MutableMap.fromArray(x, Icmp);

Belt_MutableMap.set(a0, 3, 33);

eq("File \"bs_poly_mutable_map_test.ml\", line 27, characters 7-14", Belt_MutableMap.getExn(a0, 3), 33);

Belt_MutableMap.removeMany(a0, {
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
    });

eq("File \"bs_poly_mutable_map_test.ml\", line 29, characters 7-14", Belt_internalAVLtree.keysToArray(a0.data), {
      9,
      10
    });

Belt_MutableMap.removeMany(a0, Array_data_util.randomRange(0, 100));

b("File \"bs_poly_mutable_map_test.ml\", line 31, characters 6-13", Belt_MutableMap.isEmpty(a0));

Mt.from_pair_suites("Bs_poly_mutable_map_test", suites.contents);

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
exports.f = f;
exports.ff = ff;
exports.randomRange = randomRange;
--[[ Icmp Not a pure module ]]
