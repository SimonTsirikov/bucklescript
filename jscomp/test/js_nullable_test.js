'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");

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
        end end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end end

function test(dom) do
  elem = dom.getElementById("haha");
  if (elem == null) then do
    return 1;
  end else do
    console.log(elem);
    return 2;
  end end 
end end

function f(x, y) do
  console.log("no inline");
  return x + y | 0;
end end

eq("File \"js_nullable_test.ml\", line 26, characters 7-14", false, false);

eq("File \"js_nullable_test.ml\", line 28, characters 7-14", (f(1, 2) == null), false);

eq("File \"js_nullable_test.ml\", line 30, characters 6-13", (null == null), true);

eq("File \"js_nullable_test.ml\", line 34, characters 3-10", false, false);

Mt.from_pair_suites("Js_nullable_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.test = test;
exports.f = f;
--[  Not a pure module ]--
