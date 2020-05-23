'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param, v) do
  return ((((param.x0 + param.x1 | 0) + param.x2 | 0) + param.x3 | 0) + param.x4 | 0) + v | 0;
end

function f2(param, param$1) do
  return (((((param.x0 + param.x1 | 0) + param.x2 | 0) + param.x3 | 0) + param.x4 | 0) + param$1.a | 0) + param$1.b | 0;
end

function f3(param) do
  var lhs = param.rank;
  return (function (param) do
      var rhs = param.rank;
      if (typeof lhs == "number") do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "fun_pattern_match.ml",
                44,
                9
              ]
            ];
      end
      if (typeof rhs == "number") do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "fun_pattern_match.ml",
                44,
                9
              ]
            ];
      end
      return Caml_primitive.caml_int_compare(lhs[0], rhs[0]);
    end);
end

function f4(param) do
  var lhs = param.rank;
  return (function (param) do
      var rhs = param.rank;
      if (typeof lhs == "number") do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "fun_pattern_match.ml",
                52,
                9
              ]
            ];
      end
      if (typeof rhs == "number") do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "fun_pattern_match.ml",
                52,
                9
              ]
            ];
      end
      return Caml_primitive.caml_int_compare(lhs[0], rhs[0]);
    end);
end

var x = --[ `A ]--[
  65,
  r
];

function r(param) do
  return x;
end

var match = r(--[ () ]--0);

var v = Curry._1(match[1], --[ () ]--0);

console.log(v);

exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.r = r;
exports.v = v;
--[ match Not a pure module ]--
