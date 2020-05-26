'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

function tst(param) do
  for var i = console.log("hi"), 0 , console.log("hello"), 3 , 1 do
    
  end
  return --[ () ]--0;
end

function test2(param) do
  var v = 0;
  v = 3;
  v = 10;
  for var i = 0 , 1 , 1 do
    
  end
  return v;
end

var suites_000 = --[ tuple ]--[
  "for_order",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                10,
                test2(--[ () ]--0)
              ]);
    end)
];

var suites = --[ :: ]--[
  suites_000,
  --[ [] ]--0
];

Mt.from_pair_suites("For_side_effect_test", suites);

exports.tst = tst;
exports.test2 = test2;
exports.suites = suites;
--[  Not a pure module ]--
