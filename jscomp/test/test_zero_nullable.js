'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_option = require("../../lib/js/caml_option.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function f1(x) do
  if (x ~= null) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end

function f2(x) do
  if (x ~= null) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end

function f5(h, x) do
  u = Curry._1(h, 32);
  if (u ~= null) then do
    return u + 1 | 0;
  end else do
    return 3;
  end end 
end

function f4(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u ~= null) then do
    return u + 1 | 0;
  end else do
    return 1 + v | 0;
  end end 
end

function f6(x, y) do
  return x == y;
end

function f7(x) do
  return x;
end

function f8(x) do
  if (x ~= null) then do
    if (x ~= null) then do
      return 0;
    end else do
      return 1;
    end end 
  end else do
    return 2;
  end end 
end

u = f8(undefined);

function f9(x) do
  if (x == null) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end

function f10(x) do
  return x == null;
end

f11 = false;

Test_null = do
  f1: f1,
  f2: f2,
  f5: f5,
  f4: f4,
  f6: f6,
  f7: f7,
  f8: f8,
  u: u,
  f9: f9,
  f10: f10,
  f11: f11
end;

function f1$1(x) do
  if (x ~= undefined) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end

function f2$1(x) do
  if (x ~= undefined) then do
    return x + 1 | 0;
  end else do
    return 3;
  end end 
end

function f5$1(h, x) do
  u = Curry._1(h, 32);
  if (u ~= undefined) then do
    return u + 1 | 0;
  end else do
    return 3;
  end end 
end

function f4$1(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u ~= undefined) then do
    return u + 1 | 0;
  end else do
    return 1 + v | 0;
  end end 
end

function f6$1(x, y) do
  return x == y;
end

function f7$1(x) do
  return x;
end

function f8$1(x) do
  if (x ~= undefined) then do
    if (x ~= undefined) then do
      return 0;
    end else do
      return 1;
    end end 
  end else do
    return 2;
  end end 
end

u$1 = f8$1(undefined);

function f9$1(x) do
  if (x == undefined) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end

function f10$1(x) do
  return x == undefined;
end

f11$1 = false;

Test_def = do
  f1: f1$1,
  f2: f2$1,
  f5: f5$1,
  f4: f4$1,
  f6: f6$1,
  f7: f7$1,
  f8: f8$1,
  u: u$1,
  f9: f9$1,
  f10: f10$1,
  f11: f11$1
end;

function f1$2(x) do
  if (x == null) then do
    return 3;
  end else do
    return x + 1 | 0;
  end end 
end

function f2$2(x) do
  if (x == null) then do
    return 3;
  end else do
    return x + 1 | 0;
  end end 
end

function f5$2(h, x) do
  u = Curry._1(h, 32);
  if (u == null) then do
    return 3;
  end else do
    return u + 1 | 0;
  end end 
end

function f4$2(h, x) do
  u = Curry._1(h, 32);
  v = 32 + x | 0;
  if (u == null) then do
    return 1 + v | 0;
  end else do
    return u + 1 | 0;
  end end 
end

function f6$2(x, y) do
  return x == y;
end

function f7$2(x) do
  return x;
end

function f8$2(x) do
  if (x == null) then do
    return 2;
  end else if (x == null) then do
    return 1;
  end else do
    return 0;
  end end  end 
end

u$2 = f8$2(undefined);

function f9$2(x) do
  if (x == null) then do
    return ;
  end else do
    return Caml_option.some(x);
  end end 
end

function f10$2(x) do
  return x == null;
end

f11$2 = false;

Test_null_def = do
  f1: f1$2,
  f2: f2$2,
  f5: f5$2,
  f4: f4$2,
  f6: f6$2,
  f7: f7$2,
  f8: f8$2,
  u: u$2,
  f9: f9$2,
  f10: f10$2,
  f11: f11$2
end;

eq("File \"test_zero_nullable.ml\", line 227, characters 7-14", f1$2(0), 1);

eq("File \"test_zero_nullable.ml\", line 228, characters 7-14", f1$2(null), 3);

eq("File \"test_zero_nullable.ml\", line 229, characters 7-14", f1$2(undefined), 3);

eq("File \"test_zero_nullable.ml\", line 231, characters 7-14", f1(0), 1);

eq("File \"test_zero_nullable.ml\", line 232, characters 7-14", f1(null), 3);

eq("File \"test_zero_nullable.ml\", line 234, characters 7-14", f1$1(0), 1);

eq("File \"test_zero_nullable.ml\", line 235, characters 7-14", f1$1(undefined), 3);

Mt.from_pair_suites("Test_zero_nullable", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Test_null = Test_null;
exports.Test_def = Test_def;
exports.Test_null_def = Test_null_def;
--[ u Not a pure module ]--
