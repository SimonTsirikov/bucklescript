'use strict';

var Hashtbl = require("../../lib/js/hashtbl.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function bench(param) do
  var table = Hashtbl.create(undefined, 1000000);
  for var i = 0 , 1000000 , 1 do
    Hashtbl.add(table, i, i);
  end
  for var i$1 = 0 , 1000000 , 1 do
    if (!Hashtbl.mem(table, i$1)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "raw_hash_tbl_bench.ml",
              9,
              4
            ]
          ];
    end
     end 
  end
  for var i$2 = 0 , 1000000 , 1 do
    Hashtbl.remove(table, i$2);
  end
  return --[ () ]--0;
end

bench(--[ () ]--0);

var count = 1000000;

exports.count = count;
exports.bench = bench;
--[  Not a pure module ]--
