console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_int32 = require "../../lib/js/caml_int32";

function u(param) do
  n;
  xpcall(function() do
    n = 3;
  end end,function(exn) do
    return 42;
  end end)
  return Caml_int32.div(3, 0);
end end

Mt.from_pair_suites("Jsoo_400_test", --[[ :: ]]{
      --[[ tuple ]]{
        "File \"jsoo_400_test.ml\", line 8, characters 3-10",
        (function (param) do
            return --[[ ThrowAny ]]Block.__(7, {(function (param) do
                          u(--[[ () ]]0);
                          return --[[ () ]]0;
                        end end)});
          end end)
      },
      --[[ [] ]]0
    });

exports.u = u;
--[[  Not a pure module ]]
