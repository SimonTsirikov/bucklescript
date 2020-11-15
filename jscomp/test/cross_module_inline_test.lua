__console = {log = print};

Caml_char = require "......lib.js.caml_char";

v = Caml_char.caml_is_printable(--[[ "a" ]]97);

exports = {};
exports.v = v;
return exports;
--[[ v Not a pure module ]]
