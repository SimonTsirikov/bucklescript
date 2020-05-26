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

function f(x) do
  return --[ tuple ]--[
          x["003"],
          x["50"],
          x["50x"],
          x.__50,
          x.__50x,
          x["50x'"],
          x["x'"]
        ];
end

v = f(do
      "003": 0,
      "50": 1,
      "50x": 2,
      __50: 3,
      __50x: 4,
      "50x'": 5,
      "x'": 6
    end);

eq("File \"gpr_1943_test.ml\", line 30, characters 6-13", --[ tuple ]--[
      0,
      1,
      2,
      3,
      4,
      5,
      6
    ], v);

Mt.from_pair_suites("Gpr_1943_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.v = v;
--[ v Not a pure module ]--
