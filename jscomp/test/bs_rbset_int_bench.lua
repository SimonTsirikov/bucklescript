__console = {log = print};

Rbset = require "..rbset";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function bench(param) do
  data = --[[ Empty ]]0;
  __console.time("test/bs_rbset_int_bench.ml 7");
  for i = 0 , 1000000 , 1 do
    data = Rbset.add(i, data);
  end
  __console.timeEnd("test/bs_rbset_int_bench.ml 7");
  __console.time("test/bs_rbset_int_bench.ml 11");
  for i_1 = 0 , 1000000 , 1 do
    if (not Rbset.mem(i_1, data)) then do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "bs_rbset_int_bench.ml",
          12,
          4
        }
      })
    end
     end 
  end
  __console.timeEnd("test/bs_rbset_int_bench.ml 11");
  __console.time("test/bs_rbset_int_bench.ml 14");
  for i_2 = 0 , 1000000 , 1 do
    data = Rbset.remove(i_2, data);
  end
  __console.timeEnd("test/bs_rbset_int_bench.ml 14");
  if (Rbset.cardinal(data) == 0) then do
    return 0;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_rbset_int_bench.ml",
        17,
        2
      }
    })
  end end 
end end

__console.time("test/bs_rbset_int_bench.ml 21");

bench(--[[ () ]]0);

__console.timeEnd("test/bs_rbset_int_bench.ml 21");

count = 1000000;

V = --[[ alias ]]0;

exports = {};
exports.count = count;
exports.V = V;
exports.bench = bench;
return exports;
--[[  Not a pure module ]]
