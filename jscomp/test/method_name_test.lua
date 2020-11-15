__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";

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

function f(x, i, file, v) do
  x.__case(i);
  x.__case(i, v);
  x.open(file);
  x.open(file);
  return x.MAX_LENGTH;
end end

function ff(x, i, v) do
  x.make;
  x.make_config;
  x.make = v;
  x.make_config = v;
  x.__case(i);
  return x._open(3);
end end

u = {
  "Content'type" = "x"
};

h = {
  open = 3,
  end = 32
};

function hg(x) do
  return x.open + x.end | 0;
end end

eq("File \"method_name_test.ml\", line 39, characters 12-19", 35, hg(h));

Mt.from_pair_suites("Method_name_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.ff = ff;
exports.u = u;
exports.h = h;
exports.hg = hg;
return exports;
--[[  Not a pure module ]]
