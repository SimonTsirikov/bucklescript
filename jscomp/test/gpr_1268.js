'use strict';

var Curry = require("../../lib/js/curry.js");

function f_add2(a, b, x, y) do
  return add(Curry._1(b, y), Curry._1(a, x));
end

function f(a, b, x, y) do
  return Curry._1(a, x) + Curry._1(b, y) | 0;
end

function f1(a, b, x, y) do
  return add(Curry._1(a, x), Curry._1(b, y));
end

function f2(x) do
  console.log(x);
  return --[ () ]--0;
end

function f3(x) do
  console.log(x);
  return --[ () ]--0;
end

function f4(x, y) do
  return add(y, x);
end

exports.f_add2 = f_add2;
exports.f = f;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
--[ No side effect ]--
