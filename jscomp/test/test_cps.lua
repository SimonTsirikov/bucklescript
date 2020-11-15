__console = {log = print};

Curry = require "......lib.js.curry";
Caml_array = require "......lib.js.caml_array";

function f(_n, _acc) do
  while(true) do
    acc = _acc;
    n = _n;
    if (n == 0) then do
      return Curry._1(acc, --[[ () ]]0);
    end else do
      _acc = (function(n,acc)do
      return function (param) do
        __console.log(__String(n));
        return Curry._1(acc, --[[ () ]]0);
      end end
      end end)(n,acc);
      _n = n - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function test_closure(param) do
  arr = Caml_array.caml_make_vect(6, (function(x) do
          return x;
        end end));
  for i = 0 , 6 , 1 do
    Caml_array.caml_array_set(arr, i, (function(i)do
        return function (param) do
          return i;
        end end
        end end)(i));
  end
  return arr;
end end

f(10, (function(param) do
        return --[[ () ]]0;
      end end));

exports = {};
exports.f = f;
exports.test_closure = test_closure;
return exports;
--[[  Not a pure module ]]
