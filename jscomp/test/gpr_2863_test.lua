'use strict';

Belt_MutableSetInt = require("../../lib/js/belt_MutableSetInt.lua");

mySet = do
  data: null
end;

Belt_MutableSetInt.add(mySet, 1);

Belt_MutableSetInt.add(mySet, 2);

Belt_MutableSetInt.remove(mySet, 1);

a = 3;

exports.mySet = mySet;
exports.a = a;
--[[  Not a pure module ]]
