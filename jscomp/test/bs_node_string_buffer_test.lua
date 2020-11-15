__console = {log = print};

__Node = require "......lib.js.node";

function f(str) do
  match = __Node.test(str);
  if (match[1]) then do
    __console.log(--[[ tuple ]]{
          "buffer",
          __Buffer.isBuffer(match[2])
        });
    return --[[ () ]]0;
  end else do
    __console.log(--[[ tuple ]]{
          "string",
          match[2]
        });
    return --[[ () ]]0;
  end end 
end end

f("xx");

f((Buffer.from ('xx')));

exports = {};
exports.f = f;
return exports;
--[[  Not a pure module ]]
