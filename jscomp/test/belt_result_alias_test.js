'use strict';

var Block = require("../../lib/js/block.js");
var Belt_Result = require("../../lib/js/belt_Result.js");

Belt_Result.map(--[ Ok ]--Block.__(0, ["Test"]), (function (r) do
        return "Value: " .. r;
      end));

Belt_Result.getWithDefault(Belt_Result.map(--[ Error ]--Block.__(1, ["error"]), (function (r) do
            return "Value: " .. r;
          end)), "success");

--[  Not a pure module ]--
