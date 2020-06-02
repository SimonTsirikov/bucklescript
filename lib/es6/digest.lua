

import * as Char from "./char.lua";
import * as __String from "./string.lua";
import * as Caml_md5 from "./caml_md5.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_string from "./caml_string.lua";
import * as Caml_external_polyfill from "./caml_external_polyfill.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function string(str) do
  return Caml_md5.caml_md5_string(str, 0, #str);
end end

function bytes(b) do
  return string(Caml_bytes.bytes_to_string(b));
end end

function substring(str, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#str - len | 0)) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Digest.substring"
    })
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
  xpcall(function() do
    d = Caml_external_polyfill.resolve("caml_md5_chan")(ic, -1);
  end end,function(e) do
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    error(e)
  end end)
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
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Digest.to_hex"
    })
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
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Digest.from_hex"
    })
  end
   end 
  digit = function (c) do
    if (c >= 65) then do
      if (c >= 97) then do
        if (c >= 103) then do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Digest.from_hex"
          })
        end
         end 
        return (c - --[[ "a" ]]97 | 0) + 10 | 0;
      end else do
        if (c >= 71) then do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Digest.from_hex"
          })
        end
         end 
        return (c - --[[ "A" ]]65 | 0) + 10 | 0;
      end end 
    end else do
      if (c > 57 or c < 48) then do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Digest.from_hex"
        })
      end
       end 
      return c - --[[ "0" ]]48 | 0;
    end end 
  end end;
  __byte = function (i) do
    return (digit(Caml_string.get(s, i)) << 4) + digit(Caml_string.get(s, i + 1 | 0)) | 0;
  end end;
  result = Caml_bytes.caml_create_bytes(16);
  for i = 0 , 15 , 1 do
    result[i] = Char.chr(__byte((i << 1)));
  end
  return Caml_bytes.bytes_to_string(result);
end end

compare = __String.compare;

equal = __String.equal;

export do
  compare ,
  equal ,
  string ,
  bytes ,
  substring ,
  subbytes ,
  file ,
  output ,
  input ,
  to_hex ,
  from_hex ,
  
end
--[[ No side effect ]]
