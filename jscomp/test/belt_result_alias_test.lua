console = {log = print};

Block = require "../../lib/js/block";
Belt_Result = require "../../lib/js/belt_Result";

Belt_Result.map(--[[ Ok ]]Block.__(0, {"Test"}), (function(r) do
        return "Value: " .. r;
      end end));

Belt_Result.getWithDefault(Belt_Result.map(--[[ Error ]]Block.__(1, {"error"}), (function(r) do
            return "Value: " .. r;
          end end)), "success");

exports = {}
--[[  Not a pure module ]]
