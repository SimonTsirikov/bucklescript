'use strict';

Curry = require("../../lib/js/curry.lua");
Caml_array = require("../../lib/js/caml_array.lua");
Pervasives = require("../../lib/js/pervasives.lua");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.lua");

function map(f, a) do
  f$1 = Curry.__1(f);
  a$1 = a;
  l = #a$1;
  if (l == 0) then do
    return [];
  end else do
    r = Caml_array.caml_make_vect(l, f$1(a$1[0]));
    for i = 1 , l - 1 | 0 , 1 do
      r[i] = f$1(a$1[i]);
    end
    return r;
  end end 
end end

function init(l, f) do
  l$1 = l;
  f$1 = Curry.__1(f);
  if (l$1 == 0) then do
    return [];
  end else do
    if (l$1 < 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Array.init"
          ];
    end
     end 
    res = Caml_array.caml_make_vect(l$1, f$1(0));
    for i = 1 , l$1 - 1 | 0 , 1 do
      res[i] = f$1(i);
    end
    return res;
  end end 
end end

function fold_left(f, x, a) do
  f$1 = Curry.__2(f);
  x$1 = x;
  a$1 = a;
  r = x$1;
  for i = 0 , #a$1 - 1 | 0 , 1 do
    r = f$1(r, a$1[i]);
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
  v = fold_left((function (prim, prim$1) do
          return prim + prim$1;
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
