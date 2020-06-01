'use strict';

$$Buffer = require("../../lib/js/buffer.lua");

foo = $$Buffer.contents;

function bar(str) do
  return Buffer.from(str);
end end

exports.foo = foo;
exports.bar = bar;
--[[ No side effect ]]
