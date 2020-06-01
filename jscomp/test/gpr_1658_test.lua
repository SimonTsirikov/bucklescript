'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Js_types = require("../../lib/js/js_types.lua");

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

eq("File \"gpr_1658_test.ml\", line 11, characters 7-14", null, null);

match = Js_types.classify(null);

if (typeof match == "number" and match == 2) then do
  eq("File \"gpr_1658_test.ml\", line 14, characters 11-18", true, true);
end else do
  eq("File \"gpr_1658_test.ml\", line 16, characters 11-18", true, false);
end end 

eq("File \"gpr_1658_test.ml\", line 17, characters 7-14", true, Js_types.test(null, --[[ Null ]]1));

Mt.from_pair_suites("File \"gpr_1658_test.ml\", line 19, characters 22-29", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
