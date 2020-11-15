__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Caml_int32 = require "......lib.js.caml_int32";

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

function $$(x, y) do
  return x + y | 0;
end end

$$_plus = Caml_int32.imul;

eq("File \"dollar_escape_test.ml\", line 20, characters 6-13", 3, 3);

eq("File \"dollar_escape_test.ml\", line 21, characters 6-13", 3, 3);

Mt.from_pair_suites("Dollar_escape_test", suites.contents);

v = 3;

u = 3;

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.$$ = $$;
exports.v = v;
exports.$$_plus = $$_plus;
exports.u = u;
return exports;
--[[  Not a pure module ]]
