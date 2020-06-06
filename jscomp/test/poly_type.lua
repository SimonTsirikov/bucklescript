console = {log = print};


function f(x) do
  x.pushState(3, "x");
  return x.pushState(nil, "x");
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
