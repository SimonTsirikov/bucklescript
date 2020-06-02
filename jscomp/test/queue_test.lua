console = {log = print};

Mt = require "./mt";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Queue = require "../../lib/js/queue";
Queue_402 = require "./queue_402";
Caml_array = require "../../lib/js/caml_array";

function Test(Queue) do
  to_array = function(q) do
    v = Caml_array.caml_make_vect(Curry._1(Queue.length, q), 0);
    Curry._3(Queue.fold, (function(i, e) do
            Caml_array.caml_array_set(v, i, e);
            return i + 1 | 0;
          end end), 0, q);
    return v;
  end end;
  queue_1 = function(x) do
    q = Curry._1(Queue.create, --[[ () ]]0);
    __Array.iter((function(x) do
            return Curry._2(Queue.add, x, q);
          end end), x);
    return to_array(q);
  end end;
  return do
          to_array: to_array,
          queue_1: queue_1
        end;
end end

function to_array(q) do
  v = Caml_array.caml_make_vect(q.length, 0);
  Queue.fold((function(i, e) do
          Caml_array.caml_array_set(v, i, e);
          return i + 1 | 0;
        end end), 0, q);
  return v;
end end

function queue_1(x) do
  q = do
    length: 0,
    first: --[[ Nil ]]0,
    last: --[[ Nil ]]0
  end;
  __Array.iter((function(x) do
          return Queue.add(x, q);
        end end), x);
  return to_array(q);
end end

T1 = do
  to_array: to_array,
  queue_1: queue_1
end;

function to_array_1(q) do
  v = Caml_array.caml_make_vect(q.length, 0);
  Queue_402.fold((function(i, e) do
          Caml_array.caml_array_set(v, i, e);
          return i + 1 | 0;
        end end), 0, q);
  return v;
end end

function queue_1_1(x) do
  q = do
    length: 0,
    tail: undefined
  end;
  __Array.iter((function(x) do
          return Queue_402.add(x, q);
        end end), x);
  return to_array_1(q);
end end

T2 = do
  to_array: to_array_1,
  queue_1: queue_1_1
end;

suites_000 = --[[ tuple ]]{
  "File \"queue_test.ml\", line 26, characters 2-9",
  (function(param) do
      x = {
        3,
        4,
        5,
        2
      };
      return --[[ Eq ]]Block.__(0, {
                x,
                queue_1(x)
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "File \"queue_test.ml\", line 29, characters 2-9",
    (function(param) do
        x = {
          3,
          4,
          5,
          2
        };
        return --[[ Eq ]]Block.__(0, {
                  x,
                  queue_1_1(x)
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Queue_test", suites);

exports = {}
exports.Test = Test;
exports.T1 = T1;
exports.T2 = T2;
exports.suites = suites;
--[[  Not a pure module ]]