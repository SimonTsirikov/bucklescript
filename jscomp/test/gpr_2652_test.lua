__console = {log = print};

__Buffer = require "......lib.js.buffer";

foo = __Buffer.contents;

function bar(str) do
  return __Buffer.from(str);
end end

exports = {};
exports.foo = foo;
exports.bar = bar;
return exports;
--[[ No side effect ]]
