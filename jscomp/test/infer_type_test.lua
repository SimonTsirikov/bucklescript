__console = {log = print};


hh = {
  hi = 30,
  lo = 20
};

hh.width;

v = {
  hi = 32,
  lo = 3
};

vv = {
  hi = 3,
  lo = 3,
  width = 3
};

u = v.hi;

uu = v.width;

exports = {};
exports.hh = hh;
exports.v = v;
exports.vv = vv;
exports.u = u;
exports.uu = uu;
return exports;
--[[  Not a pure module ]]
