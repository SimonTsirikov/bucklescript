

import * as Caml_option from "./caml_option.lua";

function some(x) do
  return Caml_option.some(x);
end end

function isSome(param) do
  return param ~= nil;
end end

function isSomeValue(eq, v, x) do
  if (x ~= nil) then do
    return eq(v, Caml_option.valFromOption(x));
  end else do
    return false;
  end end 
end end

function isNone(param) do
  return param == nil;
end end

function getExn(x) do
  if (x ~= nil) then do
    return Caml_option.valFromOption(x);
  end else do
    error(new Error("getExn"))
  end end 
end end

function equal(eq, a, b) do
  if (a ~= nil) then do
    if (b ~= nil) then do
      return eq(Caml_option.valFromOption(a), Caml_option.valFromOption(b));
    end else do
      return false;
    end end 
  end else do
    return b == nil;
  end end 
end end

function andThen(f, x) do
  if (x ~= nil) then do
    return f(Caml_option.valFromOption(x));
  end
   end 
end end

function map(f, x) do
  if (x ~= nil) then do
    return Caml_option.some(f(Caml_option.valFromOption(x)));
  end
   end 
end end

function getWithDefault(a, x) do
  if (x ~= nil) then do
    return Caml_option.valFromOption(x);
  end else do
    return a;
  end end 
end end

function filter(f, x) do
  if (x ~= nil) then do
    x_1 = Caml_option.valFromOption(x);
    if (f(x_1)) then do
      return Caml_option.some(x_1);
    end else do
      return ;
    end end 
  end
   end 
end end

function firstSome(a, b) do
  if (a ~= nil) then do
    return a;
  end else if (b ~= nil) then do
    return b;
  end else do
    return ;
  end end  end 
end end

__default = getWithDefault;

export do
  some ,
  isSome ,
  isSomeValue ,
  isNone ,
  getExn ,
  equal ,
  andThen ,
  map ,
  getWithDefault ,
  __default ,
  __default as default,
  filter ,
  firstSome ,
  
end
--[[ No side effect ]]
