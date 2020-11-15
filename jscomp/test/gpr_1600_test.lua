__console = {log = print};


obj = {
  hi = (function(x) do
      __console.log(x);
      return --[[ () ]]0; end
    end)
};

eventObj = {
  events = {},
  empty = (function() do
      return --[[ () ]]0; end
    end),
  push = (function(a) do
      self = this ;
      self.events[0] = a;
      return --[[ () ]]0; end
    end),
  needRebuild = (function() do
      self = this ;
      return #self.events ~= 0; end
    end),
  currentEvents = (function() do
      self = this ;
      return self.events; end
    end)
};

function f(param) do
  return eventObj;
end end

exports = {};
exports.obj = obj;
exports.eventObj = eventObj;
exports.f = f;
return exports;
--[[ obj Not a pure module ]]
