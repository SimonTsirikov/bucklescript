console = {log = print};

Mt = require "./mt";
Caml_option = require "../../lib/js/caml_option";
Gpr_3566_test = require "./gpr_3566_test";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

H = Gpr_3566_test.Test({ });

eq("File \"gpr_3566_drive_test.ml\", line 8, characters 5-12", H.b, true);

Caml_option_1 = { };

function f(x) do
  return Caml_option.some(x);
end end

Mt.from_pair_suites("gpr_3566_drive_test.ml", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.H = H;
exports.Caml_option = Caml_option_1;
exports.f = f;
--[[ H Not a pure module ]]
