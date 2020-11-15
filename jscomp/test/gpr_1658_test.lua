__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Js_types = require "......lib.js.js_types";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

eq("File \"gpr_1658_test.ml\", line 11, characters 7-14", nil, nil);

match = Js_types.classify(nil);

if (type(match) == "number" and match == 2) then do
  eq("File \"gpr_1658_test.ml\", line 14, characters 11-18", true, true);
end else do
  eq("File \"gpr_1658_test.ml\", line 16, characters 11-18", true, false);
end end 

eq("File \"gpr_1658_test.ml\", line 17, characters 7-14", true, Js_types.test(nil, --[[ Null ]]1));

Mt.from_pair_suites("File \"gpr_1658_test.ml\", line 19, characters 22-29", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
return exports;
--[[  Not a pure module ]]
