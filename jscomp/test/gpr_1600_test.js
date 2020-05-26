'use strict';


obj = do
  hi: (function (x) do
      console.log(x);
      return --[ () ]--0;
    end)
end;

eventObj = do
  events: [],
  empty: (function () do
      return --[ () ]--0;
    end),
  push: (function (a) do
      self = this ;
      self.events[0] = a;
      return --[ () ]--0;
    end),
  needRebuild: (function () do
      self = this ;
      return #self.events ~= 0;
    end),
  currentEvents: (function () do
      self = this ;
      return self.events;
    end)
end;

function f(param) do
  return eventObj;
end

exports.obj = obj;
exports.eventObj = eventObj;
exports.f = f;
--[ obj Not a pure module ]--
