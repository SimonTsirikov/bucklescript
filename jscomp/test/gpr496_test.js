'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_primitive = require("../../lib/js/caml_primitive.js");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

expected = --[[ tuple ]][
  false,
  false,
  true,
  true,
  -1,
  1,
  0,
  0
];

expected2 = --[[ tuple ]][
  false,
  false,
  true,
  true,
  -1,
  1,
  0,
  0
];

u = --[[ tuple ]][
  false,
  false,
  true,
  true,
  -1,
  1,
  0,
  0
];

eq("File \"gpr496_test.ml\", line 42, characters 12-19", expected, u);

eq("File \"gpr496_test.ml\", line 44, characters 12-19", expected, expected2);

function ff(x, y) do
  return Caml_primitive.caml_bool_min(x, Curry._1(y, --[[ () ]]0));
end end

eq("File \"gpr496_test.ml\", line 48, characters 5-12", true < false and true or false, false);

Mt.from_pair_suites("Gpr496_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.expected = expected;
exports.expected2 = expected2;
exports.u = u;
exports.ff = ff;
--[[ expected Not a pure module ]]
