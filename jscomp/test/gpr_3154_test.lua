--[['use strict';]]

Mt = require "./mt";
Js_dict = require "../../lib/js/js_dict";
Caml_option = require "../../lib/js/caml_option";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

d = { };

d["foo"] = undefined;

match = Js_dict.get(d, "foo");

if (match ~= undefined and Caml_option.valFromOption(match) == undefined) then do
  b("File \"gpr_3154_test.ml\", line 12, characters 19-26", true);
end else do
  b("File \"gpr_3154_test.ml\", line 13, characters 11-18", false);
end end 

d0 = { };

d0["foo"] = undefined;

eq("File \"gpr_3154_test.ml\", line 18, characters 5-12", Js_dict.get(d0, "foo"), Caml_option.some(undefined));

Mt.from_pair_suites("Gpr_3154_test", suites.contents);

J = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.J = J;
--[[  Not a pure module ]]
