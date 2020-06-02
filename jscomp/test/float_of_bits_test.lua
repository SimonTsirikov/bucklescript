--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
__Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Printf = require "../../lib/js/printf.lua";
Caml_float = require "../../lib/js/caml_float.lua";
Caml_int64 = require "../../lib/js/caml_int64.lua";
Pervasives = require "../../lib/js/pervasives.lua";

one_float = --[[ int64 ]]{
  --[[ hi ]]1072693248,
  --[[ lo ]]0
};

int32_pairs = {
  --[[ tuple ]]{
    32,
    4.48415508583941463e-44
  },
  --[[ tuple ]]{
    3,
    4.20389539297445121e-45
  }
};

function from_pairs(pair) do
  return List.concat(__Array.to_list(__Array.mapi((function (i, param) do
                        f = param[1];
                        i32 = param[0];
                        return --[[ :: ]]{
                                --[[ tuple ]]{
                                  Curry._1(Printf.sprintf(--[[ Format ]]{
                                            --[[ String_literal ]]Block.__(11, {
                                                "int32_float_of_bits ",
                                                --[[ Int ]]Block.__(4, {
                                                    --[[ Int_d ]]0,
                                                    --[[ No_padding ]]0,
                                                    --[[ No_precision ]]0,
                                                    --[[ End_of_format ]]0
                                                  })
                                              }),
                                            "int32_float_of_bits %d"
                                          }), i),
                                  (function (param) do
                                      return --[[ Eq ]]Block.__(0, {
                                                Caml_float.caml_int32_float_of_bits(i32),
                                                f
                                              });
                                    end end)
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    Curry._1(Printf.sprintf(--[[ Format ]]{
                                              --[[ String_literal ]]Block.__(11, {
                                                  "int32_bits_of_float ",
                                                  --[[ Int ]]Block.__(4, {
                                                      --[[ Int_d ]]0,
                                                      --[[ No_padding ]]0,
                                                      --[[ No_precision ]]0,
                                                      --[[ End_of_format ]]0
                                                    })
                                                }),
                                              "int32_bits_of_float %d"
                                            }), i),
                                    (function (param) do
                                        return --[[ Eq ]]Block.__(0, {
                                                  Caml_float.caml_int32_bits_of_float(f),
                                                  i32
                                                });
                                      end end)
                                  },
                                  --[[ [] ]]0
                                }
                              };
                      end end), int32_pairs)));
end end

suites = Pervasives.$at(--[[ :: ]]{
      --[[ tuple ]]{
        "one",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      Caml_int64.bits_of_float(1.0),
                      one_float
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "two",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        Caml_int64.float_of_bits(one_float),
                        1.0
                      });
            end end)
        },
        --[[ [] ]]0
      }
    }, from_pairs(int32_pairs));

Mt.from_pair_suites("Float_of_bits_test", suites);

exports.one_float = one_float;
exports.int32_pairs = int32_pairs;
exports.from_pairs = from_pairs;
exports.suites = suites;
--[[ suites Not a pure module ]]
