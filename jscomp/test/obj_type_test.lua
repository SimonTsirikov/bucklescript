__console = {log = print};


function f(u) do
  return u;
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
