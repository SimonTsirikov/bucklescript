__console = {log = print};

Moduleid = require "#modu";

function f(param) do
  return Moduleid.name;
end end

exports = {};
exports.f = f;
return exports;
--[[ #moduleid Not a pure module ]]
