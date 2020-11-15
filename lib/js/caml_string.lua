__console = {log = print};

Caml_builtin_exceptions = require "..caml_builtin_exceptions";

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

exports = {};
exports.caml_string_get = caml_string_get;
exports.caml_string_get16 = caml_string_get16;
exports.caml_string_get32 = caml_string_get32;
exports.get = get;
return exports;
--[[ No side effect ]]
