__console = {log = print};


__console.log("hello");

__console.log("hey");

a = 3;

b = 4;

c = 3;

exports = {};
exports.a = a;
exports.b = b;
exports.c = c;
return exports;
--[[  Not a pure module ]]
