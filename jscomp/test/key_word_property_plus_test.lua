__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Global_mangles = require "..global_mangles";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

eq("File \"key_word_property_plus_test.ml\", line 10, characters 5-12", {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14
      }.reduce((function(prim, prim_1) do
            return prim + prim_1 | 0;
          end end), 0), ((((((((((((Global_mangles.____dirname + Global_mangles.____filename | 0) + Global_mangles.__clearImmediate | 0) + Global_mangles.__clearInterval | 0) + Global_mangles.__clearTimeout | 0) + Global_mangles.__console | 0) + Global_mangles.__exports | 0) + Global_mangles.__global | 0) + Global_mangles._module | 0) + Global_mangles.__process | 0) + Global_mangles.__require | 0) + Global_mangles.__setImmediate | 0) + Global_mangles.__setInterval | 0) + Global_mangles.__setTimeout | 0);

Mt.from_pair_suites("Key_word_property_plus_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
return exports;
--[[  Not a pure module ]]
