

import * as Caml_option from "./caml_option.lua";

function some(x) do
  return Caml_option.some(x);
end end

function isSome(param) do
  return param ~= undefined;
end end

function isSomeValue(eq, v, x) do
  if (x ~= undefined) then do
    return eq(v, Caml_option.valFromOption(x));
  end else do
    return false;
  end end 
end end

function isNone(param) do
  return param == undefined;
end end

function getExn(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end else do
    throw new Error("getExn");
  end end 
end end

function equal(eq, a, b) do
  if (a ~= undefined) then do
    if (b ~= undefined) then do
      return eq(Caml_option.valFromOption(a), Caml_option.valFromOption(b));
    end else do
      return false;
    end end 
  end else do
    return b == undefined;
  end end 
end end

function andThen(f, x) do
  if (x ~= undefined) then do
    return f(Caml_option.valFromOption(x));
  end
   end 
end end

function map(f, x) do
  if (x ~= undefined) then do
    return Caml_option.some(f(Caml_option.valFromOption(x)));
  end
   end 
end end

function getWithDefault(a, x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end else do
    return a;
  end end 
end end

function filter(f, x) do
  if (x ~= undefined) then do
    x$1 = Caml_option.valFromOption(x);
    if (f(x$1)) then do
      return Caml_option.some(x$1);
    end else do
      return ;
    end end 
  end
   end 
end end

function firstSome(a, b) do
  if (a ~= undefined) then do
    return a;
  end else if (b ~= undefined) then do
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
