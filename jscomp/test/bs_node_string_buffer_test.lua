console.log = print;

__Node = require "../../lib/js/node";

function f(str) do
  match = __Node.test(str);
  if (match[0]) then do
    console.log(--[[ tuple ]]{
          "buffer",
          Buffer.isBuffer(match[1])
        });
    return --[[ () ]]0;
  end else do
    console.log(--[[ tuple ]]{
          "string",
          match[1]
        });
    return --[[ () ]]0;
  end end 
end end

f("xx");

f((Buffer.from ('xx')));

exports.f = f;
--[[  Not a pure module ]]
