'use strict';

var Curry = require("../../lib/js/curry.js");
var Belt_Array = require("../../lib/js/belt_Array.js");
var Caml_option = require("../../lib/js/caml_option.js");

function t0(x, f) do
  return Curry._1(f, Curry._1(f, Curry._1(f, x)));
end

function t1(x, f) do
  return Curry._1(f, x);
end

function t2(x, f, g) do
  return Curry._2(f, Curry._3(g, Curry._1(f, x), x, x), x);
end

function t3(x, f) do
  return Curry._3(f, x, 1, 2);
end

function f(a, b, c) do
  return --[ tuple ]--[
          Curry._1(b, a),
          Curry._1(c, a)
        ];
end

function f1(a, b, c, d) do
  var __ocaml_internal_obj = Curry._1(a, b);
  return --[ tuple ]--[
          Curry._1(c, __ocaml_internal_obj),
          Curry._1(d, __ocaml_internal_obj)
        ];
end

function f2(a, b, c, d) do
  var __ocaml_internal_obj = Curry._1(a, b);
  var u = Curry._1(c, __ocaml_internal_obj);
  var v = Curry._1(d, __ocaml_internal_obj);
  return u + v | 0;
end

function f3(a, b, c, d, e) do
  var __ocaml_internal_obj = Curry._1(a, b);
  var u = Curry._2(c, __ocaml_internal_obj, d);
  var v = Curry._3(d, __ocaml_internal_obj, 1, 2);
  var h = Curry._1(e, __ocaml_internal_obj);
  return (u + v | 0) + h | 0;
end

function f4(a, b, c) do
  return --[ tuple ]--[
          Curry._2(b, a, c),
          Curry._2(b, a, c)
        ];
end

function f5(a, b, c, d) do
  var v0 = Curry._3(b, a, c, c);
  var v1 = Curry._3(b, a, c, c);
  var v2 = Curry._3(b, a, d, d);
  return (v0 + v1 | 0) + v2 | 0;
end

function f6(a) do
  return Caml_option.some(a);
end

function f7(a) do
  return --[ tuple ]--[
          Caml_option.some(a),
          Caml_option.some(a),
          Caml_option.some(a)
        ];
end

function f8(a) do
  return Caml_option.some(Caml_option.some(a));
end

function hi(x) do
  return Belt_Array.map(x, (function (x) do
                return x + 1 | 0;
              end));
end

var with_poly = --[ `Foo ]--[
  3505894,
  1
];

exports.t0 = t0;
exports.t1 = t1;
exports.t2 = t2;
exports.t3 = t3;
exports.f = f;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
exports.hi = hi;
exports.with_poly = with_poly;
--[ No side effect ]--
