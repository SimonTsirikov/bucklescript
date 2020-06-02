--[['use strict';]]

Mt = require "./mt";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

require('../../lib/js/caml_external_polyfill.js').register("caml_fancy_add", function(x,y){
  return + ((""+x ) + (""+y))
})
;

h = Caml_external_polyfill.resolve("caml_fancy_add")(1, 2);

eq("File \"external_polyfill_test.ml\", line 19, characters 5-12", h, 12);

Mt.from_pair_suites("External_polyfill_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.h = h;
--[[  Not a pure module ]]
