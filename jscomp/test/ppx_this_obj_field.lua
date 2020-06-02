console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";

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

v5 = do
  x: 3,
  y: 3,
  setY: (function(v) do
      self = this ;
      self.y = 2;
      return --[[ tuple ]]{
              self.y,
              v
            }; end
    end),
  say: (function() do
      self = this ;
      return self.x + self.y | 0; end
    end),
  hihi: (function(u) do
      self = this ;
      return self.x + self.say() | 0; end
    end),
  bark: (function() do
      console.log("bark");
      return --[[ () ]]0; end
    end),
  xz: (function() do
      return 3; end
    end)
end;

v = do
  x: 3,
  y: 0,
  reset: (function() do
      self = this ;
      self.y = 0;
      return --[[ () ]]0; end
    end),
  incr: (function() do
      self = this ;
      self.y = self.y + 1 | 0;
      return --[[ () ]]0; end
    end),
  getY: (function() do
      self = this ;
      return self.y; end
    end),
  say: (function() do
      self = this ;
      return self.x + self.y | 0; end
    end)
end;

u = do
  incr: (function() do
      console.log("hey");
      return --[[ () ]]0; end
    end),
  getY: (function() do
      return 3; end
    end),
  say: (function() do
      return 7; end
    end)
end;

test_type_001 = --[[ :: ]]{
  v,
  --[[ [] ]]0
};

test_type = --[[ :: ]]{
  u,
  test_type_001
};

z = do
  x: do
    contents: 3
  end,
  setX: (function(x) do
      self = this ;
      self.x.contents = x;
      return --[[ () ]]0; end
    end),
  getX: (function() do
      self = this ;
      return self.x.contents; end
    end)
end;

eventObj = do
  events: {},
  empty: (function() do
      self = this ;
      a = self.events;
      a.splice(0);
      return --[[ () ]]0; end
    end),
  push: (function(a) do
      self = this ;
      xs = self.events;
      xs.push(a);
      return --[[ () ]]0; end
    end),
  needRebuild: (function() do
      self = this ;
      return #self.events ~= 0; end
    end)
end;

function test__(x) do
  return eventObj.push(x);
end end

zz = do
  x: 3,
  setX: (function(x) do
      self = this ;
      self.x = x;
      return --[[ () ]]0; end
    end),
  getX: (function() do
      self = this ;
      return self.x; end
    end)
end;

test_type2_001 = --[[ :: ]]{
  zz,
  --[[ [] ]]0
};

test_type2 = --[[ :: ]]{
  z,
  test_type2_001
};

eq("File \"ppx_this_obj_field.ml\", line 92, characters 5-12", --[[ tuple ]]{
      6,
      v5.say()
    });

a = v.say();

v.incr();

b = v.say();

v.incr();

c = v.say();

v.incr();

eq("File \"ppx_this_obj_field.ml\", line 99, characters 5-12", --[[ tuple ]]{
      --[[ tuple ]]{
        3,
        4,
        5
      },
      --[[ tuple ]]{
        a,
        b,
        c
      }
    });

aa = z.getX();

z.setX(32);

bb = z.getX();

eq("File \"ppx_this_obj_field.ml\", line 103, characters 5-12", --[[ tuple ]]{
      --[[ tuple ]]{
        3,
        32
      },
      --[[ tuple ]]{
        aa,
        bb
      }
    });

Mt.from_pair_suites("Ppx_this_obj_field", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v5 = v5;
exports.v = v;
exports.u = u;
exports.test_type = test_type;
exports.z = z;
exports.eventObj = eventObj;
exports.test__ = test__;
exports.zz = zz;
exports.test_type2 = test_type2;
--[[ v5 Not a pure module ]]
