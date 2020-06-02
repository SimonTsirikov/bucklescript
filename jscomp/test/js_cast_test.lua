console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";

suites = do
  contents: --[[ [] ]]0
end;

counter = do
  contents: 0
end;

function add_test(loc, test) do
  counter.contents = counter.contents + 1 | 0;
  id = loc .. (" id " .. String(counter.contents));
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      id,
      test
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function eq(loc, x, y) do
  return add_test(loc, (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          x,
                          y
                        });
              end end));
end end

eq("File \"js_cast_test.ml\", line 13, characters 12-19", true, 1);

eq("File \"js_cast_test.ml\", line 15, characters 12-19", false, 0);

eq("File \"js_cast_test.ml\", line 17, characters 12-19", 0, 0.0);

eq("File \"js_cast_test.ml\", line 19, characters 12-19", 1, 1.0);

eq("File \"js_cast_test.ml\", line 21, characters 12-19", 123456789, 123456789.0);

Mt.from_pair_suites("Js_cast_test", suites.contents);

exports.suites = suites;
exports.add_test = add_test;
exports.eq = eq;
--[[  Not a pure module ]]
