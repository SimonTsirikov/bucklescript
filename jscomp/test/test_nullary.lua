console = {log = print};


function f(param) do
  console.log("hey");
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
