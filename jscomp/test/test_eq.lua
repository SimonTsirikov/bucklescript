console = {log = print};


function f(x, y) do
  return x + y | 0;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
