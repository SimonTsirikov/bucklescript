

import * as Curry from "./curry.js";
import * as Caml_option from "./caml_option.js";

var $$null = null;

function make(param) do
  return do
          length: 0,
          first: $$null,
          last: $$null
        end;
end

function clear(q) do
  q.length = 0;
  q.first = $$null;
  q.last = $$null;
  return --[ () ]--0;
end

function add(q, x) do
  var cell = do
    content: x,
    next: $$null
  end;
  var match = q.last;
  if (match ~= null) then do
    q.length = q.length + 1 | 0;
    match.next = cell;
    q.last = cell;
    return --[ () ]--0;
  end else do
    q.length = 1;
    q.first = cell;
    q.last = cell;
    return --[ () ]--0;
  end end 
end

function peek(q) do
  var match = q.first;
  if (match ~= null) then do
    return Caml_option.some(match.content);
  end
   end 
end

function peekUndefined(q) do
  var match = q.first;
  if (match ~= null) then do
    return match.content;
  end
   end 
end

function peekExn(q) do
  var match = q.first;
  if (match ~= null) then do
    return match.content;
  end else do
    throw new Error("Belt.Queue.Empty");
  end end 
end

function pop(q) do
  var match = q.first;
  if (match ~= null) then do
    var next = match.next;
    if (next == null) then do
      clear(q);
      return Caml_option.some(match.content);
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return Caml_option.some(match.content);
    end end 
  end
   end 
end

function popExn(q) do
  var match = q.first;
  if (match ~= null) then do
    var next = match.next;
    if (next == null) then do
      clear(q);
      return match.content;
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return match.content;
    end end 
  end else do
    throw new Error("Empty");
  end end 
end

function popUndefined(q) do
  var match = q.first;
  if (match ~= null) then do
    var next = match.next;
    if (next == null) then do
      clear(q);
      return match.content;
    end else do
      q.length = q.length - 1 | 0;
      q.first = next;
      return match.content;
    end end 
  end
   end 
end

function copy(q) do
  var qRes = do
    length: q.length,
    first: $$null,
    last: $$null
  end;
  var _prev = $$null;
  var _cell = q.first;
  while(true) do
    var cell = _cell;
    var prev = _prev;
    if (cell ~= null) then do
      var content = cell.content;
      var res = do
        content: content,
        next: $$null
      end;
      if (prev ~= null) then do
        prev.next = res;
      end else do
        qRes.first = res;
      end end 
      _cell = cell.next;
      _prev = res;
      continue ;
    end else do
      qRes.last = prev;
      return qRes;
    end end 
  end;
end

function mapU(q, f) do
  var qRes = do
    length: q.length,
    first: $$null,
    last: $$null
  end;
  var _prev = $$null;
  var _cell = q.first;
  var f$1 = f;
  while(true) do
    var cell = _cell;
    var prev = _prev;
    if (cell ~= null) then do
      var content = f$1(cell.content);
      var res = do
        content: content,
        next: $$null
      end;
      if (prev ~= null) then do
        prev.next = res;
      end else do
        qRes.first = res;
      end end 
      _cell = cell.next;
      _prev = res;
      continue ;
    end else do
      qRes.last = prev;
      return qRes;
    end end 
  end;
end

function map(q, f) do
  return mapU(q, Curry.__1(f));
end

function isEmpty(q) do
  return q.length == 0;
end

function size(q) do
  return q.length;
end

function forEachU(q, f) do
  var _cell = q.first;
  var f$1 = f;
  while(true) do
    var cell = _cell;
    if (cell ~= null) then do
      f$1(cell.content);
      _cell = cell.next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEach(q, f) do
  return forEachU(q, Curry.__1(f));
end

function reduceU(q, accu, f) do
  var f$1 = f;
  var _accu = accu;
  var _cell = q.first;
  while(true) do
    var cell = _cell;
    var accu$1 = _accu;
    if (cell ~= null) then do
      var accu$2 = f$1(accu$1, cell.content);
      _cell = cell.next;
      _accu = accu$2;
      continue ;
    end else do
      return accu$1;
    end end 
  end;
end

function reduce(q, accu, f) do
  return reduceU(q, accu, Curry.__2(f));
end

function transfer(q1, q2) do
  if (q1.length > 0) then do
    var match = q2.last;
    if (match ~= null) then do
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
end

function fillAux(_i, arr, _cell) do
  while(true) do
    var cell = _cell;
    var i = _i;
    if (cell ~= null) then do
      arr[i] = cell.content;
      _cell = cell.next;
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function toArray(x) do
  var v = new Array(x.length);
  fillAux(0, v, x.first);
  return v;
end

function fromArray(arr) do
  var q = make(--[ () ]--0);
  for(var i = 0 ,i_finish = #arr - 1 | 0; i <= i_finish; ++i)do
    add(q, arr[i]);
  end
  return q;
end

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
--[ No side effect ]--
