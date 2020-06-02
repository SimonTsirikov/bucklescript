console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Stack = require "../../lib/js/stack";

function to_list(v) do
  acc = --[[ [] ]]0;
  while(v.c ~= --[[ [] ]]0) do
    acc = --[[ :: ]]{
      Stack.pop(v),
      acc
    };
  end;
  return List.rev(acc);
end end

function v(param) do
  v_1 = do
    c: --[[ [] ]]0,
    len: 0
  end;
  Stack.push(3, v_1);
  Stack.push(4, v_1);
  Stack.push(1, v_1);
  return to_list(v_1);
end end

suites_000 = --[[ tuple ]]{
  "push_test",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                --[[ :: ]]{
                  1,
                  --[[ :: ]]{
                    4,
                    --[[ :: ]]{
                      3,
                      --[[ [] ]]0
                    }
                  }
                },
                v(--[[ () ]]0)
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Stack_test", suites);

exports = {}
exports.to_list = to_list;
exports.v = v;
exports.suites = suites;
--[[  Not a pure module ]]
