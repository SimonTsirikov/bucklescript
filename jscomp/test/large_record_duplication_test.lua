'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Caml_obj = require("../../lib/js/caml_obj.lua");
Caml_array = require("../../lib/js/caml_array.lua");
Caml_exceptions = require("../../lib/js/caml_exceptions.lua");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.lua");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function f0(x) do
  newrecord = Caml_obj.caml_obj_dup(x);
  newrecord.x0 = 1;
  return newrecord;
end end

v1 = --[[ A0 ]][
  --[[ x0 ]]9,
  --[[ x1 ]]9,
  --[[ x2 ]]9,
  --[[ x3 ]]9,
  --[[ x4 ]]9,
  --[[ x5 ]]9,
  --[[ x6 ]]9,
  --[[ x7 ]]9,
  --[[ x8 ]]9,
  --[[ x9 ]]9,
  --[[ x10 ]]9,
  --[[ x11 ]]9,
  --[[ x12 ]]9,
  --[[ x13 ]]9,
  --[[ x14 ]]9,
  --[[ x15 ]]9,
  --[[ x16 ]]9,
  --[[ x17 ]]9,
  --[[ x18 ]]9,
  --[[ x19 ]]9,
  --[[ x20 ]]9,
  --[[ x21 ]]9,
  --[[ x22 ]]9
];

function get_x0(x) do
  if (x) then do
    return x[--[[ x0 ]]0];
  end
   end 
end end

function f1(x) do
  if (x) then do
    newrecord = Caml_array.caml_array_dup(x);
    newrecord[--[[ x0 ]]0] = 1;
    return newrecord;
  end else do
    return --[[ A1 ]]0;
  end end 
end end

eq("File \"large_record_duplication_test.ml\", line 129, characters 6-13", get_x0(f1(v1)), 1);

v2 = --[[ A0 ]]Block.__(0, [
    --[[ x0 ]]9,
    --[[ x1 ]]9,
    --[[ x2 ]]9,
    --[[ x3 ]]9,
    --[[ x4 ]]9,
    --[[ x5 ]]9,
    --[[ x6 ]]9,
    --[[ x7 ]]9,
    --[[ x8 ]]9,
    --[[ x9 ]]9,
    --[[ x10 ]]9,
    --[[ x11 ]]9,
    --[[ x12 ]]9,
    --[[ x13 ]]9,
    --[[ x14 ]]9,
    --[[ x15 ]]9,
    --[[ x16 ]]9,
    --[[ x17 ]]9,
    --[[ x18 ]]9,
    --[[ x19 ]]9,
    --[[ x20 ]]9,
    --[[ x21 ]]9,
    --[[ x22 ]]9
  ]);

function get_x0$1(x) do
  if (x.tag) then do
    return ;
  end else do
    return x[--[[ x0 ]]0];
  end end 
end end

function f2(x) do
  if (x.tag) then do
    return x;
  end else do
    newrecord = Caml_obj.caml_obj_dup(x);
    newrecord[--[[ x0 ]]0] = 1;
    return newrecord;
  end end 
end end

eq("File \"large_record_duplication_test.ml\", line 194, characters 6-13", get_x0$1(f2(v2)), 1);

A0 = Caml_exceptions.create("Large_record_duplication_test.A0");

function f3(x) do
  if (x[0] == A0) then do
    newrecord = Caml_array.caml_array_dup(x);
    newrecord[--[[ x0 ]]1] = 1;
    return newrecord;
  end else do
    return x;
  end end 
end end

function get_x0$2(x) do
  if (x[0] == A0) then do
    return x[--[[ x0 ]]1];
  end
   end 
end end

v3 = [
  A0,
  --[[ x0 ]]9,
  --[[ x1 ]]9,
  --[[ x2 ]]9,
  --[[ x3 ]]9,
  --[[ x4 ]]9,
  --[[ x5 ]]9,
  --[[ x6 ]]9,
  --[[ x7 ]]9,
  --[[ x8 ]]9,
  --[[ x9 ]]9,
  --[[ x10 ]]9,
  --[[ x11 ]]9,
  --[[ x12 ]]9,
  --[[ x13 ]]9,
  --[[ x14 ]]9,
  --[[ x15 ]]9,
  --[[ x16 ]]9,
  --[[ x17 ]]9,
  --[[ x18 ]]9,
  --[[ x19 ]]9,
  --[[ x20 ]]9,
  --[[ x21 ]]9,
  --[[ x22 ]]9
];

eq("File \"large_record_duplication_test.ml\", line 260, characters 6-13", get_x0$2(f3(v3)), 1);

eq("File \"large_record_duplication_test.ml\", line 261, characters 6-13", get_x0$2(v3), 9);

eq("File \"large_record_duplication_test.ml\", line 262, characters 6-13", get_x0$2(Caml_builtin_exceptions.not_found), undefined);

Mt.from_pair_suites("Large_record_duplication_test", suites.contents);

v0 = do
  x0: 9,
  x1: 9,
  x2: 9,
  x3: 9,
  x4: 9,
  x5: 9,
  x6: 9,
  x7: 9,
  x8: 9,
  x9: 9,
  x10: 9,
  x11: 9,
  x12: 9,
  x13: 9,
  x14: 9,
  x15: 9,
  x16: 9,
  x17: 9,
  x18: 9,
  x19: 9,
  x20: 9,
  x21: 9,
  x22: 9
end;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v0 = v0;
exports.f0 = f0;
exports.v1 = v1;
exports.f1 = f1;
exports.v2 = v2;
exports.f2 = f2;
exports.A0 = A0;
exports.f3 = f3;
exports.get_x0 = get_x0$2;
exports.v3 = v3;
--[[  Not a pure module ]]
