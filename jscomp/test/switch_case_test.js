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
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function f(x) do
  local ___conditional___=(x);
  do
     if ___conditional___ = "xx\"" then do
        return 1;end end end 
     if ___conditional___ = "xx'''" then do
        return 0;end end end 
     if ___conditional___ = "xx\\\"" then do
        return 2;end end end 
     if ___conditional___ = "xx\\\"\"" then do
        return 3;end end end 
     do
    else do
      return 4;
      end end
      
  end
end

eq("File \"switch_case_test.ml\", line 19, characters 7-14", f("xx'''"), 0);

eq("File \"switch_case_test.ml\", line 20, characters 7-14", f("xx\""), 1);

eq("File \"switch_case_test.ml\", line 21, characters 7-14", f("xx\\\""), 2);

eq("File \"switch_case_test.ml\", line 22, characters 7-14", f("xx\\\"\""), 3);

Mt.from_pair_suites("Switch_case_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
--[  Not a pure module ]--
