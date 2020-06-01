'use strict';

Mt = require("./mt.lua");
List = require("../../lib/js/list.lua");
Block = require("../../lib/js/block.lua");
Curry = require("../../lib/js/curry.lua");

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

v = do
  contents: 0
end;

function Make(U) do
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  return U;
end end

function f(param) do
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  return List;
end end

eq("File \"global_module_alias_test.ml\", line 51, characters 5-12", List.length(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ [] ]]0
          ]
        ]), 2);

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

v.contents = v.contents + 1 | 0;

H = List;

eq("File \"global_module_alias_test.ml\", line 57, characters 5-12", v.contents, 12);

function g(param) do
  return List.length(--[[ :: ]][
              1,
              --[[ :: ]][
                2,
                --[[ :: ]][
                  3,
                  --[[ :: ]][
                    4,
                    --[[ [] ]]0
                  ]
                ]
              ]
            ]);
end end

function xx(param) do
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  v.contents = v.contents + 1 | 0;
  return List;
end end

eq("File \"global_module_alias_test.ml\", line 86, characters 5-12", g(--[[ () ]]0), 4);

V = xx(--[[ () ]]0);

eq("File \"global_module_alias_test.ml\", line 92, characters 5-12", Curry._1(V.length, --[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ]
        ]), 3);

eq("File \"global_module_alias_test.ml\", line 93, characters 5-12", v.contents, 15);

H$1 = f(--[[ () ]]0);

eq("File \"global_module_alias_test.ml\", line 95, characters 5-12", Curry._1(H$1.length, --[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ [] ]]0
          ]
        ]), 2);

eq("File \"global_module_alias_test.ml\", line 96, characters 5-12", v.contents, 21);

Mt.from_pair_suites("Global_module_alias_test", suites.contents);

A = --[[ alias ]]0;

B = --[[ alias ]]0;

C = --[[ alias ]]0;

D = --[[ alias ]]0;

E = --[[ alias ]]0;

F = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.A = A;
exports.B = B;
exports.C = C;
exports.D = D;
exports.E = E;
exports.F = F;
exports.v = v;
exports.Make = Make;
exports.f = f;
exports.H = H;
exports.g = g;
exports.xx = xx;
--[[  Not a pure module ]]
