__console = {log = print};


function x(v){return [v]}
;

x("3");

v = x(3);

xxx = x;

u = xxx(3);

xx = xxx("3");

exports = {};
exports.v = v;
exports.xxx = xxx;
exports.u = u;
exports.xx = xx;
return exports;
--[[  Not a pure module ]]
