__console = {log = print};


function func(state) do
  if (type(state) == "number") then do
    return 0;
  end else do
    return 0 + state[1] | 0;
  end end 
end end

exports = {};
exports.func = func;
return exports;
--[[ No side effect ]]
