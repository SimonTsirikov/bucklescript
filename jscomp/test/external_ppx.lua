__console = {log = print};

External_ppxGen = require "..external_ppx";

function f(prim) do
  return External_ppxGen.f(prim);
end end

exports = {};
exports.f = f;
return exports;
--[[ ./external_ppx.gen Not a pure module ]]
