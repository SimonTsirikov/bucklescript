__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";

v = {
  contents = 3
};

function f(h) do
  v.contents = v.contents + 1 | 0;
  partial_arg = 3;
  return (function(param) do
      return Curry._2(h, partial_arg, param);
    end end);
end end

f((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

f((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

a = v.contents;

v_1 = {
  contents = 3
};

function f_1(h) do
  v_1.contents = v_1.contents + 1 | 0;
  partial_arg = 3;
  return (function(param) do
      return Curry._2(h, partial_arg, param);
    end end);
end end

f_1((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

f_1((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

b = v_1.contents;

v_2 = {
  contents = 3
};

function f_2(h) do
  return Curry._2(h, 2, (v_2.contents = v_2.contents + 1 | 0, 3));
end end

f_2((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

f_2((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end));

c = v_2.contents;

v_3 = {
  contents = 3
};

function f_3(h, g) do
  v_3.contents = v_3.contents + 1 | 0;
  partial_arg = 9;
  return (function(param) do
      return Curry._2(h, partial_arg, param);
    end end);
end end

f_3((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end), 3);

f_3((function(prim, prim_1) do
        return prim + prim_1 | 0;
      end end), 3);

d = v_3.contents;

Mt.from_pair_suites("Pr_regression_test", --[[ :: ]]{
      --[[ tuple ]]{
        "partial",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      --[[ tuple ]]{
                        5,
                        5,
                        5,
                        5
                      },
                      --[[ tuple ]]{
                        a,
                        b,
                        c,
                        d
                      }
                    });
          end end)
      },
      --[[ [] ]]0
    });

exports = {};
exports.a = a;
exports.b = b;
exports.c = c;
exports.d = d;
return exports;
--[[  Not a pure module ]]
