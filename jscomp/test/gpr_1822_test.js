'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Caml_int32 = require("../../lib/js/caml_int32.js");

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

myShape = --[[ Circle ]]Block.__(0, [10]);

area;

area = myShape.tag and Caml_int32.imul(10, myShape[1]) or 100 * 3.14;

eq("File \"gpr_1822_test.ml\", line 21, characters 6-13", area, 314);

Mt.from_pair_suites("Gpr_1822_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.myShape = myShape;
exports.area = area;
--[[ area Not a pure module ]]
