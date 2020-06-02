--[['use strict';]]

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function f(x) do
  return x + 1 | 0;
end end

function chr(n) do
  if (n < 0 or n > 255) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Char.chr"
        ];
  end
   end 
  return n;
end end

function lowercase(c) do
  if (c >= --[[ "A" ]]65 and c <= --[[ "Z" ]]90 or c >= --[[ "\192" ]]192 and c <= --[[ "\214" ]]214 or c >= --[[ "\216" ]]216 and c <= --[[ "\222" ]]222) then do
    return c + 32 | 0;
  end else do
    return c;
  end end 
end end

function uppercase(c) do
  if (c >= --[[ "a" ]]97 and c <= --[[ "z" ]]122 or c >= --[[ "\224" ]]224 and c <= --[[ "\246" ]]246 or c >= --[[ "\248" ]]248 and c <= --[[ "\254" ]]254) then do
    return c - 32 | 0;
  end else do
    return c;
  end end 
end end

function compare(c1, c2) do
  return c1 - c2 | 0;
end end

exports.f = f;
exports.chr = chr;
exports.lowercase = lowercase;
exports.uppercase = uppercase;
exports.compare = compare;
--[[ No side effect ]]
