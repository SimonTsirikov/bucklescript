'use strict';

Mt = require("./mt.js");
Caml_option = require("../../lib/js/caml_option.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function make(s, b, i) do
  return (function (param) do
      tmp = { };
      if (s ~= undefined) then do
        tmp.s = Caml_option.valFromOption(s);
      end
       end 
      if (b ~= undefined) then do
        tmp.b = Caml_option.valFromOption(b);
      end
       end 
      if (i ~= undefined) then do
        tmp.i = Caml_option.valFromOption(i);
      end
       end 
      return tmp;
    end);
end

hh = do
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
