--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_int32 = require "../../lib/js/caml_int32";

function f(v) do
  if (v % 2 == 0) then do
    return (function (v) do
        return Caml_int32.imul(v, v);
      end end);
  end else do
    return (function (v) do
        return v + v | 0;
      end end);
  end end 
end end

v = {
    1,
    2,
    3
  }.map((function (param, param$1) do
        return f(param)(param$1);
      end end));

vv = {
    1,
    2,
    3
  }.map((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end end));

hh = {
    "1",
    "2",
    "3"
  }.map((function (prim) do
        return parseInt(prim);
      end end));

function u() do
  return 3;
end end

vvv = do
  contents: 0
end;

function fff(param) do
  console.log("x");
  console.log("x");
  vvv.contents = vvv.contents + 1 | 0;
  return --[[ () ]]0;
end end

function g() do
  return fff(--[[ () ]]0);
end end

function abc(x, y, z) do
  console.log("xx");
  console.log("yy");
  return (x + y | 0) + z | 0;
end end

abc_u = abc;

g();

Mt.from_pair_suites("Ffi_arity_test", --[[ :: ]]{
      --[[ tuple ]]{
        "File \"ffi_arity_test.ml\", line 45, characters 4-11",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      v,
                      {
                        0,
                        1,
                        4
                      }
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "File \"ffi_arity_test.ml\", line 46, characters 4-11",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        vv,
                        {
                          1,
                          3,
                          5
                        }
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "File \"ffi_arity_test.ml\", line 47, characters 4-11",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          hh,
                          {
                            1,
                            2,
                            3
                          }
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "File \"ffi_arity_test.ml\", line 48, characters 4-11",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            {
                                  1,
                                  2,
                                  3
                                }.map((function (x) do
                                      return (function (y) do
                                          return x + y | 0;
                                        end end);
                                    end end)).map((function (y) do
                                    return Caml_int32.imul(Curry._1(y, 0), Curry._1(y, 1));
                                  end end)),
                            {
                              2,
                              6,
                              12
                            }
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "File \"ffi_arity_test.ml\", line 53, characters 4-11",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              {
                                  1,
                                  2,
                                  3
                                }.map((function (x, param) do
                                      y = Caml_int32.imul(x, x);
                                      return (function (i) do
                                                  return y + i | 0;
                                                end end)(param);
                                    end end)),
                              {
                                1,
                                5,
                                11
                              }
                            });
                  end end)
              },
              --[[ [] ]]0
            }
          }
        }
      }
    });

function bar(fn) do
  return Curry._1(fn, --[[ () ]]0);
end end

(Curry._1((function(){console.log("forgiving arity")}), --[[ () ]]0));

exports.f = f;
exports.v = v;
exports.vv = vv;
exports.hh = hh;
exports.u = u;
exports.vvv = vvv;
exports.fff = fff;
exports.g = g;
exports.abc = abc;
exports.abc_u = abc_u;
exports.bar = bar;
--[[ v Not a pure module ]]
