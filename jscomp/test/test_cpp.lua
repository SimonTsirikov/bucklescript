__console = {log = print};

Caml_primitive = require "......lib.js.caml_primitive";

f = Caml_primitive.caml_int_compare;

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
