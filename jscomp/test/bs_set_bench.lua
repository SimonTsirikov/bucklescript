__console = {log = print};

Belt_SetInt = require "......lib.js.belt_SetInt";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function bench(param) do
  data = Belt_SetInt.empty;
  __console.time("test/bs_set_bench.ml 7");
  for i = 0 , 1000000 , 1 do
    data = Belt_SetInt.add(data, i);
  end
  __console.timeEnd("test/bs_set_bench.ml 7");
  __console.time("test/bs_set_bench.ml 11");
  for i_1 = 0 , 1000000 , 1 do
    if (not Belt_SetInt.has(data, i_1)) then do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "bs_set_bench.ml",
          12,
          4
        }
      })
    end
     end 
  end
  __console.timeEnd("test/bs_set_bench.ml 11");
  __console.time("test/bs_set_bench.ml 14");
  for i_2 = 0 , 1000000 , 1 do
    data = Belt_SetInt.remove(data, i_2);
  end
  __console.timeEnd("test/bs_set_bench.ml 14");
  if (Belt_SetInt.size(data) == 0) then do
    return 0;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_set_bench.ml",
        17,
        2
      }
    })
  end end 
end end

__console.time("test/bs_set_bench.ml 21");

bench(--[[ () ]]0);

__console.timeEnd("test/bs_set_bench.ml 21");

count = 1000000;

N = --[[ alias ]]0;

exports = {};
exports.count = count;
exports.N = N;
exports.bench = bench;
return exports;
--[[  Not a pure module ]]
