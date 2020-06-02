

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";

__null = nil;

function make(param) do
  return do
          length: 0,
          first: __null,
          last: __null
        end;
end end

function clear(q) do
  q.length = 0;
  q.first = __null;
  q.last = __null;
  return --[[ () ]]0;
end end

function add(q, x) do
  cell = do
    content: x,
    next: __null
  end;
  match = q.last;
  if (match ~= nil) then do
    q.length = q.length + 1 | 0;
    match.next = cell;
    q.last = cell;
    return --[[ () ]]0;
  end else do
    q.length = 1;
    q.first = cell;
    q.last = cell;
    return --[[ () ]]0;
  end end 
end end

function peek(q) do
  match = q.first;
  if (match ~= nil) then do
    return Caml_option.some(match.content);
  end
   end 
end end

function peekUndefined(q) do
  match = q.first;
  if (match ~= nil) then do
    return match.content;
  end
   end 
end end

function peekExn(q) do
  match = q.first;
  if (match ~= nil) then do
    return match.content;
  end else do
    error(new Error("Belt.Queue.Empty"))
  end end 
end end

function pop(q) do
  match = q.first;
  if (match ~= nil) then do
    next = match.next;
    if (next == nil) then do
      clear(q);
      return Caml_option.some(match.content);
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return Caml_option.some(match.content);
    end end 
  end
   end 
end end

function popExn(q) do
  match = q.first;
  if (match ~= nil) then do
    next = match.next;
    if (next == nil) then do
      clear(q);
      return match.content;
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return match.content;
    end end 
  end else do
    error(new Error("Empty"))
  end end 
end end

function popUndefined(q) do
  match = q.first;
  if (match ~= nil) then do
    next = match.next;
    if (next == nil) then do
      clear(q);
      return match.content;
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return match.content;
    end end 
  end
   end 
end end

function copy(q) do
  qRes = do
    length: q.length,
    first: __null,
    last: __null
  end;
  _prev = __null;
  _cell = q.first;
  while(true) do
    cell = _cell;
    prev = _prev;
    if (cell ~= nil) then do
      content = cell.content;
      res = do
        content: content,
        next: __null
      end;
      if (prev ~= nil) then do
        prev.next = res;
      end else do
        qRes.first = res;
      end end 
      _cell = cell.next;
      _prev = res;
      ::continue:: ;
    end else do
      qRes.last = prev;
      return qRes;
    end end 
  end;
end end

function mapU(q, f) do
  qRes = do
    length: q.length,
    first: __null,
    last: __null
  end;
  _prev = __null;
  _cell = q.first;
  f_1 = f;
  while(true) do
    cell = _cell;
    prev = _prev;
    if (cell ~= nil) then do
      content = f_1(cell.content);
      res = do
        content: content,
        next: __null
      end;
      if (prev ~= nil) then do
        prev.next = res;
      end else do
        qRes.first = res;
      end end 
      _cell = cell.next;
      _prev = res;
      ::continue:: ;
    end else do
      qRes.last = prev;
      return qRes;
    end end 
  end;
end end

function map(q, f) do
  return mapU(q, Curry.__1(f));
end end

function isEmpty(q) do
  return q.length == 0;
end end

function size(q) do
  return q.length;
end end

function forEachU(q, f) do
  _cell = q.first;
  f_1 = f;
  while(true) do
    cell = _cell;
    if (cell ~= nil) then do
      f_1(cell.content);
      _cell = cell.next;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(q, f) do
  return forEachU(q, Curry.__1(f));
end end

function reduceU(q, accu, f) do
  f_1 = f;
  _accu = accu;
  _cell = q.first;
  while(true) do
    cell = _cell;
    accu_1 = _accu;
    if (cell ~= nil) then do
      accu_2 = f_1(accu_1, cell.content);
      _cell = cell.next;
      _accu = accu_2;
      ::continue:: ;
    end else do
      return accu_1;
    end end 
  end;
end end

function reduce(q, accu, f) do
  return reduceU(q, accu, Curry.__2(f));
end end

function transfer(q1, q2) do
  if (q1.length > 0) then do
    match = q2.last;
    if (match ~= nil) then do
      q2.length = q2.length + q1.length | 0;
      match.next = q1.first;
      q2.last = q1.last;
      return clear(q1);
    end else do
      q2.length = q1.length;
      q2.first = q1.first;
      q2.last = q1.last;
      return clear(q1);
    end end 
  end else do
    return 0;
  end end 
end end

function fillAux(_i, arr, _cell) do
  while(true) do
    cell = _cell;
    i = _i;
    if (cell ~= nil) then do
      arr[i] = cell.content;
      _cell = cell.next;
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function toArray(x) do
  v = new Array(x.length);
  fillAux(0, v, x.first);
  return v;
end end

function fromArray(arr) do
  q = make(--[[ () ]]0);
  for i = 0 , #arr - 1 | 0 , 1 do
    add(q, arr[i]);
  end
  return q;
end end

export do
  make ,
  clear ,
  isEmpty ,
  fromArray ,
  add ,
  peek ,
  peekUndefined ,
  peekExn ,
  pop ,
  popUndefined ,
  popExn ,
  copy ,
  size ,
  mapU ,
  map ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  transfer ,
  toArray ,
  
end
--[[ No side effect ]]
