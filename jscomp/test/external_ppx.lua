--[['use strict';]]

External_ppxGen = require "./external_ppx";

function f(prim) do
  return External_ppxGen.f(prim);
end end

exports.f = f;
--[[ ./external_ppx.gen Not a pure module ]]
