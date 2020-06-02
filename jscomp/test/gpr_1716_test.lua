--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_obj = require "../../lib/js/caml_obj";

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

a = { };

b = { };

Caml_obj.caml_update_dummy(a, do
      b: b
    end);

Caml_obj.caml_update_dummy(b, do
      a: a
    end);

function is_inifite(x) do
  return x.b.a == x;
end end

eq("File \"gpr_1716_test.ml\", line 26, characters 6-13", true, is_inifite(a));

Mt.from_pair_suites("Gpr_1716_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a = a;
exports.b = b;
exports.is_inifite = is_inifite;
--[[  Not a pure module ]]
