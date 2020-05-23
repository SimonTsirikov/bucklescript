'use strict';


function f(x) do
  var v = x;
  var sum = 0;
  while(v > 0) do
    sum = sum + v | 0;
    v = v - 1 | 0;
  end;
  return sum;
end

exports.f = f;
--[ No side effect ]--
