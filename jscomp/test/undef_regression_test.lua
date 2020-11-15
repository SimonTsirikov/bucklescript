__console = {log = print};


function f(obj) do
  if (type(obj) == "function") then do
    return --[[ () ]]0;
  end else do
    size = obj.length;
    if (size ~= nil) then do
      __console.log(size);
      return --[[ () ]]0;
    end else do
      return --[[ () ]]0;
    end end 
  end end 
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
