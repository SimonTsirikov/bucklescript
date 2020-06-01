'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");

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

eq("File \"gpr_1749_test.ml\", line 18, characters 6-13", 0, 0);

Mt.from_pair_suites("Gpr_1749_test", suites.contents);

a = 0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a = a;
--[[  Not a pure module ]]
