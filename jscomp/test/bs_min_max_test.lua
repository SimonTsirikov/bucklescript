console.log = print;

Mt = require "./mt";
Caml_obj = require "../../lib/js/caml_obj";
Caml_int64 = require "../../lib/js/caml_int64";
Caml_primitive = require "../../lib/js/caml_primitive";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(param, param_1) do
  return Mt.bool_suites(test_id, suites, param, param_1);
end end

function f(x, y) do
  return Caml_primitive.caml_int_compare(x + y | 0, y + x | 0);
end end

function f2(x, y) do
  return Caml_primitive.caml_int_compare(x + y | 0, y);
end end

f3 = Caml_primitive.caml_int_compare;

function f4(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end end

f5_min = Caml_obj.caml_min;

f5_max = Caml_obj.caml_max;

b("File \"bs_min_max_test.ml\", line 28, characters 4-11", Caml_int64.eq(Caml_int64.min(--[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]0
            }, --[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]1
            }), --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        }));

b("File \"bs_min_max_test.ml\", line 29, characters 4-11", Caml_int64.eq(Caml_int64.max(--[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]22
            }, --[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]1
            }), --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]22
        }));

b("File \"bs_min_max_test.ml\", line 30, characters 4-11", Caml_int64.eq(Caml_int64.max(--[[ int64 ]]{
              --[[ hi ]]-1,
              --[[ lo ]]4294967293
            }, --[[ int64 ]]{
              --[[ hi ]]0,
              --[[ lo ]]3
            }), --[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]3
        }));

eq("File \"bs_min_max_test.ml\", line 31, characters 5-12", Caml_obj.caml_min(undefined, 3), undefined);

eq("File \"bs_min_max_test.ml\", line 32, characters 5-12", Caml_obj.caml_min(3, undefined), undefined);

eq("File \"bs_min_max_test.ml\", line 33, characters 5-12", Caml_obj.caml_max(3, undefined), 3);

eq("File \"bs_min_max_test.ml\", line 34, characters 5-12", Caml_obj.caml_max(undefined, 3), 3);

b("File \"bs_min_max_test.ml\", line 35, characters 4-11", Caml_obj.caml_greaterequal(5, undefined));

b("File \"bs_min_max_test.ml\", line 36, characters 4-11", Caml_obj.caml_lessequal(undefined, 5));

b("File \"bs_min_max_test.ml\", line 37, characters 4-11", true);

b("File \"bs_min_max_test.ml\", line 38, characters 4-11", true);

Mt.from_pair_suites("Bs_min_max_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5_min = f5_min;
exports.f5_max = f5_max;
--[[  Not a pure module ]]
