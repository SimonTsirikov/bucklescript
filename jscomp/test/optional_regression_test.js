'use strict';

var Mt = require("./mt.js");
var Caml_option = require("../../lib/js/caml_option.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function make(s, b, i) do
  return (function (param) do
      var tmp = { };
      if (s ~= undefined) do
        tmp.s = Caml_option.valFromOption(s);
      end
      if (b ~= undefined) do
        tmp.b = Caml_option.valFromOption(b);
      end
      if (i ~= undefined) do
        tmp.i = Caml_option.valFromOption(i);
      end
      return tmp;
    end);
end

var hh = do
  s: "",
  b: false,
  i: 0
end;

eq("File \"optional_regression_test.ml\", line 21, characters 6-13", Caml_option.undefined_to_opt(hh.s), "");

eq("File \"optional_regression_test.ml\", line 22, characters 6-13", Caml_option.undefined_to_opt(hh.b), false);

eq("File \"optional_regression_test.ml\", line 23, characters 6-13", Caml_option.undefined_to_opt(hh.i), 0);

console.log(hh);

Mt.from_pair_suites("Optional_regression_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.make = make;
exports.hh = hh;
--[  Not a pure module ]--
