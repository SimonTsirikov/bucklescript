


function caml_int_compare(x, y) do
  if (x < y) then do
    return -1;
  end else if (x == y) then do
    return 0;
  end else do
    return 1;
  end end  end 
end

function caml_bool_compare(x, y) do
  if (x) then do
    if (y) then do
      return 0;
    end else do
      return 1;
    end end 
  end else if (y) then do
    return -1;
  end else do
    return 0;
  end end  end 
end

function caml_float_compare(x, y) do
  if (x == y) then do
    return 0;
  end else if (x < y) then do
    return -1;
  end else if (x > y or x == x) then do
    return 1;
  end else if (y == y) then do
    return -1;
  end else do
    return 0;
  end end  end  end  end 
end

function caml_string_compare(s1, s2) do
  if (s1 == s2) then do
    return 0;
  end else if (s1 < s2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end

function caml_bytes_compare_aux(s1, s2, _off, len, def) do
  while(true) do
    var off = _off;
    if (off < len) then do
      var a = s1[off];
      var b = s2[off];
      if (a > b) then do
        return 1;
      end else if (a < b) then do
        return -1;
      end else do
        _off = off + 1 | 0;
        continue ;
      end end  end 
    end else do
      return def;
    end end 
  end;
end

function caml_bytes_compare(s1, s2) do
  var len1 = #s1;
  var len2 = #s2;
  if (len1 == len2) then do
    return caml_bytes_compare_aux(s1, s2, 0, len1, 0);
  end else if (len1 < len2) then do
    return caml_bytes_compare_aux(s1, s2, 0, len1, -1);
  end else do
    return caml_bytes_compare_aux(s1, s2, 0, len2, 1);
  end end  end 
end

function caml_bytes_equal(s1, s2) do
  var len1 = #s1;
  var len2 = #s2;
  if (len1 == len2) then do
    var s1$1 = s1;
    var s2$1 = s2;
    var _off = 0;
    var len = len1;
    while(true) do
      var off = _off;
      if (off == len) then do
        return true;
      end else do
        var a = s1$1[off];
        var b = s2$1[off];
        if (a == b) then do
          _off = off + 1 | 0;
          continue ;
        end else do
          return false;
        end end 
      end end 
    end;
  end else do
    return false;
  end end 
end

function caml_bool_min(x, y) do
  if (x) then do
    return y;
  end else do
    return x;
  end end 
end

function caml_int_min(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_float_min(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_string_min(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_nativeint_min(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_int32_min(x, y) do
  if (x < y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_bool_max(x, y) do
  if (x) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_int_max(x, y) do
  if (x > y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_float_max(x, y) do
  if (x > y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_string_max(x, y) do
  if (x > y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_nativeint_max(x, y) do
  if (x > y) then do
    return x;
  end else do
    return y;
  end end 
end

function caml_int32_max(x, y) do
  if (x > y) then do
    return x;
  end else do
    return y;
  end end 
end

var caml_nativeint_compare = caml_int_compare;

var caml_int32_compare = caml_int_compare;

export do
  caml_bytes_compare ,
  caml_bytes_equal ,
  caml_int_compare ,
  caml_bool_compare ,
  caml_float_compare ,
  caml_nativeint_compare ,
  caml_string_compare ,
  caml_int32_compare ,
  caml_bool_min ,
  caml_int_min ,
  caml_float_min ,
  caml_string_min ,
  caml_nativeint_min ,
  caml_int32_min ,
  caml_bool_max ,
  caml_int_max ,
  caml_float_max ,
  caml_string_max ,
  caml_nativeint_max ,
  caml_int32_max ,
  
end
--[ No side effect ]--
