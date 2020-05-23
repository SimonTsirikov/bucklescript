'use strict';

var Rbset = require("./rbset.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function bench(param) do
  var data = --[ Empty ]--0;
  console.time("test/bs_rbset_int_bench.ml 7");
  for(var i = 0; i <= 1000000; ++i)do
    data = Rbset.add(i, data);
  end
  console.timeEnd("test/bs_rbset_int_bench.ml 7");
  console.time("test/bs_rbset_int_bench.ml 11");
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Rbset.mem(i$1, data)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_rbset_int_bench.ml",
              12,
              4
            ]
          ];
    end
     end 
  end
  console.timeEnd("test/bs_rbset_int_bench.ml 11");
  console.time("test/bs_rbset_int_bench.ml 14");
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    data = Rbset.remove(i$2, data);
  end
  console.timeEnd("test/bs_rbset_int_bench.ml 14");
  if (Rbset.cardinal(data) == 0) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_rbset_int_bench.ml",
            17,
            2
          ]
        ];
  end end 
end

console.time("test/bs_rbset_int_bench.ml 21");

bench(--[ () ]--0);

console.timeEnd("test/bs_rbset_int_bench.ml 21");

var count = 1000000;

var V = --[ alias ]--0;

exports.count = count;
exports.V = V;
exports.bench = bench;
--[  Not a pure module ]--
