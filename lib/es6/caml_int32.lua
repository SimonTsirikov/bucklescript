

local Caml_builtin_exceptions = require "..caml_builtin_exceptions.lua";

function div(x, y) do
  if (y == 0) then do
    error(Caml_builtin_exceptions.division_by_zero)
  end
   end 
  return x / y | 0;
end end

function mod_(x, y) do
  if (y == 0) then do
    error(Caml_builtin_exceptions.division_by_zero)
  end
   end 
  return x % y;
end end

function caml_bswap16(x) do
  return ((x & 255) << 8) | ((x & 65280) >>> 8);
end end

function caml_int32_bswap(x) do
  return ((x & 255) << 24) | ((x & 65280) << 8) | ((x & 16711680) >>> 8) | ((x & 4278190080) >>> 24);
end end

imul = (Math.imul || function (x,y) {
  y |= 0; return ((((x >> 16) * y) << 16) + (x & 0xffff) * y)|0; 
});

caml_nativeint_bswap = caml_int32_bswap;

export do
  div ,
  mod_ ,
  caml_bswap16 ,
  caml_int32_bswap ,
  caml_nativeint_bswap ,
  imul ,
  
end
--[[ imul Not a pure module ]]
