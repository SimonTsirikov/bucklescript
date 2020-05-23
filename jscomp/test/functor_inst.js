'use strict';


function say(x, y) do
  return x + y | 0;
end

exports.say = say;
--[ No side effect ]--
