__console = {log = print};

Caml_primitive = require "......lib.js.caml_primitive";

compare = Caml_primitive.caml_int_compare;

exports = {};
exports.compare = compare;
return exports;
--[[ No side effect ]]
