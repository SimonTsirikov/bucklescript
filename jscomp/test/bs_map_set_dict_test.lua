--[['use strict';]]

Mt = require "./mt.lua";
Belt_Id = require "../../lib/js/belt_Id.lua";
Belt_Map = require "../../lib/js/belt_Map.lua";
Belt_List = require "../../lib/js/belt_List.lua";
Belt_Array = require "../../lib/js/belt_Array.lua";
Belt_MapInt = require "../../lib/js/belt_MapInt.lua";
Belt_MapDict = require "../../lib/js/belt_MapDict.lua";
Belt_SetDict = require "../../lib/js/belt_SetDict.lua";
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

Icmp2 = Belt_Id.comparable(Caml_primitive.caml_int_compare);

m0 = do
  cmp: Icmp.cmp,
  data: Belt_MapDict.empty
end;

I2 = Belt_Id.comparable((function (x, y) do
        return Caml_primitive.caml_int_compare(y, x);
      end end));

m = do
  cmp: Icmp2.cmp,
  data: Belt_MapDict.empty
end;

m2 = do
  cmp: I2.cmp,
  data: Belt_MapDict.empty
end;

data = m.data;

Belt_Map.getId(m2);

m_dict = Belt_Map.getId(m);

for i = 0 , 100000 , 1 do
  data = Belt_MapDict.set(data, i, i, m_dict.cmp);
end

data$1 = data;

newm = do
  cmp: m_dict.cmp,
  data: data$1
end;

console.log(newm);

m11 = Belt_MapDict.set(Belt_MapDict.empty, 1, 1, Icmp.cmp);

console.log(m11);

v = do
  cmp: Icmp2.cmp,
  data: Belt_SetDict.empty
end;

m_dict$1 = Belt_Map.getId(m);

cmp = m_dict$1.cmp;

data$2 = v.data;

for i$1 = 0 , 100000 , 1 do
  data$2 = Belt_SetDict.add(data$2, i$1, cmp);
end

console.log(data$2);

function f(param) do
  return Belt_Map.fromArray(param, Icmp);
end end

function $eq$tilde(a, b) do
  return (function (param) do
      return Belt_Map.eq(a, b, param);
    end end);
end end

u0 = f(Belt_Array.map(Array_data_util.randomRange(0, 39), (function (x) do
            return --[[ tuple ]][
                    x,
                    x
                  ];
          end end)));

u1 = Belt_Map.set(u0, 39, 120);

b("File \"bs_map_set_dict_test.ml\", line 77, characters 4-11", Belt_Array.every2(Belt_MapDict.toArray(u0.data), Belt_Array.map(Array_data_util.range(0, 39), (function (x) do
                return --[[ tuple ]][
                        x,
                        x
                      ];
              end end)), (function (param, param$1) do
            if (param[0] == param$1[0]) then do
              return param[1] == param$1[1];
            end else do
              return false;
            end end 
          end end)));

b("File \"bs_map_set_dict_test.ml\", line 82, characters 4-11", Belt_List.every2(Belt_MapDict.toList(u0.data), Belt_List.fromArray(Belt_Array.map(Array_data_util.range(0, 39), (function (x) do
                    return --[[ tuple ]][
                            x,
                            x
                          ];
                  end end))), (function (param, param$1) do
            if (param[0] == param$1[0]) then do
              return param[1] == param$1[1];
            end else do
              return false;
            end end 
          end end)));

eq("File \"bs_map_set_dict_test.ml\", line 87, characters 5-12", Belt_Map.get(u0, 39), 39);

eq("File \"bs_map_set_dict_test.ml\", line 88, characters 5-12", Belt_Map.get(u1, 39), 120);

u = f(Belt_Array.makeByAndShuffle(10000, (function (x) do
            return --[[ tuple ]][
                    x,
                    x
                  ];
          end end)));

eq("File \"bs_map_set_dict_test.ml\", line 94, characters 4-11", Belt_Array.makeBy(10000, (function (x) do
            return --[[ tuple ]][
                    x,
                    x
                  ];
          end end)), Belt_MapDict.toArray(u.data));

Mt.from_pair_suites("Bs_map_set_dict_test", suites.contents);

M = --[[ alias ]]0;

MI = --[[ alias ]]0;

I = --[[ alias ]]0;

A = --[[ alias ]]0;

L = --[[ alias ]]0;

vv = Belt_MapInt.empty;

vv2 = Belt_MapInt.empty;

Md0 = --[[ alias ]]0;

ISet = --[[ alias ]]0;

S0 = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Icmp = Icmp;
exports.Icmp2 = Icmp2;
exports.M = M;
exports.MI = MI;
exports.I = I;
exports.A = A;
exports.L = L;
exports.m0 = m0;
exports.I2 = I2;
exports.m = m;
exports.m2 = m2;
exports.vv = vv;
exports.vv2 = vv2;
exports.Md0 = Md0;
exports.ISet = ISet;
exports.S0 = S0;
exports.f = f;
exports.$eq$tilde = $eq$tilde;
--[[ Icmp Not a pure module ]]
