--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
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

function hi (cb){
    cb ();
    return 0;
}
;

xs = do
  contents: --[[ [] ]]0
end;

hi((function () do
        xs.contents = --[[ :: ]]{
          --[[ () ]]0,
          xs.contents
        };
        return --[[ () ]]0;
      end end));

hi((function () do
        xs.contents = --[[ :: ]]{
          --[[ () ]]0,
          xs.contents
        };
        return --[[ () ]]0;
      end end));

eq("File \"bs_auto_uncurry_test.ml\", line 27, characters 7-14", xs.contents, --[[ :: ]]{
      --[[ () ]]0,
      --[[ :: ]]{
        --[[ () ]]0,
        --[[ [] ]]0
      }
    });

eq("File \"bs_auto_uncurry_test.ml\", line 33, characters 7-14", {
        1,
        2,
        3
      }.map((function (x) do
            return x + 1 | 0;
          end end)), {
      2,
      3,
      4
    });

eq("File \"bs_auto_uncurry_test.ml\", line 36, characters 7-14", {
        1,
        2,
        3
      }.map((function (x) do
            return x + 1 | 0;
          end end)), {
      2,
      3,
      4
    });

eq("File \"bs_auto_uncurry_test.ml\", line 40, characters 7-14", {
        1,
        2,
        3
      }.reduce((function (prim, prim$1) do
            return prim + prim$1 | 0;
          end end), 0), 6);

eq("File \"bs_auto_uncurry_test.ml\", line 44, characters 7-14", {
        1,
        2,
        3
      }.reduce((function (x, y, i) do
            return (x + y | 0) + i | 0;
          end end), 0), 9);

eq("File \"bs_auto_uncurry_test.ml\", line 48, characters 7-14", {
        1,
        2,
        3
      }.some((function (x) do
            return x < 1;
          end end)), false);

eq("File \"bs_auto_uncurry_test.ml\", line 52, characters 7-14", {
        1,
        2,
        3
      }.every((function (x) do
            return x > 0;
          end end)), true);

Mt.from_pair_suites("Bs_auto_uncurry_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
