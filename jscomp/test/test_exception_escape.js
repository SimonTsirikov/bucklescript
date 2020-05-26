'use strict';

Caml_exceptions = require("../../lib/js/caml_exceptions.js");

A = Caml_exceptions.create("Test_exception_escape.N.A");

f;

try do
  throw [
        A,
        3
      ];
end
catch (exn)do
  f = 3;
end

N = do
  f: f
end;

exports.N = N;
--[[ f Not a pure module ]]
