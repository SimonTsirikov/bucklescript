'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Printexc = require("../../lib/js/printexc.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

A = Caml_exceptions.create("Gpr_1501_test.A");

B = Caml_exceptions.create("Gpr_1501_test.B");

eq("File \"gpr_1501_test.ml\", line 15, characters 7-14", "Not_found", Printexc.to_string(Caml_builtin_exceptions.not_found));

eq("File \"gpr_1501_test.ml\", line 16, characters 7-14", "Gpr_1501_test.A", Printexc.to_string(A));

eq("File \"gpr_1501_test.ml\", line 17, characters 7-14", "Gpr_1501_test.B(1)", Printexc.to_string([
          B,
          1
        ]));

Mt.from_pair_suites("Gpr_1501_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.A = A;
exports.B = B;
--[  Not a pure module ]--
