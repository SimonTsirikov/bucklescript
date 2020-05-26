'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");

g = 7;

h = do
  contents: 0
end;

function g1(x, y) do
  u = x + y | 0;
  h.contents = h.contents + 1 | 0;
  return (function (xx, yy) do
      return (xx + yy | 0) + u | 0;
    end);
end

u = 8;

x = (function (z) do
      return u + z | 0;
    end)(6);

partial_arg = g1(3, 4);

function v(param) do
  return partial_arg(6, param);
end

suites_000 = --[ tuple ]--[
  "curry",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                g,
                7
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "curry2",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  14,
                  (Curry._1(v, 1), Curry._1(v, 1))
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "curry3",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    14
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "File \"ari_regress_test.ml\", line 20, characters 4-11",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      h.contents,
                      1
                    ]);
          end)
      ],
      --[ [] ]--0
    ]
  ]
];

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Ari_regress_test", suites);

--[ x Not a pure module ]--
