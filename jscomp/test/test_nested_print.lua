--[['use strict';]]

Curry = require "../../lib/js/curry";

function u(x, x$1) do
  return x$1 + x$1 | 0;
end end

function f(g, x) do
  u = Curry._1(g, x);
  return u + u | 0;
end end

exports.u = u;
exports.f = f;
--[[ No side effect ]]
