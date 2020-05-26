'use strict';

Block = require("./block.js");
Curry = require("./curry.js");

function getExn(param) do
  if (param.tag) then do
    throw new Error("getExn");
  end else do
    return param[0];
  end end 
end end

function mapWithDefaultU(opt, $$default, f) do
  if (opt.tag) then do
    return $$default;
  end else do
    return f(opt[0]);
  end end 
end end

function mapWithDefault(opt, $$default, f) do
  return mapWithDefaultU(opt, $$default, Curry.__1(f));
end end

function mapU(opt, f) do
  if (opt.tag) then do
    return --[[ Error ]]Block.__(1, [opt[0]]);
  end else do
    return --[[ Ok ]]Block.__(0, [f(opt[0])]);
  end end 
end end

function map(opt, f) do
  return mapU(opt, Curry.__1(f));
end end

function flatMapU(opt, f) do
  if (opt.tag) then do
    return --[[ Error ]]Block.__(1, [opt[0]]);
  end else do
    return f(opt[0]);
  end end 
end end

function flatMap(opt, f) do
  return flatMapU(opt, Curry.__1(f));
end end

function getWithDefault(opt, $$default) do
  if (opt.tag) then do
    return $$default;
  end else do
    return opt[0];
  end end 
end end

function isOk(param) do
  if (param.tag) then do
    return false;
  end else do
    return true;
  end end 
end end

function isError(param) do
  if (param.tag) then do
    return true;
  end else do
    return false;
  end end 
end end

function eqU(a, b, f) do
  if (a.tag) then do
    if (b.tag) then do
      return true;
    end else do
      return false;
    end end 
  end else if (b.tag) then do
    return false;
  end else do
    return f(a[0], b[0]);
  end end  end 
end end

function eq(a, b, f) do
  return eqU(a, b, Curry.__2(f));
end end

function cmpU(a, b, f) do
  if (a.tag) then do
    if (b.tag) then do
      return 0;
    end else do
      return -1;
    end end 
  end else if (b.tag) then do
    return 1;
  end else do
    return f(a[0], b[0]);
  end end  end 
end end

function cmp(a, b, f) do
  return cmpU(a, b, Curry.__2(f));
end end

exports.getExn = getExn;
exports.mapWithDefaultU = mapWithDefaultU;
exports.mapWithDefault = mapWithDefault;
exports.mapU = mapU;
exports.map = map;
exports.flatMapU = flatMapU;
exports.flatMap = flatMap;
exports.getWithDefault = getWithDefault;
exports.isOk = isOk;
exports.isError = isError;
exports.eqU = eqU;
exports.eq = eq;
exports.cmpU = cmpU;
exports.cmp = cmp;
--[[ No side effect ]]
