'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

eq("File \"ffi_array_test.ml\", line 12, characters 5-12", [
        1,
        2,
        3,
        4
      ].map((function (x) do
            return x + 1 | 0;
          end)), [
      2,
      3,
      4,
      5
    ]);

Mt.from_pair_suites("Ffi_array_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
