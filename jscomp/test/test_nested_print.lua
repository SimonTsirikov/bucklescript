--[['use strict';]]

Curry = require "../../lib/js/curry";

function u(x, x_1) do
  return x_1 + x_1 | 0;
end end

function f(g, x) do
  u = Curry._1(g, x);
  return u + u | 0;
end end

exports.u = u;
exports.f = f;
--[[ No side effect ]]
