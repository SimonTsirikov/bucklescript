--[['use strict';]]

Belt_Array = require "../../lib/js/belt_Array.lua";

b = Belt_Array.eq({
      1,
      2,
      3
    }, {
      1,
      2,
      3
    }, (function (prim, prim$1) do
        return prim == prim$1;
      end end));

A = --[[ alias ]]0;

exports.A = A;
exports.b = b;
--[[ b Not a pure module ]]
