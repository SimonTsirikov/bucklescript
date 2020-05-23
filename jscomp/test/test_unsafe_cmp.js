'use strict';


function f(x, y) do
  return --[ tuple ]--[
          x < y,
          x <= y,
          x > y,
          x >= y
        ];
end

function ff(x, y) do
  if (x < y) do
    return 1;
  end else do
    return 2;
  end
end

exports.f = f;
exports.ff = ff;
--[ No side effect ]--
