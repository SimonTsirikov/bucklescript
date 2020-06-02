console.log = print;

Caml_bytes = require "../../lib/js/caml_bytes";

f = Caml_bytes.bytes_to_string;

ff = Caml_bytes.bytes_to_string;

exports.f = f;
exports.ff = ff;
--[[ No side effect ]]
