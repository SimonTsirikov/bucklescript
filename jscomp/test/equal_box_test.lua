console = {log = print};

Mt = require "./mt";
Caml_obj = require "../../lib/js/caml_obj";
Caml_int64 = require "../../lib/js/caml_int64";

aa = Caml_obj.caml_equal_null;

bb = Caml_obj.caml_equal_undefined;

cc = Caml_obj.caml_equal_nullable;

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

function f(param) do
  return ;
end end

function shouldBeNull(param) do
  return nil;
end end

b("File \"equal_box_test.ml\", line 24, characters 4-11", 3 ~= nil);

b("File \"equal_box_test.ml\", line 25, characters 4-11", nil ~= nil);

b("File \"equal_box_test.ml\", line 26, characters 4-11", "3" ~= nil);

b("File \"equal_box_test.ml\", line 27, characters 4-11", --[[ "3" ]]51 ~= nil);

b("File \"equal_box_test.ml\", line 28, characters 4-11", not Caml_int64.equal_null(--[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        }, nil));

b("File \"equal_box_test.ml\", line 29, characters 4-11", 0 ~= nil);

b("File \"equal_box_test.ml\", line 30, characters 4-11", true);

b("File \"equal_box_test.ml\", line 31, characters 4-11", not Caml_obj.caml_equal_null(nil, nil));

b("File \"equal_box_test.ml\", line 32, characters 4-11", Caml_obj.caml_equal_null(nil, nil));

b("File \"equal_box_test.ml\", line 33, characters 4-11", true);

b("File \"equal_box_test.ml\", line 34, characters 4-11", nil == nil);

b("File \"equal_box_test.ml\", line 35, characters 4-11", not Caml_obj.caml_equal_null(3, nil));

v = nil;

b("File \"equal_box_test.ml\", line 39, characters 4-11", 3 ~= v);

b("File \"equal_box_test.ml\", line 40, characters 4-11", nil ~= v);

b("File \"equal_box_test.ml\", line 41, characters 4-11", "3" ~= v);

b("File \"equal_box_test.ml\", line 42, characters 4-11", --[[ "3" ]]51 ~= v);

b("File \"equal_box_test.ml\", line 43, characters 4-11", not Caml_int64.equal_nullable(--[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        }, v));

b("File \"equal_box_test.ml\", line 44, characters 4-11", 0 ~= v);

b("File \"equal_box_test.ml\", line 45, characters 4-11", 0 ~= v);

b("File \"equal_box_test.ml\", line 46, characters 4-11", not Caml_obj.caml_equal_nullable(nil, v));

b("File \"equal_box_test.ml\", line 47, characters 4-11", Caml_obj.caml_equal_nullable(nil, v));

b("File \"equal_box_test.ml\", line 48, characters 4-11", true);

b("File \"equal_box_test.ml\", line 49, characters 4-11", nil == nil);

b("File \"equal_box_test.ml\", line 50, characters 4-11", not Caml_obj.caml_equal_nullable(3, nil));

b("File \"equal_box_test.ml\", line 55, characters 4-11", 3 ~= nil);

b("File \"equal_box_test.ml\", line 56, characters 4-11", nil == nil);

b("File \"equal_box_test.ml\", line 57, characters 4-11", "3" ~= nil);

b("File \"equal_box_test.ml\", line 58, characters 4-11", --[[ "3" ]]51 ~= nil);

b("File \"equal_box_test.ml\", line 59, characters 4-11", not Caml_int64.equal_undefined(--[[ int64 ]]{
          --[[ hi ]]0,
          --[[ lo ]]0
        }, nil));

b("File \"equal_box_test.ml\", line 60, characters 4-11", 0 ~= nil);

b("File \"equal_box_test.ml\", line 61, characters 4-11", true);

b("File \"equal_box_test.ml\", line 62, characters 4-11", Caml_obj.caml_equal_undefined(nil, nil));

b("File \"equal_box_test.ml\", line 66, characters 4-11", not Caml_obj.caml_equal_undefined(nil, nil));

b("File \"equal_box_test.ml\", line 67, characters 4-11", true);

b("File \"equal_box_test.ml\", line 68, characters 4-11", nil == nil);

b("File \"equal_box_test.ml\", line 69, characters 4-11", not Caml_obj.caml_equal_undefined(3, nil));

Mt.from_pair_suites("File \"equal_box_test.ml\", line 74, characters 23-30", suites.contents);

exports = {}
exports.aa = aa;
exports.bb = bb;
exports.cc = cc;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.f = f;
exports.shouldBeNull = shouldBeNull;
--[[  Not a pure module ]]
