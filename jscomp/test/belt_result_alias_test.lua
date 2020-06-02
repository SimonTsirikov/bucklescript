--[['use strict';]]

Block = require "../../lib/js/block.lua";
Belt_Result = require "../../lib/js/belt_Result.lua";

Belt_Result.map(--[[ Ok ]]Block.__(0, {"Test"}), (function (r) do
        return "Value: " .. r;
      end end));

Belt_Result.getWithDefault(Belt_Result.map(--[[ Error ]]Block.__(1, {"error"}), (function (r) do
            return "Value: " .. r;
          end end)), "success");

--[[  Not a pure module ]]
