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

u = 3;

function nullary() do
  return 3;
end end

function unary(a) do
  return a + 3 | 0;
end end

xx = unary(3);

eq("File \"ppx_apply_test.ml\", line 17, characters 5-12", u, 3);

Mt.from_pair_suites("Ppx_apply_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.u = u;
exports.nullary = nullary;
exports.unary = unary;
exports.xx = xx;
--[[ u Not a pure module ]]
