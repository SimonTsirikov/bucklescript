'use strict';


function f(x) do
  if (x == 3) do
    return true;
  end else do
    return x == 4;
  end
end

exports.f = f;
--[ No side effect ]--
