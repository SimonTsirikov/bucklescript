console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[1];
  x = param[0];
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
  x = (function() do
      return 3; end
    end),
  say = (function(x) do
      self = this ;
      return x * self.x(); end
    end),
  hi = (function(x, y) do
      self = this ;
      return self.say(x) + y; end
    end)
};

v2 = {
  hi = (function(x, y) do
      self = this ;
      return self.say(x) + y; end
    end),
  say = (function(x) do
      self = this ;
      return x * self.x(); end
    end),
  x = (function() do
      return 3; end
    end)
};

v3 = {
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

v4 = {
  hi = (function(x, y) do
      return x + y; end
    end),
  say = (function(x) do
      return x; end
    end),
  x = (function() do
      return 1; end
    end)
};

collection = {
  v,
  v2,
  v3,
  v4
};

eq("File \"ppx_this_obj_test.ml\", line 59, characters 5-12", --[[ tuple ]]{
      11,
      v.hi(3, 2)
    });

eq("File \"ppx_this_obj_test.ml\", line 60, characters 5-12", --[[ tuple ]]{
      11,
      v2.hi(3, 2)
    });

Mt.from_pair_suites("Ppx_this_obj_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.v2 = v2;
exports.v3 = v3;
exports.v4 = v4;
exports.collection = collection;
--[[ v Not a pure module ]]
