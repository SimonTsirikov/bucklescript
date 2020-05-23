

import * as Block from "./block.js";

function classify(x) do
  var ty = typeof x;
  if (ty == "undefined") do
    return --[ JSUndefined ]--3;
  end else if (x == null) do
    return --[ JSNull ]--2;
  end else if (ty == "number") do
    return --[ JSNumber ]--Block.__(0, [x]);
  end else if (ty == "string") do
    return --[ JSString ]--Block.__(1, [x]);
  end else if (ty == "boolean") do
    if (x == true) do
      return --[ JSTrue ]--1;
    end else do
      return --[ JSFalse ]--0;
    end
  end else if (ty == "function") do
    return --[ JSFunction ]--Block.__(2, [x]);
  end else if (ty == "object") do
    return --[ JSObject ]--Block.__(3, [x]);
  end else do
    return --[ JSSymbol ]--Block.__(4, [x]);
  end
end

function test(x, v) do
  switch (v) do
    case --[ Undefined ]--0 :
        return typeof x == "undefined";
    case --[ Null ]--1 :
        return x == null;
    case --[ Boolean ]--2 :
        return typeof x == "boolean";
    case --[ Number ]--3 :
        return typeof x == "number";
    case --[ String ]--4 :
        return typeof x == "string";
    case --[ Function ]--5 :
        return typeof x == "function";
    case --[ Object ]--6 :
        return typeof x == "object";
    case --[ Symbol ]--7 :
        return typeof x == "symbol";
    
  end
end

export do
  test ,
  classify ,
  
end
--[ No side effect ]--
