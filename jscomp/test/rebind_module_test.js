'use strict';

var Rebind_module = require("./rebind_module.js");

function x(v) do
  if (v == Rebind_module.AA) do
    return 0;
  end else do
    return 1;
  end
end

exports.x = x;
--[ No side effect ]--
