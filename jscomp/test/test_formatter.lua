console.log = print;

Block = require "../../lib/js/block";

function f(param) do
  return --[[ Format ]]{
          --[[ Int ]]Block.__(4, {
              --[[ Int_d ]]0,
              --[[ No_padding ]]0,
              --[[ No_precision ]]0,
              --[[ String ]]Block.__(2, {
                  --[[ No_padding ]]0,
                  --[[ End_of_format ]]0
                })
            }),
          "%d%s"
        };
end end

exports.f = f;
--[[ No side effect ]]
