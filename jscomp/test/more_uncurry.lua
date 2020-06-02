console.log = print;


function f(x, y, param) do
  if (param ~= undefined) then do
    return (x + y | 0) + param | 0;
  end else do
    return x + y | 0;
  end end 
end end

exports.f = f;
--[[ No side effect ]]
