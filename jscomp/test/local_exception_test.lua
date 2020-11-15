__console = {log = print};

Caml_exceptions = require "......lib.js.caml_exceptions";

A = Caml_exceptions.create("Local_exception_test.A");

v = {
  A,
  3,
  true
};

B = Caml_exceptions.create("Local_exception_test.B");

D = Caml_exceptions.create("Local_exception_test.D");

d = {
  D,
  3
};

u = B;

exports = {};
exports.A = A;
exports.v = v;
exports.B = B;
exports.u = u;
exports.D = D;
exports.d = d;
return exports;
--[[ No side effect ]]
