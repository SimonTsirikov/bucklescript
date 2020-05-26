'use strict';


function u(x, y) do
  return x + y | 0;
end

h = u(1, 2);

function max2(x, y) do
  return x + y;
end

hh = max2(1, 2);

function f(x) do
  des(x, (function () do
          console.log("hei");
          return --[ () ]--0;
        end));
  return --[ () ]--0;
end

exports.u = u;
exports.h = h;
exports.max2 = max2;
exports.hh = hh;
exports.f = f;
--[ h Not a pure module ]--
