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

uu = {
  "'x" = 3
};

uu2 = {
  then = 1,
  catch = 2,
  "'x" = 3
};

hh = uu["'x"];

eq("File \"gpr_459_test.ml\", line 25, characters 12-19", hh, 3);

eq("File \"gpr_459_test.ml\", line 28, characters 5-12", --[[ tuple ]]{
      1,
      2,
      3
    }, --[[ tuple ]]{
      uu2.__then,
      uu2.__catch,
      uu2["'x"]
    });

Mt.from_pair_suites("Gpr_459_test", suites.contents);

exports = {};
return exports;
--[[ hh Not a pure module ]]
