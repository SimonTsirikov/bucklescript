console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Int32 = require "../../lib/js/int32";
Pervasives = require "../../lib/js/pervasives";

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
      loc .. (" id " .. String(test_id.contents)),
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

eq("File \"limits_test.ml\", line 10, characters 5-12", Pervasives.max_int, 2147483647);

eq("File \"limits_test.ml\", line 11, characters 5-12", Pervasives.min_int, (-2147483648));

eq("File \"limits_test.ml\", line 12, characters 5-12", Int32.max_int, 2147483647);

eq("File \"limits_test.ml\", line 13, characters 5-12", Int32.min_int, (-2147483648));

Mt.from_pair_suites("Limits_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
