--[['use strict';]]


function f(resp) do
  resp.statusCode = 200;
  resp.hi = "hi";
  return --[[ () ]]0;
end end

exports.f = f;
--[[ No side effect ]]
