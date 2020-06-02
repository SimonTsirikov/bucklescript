--[['use strict';]]

Curry = require "./curry";
Caml_option = require "./caml_option";

function make(param) do
  return do
          root: nil
        end;
end end

function clear(s) do
  s.root = nil;
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
  if (match ~= nil) then do
    return match.head;
  end
   end 
end end

function top(s) do
  match = s.root;
  if (match ~= nil) then do
    return Caml_option.some(match.head);
  end
   end 
end end

function isEmpty(s) do
  return s.root == nil;
end end

function popUndefined(s) do
  match = s.root;
  if (match ~= nil) then do
    s.root = match.tail;
    return match.head;
  end
   end 
end end

function pop(s) do
  match = s.root;
  if (match ~= nil) then do
    s.root = match.tail;
    return Caml_option.some(match.head);
  end
   end 
end end

function size(s) do
  match = s.root;
  if (match ~= nil) then do
    _x = match;
    _acc = 0;
    while(true) do
      acc = _acc;
      x = _x;
      match_1 = x.tail;
      if (match_1 ~= nil) then do
        _acc = acc + 1 | 0;
        _x = match_1;
        ::continue:: ;
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
  f_1 = f;
  while(true) do
    s_1 = _s;
    if (s_1 ~= nil) then do
      f_1(s_1.head);
      _s = s_1.tail;
      ::continue:: ;
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
  while(cursor ~= nil) do
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

exports.make = make;
exports.clear = clear;
exports.copy = copy;
exports.push = push;
exports.popUndefined = popUndefined;
exports.pop = pop;
exports.topUndefined = topUndefined;
exports.top = top;
exports.isEmpty = isEmpty;
exports.size = size;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.dynamicPopIterU = dynamicPopIterU;
exports.dynamicPopIter = dynamicPopIter;
--[[ No side effect ]]
