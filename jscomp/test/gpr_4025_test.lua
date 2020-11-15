__console = {log = print};


({ })["hi"] = "hello";

__console.log("hi");

function f(x) do
  ({
      x = (__console.log("hi"), x)
    }).x = x + 1 | 0;
  return --[[ () ]]0;
end end

exports = {};
exports.f = f;
return exports;
--[[  Not a pure module ]]
