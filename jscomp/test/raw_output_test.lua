console = {log = print};

Curry = require "../../lib/js/curry";

function mk(fn) do
  return Curry._1(fn, --[[ () ]]0);
end end

(Curry._1(function()doconsole.log('should works')end, --[[ () ]]0));

console.log((function() do
          return 1;
        end end)());

exports = {}
exports.mk = mk;
--[[  Not a pure module ]]