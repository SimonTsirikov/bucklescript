--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_obj = require "../../lib/js/caml_obj.lua";

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

function f(param) do
  x = new Date();
  y = new Date();
  return --[[ tuple ]][
          Caml_obj.caml_greaterthan(y, x),
          Caml_obj.caml_lessthan(y, x),
          true
        ];
end end

match = f(--[[ () ]]0);

a2 = match[2];

a1 = match[1];

a0 = match[0];

console.log(a0, a1);

eq("File \"gpr_1817_test.ml\", line 19, characters 6-13", a2, true);

Mt.from_pair_suites("Gpr_1817_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
--[[ match Not a pure module ]]
