'use strict';

Caml_oo_curry = require("../../lib/js/caml_oo_curry.lua");

function f(x) do
  return Caml_oo_curry.js1(623642069, 1, x);
end end

exports.f = f;
--[[ No side effect ]]
