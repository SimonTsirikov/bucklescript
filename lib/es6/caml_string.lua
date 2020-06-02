

import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function caml_string_get(s, i) do
  if (i >= #s or i < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "index out of bounds"
    })
  end
   end 
  return s.charCodeAt(i);
end end

function caml_string_get16(s, i) do
  return s.charCodeAt(i) + (s.charCodeAt(i + 1 | 0) << 8) | 0;
end end

function caml_string_get32(s, i) do
  return ((s.charCodeAt(i) + (s.charCodeAt(i + 1 | 0) << 8) | 0) + (s.charCodeAt(i + 2 | 0) << 16) | 0) + (s.charCodeAt(i + 3 | 0) << 24) | 0;
end end

function get(s, i) do
  if (i < 0 or i >= #s) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "index out of bounds"
    })
  end
   end 
  return s.charCodeAt(i);
end end

export do
  caml_string_get ,
  caml_string_get16 ,
  caml_string_get32 ,
  get ,
  
end
--[[ No side effect ]]