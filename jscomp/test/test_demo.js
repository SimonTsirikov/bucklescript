'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");

function fib(n) do
  if (n == 2 or n == 1) do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end
end

function cons(x, y) do
  return --[ Cons ]--[
          x,
          y
        ];
end

function map(f, param) do
  if (param) do
    return --[ Cons ]--[
            Curry._1(f, param[0]),
            map(f, param[1])
          ];
  end else do
    return --[ Nil ]--0;
  end
end

function sum(n) do
  var v = 0;
  for(var i = 0; i <= n; ++i)do
    v = v + i | 0;
  end
  return v;
end

function f(x, y, z) do
  return (x + y | 0) + z | 0;
end

function g(x, y) do
  var u = x + y | 0;
  return (function (z) do
      return u + z | 0;
    end);
end

function g1(x, y) do
  var u = x + y | 0;
  return (function (xx, yy) do
      return (xx + yy | 0) + u | 0;
    end);
end

var u = 8;

var x = (function (z) do
      return u + z | 0;
    end)(6);

var u$1 = 7;

function v(param) do
  var xx = 6;
  var yy = param;
  return (xx + yy | 0) + u$1 | 0;
end

var nil = --[ Nil ]--0;

var len = List.length;

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
--[ x Not a pure module ]--
