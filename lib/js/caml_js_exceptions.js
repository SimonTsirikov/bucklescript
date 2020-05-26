'use strict';

Caml_option = require("./caml_option.js");
Caml_exceptions = require("./caml_exceptions.js");

$$Error = Caml_exceptions.create("Caml_js_exceptions.Error");

function internalToOCamlException(e) do
  if (Caml_exceptions.caml_is_extension(e)) then do
    return e;
  end else do
    return [
            $$Error,
            e
          ];
  end end 
end

function caml_as_js_exn(exn) do
  if (exn[0] == $$Error) then do
    return Caml_option.some(exn[1]);
  end
   end 
end

exports.$$Error = $$Error;
exports.internalToOCamlException = internalToOCamlException;
exports.caml_as_js_exn = caml_as_js_exn;
--[ No side effect ]--
