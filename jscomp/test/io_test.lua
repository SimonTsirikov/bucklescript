__console = {log = print};


function f(param) do
  __console.error("x");
  __console.log(--[[ () ]]0);
  __console.log("hi");
  __console.log(--[[ () ]]0);
  return --[[ () ]]0;
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
