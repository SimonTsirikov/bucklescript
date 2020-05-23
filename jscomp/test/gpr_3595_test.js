'use strict';

var Mt = require("./mt.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

var match = [1];

if (#match ~= 1) then do
  throw [
        Caml_builtin_exceptions.match_failure,
        --[ tuple ]--[
          "gpr_3595_test.ml",
          9,
          4
        ]
      ];
end
 end 

var a = match[0];

var x = 1;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a = a;
exports.x = x;
--[  Not a pure module ]--
