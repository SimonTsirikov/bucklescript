console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";

console.log(JSON.stringify(--[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ [] ]]0
            }
          }
        }));

console.log("hey");

suites_000 = --[[ tuple ]]{
  "anything_to_string",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                "3",
                String(3)
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Lib_js_test", suites);

exports = {}
exports.suites = suites;
--[[  Not a pure module ]]