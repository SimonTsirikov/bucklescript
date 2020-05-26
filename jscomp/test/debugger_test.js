'use strict';


function f(x, y) do
  console.log(--[ tuple ]--[
        x,
        y
      ]);
  return x + y | 0;
end

function g(param) do
  f(1, 2);
  debugger;
  f(1, 2);
  debugger;
  return 3;
end

function exterme_g(param) do
  f(1, 2);
  debugger;
  v = --[ () ]--0;
  console.log(v);
  f(1, 2);
  debugger;
  return 3;
end

exports.f = f;
exports.g = g;
exports.exterme_g = exterme_g;
--[ No side effect ]--
