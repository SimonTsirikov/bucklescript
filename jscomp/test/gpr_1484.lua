console = {log = print};


function test(x) do
  x.nodeValue = nil;
  return --[[ () ]]0;
end end

exports = {}
exports.test = test;
--[[ No side effect ]]