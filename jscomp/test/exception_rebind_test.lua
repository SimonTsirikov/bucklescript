__console = {log = print};

Exception_def = require "..exception_def";
Caml_exceptions = require "......lib.js.caml_exceptions";

E = Caml_exceptions.create("Exception_rebind_test.A.E");

A = {
  E = E
};

B = {
  F = E
};

A0 = Caml_exceptions.create("Exception_rebind_test.A0");

H = Exception_def.A;

exports = {};
exports.A = A;
exports.B = B;
exports.H = H;
exports.A0 = A0;
return exports;
--[[ Exception_def Not a pure module ]]
