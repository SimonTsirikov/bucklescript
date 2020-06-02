console.log = print;

Caml_external_polyfill = require "../../lib/js/caml_external_polyfill";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function to_buffer(buff, ofs, len, v, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buff - len | 0)) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Marshal.to_buffer: substring out of bounds"
    })
  end
   end 
  return Caml_external_polyfill.resolve("caml_output_value_to_buffer")(buff, ofs, len, v, flags);
end end

exports.to_buffer = to_buffer;
--[[ No side effect ]]
