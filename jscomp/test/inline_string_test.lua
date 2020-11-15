__console = {log = print};


__console.log("list");

__console.log("list");

function f(param) do
  if (param ~= nil) then do
    return "Some";
  end else do
    return "None";
  end end 
end end

__console.log(--[[ tuple ]]{
      f(3),
      "None",
      "Some"
    });

__console.log(--[[ tuple ]]{
      "A",
      "A"
    });

exports = {};
return exports;
--[[  Not a pure module ]]
