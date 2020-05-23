'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var String_set = require("./string_set.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
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

var s = String_set.empty;

for(var i = 0; i <= 99999; ++i)do
  s = String_set.add(String(i), s);
end

eq("File \"string_set_test.ml\", line 16, characters 5-12", String_set.cardinal(s), 100000);

Mt.from_pair_suites("String_set_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
