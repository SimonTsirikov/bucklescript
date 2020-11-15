__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[2];
  x = param[1];
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

u = {
  say = (function(x, y) do
      return x + y | 0; end
    end)
};

v = {
  hi = (function(x, y) do
      self = this ;
      u = {
        x = x
      };
      return self.say(u.x) + y + x; end
    end),
  say = (function(x) do
      self = this ;
      return x * self.x(); end
    end),
  x = (function() do
      return 3; end
    end)
};

p_001 = u.say(1, 2);

p = --[[ tuple ]]{
  3,
  p_001
};

eq("File \"gpr_627_test.ml\", line 26, characters 5-12", p);

eq("File \"gpr_627_test.ml\", line 27, characters 5-12", --[[ tuple ]]{
      v.hi(1, 2),
      6
    });

Mt.from_pair_suites("Gpr_627_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.u = u;
exports.v = v;
return exports;
--[[ u Not a pure module ]]
