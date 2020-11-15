__console = {log = print};


function f(param) do
  __console.log("hey");
  return --[[ () ]]0;
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
