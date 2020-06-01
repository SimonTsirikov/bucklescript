'use strict';

Mt = require("./mt.lua");
List = require("../../lib/js/list.lua");
Block = require("../../lib/js/block.lua");
Caml_obj = require("../../lib/js/caml_obj.lua");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

Block$1 = { };

v0 = --[[ A ]]Block.__(1, [
    0,
    1
  ]);

Block$2 = { };

v1 = --[[ A ]]Block.__(1, [
    0,
    1
  ]);

N = do
  Block: Block$2,
  v1: v1
end;

Caml_obj$1 = { };

List$1 = { };

V = do
  List: List$1
end;

f = Caml_obj.caml_equal;

eq("File \"block_alias_test.ml\", line 32, characters 6-13", List.length(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ [] ]]0
          ]
        ]), 2);

b("File \"block_alias_test.ml\", line 33, characters 5-12", Caml_obj.caml_equal(v0, --[[ A ]]Block.__(1, [
            0,
            1
          ])));

eq("File \"block_alias_test.ml\", line 34, characters 6-13", v0, v1);

Mt.from_pair_suites("Block_alias_test", suites.contents);

h = List.length;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Block = Block$1;
exports.v0 = v0;
exports.N = N;
exports.Caml_obj = Caml_obj$1;
exports.V = V;
exports.f = f;
exports.h = h;
--[[  Not a pure module ]]
