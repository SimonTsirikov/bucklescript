--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";

function f(param) do
  v = do
    contents: 0
  end;
  acc = do
    contents: 0
  end;
  n = 10;
  while(true) do
    if (v.contents > n) then do
      return acc.contents;
    end else do
      acc.contents = acc.contents + v.contents | 0;
      v.contents = v.contents + 1 | 0;
      continue ;
    end end 
  end;
end end

suites_000 = --[[ tuple ]]{
  "sum",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                55,
                f(--[[ () ]]0)
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Loop_regression_test", suites);

exports.f = f;
exports.suites = suites;
--[[  Not a pure module ]]
