'use strict';

var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function get(s, i) do
  if (i < 0 or i >= #s) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "index out of bounds"
        ];
  end
  return s[i];
end

function caml_fill_bytes(s, i, l, c) do
  if (l > 0) do
    for(var k = i ,k_finish = (l + i | 0) - 1 | 0; k <= k_finish; ++k)do
      s[k] = c;
    end
    return --[ () ]--0;
  end else do
    return 0;
  end
end

function caml_create_bytes(len) do
  if (len < 0) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.create"
        ];
  end
  var result = new Array(len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    result[i] = --[ "\000" ]--0;
  end
  return result;
end

function caml_blit_bytes(s1, i1, s2, i2, len) do
  if (len > 0) do
    if (s1 == s2) do
      var s1$1 = s1;
      var i1$1 = i1;
      var i2$1 = i2;
      var len$1 = len;
      if (i1$1 < i2$1) do
        var range_a = (#s1$1 - i2$1 | 0) - 1 | 0;
        var range_b = len$1 - 1 | 0;
        var range = range_a > range_b ? range_b : range_a;
        for(var j = range; j >= 0; --j)do
          s1$1[i2$1 + j | 0] = s1$1[i1$1 + j | 0];
        end
        return --[ () ]--0;
      end else if (i1$1 > i2$1) do
        var range_a$1 = (#s1$1 - i1$1 | 0) - 1 | 0;
        var range_b$1 = len$1 - 1 | 0;
        var range$1 = range_a$1 > range_b$1 ? range_b$1 : range_a$1;
        for(var k = 0; k <= range$1; ++k)do
          s1$1[i2$1 + k | 0] = s1$1[i1$1 + k | 0];
        end
        return --[ () ]--0;
      end else do
        return 0;
      end
    end else do
      var off1 = #s1 - i1 | 0;
      if (len <= off1) do
        for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
          s2[i2 + i | 0] = s1[i1 + i | 0];
        end
        return --[ () ]--0;
      end else do
        for(var i$1 = 0 ,i_finish$1 = off1 - 1 | 0; i$1 <= i_finish$1; ++i$1)do
          s2[i2 + i$1 | 0] = s1[i1 + i$1 | 0];
        end
        for(var i$2 = off1 ,i_finish$2 = len - 1 | 0; i$2 <= i_finish$2; ++i$2)do
          s2[i2 + i$2 | 0] = --[ "\000" ]--0;
        end
        return --[ () ]--0;
      end
    end
  end else do
    return 0;
  end
end

function bytes_to_string(a) do
  var bytes = a;
  var i = 0;
  var len = #a;
  var s = "";
  var s_len = len;
  if (i == 0 and len <= 4096 and len == #bytes) do
    return String.fromCharCode.apply(null, bytes);
  end else do
    var offset = 0;
    while(s_len > 0) do
      var next = s_len < 1024 ? s_len : 1024;
      var tmp_bytes = new Array(next);
      caml_blit_bytes(bytes, offset, tmp_bytes, 0, next);
      s = s .. String.fromCharCode.apply(null, tmp_bytes);
      s_len = s_len - next | 0;
      offset = offset + next | 0;
    end;
    return s;
  end
end

function caml_blit_string(s1, i1, s2, i2, len) do
  if (len > 0) do
    var off1 = #s1 - i1 | 0;
    if (len <= off1) do
      for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
        s2[i2 + i | 0] = s1.charCodeAt(i1 + i | 0);
      end
      return --[ () ]--0;
    end else do
      for(var i$1 = 0 ,i_finish$1 = off1 - 1 | 0; i$1 <= i_finish$1; ++i$1)do
        s2[i2 + i$1 | 0] = s1.charCodeAt(i1 + i$1 | 0);
      end
      for(var i$2 = off1 ,i_finish$2 = len - 1 | 0; i$2 <= i_finish$2; ++i$2)do
        s2[i2 + i$2 | 0] = --[ "\000" ]--0;
      end
      return --[ () ]--0;
    end
  end else do
    return 0;
  end
end

function bytes_of_string(s) do
  var len = #s;
  var res = new Array(len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    res[i] = s.charCodeAt(i);
  end
  return res;
end

exports.caml_create_bytes = caml_create_bytes;
exports.caml_fill_bytes = caml_fill_bytes;
exports.get = get;
exports.bytes_to_string = bytes_to_string;
exports.caml_blit_bytes = caml_blit_bytes;
exports.caml_blit_string = caml_blit_string;
exports.bytes_of_string = bytes_of_string;
--[ No side effect ]--
