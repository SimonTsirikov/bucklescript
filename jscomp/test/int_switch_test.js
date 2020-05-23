'use strict';

var Mt = require("./mt.js");
var Curry = require("../../lib/js/curry.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end

function f(x) do
  var match = Curry._1(x, --[ () ]--0);
  switch (match) do
    case 1 :
        return --[ "a" ]--97;
    case 2 :
        return --[ "b" ]--98;
    case 3 :
        return --[ "c" ]--99;
    default:
      return --[ "x" ]--120;
  end
end

function f22(x) do
  var match = Curry._1(x, --[ () ]--0);
  switch (match) do
    case 1 :
        return --[ "a" ]--97;
    case 2 :
        return --[ "b" ]--98;
    case 3 :
        return --[ "c" ]--99;
    default:
      return --[ "x" ]--120;
  end
end

function f33(x) do
  var match = Curry._1(x, --[ () ]--0);
  switch (match) do
    case --[ A ]--0 :
        return --[ "a" ]--97;
    case --[ B ]--1 :
        return --[ "b" ]--98;
    case --[ C ]--2 :
        return --[ "c" ]--99;
    case --[ D ]--3 :
        return --[ "x" ]--120;
    
  end
end

eq("File \"int_switch_test.ml\", line 35, characters 6-13", f((function (param) do
            return 1;
          end)), --[ "a" ]--97);

eq("File \"int_switch_test.ml\", line 36, characters 6-13", f((function (param) do
            return 2;
          end)), --[ "b" ]--98);

eq("File \"int_switch_test.ml\", line 37, characters 6-13", f((function (param) do
            return 3;
          end)), --[ "c" ]--99);

eq("File \"int_switch_test.ml\", line 38, characters 6-13", f((function (param) do
            return 0;
          end)), --[ "x" ]--120);

eq("File \"int_switch_test.ml\", line 39, characters 6-13", f((function (param) do
            return -1;
          end)), --[ "x" ]--120);

Mt.from_pair_suites("Int_switch_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.f = f;
exports.f22 = f22;
exports.f33 = f33;
--[  Not a pure module ]--
