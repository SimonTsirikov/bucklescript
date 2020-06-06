console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";

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

v = {
  contents = 3
};

function update(param) do
  v.contents = v.contents + 1 | 0;
  return true;
end end

v.contents = v.contents + 1 | 0;

eq("File \"gpr_1762_test.ml\", line 22, characters 6-13", v.contents, 4);

Mt.from_pair_suites("Gpr_1762_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.update = update;
--[[  Not a pure module ]]
