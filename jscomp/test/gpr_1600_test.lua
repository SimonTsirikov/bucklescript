console = {log = print};


obj = do
  hi: (function(x) do
      console.log(x);
      return --[[ () ]]0; end
    end)
end;

eventObj = do
  events: {},
  empty: (function() do
      return --[[ () ]]0; end
    end),
  push: (function(a) do
      self = this ;
      self.events[0] = a;
      return --[[ () ]]0; end
    end),
  needRebuild: (function() do
      self = this ;
      return #self.events ~= 0; end
    end),
  currentEvents: (function() do
      self = this ;
      return self.events; end
    end)
end;

function f(param) do
  return eventObj;
end end

exports = {}
exports.obj = obj;
exports.eventObj = eventObj;
exports.f = f;
--[[ obj Not a pure module ]]
