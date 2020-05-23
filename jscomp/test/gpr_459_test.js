'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
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

var uu = do
  "'x": 3
end;

var uu2 = do
  then: 1,
  catch: 2,
  "'x": 3
end;

var hh = uu["'x"];

eq("File \"gpr_459_test.ml\", line 25, characters 12-19", hh, 3);

eq("File \"gpr_459_test.ml\", line 28, characters 5-12", --[ tuple ]--[
      1,
      2,
      3
    ], --[ tuple ]--[
      uu2.then,
      uu2.catch,
      uu2["'x"]
    ]);

Mt.from_pair_suites("Gpr_459_test", suites.contents);

--[ hh Not a pure module ]--
