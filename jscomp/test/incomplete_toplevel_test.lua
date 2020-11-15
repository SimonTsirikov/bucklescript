__console = {log = print};


function f(param) do
  __console.log("no inline");
  return --[[ tuple ]]{
          1,
          2,
          3
        };
end end

match = f(--[[ () ]]0);

a = match[1];

b = match[2];

c = match[3];

exports = {};
exports.f = f;
exports.a = a;
exports.b = b;
exports.c = c;
return exports;
--[[ match Not a pure module ]]
