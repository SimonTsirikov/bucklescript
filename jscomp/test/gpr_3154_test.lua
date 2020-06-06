console = {log = print};

Mt = require "./mt";
Js_dict = require "../../lib/js/js_dict";
Caml_option = require "../../lib/js/caml_option";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

d = { };

d["foo"] = nil;

match = Js_dict.get(d, "foo");

if (match ~= nil and Caml_option.valFromOption(match) == nil) then do
  b("File \"gpr_3154_test.ml\", line 12, characters 19-26", true);
end else do
  b("File \"gpr_3154_test.ml\", line 13, characters 11-18", false);
end end 

d0 = { };

d0["foo"] = nil;

eq("File \"gpr_3154_test.ml\", line 18, characters 5-12", Js_dict.get(d0, "foo"), Caml_option.some(nil));

Mt.from_pair_suites("Gpr_3154_test", suites.contents);

J = --[[ alias ]]0;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.J = J;
--[[  Not a pure module ]]
