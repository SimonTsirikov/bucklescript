

local Caml_option = require "..caml_option.lua";

function get(dict, k) do
  if ((k in dict)) then do
    return Caml_option.some(dict[k]);
  end
   end 
end end

unsafeDeleteKey = (function (dict,key){
     delete dict[key];
     return 0
     });

function entries(dict) do
  keys = __Object.keys(dict);
  l = keys.length;
  values = new __Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    key = keys[i];
    values[i] = --[[ tuple ]]{
      key,
      dict[key]
    };
  end
  return values;
end end

function values(dict) do
  keys = __Object.keys(dict);
  l = keys.length;
  values_1 = new __Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    values_1[i] = dict[keys[i]];
  end
  return values_1;
end end

function fromList(entries) do
  dict = { };
  _param = entries;
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      dict[match[1]] = match[2];
      _param = param[2];
      ::continue:: ;
    end else do
      return dict;
    end end 
  end;
end end

function fromArray(entries) do
  dict = { };
  l = entries.length;
  for i = 0 , l - 1 | 0 , 1 do
    match = entries[i];
    dict[match[1]] = match[2];
  end
  return dict;
end end

function map(f, source) do
  target = { };
  keys = __Object.keys(source);
  l = keys.length;
  for i = 0 , l - 1 | 0 , 1 do
    key = keys[i];
    target[key] = f(source[key]);
  end
  return target;
end end

export do
  get ,
  unsafeDeleteKey ,
  entries ,
  values ,
  fromList ,
  fromArray ,
  map ,
  
end
--[[ No side effect ]]
