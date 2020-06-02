console.log = print;


function f(x) do
  if (x == 3) then do
    return true;
  end else do
    return x == 4;
  end end 
end end

exports.f = f;
--[[ No side effect ]]
