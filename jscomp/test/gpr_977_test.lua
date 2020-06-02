console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Int32 = require "../../lib/js/int32";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
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

function f(x) do
  for i = 0 , 100 , 1 do
    console.log(".");
  end
  return -x | 0;
end end

function int32_f(x) do
  for i = 0 , 100 , 1 do
    console.log(".");
  end
  return -x | 0;
end end

function nint32_f(x) do
  for i = 0 , 100 , 1 do
    console.log(".");
  end
  return -x;
end end

u = f(-2147483648);

eq("File \"gpr_977_test.ml\", line 32, characters 5-12", -2147483648, u);

eq("File \"gpr_977_test.ml\", line 33, characters 5-12", Int32.min_int, int32_f(Int32.min_int));

eq("File \"gpr_977_test.ml\", line 34, characters 5-12", nint32_f(-2147483648), 2147483648);

Mt.from_pair_suites("Gpr_977_test", suites.contents);

min_32_int = -2147483648;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.int32_f = int32_f;
exports.nint32_f = nint32_f;
exports.min_32_int = min_32_int;
exports.u = u;
--[[ u Not a pure module ]]
