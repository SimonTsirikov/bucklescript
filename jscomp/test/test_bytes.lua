'use strict';

Caml_bytes = require("../../lib/js/caml_bytes.lua");

f = Caml_bytes.bytes_to_string;

ff = Caml_bytes.bytes_to_string;

exports.f = f;
exports.ff = ff;
--[[ No side effect ]]
