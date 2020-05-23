'use strict';

var Curry = require("../../lib/js/curry.js");

var v = do
  contents: 0
end;

function reset(param) do
  v.contents = 0;
  return --[ () ]--0;
end

function incr(param) do
  v.contents = v.contents + 1 | 0;
  return --[ () ]--0;
end

var vv = do
  contents: 0
end;

function reset2(param) do
  vv.contents = 0;
  return --[ () ]--0;
end

function incr2(param) do
  v.contents = v.contents + 1 | 0;
  return --[ () ]--0;
end

function f(a, b, d, e) do
  var h = Curry._1(a, b);
  var u = Curry._1(d, h);
  var v = Curry._1(e, h);
  return u + v | 0;
end

function kf(cb, v) do
  Curry._1(cb, v);
  return v + v | 0;
end

function ikf(v) do
  return kf((function (prim) do
                return --[ () ]--0;
              end), v);
end

exports.v = v;
exports.reset = reset;
exports.incr = incr;
exports.reset2 = reset2;
exports.incr2 = incr2;
exports.f = f;
exports.kf = kf;
exports.ikf = ikf;
--[ No side effect ]--
