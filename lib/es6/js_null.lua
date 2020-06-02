

import * as Caml_option from "./caml_option.lua";

function test(x) do
  return x == nil;
end end

function getExn(f) do
  if (f ~= nil) then do
    return f;
  end else do
    error (new Error("Js.Null.getExn"))
  end end 
end end

function bind(x, f) do
  if (x ~= nil) then do
    return f(x);
  end else do
    return nil;
  end end 
end end

function iter(x, f) do
  if (x ~= nil) then do
    return f(x);
  end else do
    return --[[ () ]]0;
  end end 
end end

function fromOption(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end else do
    return nil;
  end end 
end end

from_opt = fromOption;

export do
  test ,
  getExn ,
  bind ,
  iter ,
  fromOption ,
  from_opt ,
  
end
--[[ No side effect ]]
