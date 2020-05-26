'use strict';

Caml_string = require("../../lib/js/caml_string.js");
Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

hh;

try do
  hh = Caml_string.get("ghsogh", -3);
end
catch (raw_exn)do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
    console.log(exn[1]);
    hh = --[[ "a" ]]97;
  end else do
    throw exn;
  end end 
end

f = --[[ "o" ]]111;

exports.f = f;
exports.hh = hh;
--[[ hh Not a pure module ]]
