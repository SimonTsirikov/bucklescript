__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Caml_option = require "......lib.js.caml_option";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function ok(loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Ok ]]Block.__(4, {x});
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

match = type(___undefined_value) == "undefined" and nil or ___undefined_value;

a = match ~= nil and 2 or 1;

function test(param) do
  match = type(__DEV__) == "undefined" and nil or __DEV__;
  if (match ~= nil) then do
    __console.log("dev mode");
    return --[[ () ]]0;
  end else do
    __console.log("producton mode");
    return --[[ () ]]0;
  end end 
end end

function test2(param) do
  match = type(__filename) == "undefined" and nil or __filename;
  if (match ~= nil) then do
    __console.log(match);
    return --[[ () ]]0;
  end else do
    __console.log("non node environment");
    return --[[ () ]]0;
  end end 
end end

function test3(param) do
  if (Caml_option.undefined_to_opt(type(__DEV__) == "undefined" and nil or __DEV__) == nil) then do
    __console.log("production mode");
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function f(x) do
  return x == nil;
end end

ok("File \"undef_regression2_test.ml\", line 44, characters 5-12", a > 0);

eq("File \"undef_regression2_test.ml\", line 45, characters 5-12", a, 1);

Mt.from_pair_suites("Undef_regression2_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.ok = ok;
exports.a = a;
exports.test = test;
exports.test2 = test2;
exports.test3 = test3;
exports.f = f;
return exports;
--[[ match Not a pure module ]]
