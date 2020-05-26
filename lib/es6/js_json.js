

import * as Block from "./block.js";
import * as Caml_option from "./caml_option.js";

function classify(x) do
  var ty = typeof x;
  if (ty == "string") then do
    return --[ JSONString ]--Block.__(0, [x]);
  end else if (ty == "number") then do
    return --[ JSONNumber ]--Block.__(1, [x]);
  end else if (ty == "boolean") then do
    if (x == true) then do
      return --[ JSONTrue ]--1;
    end else do
      return --[ JSONFalse ]--0;
    end end 
  end else if (x == null) then do
    return --[ JSONNull ]--2;
  end else if (Array.isArray(x)) then do
    return --[ JSONArray ]--Block.__(3, [x]);
  end else do
    return --[ JSONObject ]--Block.__(2, [x]);
  end end  end  end  end  end 
end

function test(x, v) do
  local ___conditional___=(v);
  do
     if ___conditional___ = 0--[ String ]-- then do
        return typeof x == "string";end end end 
     if ___conditional___ = 1--[ Number ]-- then do
        return typeof x == "number";end end end 
     if ___conditional___ = 2--[ Object ]-- then do
        if (x ~= null and typeof x == "object") then do
          return !Array.isArray(x);
        end else do
          return false;
        end end end end end 
     if ___conditional___ = 3--[ Array ]-- then do
        return Array.isArray(x);end end end 
     if ___conditional___ = 4--[ Boolean ]-- then do
        return typeof x == "boolean";end end end 
     if ___conditional___ = 5--[ Null ]-- then do
        return x == null;end end end 
     do
    
  end
end

function decodeString(json) do
  if (typeof json == "string") then do
    return json;
  end
   end 
end

function decodeNumber(json) do
  if (typeof json == "number") then do
    return json;
  end
   end 
end

function decodeObject(json) do
  if (typeof json == "object" and !Array.isArray(json) and json ~= null) then do
    return Caml_option.some(json);
  end
   end 
end

function decodeArray(json) do
  if (Array.isArray(json)) then do
    return json;
  end
   end 
end

function decodeBoolean(json) do
  if (typeof json == "boolean") then do
    return json;
  end
   end 
end

function decodeNull(json) do
  if (json == null) then do
    return null;
  end
   end 
end

export do
  classify ,
  test ,
  decodeString ,
  decodeNumber ,
  decodeObject ,
  decodeArray ,
  decodeBoolean ,
  decodeNull ,
  
end
--[ No side effect ]--
