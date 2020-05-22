'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

var suites = {
  contents: --[ [] ]--0
};

var test_id = {
  contents: 0
};

function eq(loc, x, y) {
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc + (" id " + String(test_id.contents)),
      (function (param) {
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        })
    ],
    suites.contents
  ];
  return --[ () ]--0;
}

var uu = {
  "'x": 3
};

var uu2 = {
  then: 1,
  catch: 2,
  "'x": 3
};

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
