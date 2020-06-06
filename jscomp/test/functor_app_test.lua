console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Functor_def = require "./functor_def";
Functor_inst = require "./functor_inst";

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

Y0 = Functor_def.Make(Functor_inst);

Y1 = Functor_def.Make(Functor_inst);

eq("File \"functor_app_test.ml\", line 23, characters 6-13", Curry._2(Y0.h, 1, 2), 4);

eq("File \"functor_app_test.ml\", line 24, characters 6-13", Curry._2(Y1.h, 2, 3), 6);

v = Functor_def.__return(--[[ () ]]0);

eq("File \"functor_app_test.ml\", line 29, characters 6-13", v, 2);

Mt.from_pair_suites("Functor_app_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Y0 = Y0;
exports.Y1 = Y1;
exports.v = v;
--[[ Y0 Not a pure module ]]
