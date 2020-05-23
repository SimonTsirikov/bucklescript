'use strict';

var SysBluebird = require("sys-bluebird");

function f(p) do
  return p.catch(3);
end

var p = new SysBluebird.Promise();

p.then((function (x) do
          return x + 3 | 0;
        end)).catch((function (reason) do
        return reason;
      end));

var u = do
  then: 3,
  catch: 32
end;

var uu = do
  "'x": 3
end;

var hh = uu["'x"];

exports.f = f;
exports.u = u;
exports.uu = uu;
exports.hh = hh;
--[ p Not a pure module ]--
