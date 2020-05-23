'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");

function f(_n, _acc) do
  while(true) do
    var acc = _acc;
    var n = _n;
    if (n == 0) do
      return Curry._1(acc, --[ () ]--0);
    end else do
      _acc = (function(n,acc)do
      return function (param) do
        console.log(String(n));
        return Curry._1(acc, --[ () ]--0);
      end
      end(n,acc));
      _n = n - 1 | 0;
      continue ;
    end
  end;
end

function test_closure(param) do
  var arr = Caml_array.caml_make_vect(6, (function (x) do
          return x;
        end));
  for(var i = 0; i <= 6; ++i)do
    Caml_array.caml_array_set(arr, i, (function(i)do
        return function (param) do
          return i;
        end
        end(i)));
  end
  return arr;
end

f(10, (function (param) do
        return --[ () ]--0;
      end));

exports.f = f;
exports.test_closure = test_closure;
--[  Not a pure module ]--
