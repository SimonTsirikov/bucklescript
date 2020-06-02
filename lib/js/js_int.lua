console = {log = print};


function equal(x, y) do
  return x == y;
end end

max = 2147483647;

min = -2147483648;

exports = {}
exports.equal = equal;
exports.max = max;
exports.min = min;
--[[ No side effect ]]
