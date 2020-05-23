'use strict';


var v = do
  x: (function () do
      return 3;
    end),
  say: (function (x) do
      var self = this ;
      return self.x() + x | 0;
    end)
end;

var u = v.x() + v.say(3) | 0;

exports.v = v;
exports.u = u;
--[ v Not a pure module ]--
