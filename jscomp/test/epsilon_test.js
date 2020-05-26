'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Pervasives = require("../../lib/js/pervasives.js");

v = (Number.EPSILON?Number.EPSILON:2.220446049250313e-16);

suites_000 = --[ tuple ]--[
  "epsilon",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                Pervasives.epsilon_float,
                v
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "raw_epsilon",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  2.220446049250313e-16,
                  v
                ]);
      end)
  ],
  --[ [] ]--0
];

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Epsilon_test", suites);

exports.v = v;
exports.suites = suites;
--[ v Not a pure module ]--
