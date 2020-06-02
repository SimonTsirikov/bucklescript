--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
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

u = do
  say: (function (x, y) do
      return x + y | 0; end
    end)
end;

v = do
  hi: (function (x, y) do
      self = this ;
      u = do
        x: x
      end;
      return self.say(u.x) + y + x; end
    end),
  say: (function (x) do
      self = this ;
      return x * self.x(); end
    end),
  x: (function () do
      return 3; end
    end)
end;

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

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.u = u;
exports.v = v;
--[[ u Not a pure module ]]
