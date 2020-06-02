

import * as Caml_format from "./caml_format.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_js_exceptions from "./caml_js_exceptions.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function succ(n) do
  return n + 1 | 0;
end end

function pred(n) do
  return n - 1 | 0;
end end

function abs(n) do
  if (n >= 0) then do
    return n;
  end else do
    return -n | 0;
  end end 
end end

function lognot(n) do
  return n ^ -1;
end end

function to_string(n) do
  return Caml_format.caml_int32_format("%d", n);
end end

function of_string_opt(s) do
  xpcall(function() do
    return Caml_format.caml_int32_of_string(s);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

compare = Caml_primitive.caml_int32_compare;

function equal(x, y) do
  return x == y;
end end

zero = 0;

one = 1;

minus_one = -1;

max_int = 2147483647;

min_int = -2147483648;

export do
  zero ,
  one ,
  minus_one ,
  succ ,
  pred ,
  abs ,
  max_int ,
  min_int ,
  lognot ,
  of_string_opt ,
  to_string ,
  compare ,
  equal ,
  
end
--[[ No side effect ]]
