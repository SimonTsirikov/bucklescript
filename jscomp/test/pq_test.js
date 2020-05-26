'use strict';

Caml_exceptions = require("../../lib/js/caml_exceptions.js");

function insert(queue, prio, elt) do
  if (queue) then do
    right = queue[3];
    left = queue[2];
    e = queue[1];
    p = queue[0];
    if (prio <= p) then do
      return --[[ Node ]][
              prio,
              elt,
              insert(right, p, e),
              left
            ];
    end else do
      return --[[ Node ]][
              p,
              e,
              insert(right, prio, elt),
              left
            ];
    end end 
  end else do
    return --[[ Node ]][
            prio,
            elt,
            --[[ Empty ]]0,
            --[[ Empty ]]0
          ];
  end end 
end end

Queue_is_empty = Caml_exceptions.create("Pq_test.PrioQueue.Queue_is_empty");

function remove_top(param) do
  if (param) then do
    left = param[2];
    if (param[3]) then do
      if (left) then do
        right = param[3];
        rprio = right[0];
        lprio = left[0];
        if (lprio <= rprio) then do
          return --[[ Node ]][
                  lprio,
                  left[1],
                  remove_top(left),
                  right
                ];
        end else do
          return --[[ Node ]][
                  rprio,
                  right[1],
                  left,
                  remove_top(right)
                ];
        end end 
      end else do
        return param[3];
      end end 
    end else do
      return left;
    end end 
  end else do
    throw Queue_is_empty;
  end end 
end end

function extract(queue) do
  if (queue) then do
    return --[[ tuple ]][
            queue[0],
            queue[1],
            remove_top(queue)
          ];
  end else do
    throw Queue_is_empty;
  end end 
end end

PrioQueue = do
  empty: --[[ Empty ]]0,
  insert: insert,
  Queue_is_empty: Queue_is_empty,
  remove_top: remove_top,
  extract: extract
end;

exports.PrioQueue = PrioQueue;
--[[ No side effect ]]
