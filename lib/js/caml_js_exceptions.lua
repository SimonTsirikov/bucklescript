__console = {log = print};

Caml_option = require "..caml_option";
Caml_exceptions = require "..caml_exceptions";

__Error = Caml_exceptions.create("Caml_js_exceptions.Error");

function internalToOCamlException(e) do
  if (Caml_exceptions.caml_is_extension(e)) then do
    return e;
  end else do
    return {
            __Error,
            e
          };
  end end 
end end

function caml_as_js_exn(exn) do
  if (exn[1] == __Error) then do
    return Caml_option.some(exn[2]);
  end
   end 
end end

exports = {};
exports.__Error = __Error;
exports.internalToOCamlException = internalToOCamlException;
exports.caml_as_js_exn = caml_as_js_exn;
return exports;
--[[ No side effect ]]
