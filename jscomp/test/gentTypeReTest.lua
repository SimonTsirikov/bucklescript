__console = {log = print};

GentTypeReTestGen = require "..gentTypeReTest";

function f(prim) do
  return GentTypeReTestGen.f(prim);
end end

exports = {};
exports.f = f;
return exports;
--[[ ./gentTypeReTest.gen Not a pure module ]]
