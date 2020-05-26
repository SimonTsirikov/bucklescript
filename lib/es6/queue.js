

import * as Curry from "./curry.js";
import * as Caml_exceptions from "./caml_exceptions.js";

Empty = Caml_exceptions.create("Queue.Empty");

function create(param) do
  return do
          length: 0,
          first: --[ Nil ]--0,
          last: --[ Nil ]--0
        end;
end

function clear(q) do
  q.length = 0;
  q.first = --[ Nil ]--0;
  q.last = --[ Nil ]--0;
  return --[ () ]--0;
end

function add(x, q) do
  cell = --[ Cons ]--[
    --[ content ]--x,
    --[ next : Nil ]--0
  ];
  match = q.last;
  if (match) then do
    q.length = q.length + 1 | 0;
    match[--[ next ]--1] = cell;
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
  match = q.first;
  if (match) then do
    return match[--[ content ]--0];
  end else do
    throw Empty;
  end end 
end

function take(q) do
  match = q.first;
  if (match) then do
    content = match[--[ content ]--0];
    next = match[--[ next ]--1];
    if (next) then do
      q.length = q.length - 1 | 0;
      q.first = next;
      return content;
    end else do
      clear(q);
      return content;
    end end 
  end else do
    throw Empty;
  end end 
end

function copy(q) do
  q_res = do
    length: q.length,
    first: --[ Nil ]--0,
    last: --[ Nil ]--0
  end;
  _prev = --[ Nil ]--0;
  _cell = q.first;
  while(true) do
    cell = _cell;
    prev = _prev;
    if (cell) then do
      next = cell[--[ next ]--1];
      res = --[ Cons ]--[
        --[ content ]--cell[--[ content ]--0],
        --[ next : Nil ]--0
      ];
      if (prev) then do
        prev[--[ next ]--1] = res;
      end else do
        q_res.first = res;
      end end 
      _cell = next;
      _prev = res;
      continue ;
    end else do
      q_res.last = prev;
      return q_res;
    end end 
  end;
end

function is_empty(q) do
  return q.length == 0;
end

function length(q) do
  return q.length;
end

function iter(f, q) do
  f$1 = f;
  _cell = q.first;
  while(true) do
    cell = _cell;
    if (cell) then do
      next = cell[--[ next ]--1];
      Curry._1(f$1, cell[--[ content ]--0]);
      _cell = next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function fold(f, accu, q) do
  f$1 = f;
  _accu = accu;
  _cell = q.first;
  while(true) do
    cell = _cell;
    accu$1 = _accu;
    if (cell) then do
      next = cell[--[ next ]--1];
      accu$2 = Curry._2(f$1, accu$1, cell[--[ content ]--0]);
      _cell = next;
      _accu = accu$2;
      continue ;
    end else do
      return accu$1;
    end end 
  end;
end

function transfer(q1, q2) do
  if (q1.length > 0) then do
    match = q2.last;
    if (match) then do
      q2.length = q2.length + q1.length | 0;
      match[--[ next ]--1] = q1.first;
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

push = add;

pop = take;

top = peek;

export do
  Empty ,
  create ,
  add ,
  push ,
  take ,
  pop ,
  peek ,
  top ,
  clear ,
  copy ,
  is_empty ,
  length ,
  iter ,
  fold ,
  transfer ,
  
end
--[ No side effect ]--
