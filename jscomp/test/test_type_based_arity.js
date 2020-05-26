'use strict';

Curry = require("../../lib/js/curry.js");

function f0(g, x) do
  return Curry._1(g, x);
end end

function f1(g, x) do
  return Curry._1(g, x);
end end

X = { };

function f2(g, x) do
  return Curry._1(g, x);
end end

function f3(g, x) do
  Curry._1(g, x);
  return --[ () ]--0;
end end

function f4(g, x) do
  return Curry._1(g, x);
end end

function f5(g, x) do
  return Curry._1(g, x);
end end

function f6(g, x) do
  return Curry._1(g, x);
end end

function f7(g, x) do
  return Curry._1(g, x);
end end

X0 = { };

function f8(g, x) do
  return Curry._1(g, x);
end end

function f9(g, x) do
  return Curry._1(g, x);
end end

function f10(g, x) do
  return Curry._1(g, x);
end end

function f11(g, x) do
  return Curry._1(g, x);
end end

function f12(g, x) do
  return Curry._1(g, x);
end end

function f13(g, x) do
  return Curry._1(g, x);
end end

X2 = do
  f13: f13
end;

function f14(h, g, x) do
  return Curry._2(h, g, x);
end end

exports.f0 = f0;
exports.f1 = f1;
exports.X = X;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.X0 = X0;
exports.f8 = f8;
exports.f9 = f9;
exports.f10 = f10;
exports.f11 = f11;
exports.f12 = f12;
exports.X2 = X2;
exports.f14 = f14;
--[ No side effect ]--
