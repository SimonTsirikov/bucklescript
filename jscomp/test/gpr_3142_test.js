'use strict';

Mt = require("./mt.js");
Js_mapperRt = require("../../lib/js/js_mapperRt.js");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

jsMapperConstantArray = [
  --[[ tuple ]][
    97,
    "x"
  ],
  --[[ tuple ]][
    98,
    "你"
  ],
  --[[ tuple ]][
    99,
    "我"
  ],
  --[[ tuple ]][
    117,
    "hi"
  ]
];

function tToJs(param) do
  return Js_mapperRt.binarySearch(4, param, jsMapperConstantArray);
end end

function tFromJs(param) do
  return Js_mapperRt.revSearch(4, jsMapperConstantArray, param);
end end

eq("File \"gpr_3142_test.ml\", line 25, characters 6-13", tToJs(--[[ a ]]97), "x");

eq("File \"gpr_3142_test.ml\", line 26, characters 6-13", tToJs(--[[ u ]]117), "hi");

eq("File \"gpr_3142_test.ml\", line 27, characters 6-13", tToJs(--[[ b ]]98), "你");

eq("File \"gpr_3142_test.ml\", line 28, characters 6-13", tToJs(--[[ c ]]99), "我");

eq("File \"gpr_3142_test.ml\", line 30, characters 6-13", tFromJs("x"), --[[ a ]]97);

eq("File \"gpr_3142_test.ml\", line 31, characters 6-13", tFromJs("hi"), --[[ u ]]117);

eq("File \"gpr_3142_test.ml\", line 32, characters 6-13", tFromJs("你"), --[[ b ]]98);

eq("File \"gpr_3142_test.ml\", line 33, characters 6-13", tFromJs("我"), --[[ c ]]99);

eq("File \"gpr_3142_test.ml\", line 34, characters 6-13", tFromJs("xx"), undefined);

Mt.from_pair_suites("Gpr_3142_test", suites.contents);

v = tToJs;

u = tFromJs;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.tToJs = tToJs;
exports.tFromJs = tFromJs;
exports.v = v;
exports.u = u;
--[[  Not a pure module ]]
