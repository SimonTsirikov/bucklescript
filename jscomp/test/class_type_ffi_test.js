'use strict';

Curry = require("../../lib/js/curry.js");

function sum_float_array(arr) do
  v = 0;
  for i = 0 , arr.length - 1 | 0 , 1 do
    v = v + arr.case(i);
  end
  return v;
end

function sum_int_array(arr) do
  v = 0;
  for i = 0 , arr.length - 1 | 0 , 1 do
    v = v + arr.case(i) | 0;
  end
  return v;
end

function sum_poly(zero, add, arr) do
  v = zero;
  for i = 0 , arr.length - 1 | 0 , 1 do
    v = add(v, arr.case(i));
  end
  return v;
end

function test_set(x) do
  x.length = 3;
  return --[ () ]--0;
end

function f(x) do
  x.bark("he");
  return x.fight();
end

function ff(fn, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) do
  return fn(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11);
end

function ff2(fn, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) do
  return fn(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12);
end

function off2(o, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) do
  return o.huge_method(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12);
end

function mk_f(param) do
  return (function (a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) do
      return Curry.app(a0, [
                  a1,
                  a2,
                  a3,
                  a4,
                  a5,
                  a6,
                  a7,
                  a8,
                  a9,
                  a10,
                  a11,
                  a12
                ]);
    end);
end

function omk_f(param) do
  return do
          huge_methdo: (function (a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) do
              return Curry.app(a0, [
                          a1,
                          a2,
                          a3,
                          a4,
                          a5,
                          a6,
                          a7,
                          a8,
                          a9,
                          a10,
                          a11,
                          a12
                        ]);
            end)
        end;
end

exports.sum_float_array = sum_float_array;
exports.sum_int_array = sum_int_array;
exports.sum_poly = sum_poly;
exports.test_set = test_set;
exports.f = f;
exports.ff = ff;
exports.ff2 = ff2;
exports.off2 = off2;
exports.mk_f = mk_f;
exports.omk_f = omk_f;
--[ No side effect ]--
