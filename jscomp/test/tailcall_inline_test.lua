__console = {log = print};

Mt = require "..mt";
__Array = require "......lib.js.array";
Block = require "......lib.js.block";
Caml_array = require "......lib.js.caml_array";

function f(param) do
  f_1 = function(_acc, _n) do
    while(true) do
      n = _n;
      acc = _acc;
      if (n > 0) then do
        _n = n - 1 | 0;
        _acc = acc + n | 0;
        ::continue:: ;
      end else do
        return acc;
      end end 
    end;
  end end;
  v = Caml_array.caml_make_vect(10, 0);
  for i = 0 , 9 , 1 do
    Caml_array.caml_array_set(v, i, f_1(0, i));
  end
  return v;
end end

suites_000 = --[[ tuple ]]{
  "acc",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                f(--[[ () ]]0),
                {
                  0,
                  1,
                  3,
                  6,
                  10,
                  15,
                  21,
                  28,
                  36,
                  45
                }
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "array_to_list",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  --[[ :: ]]{
                    1,
                    --[[ :: ]]{
                      2,
                      --[[ :: ]]{
                        3,
                        --[[ [] ]]0
                      }
                    }
                  },
                  __Array.to_list({
                        1,
                        2,
                        3
                      })
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Tailcall_inline_test", suites);

exports = {};
exports.f = f;
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
