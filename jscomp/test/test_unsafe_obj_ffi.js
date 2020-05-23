'use strict';


function f(x) do
  return x.height + x.width | 0;
end

function g(x) do
  x.method1(3);
  return x.method2(3, 3);
end

function h(x) do
  x.height = 3;
  x.width = 3;
  return --[ () ]--0;
end

exports.f = f;
exports.g = g;
exports.h = h;
--[ No side effect ]--
