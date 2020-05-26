'use strict';

Mt = require("./mt.js");
Caml_array = require("../../lib/js/caml_array.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

v = Caml_array.caml_make_float_vect(5);

for i = 0 , 4 , 1 do
  v[i] = 0;
end

Caml_array.caml_array_set(v, 2, 15.5);

eq("File \"floatarray_test.ml\", line 17, characters 5-12", --[ tuple ]--[
      #v,
      v[2],
      Caml_array.caml_array_get(v, 1)
    ], --[ tuple ]--[
      5,
      15.5,
      0
    ]);

Mt.from_pair_suites("Floatarray_test", suites.contents);

K = --[ alias ]--0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.K = K;
--[ v Not a pure module ]--
