console.log = print;

Curry = require "../../lib/js/curry";
Caml_array = require "../../lib/js/caml_array";
Pervasives = require "../../lib/js/pervasives";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function map(f, a) do
  f_1 = Curry.__1(f);
  a_1 = a;
  l = #a_1;
  if (l == 0) then do
    return {};
  end else do
    r = Caml_array.caml_make_vect(l, f_1(a_1[0]));
    for i = 1 , l - 1 | 0 , 1 do
      r[i] = f_1(a_1[i]);
    end
    return r;
  end end 
end end

function init(l, f) do
  l_1 = l;
  f_1 = Curry.__1(f);
  if (l_1 == 0) then do
    return {};
  end else do
    if (l_1 < 0) then do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Array.init"
      })
    end
     end 
    res = Caml_array.caml_make_vect(l_1, f_1(0));
    for i = 1 , l_1 - 1 | 0 , 1 do
      res[i] = f_1(i);
    end
    return res;
  end end 
end end

function fold_left(f, x, a) do
  f_1 = Curry.__2(f);
  x_1 = x;
  a_1 = a;
  r = x_1;
  for i = 0 , #a_1 - 1 | 0 , 1 do
    r = f_1(r, a_1[i]);
  end
  return r;
end end

function f2(param) do
  arr = init(3000000, (function (i) do
          return i;
        end end));
  b = map((function (i) do
          return i + i - 1;
        end end), arr);
  v = fold_left((function (prim, prim_1) do
          return prim + prim_1;
        end end), 0, b);
  console.log(Pervasives.string_of_float(v));
  return --[[ () ]]0;
end end

f2(--[[ () ]]0);

exports.map = map;
exports.init = init;
exports.fold_left = fold_left;
exports.f2 = f2;
--[[  Not a pure module ]]
