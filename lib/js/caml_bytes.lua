--[['use strict';]]

Caml_builtin_exceptions = require "./caml_builtin_exceptions.lua";

function get(s, i) do
  if (i < 0 or i >= #s) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "index out of bounds"
        };
  end
   end 
  return s[i];
end end

function caml_fill_bytes(s, i, l, c) do
  if (l > 0) then do
    for k = i , (l + i | 0) - 1 | 0 , 1 do
      s[k] = c;
    end
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function caml_create_bytes(len) do
  if (len < 0) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.create"
        };
  end
   end 
  result = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    result[i] = --[[ "\000" ]]0;
  end
  return result;
end end

function caml_blit_bytes(s1, i1, s2, i2, len) do
  if (len > 0) then do
    if (s1 == s2) then do
      s1$1 = s1;
      i1$1 = i1;
      i2$1 = i2;
      len$1 = len;
      if (i1$1 < i2$1) then do
        range_a = (#s1$1 - i2$1 | 0) - 1 | 0;
        range_b = len$1 - 1 | 0;
        range = range_a > range_b and range_b or range_a;
        for j = range , 0 , -1 do
          s1$1[i2$1 + j | 0] = s1$1[i1$1 + j | 0];
        end
        return --[[ () ]]0;
      end else if (i1$1 > i2$1) then do
        range_a$1 = (#s1$1 - i1$1 | 0) - 1 | 0;
        range_b$1 = len$1 - 1 | 0;
        range$1 = range_a$1 > range_b$1 and range_b$1 or range_a$1;
        for k = 0 , range$1 , 1 do
          s1$1[i2$1 + k | 0] = s1$1[i1$1 + k | 0];
        end
        return --[[ () ]]0;
      end else do
        return 0;
      end end  end 
    end else do
      off1 = #s1 - i1 | 0;
      if (len <= off1) then do
        for i = 0 , len - 1 | 0 , 1 do
          s2[i2 + i | 0] = s1[i1 + i | 0];
        end
        return --[[ () ]]0;
      end else do
        for i$1 = 0 , off1 - 1 | 0 , 1 do
          s2[i2 + i$1 | 0] = s1[i1 + i$1 | 0];
        end
        for i$2 = off1 , len - 1 | 0 , 1 do
          s2[i2 + i$2 | 0] = --[[ "\000" ]]0;
        end
        return --[[ () ]]0;
      end end 
    end end 
  end else do
    return 0;
  end end 
end end

function bytes_to_string(a) do
  bytes = a;
  i = 0;
  len = #a;
  s = "";
  s_len = len;
  if (i == 0 and len <= 4096 and len == #bytes) then do
    return String.fromCharCode.apply(null, bytes);
  end else do
    offset = 0;
    while(s_len > 0) do
      next = s_len < 1024 and s_len or 1024;
      tmp_bytes = new Array(next);
      caml_blit_bytes(bytes, offset, tmp_bytes, 0, next);
      s = s .. String.fromCharCode.apply(null, tmp_bytes);
      s_len = s_len - next | 0;
      offset = offset + next | 0;
    end;
    return s;
  end end 
end end

function caml_blit_string(s1, i1, s2, i2, len) do
  if (len > 0) then do
    off1 = #s1 - i1 | 0;
    if (len <= off1) then do
      for i = 0 , len - 1 | 0 , 1 do
        s2[i2 + i | 0] = s1.charCodeAt(i1 + i | 0);
      end
      return --[[ () ]]0;
    end else do
      for i$1 = 0 , off1 - 1 | 0 , 1 do
        s2[i2 + i$1 | 0] = s1.charCodeAt(i1 + i$1 | 0);
      end
      for i$2 = off1 , len - 1 | 0 , 1 do
        s2[i2 + i$2 | 0] = --[[ "\000" ]]0;
      end
      return --[[ () ]]0;
    end end 
  end else do
    return 0;
  end end 
end end

function bytes_of_string(s) do
  len = #s;
  res = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    res[i] = s.charCodeAt(i);
  end
  return res;
end end

exports.caml_create_bytes = caml_create_bytes;
exports.caml_fill_bytes = caml_fill_bytes;
exports.get = get;
exports.bytes_to_string = bytes_to_string;
exports.caml_blit_bytes = caml_blit_bytes;
exports.caml_blit_string = caml_blit_string;
exports.bytes_of_string = bytes_of_string;
--[[ No side effect ]]
