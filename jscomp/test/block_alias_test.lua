console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Caml_obj = require "../../lib/js/caml_obj";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

Block_1 = { };

v0 = --[[ A ]]Block.__(1, {
    0,
    1
  });

Block_2 = { };

v1 = --[[ A ]]Block.__(1, {
    0,
    1
  });

N = {
  Block = Block_2,
  v1 = v1
};

Caml_obj_1 = { };

List_1 = { };

V = {
  List = List_1
};

f = Caml_obj.caml_equal;

eq("File \"block_alias_test.ml\", line 32, characters 6-13", List.length(--[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ [] ]]0
          }
        }), 2);

b("File \"block_alias_test.ml\", line 33, characters 5-12", Caml_obj.caml_equal(v0, --[[ A ]]Block.__(1, {
            0,
            1
          })));

eq("File \"block_alias_test.ml\", line 34, characters 6-13", v0, v1);

Mt.from_pair_suites("Block_alias_test", suites.contents);

h = List.length;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Block = Block_1;
exports.v0 = v0;
exports.N = N;
exports.Caml_obj = Caml_obj_1;
exports.V = V;
exports.f = f;
exports.h = h;
--[[  Not a pure module ]]
