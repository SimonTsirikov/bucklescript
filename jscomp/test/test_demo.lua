console.log = print;

List = require "../../lib/js/list";
Curry = require "../../lib/js/curry";

function fib(n) do
  if (n == 2 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end end

function cons(x, y) do
  return --[[ Cons ]]{
          x,
          y
        };
end end

function map(f, param) do
  if (param) then do
    return --[[ Cons ]]{
            Curry._1(f, param[0]),
            map(f, param[1])
          };
  end else do
    return --[[ Nil ]]0;
  end end 
end end

function sum(n) do
  v = 0;
  for i = 0 , n , 1 do
    v = v + i | 0;
  end
  return v;
end end

function f(x, y, z) do
  return (x + y | 0) + z | 0;
end end

function g(x, y) do
  u = x + y | 0;
  return (function (z) do
      return u + z | 0;
    end end);
end end

function g1(x, y) do
  u = x + y | 0;
  return (function (xx, yy) do
      return (xx + yy | 0) + u | 0;
    end end);
end end

u = 8;

x = (function (z) do
      return u + z | 0;
    end end)(6);

u_1 = 7;

function v(param) do
  xx = 6;
  yy = param;
  return (xx + yy | 0) + u_1 | 0;
end end

nil = --[[ Nil ]]0;

len = List.length;

exports.fib = fib;
exports.nil = nil;
exports.cons = cons;
exports.map = map;
exports.sum = sum;
exports.len = len;
exports.f = f;
exports.g = g;
exports.g1 = g1;
exports.x = x;
exports.v = v;
--[[ x Not a pure module ]]
