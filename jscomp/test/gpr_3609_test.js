'use strict';


function func(state) do
  if (typeof state == "number") do
    return 0;
  end else do
    return 0 + state[0] | 0;
  end
end

exports.func = func;
--[ No side effect ]--
