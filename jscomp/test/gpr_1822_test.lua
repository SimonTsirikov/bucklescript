console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_int32 = require "../../lib/js/caml_int32";

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

myShape = --[[ Circle ]]Block.__(0, {10});

area;

area = myShape.tag and Caml_int32.imul(10, myShape[1]) or 100 * 3.14;

eq("File \"gpr_1822_test.ml\", line 21, characters 6-13", area, 314);

Mt.from_pair_suites("Gpr_1822_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.myShape = myShape;
exports.area = area;
--[[ area Not a pure module ]]
