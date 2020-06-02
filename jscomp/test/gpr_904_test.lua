console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";

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
      (function (param) do
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

function check_healty(check) do
  if (not check.a and not check.b) then do
    return not check.c;
  end else do
    return false;
  end end 
end end

function basic_not(x) do
  return not x;
end end

function f(check) do
  if (check.x) then do
    return check.y;
  end else do
    return false;
  end end 
end end

eq("File \"gpr_904_test.ml\", line 23, characters 5-12", f(do
          x: true,
          y: false
        end), false);

eq("File \"gpr_904_test.ml\", line 26, characters 5-12", check_healty(do
          a: false,
          b: false,
          c: true
        end), false);

Mt.from_pair_suites("Gpr_904_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.check_healty = check_healty;
exports.basic_not = basic_not;
exports.f = f;
--[[  Not a pure module ]]
