'use strict';

var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function caml_array_sub(x, offset, len) do
  var result = new Array(len);
  var j = 0;
  var i = offset;
  while(j < len) do
    result[j] = x[i];
    j = j + 1 | 0;
    i = i + 1 | 0;
  end;
  return result;
end

function len(_acc, _l) do
  while(true) do
    var l = _l;
    var acc = _acc;
    if (l) then do
      _l = l[1];
      _acc = #l[0] + acc | 0;
      continue ;
    end else do
      return acc;
    end end 
  end;
end

function fill(arr, _i, _l) do
  while(true) do
    var l = _l;
    var i = _i;
    if (l) then do
      var x = l[0];
      var l$1 = #x;
      var k = i;
      var j = 0;
      while(j < l$1) do
        arr[k] = x[j];
        k = k + 1 | 0;
        j = j + 1 | 0;
      end;
      _l = l[1];
      _i = k;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function caml_array_concat(l) do
  var v = len(0, l);
  var result = new Array(v);
  fill(result, 0, l);
  return result;
end

function caml_array_set(xs, index, newval) do
  if (index < 0 or index >= #xs) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "index out of bounds"
        ];
  end
   end 
  xs[index] = newval;
  return --[ () ]--0;
end

function caml_array_get(xs, index) do
  if (index < 0 or index >= #xs) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "index out of bounds"
        ];
  end
   end 
  return xs[index];
end

function caml_make_vect(len, init) do
  var b = new Array(len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    b[i] = init;
  end
  return b;
end

function caml_make_float_vect(len) do
  var b = new Array(len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    b[i] = 0;
  end
  return b;
end

function caml_array_blit(a1, i1, a2, i2, len) do
  if (i2 <= i1) then do
    for(var j = 0 ,j_finish = len - 1 | 0; j <= j_finish; ++j)do
      a2[j + i2 | 0] = a1[j + i1 | 0];
    end
    return --[ () ]--0;
  end else do
    for(var j$1 = len - 1 | 0; j$1 >= 0; --j$1)do
      a2[j$1 + i2 | 0] = a1[j$1 + i1 | 0];
    end
    return --[ () ]--0;
  end end 
end

function caml_array_dup(prim) do
  return prim.slice(0);
end

exports.caml_array_dup = caml_array_dup;
exports.caml_array_sub = caml_array_sub;
exports.caml_array_concat = caml_array_concat;
exports.caml_make_vect = caml_make_vect;
exports.caml_make_float_vect = caml_make_float_vect;
exports.caml_array_blit = caml_array_blit;
exports.caml_array_get = caml_array_get;
exports.caml_array_set = caml_array_set;
--[ No side effect ]--
