__console = {log = print};

Caml_exceptions = require "......lib.js.caml_exceptions";

function insert(queue, prio, elt) do
  if (queue) then do
    right = queue[4];
    left = queue[3];
    e = queue[2];
    p = queue[1];
    if (prio <= p) then do
      return --[[ Node ]]{
              prio,
              elt,
              insert(right, p, e),
              left
            };
    end else do
      return --[[ Node ]]{
              p,
              e,
              insert(right, prio, elt),
              left
            };
    end end 
  end else do
    return --[[ Node ]]{
            prio,
            elt,
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

Queue_is_empty = Caml_exceptions.create("Pq_test.PrioQueue.Queue_is_empty");

function remove_top(param) do
  if (param) then do
    left = param[3];
    if (param[4]) then do
      if (left) then do
        right = param[4];
        rprio = right[1];
        lprio = left[1];
        if (lprio <= rprio) then do
          return --[[ Node ]]{
                  lprio,
                  left[2],
                  remove_top(left),
                  right
                };
        end else do
          return --[[ Node ]]{
                  rprio,
                  right[2],
                  left,
                  remove_top(right)
                };
        end end 
      end else do
        return param[4];
      end end 
    end else do
      return left;
    end end 
  end else do
    error(Queue_is_empty)
  end end 
end end

function extract(queue) do
  if (queue) then do
    return --[[ tuple ]]{
            queue[1],
            queue[2],
            remove_top(queue)
          };
  end else do
    error(Queue_is_empty)
  end end 
end end

PrioQueue = {
  empty = --[[ Empty ]]0,
  insert = insert,
  Queue_is_empty = Queue_is_empty,
  remove_top = remove_top,
  extract = extract
};

exports = {};
exports.PrioQueue = PrioQueue;
return exports;
--[[ No side effect ]]
