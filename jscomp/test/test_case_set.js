'use strict';

Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");

function f(x) do
  x.case = 3;
  return --[ () ]--0;
end

function g(x) do
  return Caml_oo_curry.js2(-977287917, 1, x, 3);
end

exports.f = f;
exports.g = g;
--[ No side effect ]--
