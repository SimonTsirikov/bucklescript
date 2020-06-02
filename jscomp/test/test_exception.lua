console = {log = print};

Test_common = require "./test_common";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Local = Caml_exceptions.create("Test_exception.Local");

function f(param) do
  error({
    Local,
    3
  })
end end

function g(param) do
  error(Caml_builtin_exceptions.not_found)
end end

function h(param) do
  error({
    Test_common.U,
    3
  })
end end

function x(param) do
  error(Test_common.H)
end end

function xx(param) do
  error({
    Caml_builtin_exceptions.invalid_argument,
    "x"
  })
end end

Nullary = Caml_exceptions.create("Test_exception.Nullary");

a = Nullary;

exports = {}
exports.Local = Local;
exports.f = f;
exports.g = g;
exports.h = h;
exports.x = x;
exports.xx = xx;
exports.Nullary = Nullary;
exports.a = a;
--[[ No side effect ]]