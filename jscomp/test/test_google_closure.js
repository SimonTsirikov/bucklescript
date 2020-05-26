'use strict';

var $$Array = require("../../lib/js/array.js");
var Caml_array = require("../../lib/js/caml_array.js");

function f(a, b, param) do
  return a + b | 0;
end

function f2(a) do
  return (function (param) do
      return a + 1 | 0;
    end);
end

var a = String(3);

var b = 101;

var arr = $$Array.init(2, (function (param) do
        return 0;
      end));

for var i = 0 , 1 , 1 do
  Caml_array.caml_array_set(arr, i, i + 1 | 0);
end

console.log(--[ tuple ]--[
      a,
      b,
      arr
    ]);

var c = arr;

exports.f = f;
exports.f2 = f2;
exports.a = a;
exports.b = b;
exports.c = c;
--[ a Not a pure module ]--
