'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");

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

function f(x) do
  console.log(x);
  console.log(List.length(x));
  return List;
end end

h = f(--[[ [] ]]0);

a = Curry._1(h.length, --[[ :: ]][
      1,
      --[[ :: ]][
        2,
        --[[ :: ]][
          3,
          --[[ [] ]]0
        ]
      ]
    ]);

eq("File \"module_alias_test.ml\", line 30, characters 6-13", a, 3);

Mt.from_pair_suites("Module_alias_test", suites.contents);

N = --[[ alias ]]0;

V = --[[ alias ]]0;

J = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.N = N;
exports.V = V;
exports.J = J;
exports.f = f;
exports.a = a;
--[[ h Not a pure module ]]
