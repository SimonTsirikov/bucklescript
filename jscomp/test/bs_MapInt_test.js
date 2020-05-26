'use strict';

var Belt_MapInt = require("../../lib/js/belt_MapInt.js");

function should(b) do
  if (b) then do
    return 0;
  end else do
    throw new Error("IMPOSSIBLE");
  end end 
end

function test(param) do
  var m = Belt_MapInt.empty;
  for var i = 0 , 999999 , 1 do
    m = Belt_MapInt.set(m, i, i);
  end
  for var i$1 = 0 , 999999 , 1 do
    should(Belt_MapInt.get(m, i$1) ~= undefined);
  end
  for var i$2 = 0 , 999999 , 1 do
    m = Belt_MapInt.remove(m, i$2);
  end
  return should(Belt_MapInt.isEmpty(m));
end

test(--[ () ]--0);

var M = --[ alias ]--0;

exports.should = should;
exports.M = M;
exports.test = test;
--[  Not a pure module ]--
