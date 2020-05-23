'use strict';

var Caml_exceptions = require("../../lib/js/caml_exceptions.js");

var A = Caml_exceptions.create("Test_exception_escape.N.A");

var f;

try do
  throw [
        A,
        3
      ];
end
catch (exn)do
  f = 3;
end

var N = do
  f: f
end;

exports.N = N;
--[ f Not a pure module ]--
