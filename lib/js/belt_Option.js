'use strict';

Curry = require("./curry.js");
Caml_option = require("./caml_option.js");

function forEachU(opt, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end else do
    return --[ () ]--0;
  end end 
end

function forEach(opt, f) do
  return forEachU(opt, Curry.__1(f));
end

function getExn(param) do
  if (param ~= undefined) then do
    return Caml_option.valFromOption(param);
  end else do
    throw new Error("getExn");
  end end 
end

function mapWithDefaultU(opt, $$default, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end else do
    return $$default;
  end end 
end

function mapWithDefault(opt, $$default, f) do
  return mapWithDefaultU(opt, $$default, Curry.__1(f));
end

function mapU(opt, f) do
  if (opt ~= undefined) then do
    return Caml_option.some(f(Caml_option.valFromOption(opt)));
  end
   end 
end

function map(opt, f) do
  return mapU(opt, Curry.__1(f));
end

function flatMapU(opt, f) do
  if (opt ~= undefined) then do
    return f(Caml_option.valFromOption(opt));
  end
   end 
end

function flatMap(opt, f) do
  return flatMapU(opt, Curry.__1(f));
end

function getWithDefault(opt, $$default) do
  if (opt ~= undefined) then do
    return Caml_option.valFromOption(opt);
  end else do
    return $$default;
  end end 
end

function isSome(param) do
  return param ~= undefined;
end

function isNone(x) do
  return x == undefined;
end

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
end

function eq(a, b, f) do
  return eqU(a, b, Curry.__2(f));
end

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
end

function cmp(a, b, f) do
  return cmpU(a, b, Curry.__2(f));
end

exports.forEachU = forEachU;
exports.forEach = forEach;
exports.getExn = getExn;
exports.mapWithDefaultU = mapWithDefaultU;
exports.mapWithDefault = mapWithDefault;
exports.mapU = mapU;
exports.map = map;
exports.flatMapU = flatMapU;
exports.flatMap = flatMap;
exports.getWithDefault = getWithDefault;
exports.isSome = isSome;
exports.isNone = isNone;
exports.eqU = eqU;
exports.eq = eq;
exports.cmpU = cmpU;
exports.cmp = cmp;
--[ No side effect ]--
