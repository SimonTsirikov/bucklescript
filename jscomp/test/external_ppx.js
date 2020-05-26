'use strict';

External_ppxGen = require("./external_ppx.gen");

function f(prim) do
  return External_ppxGen.f(prim);
end

exports.f = f;
--[ ./external_ppx.gen Not a pure module ]--
