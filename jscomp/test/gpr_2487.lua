console = {log = print};

Belt_Array = require "../../lib/js/belt_Array";

b = Belt_Array.eq({
      1,
      2,
      3
    }, {
      1,
      2,
      3
    }, (function(prim, prim_1) do
        return prim == prim_1;
      end end));

A = --[[ alias ]]0;

exports = {}
exports.A = A;
exports.b = b;
--[[ b Not a pure module ]]
