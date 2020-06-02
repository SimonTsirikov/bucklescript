

import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function caml_array_sub(x, offset, len) do
  result = new Array(len);
  j = 0;
  i = offset;
  while(j < len) do
    result[j] = x[i];
    j = j + 1 | 0;
    i = i + 1 | 0;
  end;
  return result;
end end

function len(_acc, _l) do
  while(true) do
    l = _l;
    acc = _acc;
    if (l) then do
      _l = l[1];
      _acc = #l[0] + acc | 0;
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function fill(arr, _i, _l) do
  while(true) do
    l = _l;
    i = _i;
    if (l) then do
      x = l[0];
      l$1 = #x;
      k = i;
      j = 0;
      while(j < l$1) do
        arr[k] = x[j];
        k = k + 1 | 0;
        j = j + 1 | 0;
      end;
      _l = l[1];
      _i = k;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function caml_array_concat(l) do
  v = len(0, l);
  result = new Array(v);
  fill(result, 0, l);
  return result;
end end

function caml_array_set(xs, index, newval) do
  if (index < 0 or index >= #xs) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "index out of bounds"
    })
  end
   end 
  xs[index] = newval;
  return --[[ () ]]0;
end end

function caml_array_get(xs, index) do
  if (index < 0 or index >= #xs) then do
    error ({
      Caml_builtin_exceptions.invalid_argument,
      "index out of bounds"
    })
  end
   end 
  return xs[index];
end end

function caml_make_vect(len, init) do
  b = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    b[i] = init;
  end
  return b;
end end

function caml_make_float_vect(len) do
  b = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    b[i] = 0;
  end
  return b;
end end

function caml_array_blit(a1, i1, a2, i2, len) do
  if (i2 <= i1) then do
    for j = 0 , len - 1 | 0 , 1 do
      a2[j + i2 | 0] = a1[j + i1 | 0];
    end
    return --[[ () ]]0;
  end else do
    for j$1 = len - 1 | 0 , 0 , -1 do
      a2[j$1 + i2 | 0] = a1[j$1 + i1 | 0];
    end
    return --[[ () ]]0;
  end end 
end end

function caml_array_dup(prim) do
  return prim.slice(0);
end end

export do
  caml_array_dup ,
  caml_array_sub ,
  caml_array_concat ,
  caml_make_vect ,
  caml_make_float_vect ,
  caml_array_blit ,
  caml_array_get ,
  caml_array_set ,
  
end
--[[ No side effect ]]
