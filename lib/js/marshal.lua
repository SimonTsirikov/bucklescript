console.log = print;

Caml_bytes = require "./caml_bytes";
Caml_external_polyfill = require "./caml_external_polyfill";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

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

function data_size(buff, ofs) do
  if (ofs < 0 or ofs > (#buff - 20 | 0)) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Marshal.data_size"
    })
  end
   end 
  return Caml_external_polyfill.resolve("caml_marshal_data_size")(buff, ofs);
end end

function total_size(buff, ofs) do
  return 20 + data_size(buff, ofs) | 0;
end end

function from_bytes(buff, ofs) do
  if (ofs < 0 or ofs > (#buff - 20 | 0)) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Marshal.from_bytes"
    })
  end
   end 
  len = Caml_external_polyfill.resolve("caml_marshal_data_size")(buff, ofs);
  if (ofs > (#buff - (20 + len | 0) | 0)) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Marshal.from_bytes"
    })
  end
   end 
  return Caml_external_polyfill.resolve("caml_input_value_from_string")(buff, ofs);
end end

function from_string(buff, ofs) do
  return from_bytes(Caml_bytes.bytes_of_string(buff), ofs);
end end

function to_channel(prim, prim_1, prim_2) do
  return Caml_external_polyfill.resolve("caml_output_value")(prim, prim_1, prim_2);
end end

function from_channel(prim) do
  return Caml_external_polyfill.resolve("caml_input_value")(prim);
end end

header_size = 20;

exports.to_channel = to_channel;
exports.to_buffer = to_buffer;
exports.from_channel = from_channel;
exports.from_bytes = from_bytes;
exports.from_string = from_string;
exports.header_size = header_size;
exports.data_size = data_size;
exports.total_size = total_size;
--[[ No side effect ]]
