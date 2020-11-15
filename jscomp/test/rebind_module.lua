__console = {log = print};

Caml_exceptions = require "......lib.js.caml_exceptions";

A = Caml_exceptions.create("Rebind_module.A");

AA = Caml_exceptions.create("Rebind_module.AA");

exports = {};
exports.A = A;
exports.AA = AA;
return exports;
--[[ No side effect ]]
