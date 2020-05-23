'use strict';

var Mt = require("./mt.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

var others = --[ tuple ]--[
  0,
  0,
  1,
  1,
  2e3
];

eq("File \"gpr_3549_test.ml\", line 18, characters 5-12", 7.0, 7);

eq("File \"gpr_3549_test.ml\", line 19, characters 5-12", 2e3, 2000);

eq("File \"gpr_3549_test.ml\", line 20, characters 5-12", 0.2, 0.2);

eq("File \"gpr_3549_test.ml\", line 21, characters 5-12", 32, 32);

eq("File \"gpr_3549_test.ml\", line 22, characters 5-12", others, --[ tuple ]--[
      0.0,
      0.0,
      1.0,
      1.0,
      2e3
    ]);

Mt.from_pair_suites("Gpr_3549_test", suites.contents);

var u = 32;

var x = 7.0;

var y = 2e3;

var z = 0.2;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.u = u;
exports.x = x;
exports.y = y;
exports.z = z;
exports.others = others;
--[  Not a pure module ]--
