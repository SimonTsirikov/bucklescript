--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

eq("File \"bs_string_test.ml\", line 11, characters 5-12", "ghso ghso g".split(" ").reduce((function (x, y) do
            return x .. ("-" .. y);
          end end), ""), "-ghso-ghso-g");

Mt.from_pair_suites("Bs_string_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
