--[['use strict';]]

Mt = require "./mt.lua";
__Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Printf = require "../../lib/js/printf.lua";
Mt_global = require "./mt_global.lua";
Caml_float = require "../../lib/js/caml_float.lua";
Caml_int64 = require "../../lib/js/caml_int64.lua";
Pervasives = require "../../lib/js/pervasives.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";

test_id = do
  contents: 0
end;

suites = do
  contents: --[[ [] ]]0
end;

function eq(loc) do
  return (function (param, param$1) do
      return Mt_global.collect_eq(test_id, suites, loc, param, param$1);
    end end);
end end

function approx(loc) do
  return (function (param, param$1) do
      return Mt_global.collect_approx(test_id, suites, loc, param, param$1);
    end end);
end end

epsilon_float = Caml_int64.float_of_bits(--[[ int64 ]]{
      --[[ hi ]]1018167296,
      --[[ lo ]]0
    });

match = Caml_float.caml_frexp_float(12.0);

match$1 = Caml_float.caml_frexp_float(0);

match$2 = Caml_float.caml_frexp_float(-12.0);

results = __Array.append({
      --[[ tuple ]]{
        Math.log10(2),
        0.301029995663981198
      },
      --[[ tuple ]]{
        Caml_float.caml_ldexp_float(1, 6),
        64
      },
      --[[ tuple ]]{
        Caml_float.caml_ldexp_float(1, 5),
        32
      },
      --[[ tuple ]]{
        Caml_float.caml_ldexp_float(1.e-5, 1024),
        1.79769313486231605e+303
      },
      --[[ tuple ]]{
        Caml_float.caml_ldexp_float(1, -1024),
        5.56268464626800346e-309
      },
      --[[ tuple ]]{
        Caml_float.caml_hypot_float(3, 4),
        5
      },
      --[[ tuple ]]{
        Caml_float.caml_hypot_float(4, 3),
        5
      },
      --[[ tuple ]]{
        Caml_float.caml_hypot_float(5, 12),
        13
      },
      --[[ tuple ]]{
        Caml_float.caml_hypot_float(12, 5),
        13
      },
      --[[ tuple ]]{
        Caml_float.caml_copysign_float(22.3, -1),
        -22.3
      },
      --[[ tuple ]]{
        Caml_float.caml_copysign_float(22.3, 1),
        22.3
      },
      --[[ tuple ]]{
        Caml_float.caml_expm1_float(1e-15),
        1.00000000000000067e-15
      },
      --[[ tuple ]]{
        Math.log1p(1e-10),
        9.9999999995000007e-11
      }
    }, {
      --[[ tuple ]]{
        match$1[0],
        0
      },
      --[[ tuple ]]{
        match$1[1],
        0
      },
      --[[ tuple ]]{
        match[0],
        0.75
      },
      --[[ tuple ]]{
        match[1],
        4
      },
      --[[ tuple ]]{
        match$2[0],
        -0.75
      },
      --[[ tuple ]]{
        match$2[1],
        4
      }
    });

function from_pairs(ps) do
  return __Array.to_list(__Array.mapi((function (i, param) do
                    b = param[1];
                    a = param[0];
                    return --[[ tuple ]]{
                            Curry._1(Printf.sprintf(--[[ Format ]]{
                                      --[[ String_literal ]]Block.__(11, {
                                          "pair ",
                                          --[[ Int ]]Block.__(4, {
                                              --[[ Int_d ]]0,
                                              --[[ No_padding ]]0,
                                              --[[ No_precision ]]0,
                                              --[[ End_of_format ]]0
                                            })
                                        }),
                                      "pair %d"
                                    }), i),
                            (function (param) do
                                return --[[ Approx ]]Block.__(5, {
                                          a,
                                          b
                                        });
                              end end)
                          };
                  end end), ps));
end end

float_compare = Caml_primitive.caml_float_compare;

param = Pervasives.classify_float(3);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 47, characters 5-12", param, --[[ FP_normal ]]0);

param$1 = Caml_float.caml_modf_float(-3.125);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 48, characters 5-12", param$1, --[[ tuple ]]{
      -0.125,
      -3
    });

match$3 = Caml_float.caml_modf_float(Number.NaN);

param_000 = isNaN(match$3[0]);

param_001 = isNaN(match$3[1]);

param$2 = --[[ tuple ]]{
  param_000,
  param_001
};

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 49, characters 5-12", param$2, --[[ tuple ]]{
      true,
      true
    });

param$3 = {
  -1,
  1,
  1
};

param$4 = __Array.map((function (x) do
        if (x > 0) then do
          return 1;
        end else if (x < 0) then do
          return -1;
        end else do
          return 0;
        end end  end 
      end end), __Array.map((function (param) do
            return Caml_primitive.caml_float_compare(param[0], param[1]);
          end end), {
          --[[ tuple ]]{
            1,
            3
          },
          --[[ tuple ]]{
            2,
            1
          },
          --[[ tuple ]]{
            3,
            2
          }
        }));

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 52, characters 5-12", param$4, param$3);

param$5 = Caml_float.caml_copysign_float(-3, 0);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 56, characters 5-12", param$5, 3);

param$6 = Caml_float.caml_copysign_float(3, 0);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 57, characters 5-12", param$6, 3);

param$7 = Math.log10(10);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 58, characters 5-12", param$7, 1);

param$8 = Caml_float.caml_expm1_float(0);

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 59, characters 5-12", param$8, 0);

param$9 = Number("3.0");

Mt_global.collect_eq(test_id, suites, "File \"float_test.ml\", line 60, characters 5-12", param$9, 3.0);

param$10 = Caml_float.caml_expm1_float(2);

Mt_global.collect_approx(test_id, suites, "File \"float_test.ml\", line 61, characters 9-16", param$10, 6.38905609893065);

match$4 = Caml_float.caml_modf_float(32.3);

b = match$4[1];

a = match$4[0];

Mt.from_pair_suites("Float_test", Pervasives.$at(--[[ :: ]]{
          --[[ tuple ]]{
            "mod_float",
            (function (param) do
                return --[[ Approx ]]Block.__(5, {
                          3.2 % 0.5,
                          0.200000000000000178
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "modf_float1",
              (function (param) do
                  return --[[ Approx ]]Block.__(5, {
                            a,
                            0.299999999999997158
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "modf_float2",
                (function (param) do
                    return --[[ Approx ]]Block.__(5, {
                              b,
                              32
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "int_of_float",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                3,
                                3
                              });
                    end end)
                },
                --[[ [] ]]0
              }
            }
          }
        }, Pervasives.$at(from_pairs(results), suites.contents)));

exports.test_id = test_id;
exports.suites = suites;
exports.eq = eq;
exports.approx = approx;
exports.epsilon_float = epsilon_float;
exports.results = results;
exports.from_pairs = from_pairs;
exports.float_compare = float_compare;
--[[ results Not a pure module ]]
