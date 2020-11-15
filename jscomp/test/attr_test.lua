__console = {log = print};


function u(x, y) do
  return x + y | 0;
end end

h = u(1, 2);

function max2(x, y) do
  return x + y;
end end

hh = max2(1, 2);

function f(x) do
  des(x, (function() do
          __console.log("hei");
          return --[[ () ]]0;
        end end));
  return --[[ () ]]0;
end end

exports = {};
exports.u = u;
exports.h = h;
exports.max2 = max2;
exports.hh = hh;
exports.f = f;
return exports;
--[[ h Not a pure module ]]
