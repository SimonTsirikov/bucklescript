--[['use strict';]]


function f(x, y) do
  x$1 = x;
  y$1 = y;
  return --[[ tuple ]][
          x$1,
          y$1
        ];
end end

exports.f = f;
--[[ No side effect ]]
