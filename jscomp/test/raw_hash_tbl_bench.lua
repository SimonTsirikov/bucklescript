--[['use strict';]]

Hashtbl = require "../../lib/js/hashtbl";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function bench(param) do
  table = Hashtbl.create(undefined, 1000000);
  for i = 0 , 1000000 , 1 do
    Hashtbl.add(table, i, i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Hashtbl.mem(table, i$1)) then do
      error ({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "raw_hash_tbl_bench.ml",
          9,
          4
        }
      })
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    Hashtbl.remove(table, i$2);
  end
  return --[[ () ]]0;
end end

bench(--[[ () ]]0);

count = 1000000;

exports.count = count;
exports.bench = bench;
--[[  Not a pure module ]]
