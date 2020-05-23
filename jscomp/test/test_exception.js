'use strict';

var Test_common = require("./test_common.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var Local = Caml_exceptions.create("Test_exception.Local");

function f(param) do
  throw [
        Local,
        3
      ];
end

function g(param) do
  throw Caml_builtin_exceptions.not_found;
end

function h(param) do
  throw [
        Test_common.U,
        3
      ];
end

function x(param) do
  throw Test_common.H;
end

function xx(param) do
  throw [
        Caml_builtin_exceptions.invalid_argument,
        "x"
      ];
end

var Nullary = Caml_exceptions.create("Test_exception.Nullary");

var a = Nullary;

exports.Local = Local;
exports.f = f;
exports.g = g;
exports.h = h;
exports.x = x;
exports.xx = xx;
exports.Nullary = Nullary;
exports.a = a;
--[ No side effect ]--
