'use strict';

Test_common = require("./test_common.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

Local = Caml_exceptions.create("Test_exception.Local");

function f(param) do
  throw [
        Local,
        3
      ];
end end

function g(param) do
  throw Caml_builtin_exceptions.not_found;
end end

function h(param) do
  throw [
        Test_common.U,
        3
      ];
end end

function x(param) do
  throw Test_common.H;
end end

function xx(param) do
  throw [
        Caml_builtin_exceptions.invalid_argument,
        "x"
      ];
end end

Nullary = Caml_exceptions.create("Test_exception.Nullary");

a = Nullary;

exports.Local = Local;
exports.f = f;
exports.g = g;
exports.h = h;
exports.x = x;
exports.xx = xx;
exports.Nullary = Nullary;
exports.a = a;
--[ No side effect ]--
