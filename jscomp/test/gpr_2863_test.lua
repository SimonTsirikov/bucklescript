__console = {log = print};

Belt_MutableSetInt = require "......lib.js.belt_MutableSetInt";

mySet = {
  data = nil
};

Belt_MutableSetInt.add(mySet, 1);

Belt_MutableSetInt.add(mySet, 2);

Belt_MutableSetInt.remove(mySet, 1);

a = 3;

exports = {};
exports.mySet = mySet;
exports.a = a;
return exports;
--[[  Not a pure module ]]
