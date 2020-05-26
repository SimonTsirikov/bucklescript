'use strict';

Block = require("./block.js");

function classify(x) do
  ty = typeof x;
  if (ty == "undefined") then do
    return --[ JSUndefined ]--3;
  end else if (x == null) then do
    return --[ JSNull ]--2;
  end else if (ty == "number") then do
    return --[ JSNumber ]--Block.__(0, [x]);
  end else if (ty == "string") then do
    return --[ JSString ]--Block.__(1, [x]);
  end else if (ty == "boolean") then do
    if (x == true) then do
      return --[ JSTrue ]--1;
    end else do
      return --[ JSFalse ]--0;
    end end 
  end else if (ty == "function") then do
    return --[ JSFunction ]--Block.__(2, [x]);
  end else if (ty == "object") then do
    return --[ JSObject ]--Block.__(3, [x]);
  end else do
    return --[ JSSymbol ]--Block.__(4, [x]);
  end end  end  end  end  end  end  end 
end

function test(x, v) do
  local ___conditional___=(v);
  do
     if ___conditional___ = 0--[ Undefined ]-- then do
        return typeof x == "undefined";end end end 
     if ___conditional___ = 1--[ Null ]-- then do
        return x == null;end end end 
     if ___conditional___ = 2--[ Boolean ]-- then do
        return typeof x == "boolean";end end end 
     if ___conditional___ = 3--[ Number ]-- then do
        return typeof x == "number";end end end 
     if ___conditional___ = 4--[ String ]-- then do
        return typeof x == "string";end end end 
     if ___conditional___ = 5--[ Function ]-- then do
        return typeof x == "function";end end end 
     if ___conditional___ = 6--[ Object ]-- then do
        return typeof x == "object";end end end 
     if ___conditional___ = 7--[ Symbol ]-- then do
        return typeof x == "symbol";end end end 
     do
    
  end
end

exports.test = test;
exports.classify = classify;
--[ No side effect ]--
