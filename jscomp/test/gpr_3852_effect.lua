__console = {log = print};


__console.log("hello");

v = 0;

exports = {};
exports.v = v;
return exports;
--[[  Not a pure module ]]
