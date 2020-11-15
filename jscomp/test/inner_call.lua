__console = {log = print};

Inner_define = require "..inner_define";

__console.log(Inner_define.N.add(1, 2));

function f(x) do
  return --[[ tuple ]]{
          Inner_define.N0.f1(x),
          Inner_define.N0.f2(x, x),
          Inner_define.N0.f3(x, x, x),
          Inner_define.N1.f2(x, x)
        };
end end

exports = {};
exports.f = f;
return exports;
--[[  Not a pure module ]]
