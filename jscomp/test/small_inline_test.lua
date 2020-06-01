'use strict';

Curry = require("../../lib/js/curry.lua");

function $pipe$great(x, f) do
  return Curry._1(f, x);
end end

function hello1(y, f) do
  return Curry._1(f, y);
end end

function hello2(y, f) do
  return Curry._1(f, y);
end end

function hello3(y, f) do
  return Curry._1(f, y);
end end

function hello4(y, f) do
  return Curry._1(f, y);
end end

function hello5(y, f) do
  return Curry._1(f, y);
end end

function f(_x) do
  while(true) do
    x = _x;
    _x = x + 1 | 0;
    continue ;
  end;
end end

function ff(_x, _y) do
  while(true) do
    y = _y;
    x = _x;
    _y = x + 1 | 0;
    _x = y;
    continue ;
  end;
end end

function fff(_x, _y) do
  while(true) do
    y = _y;
    x = _x;
    _y = x;
    _x = y;
    continue ;
  end;
end end

exports.$pipe$great = $pipe$great;
exports.hello1 = hello1;
exports.hello2 = hello2;
exports.hello3 = hello3;
exports.hello4 = hello4;
exports.hello5 = hello5;
exports.f = f;
exports.ff = ff;
exports.fff = fff;
--[[ No side effect ]]
