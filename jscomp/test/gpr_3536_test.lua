'use strict';

Mt = require("./mt.lua");
Curry = require("../../lib/js/curry.lua");
Caml_int32 = require("../../lib/js/caml_int32.lua");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

X = { };

function xx(obj, a0, a1, a2, a3, a4, a5) do
  return (Curry._2(a4, Curry._2(a2, Curry._2(a0, obj, a1), a3), a5) - 1 | 0) - 3 | 0;
end end

eq("File \"gpr_3536_test.ml\", line 29, characters 12-19", 5, 5);

eq("File \"gpr_3536_test.ml\", line 32, characters 6-13", xx(3, (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end), 2, (function (prim, prim$1) do
            return prim + prim$1 | 0;
          end end), 4, Caml_int32.imul, 3), 11);

Mt.from_pair_suites("Gpr_3536_test", suites.contents);

v = 5;

u = --[[ Some ]][3];

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.X = X;
exports.u = u;
exports.xx = xx;
--[[  Not a pure module ]]
