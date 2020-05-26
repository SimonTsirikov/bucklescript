'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Pervasives = require("../../lib/js/pervasives.js");

suites_000 = --[ tuple ]--[
  "string_of_float_1",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                "10.",
                Pervasives.string_of_float(10)
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "string_of_int",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  "10",
                  String(10)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "valid_float_lexem",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    "10.",
                    Pervasives.valid_float_lexem("10")
                  ]);
        end)
    ],
    --[ [] ]--0
  ]
];

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Of_string_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
