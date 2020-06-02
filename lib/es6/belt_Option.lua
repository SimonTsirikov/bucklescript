

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";

function forEachU(opt, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end else do
    return --[[ () ]]0;
  end end 
end end

function forEach(opt, f) do
  return forEachU(opt, Curry.__1(f));
end end

function getExn(param) do
  if (param ~= undefined) then do
    return Caml_option.valFromOption(param);
  end else do
    error (new Error("getExn"))
  end end 
end end

function mapWithDefaultU(opt, __default, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end else do
    return __default;
  end end 
end end

function mapWithDefault(opt, __default, f) do
  return mapWithDefaultU(opt, __default, Curry.__1(f));
end end

function mapU(opt, f) do
  if (opt ~= undefined) then do
    return Caml_option.some(f(Caml_option.valFromOption(opt)));
  end
   end 
end end

function map(opt, f) do
  return mapU(opt, Curry.__1(f));
end end

function flatMapU(opt, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end
   end 
end end

function flatMap(opt, f) do
  return flatMapU(opt, Curry.__1(f));
end end

function getWithDefault(opt, __default) do
  if (opt ~= undefined) then do
    return Caml_option.valFromOption(opt);
  end else do
    return __default;
  end end 
end end

function isSome(param) do
  return param ~= undefined;
end end

function isNone(x) do
  return x == undefined;
end end

function eqU(a, b, f) do
  if (a ~= undefined) then do
    if (b ~= undefined) then do
      return f(Caml_option.valFromOption(a), Caml_option.valFromOption(b));
    end else do
      return false;
    end end 
  end else do
    return b == undefined;
  end end 
end end

function eq(a, b, f) do
  return eqU(a, b, Curry.__2(f));
end end

function cmpU(a, b, f) do
  if (a ~= undefined) then do
    if (b ~= undefined) then do
      return f(Caml_option.valFromOption(a), Caml_option.valFromOption(b));
    end else do
      return 1;
    end end 
  end else if (b ~= undefined) then do
    return -1;
  end else do
    return 0;
  end end  end 
end end

function cmp(a, b, f) do
  return cmpU(a, b, Curry.__2(f));
end end

export do
  forEachU ,
  forEach ,
  getExn ,
  mapWithDefaultU ,
  mapWithDefault ,
  mapU ,
  map ,
  flatMapU ,
  flatMap ,
  getWithDefault ,
  isSome ,
  isNone ,
  eqU ,
  eq ,
  cmpU ,
  cmp ,
  
end
--[[ No side effect ]]
