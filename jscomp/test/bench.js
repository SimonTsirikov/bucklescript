'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function map(f, a) do
  var f$1 = Curry.__1(f);
  var a$1 = a;
  var l = #a$1;
  if (l == 0) then do
    return [];
  end else do
    var r = Caml_array.caml_make_vect(l, f$1(a$1[0]));
    for(var i = 1 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = f$1(a$1[i]);
    end
    return r;
  end end 
end

function init(l, f) do
  var l$1 = l;
  var f$1 = Curry.__1(f);
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
    var res = Caml_array.caml_make_vect(l$1, f$1(0));
    for(var i = 1 ,i_finish = l$1 - 1 | 0; i <= i_finish; ++i)do
      res[i] = f$1(i);
    end
    return res;
  end end 
end

function fold_left(f, x, a) do
  var f$1 = Curry.__2(f);
  var x$1 = x;
  var a$1 = a;
  var r = x$1;
  for(var i = 0 ,i_finish = #a$1 - 1 | 0; i <= i_finish; ++i)do
    r = f$1(r, a$1[i]);
  end
  return r;
end

function f2(param) do
  var arr = init(3000000, (function (i) do
          return i;
        end));
  var b = map((function (i) do
          return i + i - 1;
        end), arr);
  var v = fold_left((function (prim, prim$1) do
          return prim + prim$1;
        end), 0, b);
  console.log(Pervasives.string_of_float(v));
  return --[ () ]--0;
end

f2(--[ () ]--0);

exports.map = map;
exports.init = init;
exports.fold_left = fold_left;
exports.f2 = f2;
--[  Not a pure module ]--
