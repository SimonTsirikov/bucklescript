console = {log = print};


function f(param) do
  console.error("x");
  console.log(--[[ () ]]0);
  console.log("hi");
  console.log(--[[ () ]]0);
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
