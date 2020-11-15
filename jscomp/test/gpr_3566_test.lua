__console = {log = print};

Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_obj = require "......lib.js.caml_obj";
Caml_option = require "......lib.js.caml_option";

function eq_A(x, y) do
  if (x.tag or y.tag) then do
    return false;
  end else do
    return x[1] == y[1];
  end end 
end end

function Test(_star) do
  __console.log("no inline");
  u = --[[ A ]]Block.__(0, {3});
  Block_1 = { };
  b = eq_A(--[[ A ]]Block.__(0, {3}), u);
  return {
          u = u,
          Block = Block_1,
          y = 32,
          b = b
        };
end end

function Test2(_star) do
  __console.log("no inline");
  Block_1 = { };
  b = eq_A(--[[ A ]]Block.__(0, {3}), --[[ A ]]Block.__(0, {3}));
  return {
          Block = Block_1,
          y = 32,
          b = b
        };
end end

function f(i, y) do
  x = --[[ A ]]Block.__(0, {i});
  return eq_A(x, y);
end end

function Test3(_star) do
  f = Caml_obj.caml_equal;
  Caml_obj_1 = { };
  return {
          f = f,
          Caml_obj = Caml_obj_1
        };
end end

function Test4(_star) do
  Caml_obj_1 = { };
  f = Caml_obj.caml_equal;
  return {
          Caml_obj = Caml_obj_1,
          f = f
        };
end end

function Test5(_star) do
  f = function(x) do
    return Caml_option.some(x);
  end end;
  Caml_option_1 = { };
  return {
          f = f,
          Caml_option = Caml_option_1
        };
end end

function Test6(_star) do
  Caml_option_1 = { };
  f = function(x) do
    return Caml_option.some(x);
  end end;
  return {
          Caml_option = Caml_option_1,
          f = f
        };
end end

function Test7(_star) do
  Caml_option = { };
  return {
          Caml_option = Caml_option
        };
end end

function Test8(_star) do
  Curry_1 = { };
  f = function(x) do
    return Curry._1(x, 1);
  end end;
  return {
          Curry = Curry_1,
          f = f
        };
end end

function Test9(_star) do
  f = function(x) do
    return Curry._1(x, 1);
  end end;
  Curry_1 = { };
  return {
          f = f,
          Curry = Curry_1
        };
end end

function Test10(_star) do
  Curry = { };
  return {
          Curry = Curry
        };
end end

x = 3;

exports = {};
exports.eq_A = eq_A;
exports.Test = Test;
exports.Test2 = Test2;
exports.x = x;
exports.f = f;
exports.Test3 = Test3;
exports.Test4 = Test4;
exports.Test5 = Test5;
exports.Test6 = Test6;
exports.Test7 = Test7;
exports.Test8 = Test8;
exports.Test9 = Test9;
exports.Test10 = Test10;
return exports;
--[[ No side effect ]]
