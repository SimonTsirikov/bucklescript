'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Int64 = require("../../lib/js/int64.js");
Caml_format = require("../../lib/js/caml_format.js");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

function id(x) do
  return Caml_format.caml_int64_of_string(Caml_format.caml_int64_format("%d", x));
end end

i = --[[ int64 ]][
  --[[ hi ]]2074848171,
  --[[ lo ]]2880154539
];

s = Caml_format.caml_int64_format("%d", i);

i$prime = Caml_format.caml_int64_of_string(s);

eq("File \"gpr_1503_test.ml\", line 18, characters 5-12", i, i$prime);

eq("File \"gpr_1503_test.ml\", line 21, characters 7-14", Int64.max_int, Caml_format.caml_int64_of_string(Caml_format.caml_int64_format("%d", Int64.max_int)));

eq("File \"gpr_1503_test.ml\", line 22, characters 7-14", Int64.min_int, Caml_format.caml_int64_of_string(Caml_format.caml_int64_format("%d", Int64.min_int)));

Mt.from_pair_suites("Gpr_1503_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.id = id;
--[[ s Not a pure module ]]
