'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
JoinClasses = require("./joinClasses");
Caml_splice_call = require("../../lib/js/caml_splice_call.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end end

function joinClasses(prim) do
  return Caml_splice_call.spliceApply(JoinClasses, [prim]);
end end

a = JoinClasses(1, 2, 3);

pair = --[ tuple ]--[
  a,
  6
];

console.log(pair);

eq("File \"module_splice_test.ml\", line 21, characters 5-12", pair);

Mt.from_pair_suites("Module_splice_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.joinClasses = joinClasses;
exports.a = a;
--[ a Not a pure module ]--
