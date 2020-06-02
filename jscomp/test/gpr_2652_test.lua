console.log = print;

__Buffer = require "../../lib/js/buffer";

foo = __Buffer.contents;

function bar(str) do
  return Buffer.from(str);
end end

exports.foo = foo;
exports.bar = bar;
--[[ No side effect ]]
