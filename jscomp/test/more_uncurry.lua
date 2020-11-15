__console = {log = print};


function f(x, y, param) do
  if (param ~= nil) then do
    return (x + y | 0) + param | 0;
  end else do
    return x + y | 0;
  end end 
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
