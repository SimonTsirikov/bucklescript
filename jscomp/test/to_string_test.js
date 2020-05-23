'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Pervasives = require("../../lib/js/pervasives.js");

var ff = Pervasives.string_of_float;

function f(v) do
  return String(v);
end

Mt.from_pair_suites("To_string_test", --[ :: ]--[
      --[ tuple ]--[
        "File \"to_string_test.ml\", line 7, characters 2-9",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      Pervasives.string_of_float(Pervasives.infinity),
                      "inf"
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "File \"to_string_test.ml\", line 8, characters 1-8",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        Pervasives.string_of_float(Pervasives.neg_infinity),
                        "-inf"
                      ]);
            end)
        ],
        --[ [] ]--0
      ]
    ]);

exports.ff = ff;
exports.f = f;
--[  Not a pure module ]--
