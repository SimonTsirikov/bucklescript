--[['use strict';]]


function test(x) do
  x.nodeValue = nil;
  return --[[ () ]]0;
end end

exports.test = test;
--[[ No side effect ]]
