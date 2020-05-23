'use strict';

var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_string = require("../../lib/js/caml_string.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param) do
  switch (param) do
    case "aaaabb" :
        return 0;
    case "bbbb" :
        return 1;
    default:
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "test_string.ml",
              4,
              18
            ]
          ];
  end
end

function a(x) do
  return "helloworldhello" .. x;
end

function b(y, x) do
  return y .. ("helloworldhello" .. x);
end

function c(x, y) do
  return x .. "hellohiuhi" .. y;
end

function h(s, b) do
  if (Caml_string.get(s, 0) == --[ "a" ]--97 and Caml_bytes.get(b, 0) == --[ "b" ]--98) then do
    return Caml_string.get(s, 1) == Caml_bytes.get(b, 2);
  end else do
    return false;
  end end 
end

var v = 2;

exports.f = f;
exports.a = a;
exports.b = b;
exports.c = c;
exports.v = v;
exports.h = h;
--[ No side effect ]--
