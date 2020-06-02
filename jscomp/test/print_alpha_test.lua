console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";

function f(h, param) do
  console.log(3);
  return Curry.__2(h);
end end

Mt.from_pair_suites("Print_alpha_test", --[[ :: ]]{
      --[[ tuple ]]{
        "File \"print_alpha_test.ml\", line 15, characters 4-11",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      f((function(prim, prim_1) do
                                return prim + prim_1 | 0;
                              end end), --[[ () ]]0)(1, 2),
                      3
                    });
          end end)
      },
      --[[ [] ]]0
    });

exports = {}
exports.f = f;
--[[  Not a pure module ]]
