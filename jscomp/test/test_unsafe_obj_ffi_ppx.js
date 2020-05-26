'use strict';


function f(x) do
  return x.length + x.width;
end end

function h(x) do
  x.height = 3;
  x.width = 3;
  return --[[ () ]]0;
end end

function chain(x) do
  return x.element.length + x.element.length | 0;
end end

function g(x) do
  x.method1(3);
  return x.method2(3, 3);
end end

exports.f = f;
exports.h = h;
exports.chain = chain;
exports.g = g;
--[[ No side effect ]]
