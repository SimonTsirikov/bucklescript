'use strict';

FileJs = require("./File.js");

foo = FileJs.foo;

function foo2(prim) do
  return FileJs.foo2(prim);
end

bar = foo;

exports.foo = foo;
exports.foo2 = foo2;
exports.bar = bar;
--[ foo Not a pure module ]--
