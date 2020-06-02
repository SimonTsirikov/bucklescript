console = {log = print};


({ })["hi"] = "hello";

console.log("hi");

function f(x) do
  (do
      x: (console.log("hi"), x)
    end).x = x + 1 | 0;
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
--[[  Not a pure module ]]
