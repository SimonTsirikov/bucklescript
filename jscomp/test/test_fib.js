'use strict';

var Curry = require("../../lib/js/curry.js");

function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end

function fib2(n) do
  if (n == 2 or n == 1) then do
    return 1;
  end else do
    return fib2(n - 1 | 0) + fib2(n - 2 | 0) | 0;
  end end 
end

var v = 0;

for(var i = 0; i <= 10; ++i)do
  v = v + i | 0;
end

var sum = v;

var v$1 = 0;

for(var i$1 = 10; i$1 >= 0; --i$1)do
  v$1 = v$1 + i$1 | 0;
end

var sumdown = v$1;

function cons(x, y) do
  return --[ Cons ]--[
          x,
          y
        ];
end

function length(x) do
  if (x) then do
    return 1 + length(x[1]) | 0;
  end else do
    return 0;
  end end 
end

function map(f, x) do
  if (x) then do
    return --[ Cons ]--[
            Curry._1(f, x[0]),
            map(f, x[1])
          ];
  end else do
    return --[ Nil ]--0;
  end end 
end

function f(x) do
  var v = x;
  var sum = 0;
  while(v > 0) do
    sum = sum + v | 0;
    v = v - 1 | 0;
  end;
  return sum;
end

function fib3(n) do
  var _a = 0;
  var _b = 1;
  var _n = n;
  while(true) do
    var n$1 = _n;
    var b = _b;
    var a = _a;
    if (n$1 > 0) then do
      _n = n$1 - 1 | 0;
      _b = a + b | 0;
      _a = b;
      continue ;
    end else do
      return a;
    end end 
  end;
end

var b = fib;

exports.fib = fib;
exports.fib2 = fib2;
exports.b = b;
exports.sum = sum;
exports.sumdown = sumdown;
exports.cons = cons;
exports.length = length;
exports.map = map;
exports.f = f;
exports.fib3 = fib3;
--[  Not a pure module ]--
