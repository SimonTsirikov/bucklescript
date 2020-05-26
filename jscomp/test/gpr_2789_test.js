'use strict';

Mt = require("./mt.js");
Caml_weak = require("../../lib/js/caml_weak.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"gpr_2789_test.ml\", line 8, characters 5-12", 0, #Caml_weak.caml_weak_create(0));

eq("File \"gpr_2789_test.ml\", line 9, characters 5-12", 1, #Caml_weak.caml_weak_create(1));

Mt.from_pair_suites("Gpr_2789_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
