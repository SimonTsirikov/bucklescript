console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Int64 = require "../../lib/js/int64";
Printf = require "../../lib/js/printf";
Random = require "../../lib/js/random";
Mt_global = require "./mt_global";
Caml_array = require "../../lib/js/caml_array";

id = do
  contents: 0
end;

suites = do
  contents: --[[ [] ]]0
end;

function eq(f) do
  return (function (param, param_1) do
      return Mt_global.collect_eq(id, suites, f, param, param_1);
    end end);
end end

function neq(f) do
  return (function (param, param_1) do
      return Mt_global.collect_neq(id, suites, f, param, param_1);
    end end);
end end

function approx(f) do
  return (function (param, param_1) do
      return Mt_global.collect_approx(id, suites, f, param, param_1);
    end end);
end end

Random.self_init(--[[ () ]]0);

param = Random.__int(1000);

Random.self_init(--[[ () ]]0);

param_1 = Random.__int(10000);

Mt_global.collect_neq(id, suites, "File \"random_test.ml\", line 12, characters 6-13", param_1, param);

Random.init(0);

v = Caml_array.caml_make_vect(10, false);

for i = 0 , 9 , 1 do
  Caml_array.caml_array_set(v, i, Random.bool(--[[ () ]]0));
end

param_2 = {
  true,
  true,
  true,
  true,
  true,
  false,
  true,
  true,
  true,
  false
};

Mt_global.collect_eq(id, suites, "File \"random_test.ml\", line 26, characters 5-12", v, param_2);

f = Random.int64(Int64.max_int);

h = Random.int64(--[[ int64 ]]{
      --[[ hi ]]0,
      --[[ lo ]]3
    });

vv = Random.bits(--[[ () ]]0);

xx = Random.__float(3.0);

xxx = Random.int32(103);

Curry._5(Printf.printf(--[[ Format ]]{
          --[[ Int64 ]]Block.__(7, {
              --[[ Int_d ]]0,
              --[[ No_padding ]]0,
              --[[ No_precision ]]0,
              --[[ Char_literal ]]Block.__(12, {
                  --[[ " " ]]32,
                  --[[ Int64 ]]Block.__(7, {
                      --[[ Int_d ]]0,
                      --[[ No_padding ]]0,
                      --[[ No_precision ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ " " ]]32,
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_d ]]0,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ Char_literal ]]Block.__(12, {
                                  --[[ " " ]]32,
                                  --[[ Float ]]Block.__(8, {
                                      --[[ Float_f ]]0,
                                      --[[ No_padding ]]0,
                                      --[[ No_precision ]]0,
                                      --[[ Char_literal ]]Block.__(12, {
                                          --[[ " " ]]32,
                                          --[[ Int32 ]]Block.__(5, {
                                              --[[ Int_d ]]0,
                                              --[[ No_padding ]]0,
                                              --[[ No_precision ]]0,
                                              --[[ String_literal ]]Block.__(11, {
                                                  " \n",
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            }),
          "%Ld %Ld %d %f %ld \n"
        }), f, h, vv, xx, xxx);

Mt.from_pair_suites("Random_test", suites.contents);

exports.id = id;
exports.suites = suites;
exports.eq = eq;
exports.neq = neq;
exports.approx = approx;
exports.v = v;
exports.f = f;
exports.h = h;
exports.vv = vv;
exports.xx = xx;
exports.xxx = xxx;
--[[  Not a pure module ]]
