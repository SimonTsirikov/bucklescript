__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";

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

eq("File \"gpr_1749_test.ml\", line 18, characters 6-13", 0, 0);

Mt.from_pair_suites("Gpr_1749_test", suites.contents);

a = 0;

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a = a;
return exports;
--[[  Not a pure module ]]
