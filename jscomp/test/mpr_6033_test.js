'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var CamlinternalLazy = require("../../lib/js/camlinternalLazy.js");

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

function f(x) do
  var y = CamlinternalLazy.force(x);
  return y .. "abc";
end

var x = "def";

CamlinternalLazy.force(x);

var u = f(x);

eq("File \"mpr_6033_test.ml\", line 20, characters 6-13", u, "defabc");

Mt.from_pair_suites("Mpr_6033_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.u = u;
--[  Not a pure module ]--
