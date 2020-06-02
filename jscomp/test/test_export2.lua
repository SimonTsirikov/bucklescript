console.log = print;

Caml_int32 = require "../../lib/js/caml_int32";

f = Caml_int32.imul;

exports.f = f;
--[[ No side effect ]]
