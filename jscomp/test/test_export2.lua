__console = {log = print};

Caml_int32 = require "......lib.js.caml_int32";

f = Caml_int32.imul;

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
