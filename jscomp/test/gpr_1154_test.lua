--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Int64 = require "../../lib/js/int64.lua";
Caml_int64 = require "../../lib/js/caml_int64.lua";
Pervasives = require "../../lib/js/pervasives.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function f(x) do
  Pervasives.print_string("f");
  return x;
end end

function g(x) do
  return Caml_int64.or_(x, (Pervasives.print_string("f"), x));
end end

v = do
  contents: 0
end;

function f2(x) do
  v.contents = v.contents + 1 | 0;
  return x;
end end

function g2(x) do
  return Caml_int64.or_(x, (v.contents = v.contents + 1 | 0, x));
end end

a = Caml_int64.or_(Int64.one, (v.contents = v.contents + 1 | 0, Int64.one));

eq("File \"gpr_1154_test.ml\", line 27, characters 12-19", v.contents, 1);

Mt.from_pair_suites("Gpr_1154_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.g = g;
exports.v = v;
exports.f2 = f2;
exports.g2 = g2;
exports.a = a;
--[[ a Not a pure module ]]
