'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

function f(b, x, _n) do
  while(true) do
    var n = _n;
    if (n > 100000 or !b) do
      return false;
    end else do
      _n = n + 1 | 0;
      continue ;
    end
  end;
end

function or_f(b, x, _n) do
  while(true) do
    var n = _n;
    if (n > 100000) do
      return false;
    end else if (b) do
      return true;
    end else do
      _n = n + 1 | 0;
      continue ;
    end
  end;
end

var suites_000 = --[ tuple ]--[
  "and_tail",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                false,
                f(true, 1, 0)
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "or_tail",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  false,
                  or_f(false, 1, 0)
                ]);
      end)
  ],
  --[ [] ]--0
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("And_or_tailcall_test", suites);

exports.f = f;
exports.or_f = or_f;
exports.suites = suites;
--[  Not a pure module ]--
