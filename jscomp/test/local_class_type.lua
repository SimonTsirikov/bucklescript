__console = {log = print};

Caml_oo_curry = require "......lib.js.caml_oo_curry";

function f(x) do
  x.height = 3;
  return --[[ () ]]0;
end end

function h(x) do
  return Caml_oo_curry.js1(38537191, 1, x);
end end

exports = {};
exports.f = f;
exports.h = h;
return exports;
--[[ No side effect ]]
