'use strict';

Rebind_module = require("./rebind_module.js");

function x(v) do
  if (v == Rebind_module.AA) then do
    return 0;
  end else do
    return 1;
  end end 
end end

exports.x = x;
--[[ No side effect ]]
