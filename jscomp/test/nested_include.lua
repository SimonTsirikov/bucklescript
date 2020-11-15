__console = {log = print};


function f(x) do
  return x;
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
