console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_option = require "../../lib/js/caml_option";

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

function f1(x) do
  if (x ~= nil) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f2(x) do
  if (x ~= nil) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f5(h, x) do
  u = Curry._1(h, 32);
  if (u ~= nil) then do
    return u + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f4(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u ~= nil) then do
    return u + 1 | 0;
  end else do
    return 1 + v | 0;
  end end 
end end

function f6(x, y) do
  return x == y;
end end

function f7(x) do
  return x;
end end

function f8(x) do
  if (x ~= nil) then do
    if (x ~= nil) then do
      return 0;
    end else do
      return 1;
    end end 
  end else do
    return 2;
  end end 
end end

u = f8(nil);

function f9(x) do
  if (x == nil) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end end

function f10(x) do
  return x == nil;
end end

f11 = false;

Test_null = {
  f1 = f1,
  f2 = f2,
  f5 = f5,
  f4 = f4,
  f6 = f6,
  f7 = f7,
  f8 = f8,
  u = u,
  f9 = f9,
  f10 = f10,
  f11 = f11
};

function f1_1(x) do
  if (x ~= nil) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f2_1(x) do
  if (x ~= nil) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f5_1(h, x) do
  u = Curry._1(h, 32);
  if (u ~= nil) then do
    return u + 1 | 0;
  end else do
    return 3;
  end end 
end end

function f4_1(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u ~= nil) then do
    return u + 1 | 0;
  end else do
    return 1 + v | 0;
  end end 
end end

function f6_1(x, y) do
  return x == y;
end end

function f7_1(x) do
  return x;
end end

function f8_1(x) do
  if (x ~= nil) then do
    if (x ~= nil) then do
      return 0;
    end else do
      return 1;
    end end 
  end else do
    return 2;
  end end 
end end

u_1 = f8_1(nil);

function f9_1(x) do
  if (x == nil) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end end

function f10_1(x) do
  return x == nil;
end end

f11_1 = false;

Test_def = {
  f1 = f1_1,
  f2 = f2_1,
  f5 = f5_1,
  f4 = f4_1,
  f6 = f6_1,
  f7 = f7_1,
  f8 = f8_1,
  u = u_1,
  f9 = f9_1,
  f10 = f10_1,
  f11 = f11_1
};

function f1_2(x) do
  if (x == nil) then do
    return 3;
  end else do
    return x + 1 | 0;
  end end 
end end

function f2_2(x) do
  if (x == nil) then do
    return 3;
  end else do
    return x + 1 | 0;
  end end 
end end

function f5_2(h, x) do
  u = Curry._1(h, 32);
  if (u == nil) then do
    return 3;
  end else do
    return u + 1 | 0;
  end end 
end end

function f4_2(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u == nil) then do
    return 1 + v | 0;
  end else do
    return u + 1 | 0;
  end end 
end end

function f6_2(x, y) do
  return x == y;
end end

function f7_2(x) do
  return x;
end end

function f8_2(x) do
  if (x == nil) then do
    return 2;
  end else if (x == nil) then do
    return 1;
  end else do
    return 0;
  end end  end 
end end

u_2 = f8_2(nil);

function f9_2(x) do
  if (x == nil) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end end

function f10_2(x) do
  return x == nil;
end end

f11_2 = false;

Test_null_def = {
  f1 = f1_2,
  f2 = f2_2,
  f5 = f5_2,
  f4 = f4_2,
  f6 = f6_2,
  f7 = f7_2,
  f8 = f8_2,
  u = u_2,
  f9 = f9_2,
  f10 = f10_2,
  f11 = f11_2
};

eq("File \"test_zero_nullable.ml\", line 227, characters 7-14", f1_2(0), 1);

eq("File \"test_zero_nullable.ml\", line 228, characters 7-14", f1_2(null), 3);

eq("File \"test_zero_nullable.ml\", line 229, characters 7-14", f1_2(undefined), 3);

eq("File \"test_zero_nullable.ml\", line 231, characters 7-14", f1(0), 1);

eq("File \"test_zero_nullable.ml\", line 232, characters 7-14", f1(null), 3);

eq("File \"test_zero_nullable.ml\", line 234, characters 7-14", f1_1(0), 1);

eq("File \"test_zero_nullable.ml\", line 235, characters 7-14", f1_1(undefined), 3);

Mt.from_pair_suites("Test_zero_nullable", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Test_null = Test_null;
exports.Test_def = Test_def;
exports.Test_null_def = Test_null_def;
--[[ u Not a pure module ]]
