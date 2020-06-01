'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Caml_int32 = require("../../lib/js/caml_int32.lua");
Caml_int64 = require("../../lib/js/caml_int64.lua");

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

function add(suite) do
  suites.contents = --[[ :: ]][
    suite,
    suites.contents
  ];
  return --[[ () ]]0;
end end

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 14, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int32.div(3, 0);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 15, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int32.mod_(3, 0);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 16, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int32.div(3, 0);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 17, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int32.mod_(3, 0);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 18, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int64.div(--[[ int64 ]][
                              --[[ hi ]]0,
                              --[[ lo ]]3
                            ], --[[ int64 ]][
                              --[[ hi ]]0,
                              --[[ lo ]]0
                            ]);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

add(--[[ tuple ]][
      "File \"div_by_zero_test.ml\", line 19, characters 7-14",
      (function (param) do
          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                        Caml_int64.mod_(--[[ int64 ]][
                              --[[ hi ]]0,
                              --[[ lo ]]3
                            ], --[[ int64 ]][
                              --[[ hi ]]0,
                              --[[ lo ]]0
                            ]);
                        return --[[ () ]]0;
                      end end)]);
        end end)
    ]);

function div(x, y) do
  return Caml_int32.div(x, y) + 3 | 0;
end end

Mt.from_pair_suites("Div_by_zero_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.add = add;
exports.div = div;
--[[  Not a pure module ]]
