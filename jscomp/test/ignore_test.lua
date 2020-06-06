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

function f(x) do
  return --[[ () ]]0;
end end

function ff(x) do
  console.log(x);
  return --[[ () ]]0;
end end

eq("File \"ignore_test.ml\", line 16, characters 5-12", --[[ () ]]0, --[[ () ]]0);

Mt.from_pair_suites("Ignore_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.ff = ff;
--[[  Not a pure module ]]
