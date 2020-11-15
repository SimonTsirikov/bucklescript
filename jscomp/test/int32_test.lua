__console = {log = print};

Mt = require "..mt";
__Array = require "......lib.js.array";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Int32 = require "......lib.js.int32";
Format = require "......lib.js.format";
Caml_float = require "......lib.js.caml_float";
Caml_int32 = require "......lib.js.caml_int32";
Pervasives = require "......lib.js.pervasives";
Ext_array_test = require "..ext_array_test";

function f(x) do
  return --[[ tuple ]]{
          x,
          (x >>> 1),
          (x >>> 2)
        };
end end

shift_right_logical_tests_000 = __Array.map((function(x) do
        return (-1 >>> x) | 0;
      end end), Ext_array_test.range(0, 31));

shift_right_logical_tests_001 = {
  -1,
  2147483647,
  1073741823,
  536870911,
  268435455,
  134217727,
  67108863,
  33554431,
  16777215,
  8388607,
  4194303,
  2097151,
  1048575,
  524287,
  262143,
  131071,
  65535,
  32767,
  16383,
  8191,
  4095,
  2047,
  1023,
  511,
  255,
  127,
  63,
  31,
  15,
  7,
  3,
  1
};

shift_right_logical_tests = --[[ tuple ]]{
  shift_right_logical_tests_000,
  shift_right_logical_tests_001
};

shift_right_tests_000 = __Array.map((function(x) do
        return (Int32.min_int >> x);
      end end), Ext_array_test.range(0, 31));

shift_right_tests_001 = {
  -2147483648,
  -1073741824,
  -536870912,
  -268435456,
  -134217728,
  -67108864,
  -33554432,
  -16777216,
  -8388608,
  -4194304,
  -2097152,
  -1048576,
  -524288,
  -262144,
  -131072,
  -65536,
  -32768,
  -16384,
  -8192,
  -4096,
  -2048,
  -1024,
  -512,
  -256,
  -128,
  -64,
  -32,
  -16,
  -8,
  -4,
  -2,
  -1
};

shift_right_tests = --[[ tuple ]]{
  shift_right_tests_000,
  shift_right_tests_001
};

shift_left_tests_000 = __Array.map((function(x) do
        return (1 << x);
      end end), Ext_array_test.range(0, 31));

shift_left_tests_001 = {
  1,
  2,
  4,
  8,
  16,
  32,
  64,
  128,
  256,
  512,
  1024,
  2048,
  4096,
  8192,
  16384,
  32768,
  65536,
  131072,
  262144,
  524288,
  1048576,
  2097152,
  4194304,
  8388608,
  16777216,
  33554432,
  67108864,
  134217728,
  268435456,
  536870912,
  1073741824,
  -2147483648
};

shift_left_tests = --[[ tuple ]]{
  shift_left_tests_000,
  shift_left_tests_001
};

_star_tilde = Caml_int32.imul;

suites = {
  contents = Pervasives._at(--[[ :: ]]{
        --[[ tuple ]]{
          "File \"int32_test.ml\", line 31, characters 2-9",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        1,
                        1
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "File \"int32_test.ml\", line 32, characters 2-9",
            (function(param) do
                return --[[ Eq ]]Block.__(0, {
                          -2147483647,
                          -2147483647
                        });
              end end)
          },
          --[[ [] ]]0
        }
      }, Pervasives._at(__Array.to_list(Ext_array_test.map2i((function(i, a, b) do
                      return --[[ tuple ]]{
                              Curry._1(Format.asprintf(--[[ Format ]]{
                                        --[[ String_literal ]]Block.__(11, {
                                            "shift_right_logical_cases ",
                                            --[[ Int ]]Block.__(4, {
                                                --[[ Int_d ]]0,
                                                --[[ No_padding ]]0,
                                                --[[ No_precision ]]0,
                                                --[[ End_of_format ]]0
                                              })
                                          }),
                                        "shift_right_logical_cases %d"
                                      }), i),
                              (function(param) do
                                  return --[[ Eq ]]Block.__(0, {
                                            a,
                                            b
                                          });
                                end end)
                            };
                    end end), shift_right_logical_tests_001, shift_right_logical_tests[2])), Pervasives._at(__Array.to_list(Ext_array_test.map2i((function(i, a, b) do
                          return --[[ tuple ]]{
                                  Curry._1(Format.asprintf(--[[ Format ]]{
                                            --[[ String_literal ]]Block.__(11, {
                                                "shift_right_cases ",
                                                --[[ Int ]]Block.__(4, {
                                                    --[[ Int_d ]]0,
                                                    --[[ No_padding ]]0,
                                                    --[[ No_precision ]]0,
                                                    --[[ End_of_format ]]0
                                                  })
                                              }),
                                            "shift_right_cases %d"
                                          }), i),
                                  (function(param) do
                                      return --[[ Eq ]]Block.__(0, {
                                                a,
                                                b
                                              });
                                    end end)
                                };
                        end end), shift_right_tests_001, shift_right_tests[2])), __Array.to_list(Ext_array_test.map2i((function(i, a, b) do
                          return --[[ tuple ]]{
                                  Curry._1(Format.asprintf(--[[ Format ]]{
                                            --[[ String_literal ]]Block.__(11, {
                                                "shift_left_cases ",
                                                --[[ Int ]]Block.__(4, {
                                                    --[[ Int_d ]]0,
                                                    --[[ No_padding ]]0,
                                                    --[[ No_precision ]]0,
                                                    --[[ End_of_format ]]0
                                                  })
                                              }),
                                            "shift_left_cases %d"
                                          }), i),
                                  (function(param) do
                                      return --[[ Eq ]]Block.__(0, {
                                                a,
                                                b
                                              });
                                    end end)
                                };
                        end end), shift_left_tests_001, shift_left_tests[2])))))
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"int32_test.ml\", line 47, characters 5-12", Caml_float.caml_int32_bits_of_float(0.3), 1050253722);

eq("File \"int32_test.ml\", line 48, characters 5-12", Caml_float.caml_int32_float_of_bits(1050253722), 0.300000011920928955);

Mt.from_pair_suites("Int32_test", suites.contents);

test_div = 30;

exports = {};
exports.f = f;
exports.shift_right_logical_tests = shift_right_logical_tests;
exports.shift_right_tests = shift_right_tests;
exports.shift_left_tests = shift_left_tests;
exports.test_div = test_div;
exports._star_tilde = _star_tilde;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
return exports;
--[[ shift_right_logical_tests Not a pure module ]]
