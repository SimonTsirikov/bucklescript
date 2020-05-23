

import * as Caml_option from "./caml_option.js";

function test(x) do
  return x == undefined;
end

function testAny(x) do
  return x == undefined;
end

function getExn(f) do
  if (f ~= undefined) then do
    return f;
  end else do
    throw new Error("Js.Undefined.getExn");
  end end 
end

function bind(x, f) do
  if (x ~= undefined) then do
    return f(x);
  end
   end 
end

function iter(x, f) do
  if (x ~= undefined) then do
    return f(x);
  end else do
    return --[ () ]--0;
  end end 
end

function fromOption(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end
   end 
end

var from_opt = fromOption;

export do
  test ,
  testAny ,
  getExn ,
  bind ,
  iter ,
  fromOption ,
  from_opt ,
  
end
--[ No side effect ]--
