console = {log = print};


function f(point) do
  y = point.y;
  x = point.x;
  return Math.pow(x * x + y * y, 2);
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
