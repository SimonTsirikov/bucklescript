__console = {log = print};


h = x(3);

hh = x(3);

function f(x, y) do
  return x .. y;
end end

exports = {};
exports.h = h;
exports.hh = hh;
exports.f = f;
return exports;
--[[ h Not a pure module ]]
