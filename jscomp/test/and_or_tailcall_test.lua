--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";

function f(b, x, _n) do
  while(true) do
    n = _n;
    if (n > 100000 or not b) then do
      return false;
    end else do
      _n = n + 1 | 0;
      continue ;
    end end 
  end;
end end

function or_f(b, x, _n) do
  while(true) do
    n = _n;
    if (n > 100000) then do
      return false;
    end else if (b) then do
      return true;
    end else do
      _n = n + 1 | 0;
      continue ;
    end end  end 
  end;
end end

suites_000 = --[[ tuple ]]{
  "and_tail",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                false,
                f(true, 1, 0)
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "or_tail",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  false,
                  or_f(false, 1, 0)
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("And_or_tailcall_test", suites);

exports.f = f;
exports.or_f = or_f;
exports.suites = suites;
--[[  Not a pure module ]]
