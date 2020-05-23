'use strict';


function f(point) do
  var y = point.y;
  var x = point.x;
  return Math.pow(x * x + y * y, 2);
end

exports.f = f;
--[ No side effect ]--
