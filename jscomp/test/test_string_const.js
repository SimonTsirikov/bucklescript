'use strict';

var Caml_string = require("../../lib/js/caml_string.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var hh;

try do
  hh = Caml_string.get("ghsogh", -3);
end
catch (raw_exn)do
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Caml_builtin_exceptions.invalid_argument) do
    console.log(exn[1]);
    hh = --[ "a" ]--97;
  end else do
    throw exn;
  end
end

var f = --[ "o" ]--111;

exports.f = f;
exports.hh = hh;
--[ hh Not a pure module ]--
