'use strict';

Curry = require("../../lib/js/curry.js");

function mk(fn) do
  return Curry._1(fn, --[ () ]--0);
end

(Curry._1(function ()doconsole.log('should works')end, --[ () ]--0));

console.log((function () do
          return 1;
        end)());

exports.mk = mk;
--[  Not a pure module ]--
