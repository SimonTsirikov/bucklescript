

local List = require "..list.lua";
local Caml_exceptions = require "..caml_exceptions.lua";

Empty = Caml_exceptions.create("Stack.Empty");

function create(param) do
  return {
          c = --[[ [] ]]0,
          len = 0
        };
end end

function clear(s) do
  s.c = --[[ [] ]]0;
  s.len = 0;
  return --[[ () ]]0;
end end

function copy(s) do
  return {
          c = s.c,
          len = s.len
        };
end end

function push(x, s) do
  s.c = --[[ :: ]]{
    x,
    s.c
  };
  s.len = s.len + 1 | 0;
  return --[[ () ]]0;
end end

function pop(s) do
  match = s.c;
  if (match) then do
    s.c = match[2];
    s.len = s.len - 1 | 0;
    return match[1];
  end else do
    error(Empty)
  end end 
end end

function top(s) do
  match = s.c;
  if (match) then do
    return match[1];
  end else do
    error(Empty)
  end end 
end end

function is_empty(s) do
  return s.c == --[[ [] ]]0;
end end

function length(s) do
  return s.len;
end end

function iter(f, s) do
  return List.iter(f, s.c);
end end

function fold(f, acc, s) do
  return List.fold_left(f, acc, s.c);
end end

export do
  Empty ,
  create ,
  push ,
  pop ,
  top ,
  clear ,
  copy ,
  is_empty ,
  length ,
  iter ,
  fold ,
  
end
--[[ No side effect ]]
