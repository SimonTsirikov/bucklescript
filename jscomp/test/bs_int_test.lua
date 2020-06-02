console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";
Belt_Int = require "../../lib/js/belt_Int";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function __throw(loc, x) do
  return Mt.throw_suites(test_id, suites, loc, x);
end end

function neq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Neq ]]Block.__(1, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

eq("File \"bs_int_test.ml\", line 14, characters 5-12", 1, 1.0);

eq("File \"bs_int_test.ml\", line 15, characters 5-12", -1, -1.0);

eq("File \"bs_int_test.ml\", line 18, characters 5-12", 1, 1);

eq("File \"bs_int_test.ml\", line 19, characters 5-12", 1, 1);

eq("File \"bs_int_test.ml\", line 20, characters 5-12", 1, 1);

eq("File \"bs_int_test.ml\", line 21, characters 5-12", -1, -1);

eq("File \"bs_int_test.ml\", line 22, characters 5-12", -1, -1);

eq("File \"bs_int_test.ml\", line 23, characters 5-12", -1, -1);

eq("File \"bs_int_test.ml\", line 26, characters 5-12", Belt_Int.fromString("1"), 1);

eq("File \"bs_int_test.ml\", line 27, characters 5-12", Belt_Int.fromString("-1"), -1);

eq("File \"bs_int_test.ml\", line 28, characters 5-12", Belt_Int.fromString("1.7"), 1);

eq("File \"bs_int_test.ml\", line 29, characters 5-12", Belt_Int.fromString("-1.0"), -1);

eq("File \"bs_int_test.ml\", line 30, characters 5-12", Belt_Int.fromString("-1.5"), -1);

eq("File \"bs_int_test.ml\", line 31, characters 5-12", Belt_Int.fromString("-1.7"), -1);

eq("File \"bs_int_test.ml\", line 32, characters 5-12", Belt_Int.fromString("not an int"), undefined);

eq("File \"bs_int_test.ml\", line 35, characters 5-12", String(1), "1");

eq("File \"bs_int_test.ml\", line 36, characters 5-12", String(-1), "-1");

eq("File \"bs_int_test.ml\", line 40, characters 5-12", 5, 5);

eq("File \"bs_int_test.ml\", line 41, characters 5-12", -1, -1);

eq("File \"bs_int_test.ml\", line 42, characters 5-12", 6, 6);

eq("File \"bs_int_test.ml\", line 43, characters 5-12", 0, 0);

Mt.from_pair_suites("File \"bs_int_test.ml\", line 45, characters 23-30", suites.contents);

I = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.__throw = __throw;
exports.neq = neq;
exports.I = I;
--[[  Not a pure module ]]
