'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Caml_option = require("../../lib/js/caml_option.js");

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

function ok(loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Ok ]]Block.__(4, [x]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

match = typeof ___undefined_value == "undefined" and undefined or ___undefined_value;

a = match ~= undefined and 2 or 1;

function test(param) do
  match = typeof __DEV__ == "undefined" and undefined or __DEV__;
  if (match ~= undefined) then do
    console.log("dev mode");
    return --[[ () ]]0;
  end else do
    console.log("producton mode");
    return --[[ () ]]0;
  end end 
end end

function test2(param) do
  match = typeof __filename == "undefined" and undefined or __filename;
  if (match ~= undefined) then do
    console.log(match);
    return --[[ () ]]0;
  end else do
    console.log("non node environment");
    return --[[ () ]]0;
  end end 
end end

function test3(param) do
  if (Caml_option.undefined_to_opt(typeof __DEV__ == "undefined" and undefined or __DEV__) == undefined) then do
    console.log("production mode");
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function f(x) do
  return x == undefined;
end end

ok("File \"undef_regression2_test.ml\", line 44, characters 5-12", a > 0);

eq("File \"undef_regression2_test.ml\", line 45, characters 5-12", a, 1);

Mt.from_pair_suites("Undef_regression2_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.ok = ok;
exports.a = a;
exports.test = test;
exports.test2 = test2;
exports.test3 = test3;
exports.f = f;
--[[ match Not a pure module ]]
