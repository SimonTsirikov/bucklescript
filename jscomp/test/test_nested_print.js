'use strict';

var Curry = require("../../lib/js/curry.js");

function u(x, x$1) do
  return x$1 + x$1 | 0;
end

function f(g, x) do
  var u = Curry._1(g, x);
  return u + u | 0;
end

exports.u = u;
exports.f = f;
--[ No side effect ]--
