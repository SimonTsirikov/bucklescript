'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Caml_int32 = require("../../lib/js/caml_int32.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function $$(x, y) do
  return x + y | 0;
end

$$$plus = Caml_int32.imul;

eq("File \"dollar_escape_test.ml\", line 20, characters 6-13", 3, 3);

eq("File \"dollar_escape_test.ml\", line 21, characters 6-13", 3, 3);

Mt.from_pair_suites("Dollar_escape_test", suites.contents);

v = 3;

u = 3;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.$$ = $$;
exports.v = v;
exports.$$$plus = $$$plus;
exports.u = u;
--[  Not a pure module ]--
