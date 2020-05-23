'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var $$String = require("../../lib/js/string.js");

function u(v) do
  return v;
end

var s = $$String;

var N = do
  s: s
end;

function v(x) do
  return #x;
end

var suites_000 = --[ tuple ]--[
  "const",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                1,
                1
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "other",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  3,
                  3
                ]);
      end)
  ],
  --[ [] ]--0
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Module_parameter_test", suites);

var v0 = 1;

exports.u = u;
exports.N = N;
exports.v0 = v0;
exports.v = v;
exports.suites = suites;
--[  Not a pure module ]--
