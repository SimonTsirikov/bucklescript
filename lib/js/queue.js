'use strict';

var Curry = require("./curry.js");
var Caml_exceptions = require("./caml_exceptions.js");

var Empty = Caml_exceptions.create("Queue.Empty");

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
  var cell = --[ Cons ]--[
    --[ content ]--x,
    --[ next : Nil ]--0
  ];
  var match = q.last;
  if (match) do
    q.length = q.length + 1 | 0;
    match[--[ next ]--1] = cell;
    q.last = cell;
    return --[ () ]--0;
  end else do
    q.length = 1;
    q.first = cell;
    q.last = cell;
    return --[ () ]--0;
  end
end

function peek(q) do
  var match = q.first;
  if (match) do
    return match[--[ content ]--0];
  end else do
    throw Empty;
  end
end

function take(q) do
  var match = q.first;
  if (match) do
    var content = match[--[ content ]--0];
    var next = match[--[ next ]--1];
    if (next) do
      q.length = q.length - 1 | 0;
      q.first = next;
      return content;
    end else do
      clear(q);
      return content;
    end
  end else do
    throw Empty;
  end
end

function copy(q) do
  var q_res = do
    length: q.length,
    first: --[ Nil ]--0,
    last: --[ Nil ]--0
  end;
  var _prev = --[ Nil ]--0;
  var _cell = q.first;
  while(true) do
    var cell = _cell;
    var prev = _prev;
    if (cell) do
      var next = cell[--[ next ]--1];
      var res = --[ Cons ]--[
        --[ content ]--cell[--[ content ]--0],
        --[ next : Nil ]--0
      ];
      if (prev) do
        prev[--[ next ]--1] = res;
      end else do
        q_res.first = res;
      end
      _cell = next;
      _prev = res;
      continue ;
    end else do
      q_res.last = prev;
      return q_res;
    end
  end;
end

function is_empty(q) do
  return q.length == 0;
end

function length(q) do
  return q.length;
end

function iter(f, q) do
  var f$1 = f;
  var _cell = q.first;
  while(true) do
    var cell = _cell;
    if (cell) do
      var next = cell[--[ next ]--1];
      Curry._1(f$1, cell[--[ content ]--0]);
      _cell = next;
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function fold(f, accu, q) do
  var f$1 = f;
  var _accu = accu;
  var _cell = q.first;
  while(true) do
    var cell = _cell;
    var accu$1 = _accu;
    if (cell) do
      var next = cell[--[ next ]--1];
      var accu$2 = Curry._2(f$1, accu$1, cell[--[ content ]--0]);
      _cell = next;
      _accu = accu$2;
      continue ;
    end else do
      return accu$1;
    end
  end;
end

function transfer(q1, q2) do
  if (q1.length > 0) do
    var match = q2.last;
    if (match) do
      q2.length = q2.length + q1.length | 0;
      match[--[ next ]--1] = q1.first;
      q2.last = q1.last;
      return clear(q1);
    end else do
      q2.length = q1.length;
      q2.first = q1.first;
      q2.last = q1.last;
      return clear(q1);
    end
  end else do
    return 0;
  end
end

var push = add;

var pop = take;

var top = peek;

exports.Empty = Empty;
exports.create = create;
exports.add = add;
exports.push = push;
exports.take = take;
exports.pop = pop;
exports.peek = peek;
exports.top = top;
exports.clear = clear;
exports.copy = copy;
exports.is_empty = is_empty;
exports.length = length;
exports.iter = iter;
exports.fold = fold;
exports.transfer = transfer;
--[ No side effect ]--
