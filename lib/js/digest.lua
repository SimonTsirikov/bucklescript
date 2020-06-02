--[['use strict';]]

Char = require "./char.lua";
$$String = require "./string.lua";
Caml_md5 = require "./caml_md5.lua";
Caml_bytes = require "./caml_bytes.lua";
Pervasives = require "./pervasives.lua";
Caml_string = require "./caml_string.lua";
Caml_external_polyfill = require "./caml_external_polyfill.lua";
Caml_builtin_exceptions = require "./caml_builtin_exceptions.lua";

function string(str) do
  return Caml_md5.caml_md5_string(str, 0, #str);
end end

function bytes(b) do
  return string(Caml_bytes.bytes_to_string(b));
end end

function substring(str, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#str - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Digest.substring"
        ];
  end
   end 
  return Caml_md5.caml_md5_string(str, ofs, len);
end end

function subbytes(b, ofs, len) do
  return substring(Caml_bytes.bytes_to_string(b), ofs, len);
end end

function file(filename) do
  ic = Pervasives.open_in_bin(filename);
  d;
  try do
    d = Caml_external_polyfill.resolve("caml_md5_chan")(ic, -1);
  end
  catch (e)do
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    throw e;
  end
  Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  return d;
end end

output = Pervasives.output_string;

function input(chan) do
  return Pervasives.really_input_string(chan, 16);
end end

function char_hex(n) do
  return n + (
          n < 10 and --[[ "0" ]]48 or 87
        ) | 0;
end end

function to_hex(d) do
  if (#d ~= 16) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Digest.to_hex"
        ];
  end
   end 
  result = Caml_bytes.caml_create_bytes(32);
  for i = 0 , 15 , 1 do
    x = Caml_string.get(d, i);
    result[(i << 1)] = char_hex((x >>> 4));
    result[(i << 1) + 1 | 0] = char_hex(x & 15);
  end
  return Caml_bytes.bytes_to_string(result);
end end

function from_hex(s) do
  if (#s ~= 32) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Digest.from_hex"
        ];
  end
   end 
  digit = function (c) do
    if (c >= 65) then do
      if (c >= 97) then do
        if (c >= 103) then do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Digest.from_hex"
              ];
        end
         end 
        return (c - --[[ "a" ]]97 | 0) + 10 | 0;
      end else do
        if (c >= 71) then do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Digest.from_hex"
              ];
        end
         end 
        return (c - --[[ "A" ]]65 | 0) + 10 | 0;
      end end 
    end else do
      if (c > 57 or c < 48) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Digest.from_hex"
            ];
      end
       end 
      return c - --[[ "0" ]]48 | 0;
    end end 
  end end;
  $$byte = function (i) do
    return (digit(Caml_string.get(s, i)) << 4) + digit(Caml_string.get(s, i + 1 | 0)) | 0;
  end end;
  result = Caml_bytes.caml_create_bytes(16);
  for i = 0 , 15 , 1 do
    result[i] = Char.chr($$byte((i << 1)));
  end
  return Caml_bytes.bytes_to_string(result);
end end

compare = $$String.compare;

equal = $$String.equal;

exports.compare = compare;
exports.equal = equal;
exports.string = string;
exports.bytes = bytes;
exports.substring = substring;
exports.subbytes = subbytes;
exports.file = file;
exports.output = output;
exports.input = input;
exports.to_hex = to_hex;
exports.from_hex = from_hex;
--[[ No side effect ]]
