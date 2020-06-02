console = {log = print};


function f(x) do
  v = x;
  sum = 0;
  while(v > 0) do
    sum = sum + v | 0;
    v = v - 1 | 0;
  end;
  return sum;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
