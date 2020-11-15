__console = {log = print};


v = 0;

v = v + 1 | 0;

__console.log(__String(v));

function unuse_v(param) do
  return 35;
end end

h = unuse_v;

exports = {};
exports.h = h;
return exports;
--[[  Not a pure module ]]
