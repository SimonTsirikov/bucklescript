--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_array = require "../../lib/js/caml_array";

a = {
  0,
  1,
  2
};

b = {
  0,
  1,
  2
};

c = {
  0,
  1,
  2,
  3,
  4,
  5
};

function f(param) do
  Caml_array.caml_array_set(a, 0, 3.0);
  return Caml_array.caml_array_set(b, 0, 3);
end end

function h(param) do
  return c;
end end

function g(param) do
  f(--[[ () ]]0);
  return --[[ Eq ]]Block.__(0, {
            --[[ tuple ]]{
              Caml_array.caml_array_get(a, 0),
              Caml_array.caml_array_get(b, 0)
            },
            --[[ tuple ]]{
              3.0,
              3
            }
          });
end end

suites_000 = --[[ tuple ]]{
  "const_block_test",
  g
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "avoid_mutable_inline_test",
    (function (param) do
        Caml_array.caml_array_set(c, 0, 3);
        Caml_array.caml_array_set(c, 1, 4);
        return --[[ Eq ]]Block.__(0, {
                  {
                    3,
                    4,
                    2,
                    3,
                    4,
                    5
                  },
                  c
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Const_block_test", suites);

v = --[[ tuple ]]{
  0,
  1,
  2,
  3,
  4,
  5
};

exports.a = a;
exports.b = b;
exports.c = c;
exports.v = v;
exports.f = f;
exports.h = h;
--[[  Not a pure module ]]
