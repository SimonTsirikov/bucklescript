'use strict';

$$Node = require("../../lib/js/node.js");

function f(str) do
  match = $$Node.test(str);
  if (match[0]) then do
    console.log(--[[ tuple ]][
          "buffer",
          Buffer.isBuffer(match[1])
        ]);
    return --[[ () ]]0;
  end else do
    console.log(--[[ tuple ]][
          "string",
          match[1]
        ]);
    return --[[ () ]]0;
  end end 
end end

f("xx");

f((Buffer.from ('xx')));

exports.f = f;
--[[  Not a pure module ]]
