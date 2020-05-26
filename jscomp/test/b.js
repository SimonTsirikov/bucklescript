'use strict';


function f(point) do
  y = point.y;
  x = point.x;
  return Math.pow(x * x + y * y, 2);
end

exports.f = f;
--[ No side effect ]--
