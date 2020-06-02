console.log = print;

Block = require "./block";
Caml_option = require "./caml_option";

function classify(x) do
  ty = typeof x;
  if (ty == "string") then do
    return --[[ JSONString ]]Block.__(0, {x});
  end else if (ty == "number") then do
    return --[[ JSONNumber ]]Block.__(1, {x});
  end else if (ty == "boolean") then do
    if (x == true) then do
      return --[[ JSONTrue ]]1;
    end else do
      return --[[ JSONFalse ]]0;
    end end 
  end else if (x == nil) then do
    return --[[ JSONNull ]]2;
  end else if (Array.isArray(x)) then do
    return --[[ JSONArray ]]Block.__(3, {x});
  end else do
    return --[[ JSONObject ]]Block.__(2, {x});
  end end  end  end  end  end 
end end

function test(x, v) do
  local ___conditional___=(v);
  do
     if ___conditional___ = 0--[[ String ]] then do
        return typeof x == "string";end end end 
     if ___conditional___ = 1--[[ Number ]] then do
        return typeof x == "number";end end end 
     if ___conditional___ = 2--[[ Object ]] then do
        if (x ~= nil and typeof x == "object") then do
          return not Array.isArray(x);
        end else do
          return false;
        end end end end end 
     if ___conditional___ = 3--[[ Array ]] then do
        return Array.isArray(x);end end end 
     if ___conditional___ = 4--[[ Boolean ]] then do
        return typeof x == "boolean";end end end 
     if ___conditional___ = 5--[[ Null ]] then do
        return x == nil;end end end 
     do
    
  end
end end

function decodeString(json) do
  if (typeof json == "string") then do
    return json;
  end
   end 
end end

function decodeNumber(json) do
  if (typeof json == "number") then do
    return json;
  end
   end 
end end

function decodeObject(json) do
  if (typeof json == "object" and not Array.isArray(json) and json ~= nil) then do
    return Caml_option.some(json);
  end
   end 
end end

function decodeArray(json) do
  if (Array.isArray(json)) then do
    return json;
  end
   end 
end end

function decodeBoolean(json) do
  if (typeof json == "boolean") then do
    return json;
  end
   end 
end end

function decodeNull(json) do
  if (json == nil) then do
    return nil;
  end
   end 
end end

exports.classify = classify;
exports.test = test;
exports.decodeString = decodeString;
exports.decodeNumber = decodeNumber;
exports.decodeObject = decodeObject;
exports.decodeArray = decodeArray;
exports.decodeBoolean = decodeBoolean;
exports.decodeNull = decodeNull;
--[[ No side effect ]]
