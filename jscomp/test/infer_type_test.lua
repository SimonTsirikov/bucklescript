--[['use strict';]]


hh = do
  hi: 30,
  lo: 20
end;

hh.width;

v = do
  hi: 32,
  lo: 3
end;

vv = do
  hi: 3,
  lo: 3,
  width: 3
end;

u = v.hi;

uu = v.width;

exports.hh = hh;
exports.v = v;
exports.vv = vv;
exports.u = u;
exports.uu = uu;
--[[  Not a pure module ]]
