--[['use strict';]]


function f(x) do
  x.hey = 22;
  return --[[ () ]]0;
end end

exports.f = f;
--[[ No side effect ]]
