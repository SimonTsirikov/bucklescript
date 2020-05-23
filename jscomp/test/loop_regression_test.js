'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

function f(param) do
  var v = do
    contents: 0
  end;
  var acc = do
    contents: 0
  end;
  var n = 10;
  while(true) do
    if (v.contents > n) do
      return acc.contents;
    end else do
      acc.contents = acc.contents + v.contents | 0;
      v.contents = v.contents + 1 | 0;
      continue ;
    end
  end;
end

var suites_000 = --[ tuple ]--[
  "sum",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                55,
                f(--[ () ]--0)
              ]);
    end)
];

var suites = --[ :: ]--[
  suites_000,
  --[ [] ]--0
];

Mt.from_pair_suites("Loop_regression_test", suites);

exports.f = f;
exports.suites = suites;
--[  Not a pure module ]--
