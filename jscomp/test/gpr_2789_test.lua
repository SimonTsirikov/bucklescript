console = {log = print};

Mt = require "./mt";
Caml_weak = require "../../lib/js/caml_weak";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"gpr_2789_test.ml\", line 8, characters 5-12", 0, #Caml_weak.caml_weak_create(0));

eq("File \"gpr_2789_test.ml\", line 9, characters 5-12", 1, #Caml_weak.caml_weak_create(1));

Mt.from_pair_suites("Gpr_2789_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
