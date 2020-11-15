__console = {log = print};


function f(x) do
  return x;
end end

function f2(x) do
  return x;
end end

exports = {};
exports.f = f;
exports.f2 = f2;
return exports;
--[[ No side effect ]]
