__console = {log = print};

FileJs = require "..Fil";

foo = FileJs.foo;

function foo2(prim) do
  return FileJs.foo2(prim);
end end

bar = foo;

exports = {};
exports.foo = foo;
exports.foo2 = foo2;
exports.bar = bar;
return exports;
--[[ foo Not a pure module ]]
