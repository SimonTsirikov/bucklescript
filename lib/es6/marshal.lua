

import * as Caml_bytes from "./caml_bytes.lua";
import * as Caml_external_polyfill from "./caml_external_polyfill.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function to_buffer(buff, ofs, len, v, flags) do
  if (ofs < 0 or len < 0 or ofs > (#buff - len | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Marshal.to_buffer: substring out of bounds"
        };
  end
   end 
  return Caml_external_polyfill.resolve("caml_output_value_to_buffer")(buff, ofs, len, v, flags);
end end

function data_size(buff, ofs) do
  if (ofs < 0 or ofs > (#buff - 20 | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Marshal.data_size"
        };
  end
   end 
  return Caml_external_polyfill.resolve("caml_marshal_data_size")(buff, ofs);
end end

function total_size(buff, ofs) do
  return 20 + data_size(buff, ofs) | 0;
end end

function from_bytes(buff, ofs) do
  if (ofs < 0 or ofs > (#buff - 20 | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Marshal.from_bytes"
        };
  end
   end 
  len = Caml_external_polyfill.resolve("caml_marshal_data_size")(buff, ofs);
  if (ofs > (#buff - (20 + len | 0) | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Marshal.from_bytes"
        };
  end
   end 
  return Caml_external_polyfill.resolve("caml_input_value_from_string")(buff, ofs);
end end

function from_string(buff, ofs) do
  return from_bytes(Caml_bytes.bytes_of_string(buff), ofs);
end end

function to_channel(prim, prim$1, prim$2) do
  return Caml_external_polyfill.resolve("caml_output_value")(prim, prim$1, prim$2);
end end

function from_channel(prim) do
  return Caml_external_polyfill.resolve("caml_input_value")(prim);
end end

header_size = 20;

export do
  to_channel ,
  to_buffer ,
  from_channel ,
  from_bytes ,
  from_string ,
  header_size ,
  data_size ,
  total_size ,
  
end
--[[ No side effect ]]
