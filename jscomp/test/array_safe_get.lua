'use strict';

Caml_array = require("../../lib/js/caml_array.lua");
Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.lua");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.lua");

x = [
  1,
  2
];

y;

try do
  y = Caml_array.caml_array_get(x, 3);
end
catch (raw_exn)do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
    console.log(exn[1]);
    y = 0;
  end else do
    throw exn;
  end end 
end

exports.x = x;
exports.y = y;
--[[ y Not a pure module ]]
