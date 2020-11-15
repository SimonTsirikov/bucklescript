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

function f0(x) do
  old = x.open;
  x.open = old + 1 | 0;
  return x.open;
end end

function f1(x) do
  old = x.__in;
  x.__in = old + 1 | 0;
  return x.__in;
end end

function f2(x) do
  old = x.MAX_LENGTH;
  x.MAX_LENGTH = old + 1 | 0;
  return x.MAX_LENGTH;
end end

function f3(x) do
  old = x.Capital;
  x.Capital = old + 1 | 0;
  return x.Capital;
end end

function f4(x) do
  old = x._open;
  x._open = old + 1 | 0;
  return x._open;
end end

function f5(x) do
  old = x.open;
  x.open = old + 1 | 0;
  return x.open;
end end

function f6(x) do
  old = x["'x"];
  x["'x"] = old + 1 | 0;
  return x["'x"];
end end

function f7(x) do
  old = x._Capital;
  x._Capital = old + 1 | 0;
  return x._Capital;
end end

function f8(x) do
  old = x._MAX;
  x._MAX = old + 1 | 0;
  return x._MAX;
end end

function f9(x) do
  old = x.__;
  x.__ = old + 1 | 0;
  return x.__;
end end

function f10(x) do
  old = x.__x;
  x.__x = old + 1 | 0;
  return x.__x;
end end

function f11(x) do
  old = x._;
  x._ = old + 1 | 0;
  return x._;
end end

function f12(x) do
  old = x.__;
  x.__ = old + 1 | 0;
  return x.__;
end end

eq("File \"name_mangle_test.ml\", line 85, characters 7-14", f0(({open:0})), 1);

eq("File \"name_mangle_test.ml\", line 86, characters 7-14", f1(({in:0})), 1);

eq("File \"name_mangle_test.ml\", line 87, characters 7-14", f2(({MAX_LENGTH:0})), 1);

eq("File \"name_mangle_test.ml\", line 88, characters 7-14", f3(({Capital:0})), 1);

eq("File \"name_mangle_test.ml\", line 89, characters 7-14", f4(({_open:0})), 1);

eq("File \"name_mangle_test.ml\", line 90, characters 7-14", f5(({open:0})), 1);

eq("File \"name_mangle_test.ml\", line 91, characters 7-14", f6(({ "'x" :0})), 1);

eq("File \"name_mangle_test.ml\", line 92, characters 7-14", f7(({_Capital:0})), 1);

eq("File \"name_mangle_test.ml\", line 93, characters 7-14", f8(({_MAX:0})), 1);

eq("File \"name_mangle_test.ml\", line 94, characters 7-14", f9(({__:0})), 1);

eq("File \"name_mangle_test.ml\", line 95, characters 7-14", f10(({__x:0})), 1);

eq("File \"name_mangle_test.ml\", line 96, characters 7-14", f11(({_:0})), 1);

eq("File \"name_mangle_test.ml\", line 97, characters 7-14", f12(({__:0})), 1);

Mt.from_pair_suites("File \"name_mangle_test.ml\", line 101, characters 23-30", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f0 = f0;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
exports.f9 = f9;
exports.f10 = f10;
exports.f11 = f11;
exports.f12 = f12;
return exports;
--[[  Not a pure module ]]
