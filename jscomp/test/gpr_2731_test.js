'use strict';


function f(x) do
  return x + 1 | 0;
end

var a = f(1);

var b = f(2);

function g(param) do
  return 1;
end

var c = g(--[ () ]--0);

var d = g(--[ () ]--0);

exports.f = f;
exports.a = a;
exports.b = b;
exports.g = g;
exports.c = c;
exports.d = d;
--[ a Not a pure module ]--
