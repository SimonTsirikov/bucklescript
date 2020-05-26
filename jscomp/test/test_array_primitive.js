'use strict';

Caml_array = require("../../lib/js/caml_array.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function caml_array_sub(x, offset, len) do
  result = new Array(len);
  for j = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(result, j, Caml_array.caml_array_get(x, offset + j | 0));
  end
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
  return Caml_array.caml_array_set(xs, index, newval);
end

function caml_array_get(xs, index) do
  if (index < 0 or index >= #xs) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "index out of bounds"
        ];
  end
   end 
  return Caml_array.caml_array_get(xs, index);
end

function caml_make_vect(len, init) do
  b = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(b, i, init);
  end
  return b;
end

exports.caml_array_sub = caml_array_sub;
exports.caml_array_set = caml_array_set;
exports.caml_array_get = caml_array_get;
exports.caml_make_vect = caml_make_vect;
--[ No side effect ]--
