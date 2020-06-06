console = {log = print};


console.log("list");

console.log("list");

function f(param) do
  if (param ~= nil) then do
    return "Some";
  end else do
    return "None";
  end end 
end end

console.log(--[[ tuple ]]{
      f(3),
      "None",
      "Some"
    });

console.log(--[[ tuple ]]{
      "A",
      "A"
    });

exports = {}
--[[  Not a pure module ]]
