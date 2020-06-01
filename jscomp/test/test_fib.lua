'use strict';

Curry = require("../../lib/js/curry.lua");

function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end end

function fib2(n) do
  if (n == 2 or n == 1) then do
    return 1;
  end else do
    return fib2(n - 1 | 0) + fib2(n - 2 | 0) | 0;
  end end 
end end

v = 0;

for i = 0 , 10 , 1 do
  v = v + i | 0;
end

sum = v;

v$1 = 0;

for i$1 = 10 , 0 , -1 do
  v$1 = v$1 + i$1 | 0;
end

sumdown = v$1;

function cons(x, y) do
  return --[[ Cons ]][
          x,
          y
        ];
end end

function length(x) do
  if (x) then do
    return 1 + length(x[1]) | 0;
  end else do
    return 0;
  end end 
end end

function map(f, x) do
  if (x) then do
    return --[[ Cons ]][
            Curry._1(f, x[0]),
            map(f, x[1])
          ];
  end else do
    return --[[ Nil ]]0;
  end end 
end end

function f(x) do
  v = x;
  sum = 0;
  while(v > 0) do
    sum = sum + v | 0;
    v = v - 1 | 0;
  end;
  return sum;
end end

function fib3(n) do
  _a = 0;
  _b = 1;
  _n = n;
  while(true) do
    n$1 = _n;
    b = _b;
    a = _a;
    if (n$1 > 0) then do
      _n = n$1 - 1 | 0;
      _b = a + b | 0;
      _a = b;
      continue ;
    end else do
      return a;
    end end 
  end;
end end

b = fib;

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
--[[  Not a pure module ]]
