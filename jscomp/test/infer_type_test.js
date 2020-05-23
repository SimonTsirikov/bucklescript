'use strict';


var hh = do
  hi: 30,
  lo: 20
end;

hh.width;

var v = do
  hi: 32,
  lo: 3
end;

var vv = do
  hi: 3,
  lo: 3,
  width: 3
end;

var u = v.hi;

var uu = v.width;

exports.hh = hh;
exports.v = v;
exports.vv = vv;
exports.u = u;
exports.uu = uu;
--[  Not a pure module ]--
