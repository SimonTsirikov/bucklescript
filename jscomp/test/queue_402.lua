__console = {log = print};

Curry = require "......lib.js.curry";
Caml_obj = require "......lib.js.caml_obj";
Caml_exceptions = require "......lib.js.caml_exceptions";

Empty = Caml_exceptions.create("Queue_402.Empty");

function create(param) do
  return {
          length = 0,
          tail = nil
        };
end end

function clear(q) do
  q.length = 0;
  q.tail = nil;
  return --[[ () ]]0;
end end

function add(x, q) do
  if (q.length == 0) then do
    cell = { };
    cell.content = x;
    cell.next = cell;
    q.length = 1;
    q.tail = cell;
    return --[[ () ]]0;
  end else do
    tail = q.tail;
    head = tail.next;
    cell_1 = {
      content = x,
      next = head
    };
    q.length = q.length + 1 | 0;
    tail.next = cell_1;
    q.tail = cell_1;
    return --[[ () ]]0;
  end end 
end end

function peek(q) do
  if (q.length == 0) then do
    error(Empty)
  end
   end 
  return q.tail.next.content;
end end

function take(q) do
  if (q.length == 0) then do
    error(Empty)
  end
   end 
  q.length = q.length - 1 | 0;
  tail = q.tail;
  head = tail.next;
  if (head == tail) then do
    q.tail = nil;
  end else do
    tail.next = head.next;
  end end 
  return head.content;
end end

function copy(q) do
  if (q.length == 0) then do
    return {
            length = 0,
            tail = nil
          };
  end else do
    tail = q.tail;
    tail_prime = { };
    Caml_obj.caml_update_dummy(tail_prime, {
          content = tail.content,
          next = tail_prime
        });
    copy_1 = function(_prev, _cell) do
      while(true) do
        cell = _cell;
        prev = _prev;
        if (cell ~= tail) then do
          res = {
            content = cell.content,
            next = tail_prime
          };
          prev.next = res;
          _cell = cell.next;
          _prev = res;
          ::continue:: ;
        end else do
          return 0;
        end end 
      end;
    end end;
    copy_1(tail_prime, tail.next);
    return {
            length = q.length,
            tail = tail_prime
          };
  end end 
end end

function is_empty(q) do
  return q.length == 0;
end end

function length(q) do
  return q.length;
end end

function iter(f, q) do
  if (q.length > 0) then do
    tail = q.tail;
    _cell = tail.next;
    while(true) do
      cell = _cell;
      Curry._1(f, cell.content);
      if (cell ~= tail) then do
        _cell = cell.next;
        ::continue:: ;
      end else do
        return 0;
      end end 
    end;
  end else do
    return 0;
  end end 
end end

function fold(f, accu, q) do
  if (q.length == 0) then do
    return accu;
  end else do
    tail = q.tail;
    _accu = accu;
    _cell = tail.next;
    while(true) do
      cell = _cell;
      accu_1 = _accu;
      accu_2 = Curry._2(f, accu_1, cell.content);
      if (cell == tail) then do
        return accu_2;
      end else do
        _cell = cell.next;
        _accu = accu_2;
        ::continue:: ;
      end end 
    end;
  end end 
end end

function transfer(q1, q2) do
  length1 = q1.length;
  if (length1 > 0) then do
    tail1 = q1.tail;
    clear(q1);
    if (q2.length > 0) then do
      tail2 = q2.tail;
      head1 = tail1.next;
      head2 = tail2.next;
      tail1.next = head2;
      tail2.next = head1;
    end
     end 
    q2.length = q2.length + length1 | 0;
    q2.tail = tail1;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

push = add;

top = peek;

pop = take;

exports = {};
exports.Empty = Empty;
exports.create = create;
exports.clear = clear;
exports.add = add;
exports.push = push;
exports.peek = peek;
exports.top = top;
exports.take = take;
exports.pop = pop;
exports.copy = copy;
exports.is_empty = is_empty;
exports.length = length;
exports.iter = iter;
exports.fold = fold;
exports.transfer = transfer;
return exports;
--[[ No side effect ]]
