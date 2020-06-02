--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

oppHeroes = --[[ :: ]]{
  0,
  --[[ [] ]]0
};

huntGrootCondition = false;

if (List.length(--[[ [] ]]0) > 0) then do
  x = List.filter((function (h) do
            return List.hd(--[[ [] ]]0) <= 1000;
          end end))(oppHeroes);
  huntGrootCondition = List.length(x) == 0;
end
 end 

huntGrootCondition2 = true;

if (List.length(--[[ [] ]]0) < 0) then do
  x$1 = List.filter((function (h) do
            return List.hd(--[[ [] ]]0) <= 1000;
          end end))(oppHeroes);
  huntGrootCondition2 = List.length(x$1) == 0;
end
 end 

eq("File \"gpr_2608_test.ml\", line 23, characters 5-12", huntGrootCondition, false);

eq("File \"gpr_2608_test.ml\", line 24, characters 5-12", huntGrootCondition2, true);

Mt.from_pair_suites("Gpr_2608_test", suites.contents);

nearestGroots = --[[ [] ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.nearestGroots = nearestGroots;
exports.oppHeroes = oppHeroes;
exports.huntGrootCondition = huntGrootCondition;
exports.huntGrootCondition2 = huntGrootCondition2;
--[[ huntGrootCondition Not a pure module ]]
