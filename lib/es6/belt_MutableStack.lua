

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";

function make(param) do
  return do
          root: null
        end;
end end

function clear(s) do
  s.root = null;
  return --[[ () ]]0;
end end

function copy(s) do
  return do
          root: s.root
        end;
end end

function push(s, x) do
  s.root = do
    head: x,
    tail: s.root
  end;
  return --[[ () ]]0;
end end

function topUndefined(s) do
  match = s.root;
  if (match ~= null) then do
    return match.head;
  end
   end 
end end

function top(s) do
  match = s.root;
  if (match ~= null) then do
    return Caml_option.some(match.head);
  end
   end 
end end

function isEmpty(s) do
  return s.root == null;
end end

function popUndefined(s) do
  match = s.root;
  if (match ~= null) then do
    s.root = match.tail;
    return match.head;
  end
   end 
end end

function pop(s) do
  match = s.root;
  if (match ~= null) then do
    s.root = match.tail;
    return Caml_option.some(match.head);
  end
   end 
end end

function size(s) do
  match = s.root;
  if (match ~= null) then do
    _x = match;
    _acc = 0;
    while(true) do
      acc = _acc;
      x = _x;
      match$1 = x.tail;
      if (match$1 ~= null) then do
        _acc = acc + 1 | 0;
        _x = match$1;
        continue ;
      end else do
        return acc + 1 | 0;
      end end 
    end;
  end else do
    return 0;
  end end 
end end

function forEachU(s, f) do
  _s = s.root;
  f$1 = f;
  while(true) do
    s$1 = _s;
    if (s$1 ~= null) then do
      f$1(s$1.head);
      _s = s$1.tail;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(s, f) do
  return forEachU(s, Curry.__1(f));
end end

function dynamicPopIterU(s, f) do
  cursor = s.root;
  while(cursor ~= null) do
    v = cursor;
    s.root = v.tail;
    f(v.head);
    cursor = s.root;
  end;
  return --[[ () ]]0;
end end

function dynamicPopIter(s, f) do
  return dynamicPopIterU(s, Curry.__1(f));
end end

export do
  make ,
  clear ,
  copy ,
  push ,
  popUndefined ,
  pop ,
  topUndefined ,
  top ,
  isEmpty ,
  size ,
  forEachU ,
  forEach ,
  dynamicPopIterU ,
  dynamicPopIter ,
  
end
--[[ No side effect ]]
