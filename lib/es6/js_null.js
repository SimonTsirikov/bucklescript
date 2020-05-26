

import * as Caml_option from "./caml_option.js";

function test(x) do
  return x == null;
end

function getExn(f) do
  if (f ~= null) then do
    return f;
  end else do
    throw new Error("Js.Null.getExn");
  end end 
end

function bind(x, f) do
  if (x ~= null) then do
    return f(x);
  end else do
    return null;
  end end 
end

function iter(x, f) do
  if (x ~= null) then do
    return f(x);
  end else do
    return --[ () ]--0;
  end end 
end

function fromOption(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end else do
    return null;
  end end 
end

from_opt = fromOption;

export do
  test ,
  getExn ,
  bind ,
  iter ,
  fromOption ,
  from_opt ,
  
end
--[ No side effect ]--
