console = {log = print};

Moduleid = require "#modu";

function f(param) do
  return Moduleid.name;
end end

exports = {}
exports.f = f;
--[[ #moduleid Not a pure module ]]
