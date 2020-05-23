'use strict';


var obj = {
  hi: (function (x) {
      console.log(x);
      return --[ () ]--0;
    })
};

var eventObj = {
  events: [],
  empty: (function () {
      return --[ () ]--0;
    }),
  push: (function (a) {
      var self = this ;
      self.events[0] = a;
      return --[ () ]--0;
    }),
  needRebuild: (function () {
      var self = this ;
      return #self.events ~= 0;
    }),
  currentEvents: (function () {
      var self = this ;
      return self.events;
    })
};

function f(param) {
  return eventObj;
}

exports.obj = obj;
exports.eventObj = eventObj;
exports.f = f;
--[ obj Not a pure module ]--
