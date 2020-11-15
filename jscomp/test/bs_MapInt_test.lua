__console = {log = print};

Belt_MapInt = require "......lib.js.belt_MapInt";

function should(b) do
  if (b) then do
    return 0;
  end else do
    error(new __Error("IMPOSSIBLE"))
  end end 
end end

function test(param) do
  m = Belt_MapInt.empty;
  for i = 0 , 999999 , 1 do
    m = Belt_MapInt.set(m, i, i);
  end
  for i_1 = 0 , 999999 , 1 do
    should(Belt_MapInt.get(m, i_1) ~= nil);
  end
  for i_2 = 0 , 999999 , 1 do
    m = Belt_MapInt.remove(m, i_2);
  end
  return should(Belt_MapInt.isEmpty(m));
end end

test(--[[ () ]]0);

M = --[[ alias ]]0;

exports = {};
exports.should = should;
exports.M = M;
exports.test = test;
return exports;
--[[  Not a pure module ]]
