__console = {log = print};

__Array = require "......lib.js.array";
Curry = require "......lib.js.curry";
Caml_array = require "......lib.js.caml_array";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

v = {
  contents = 0
};

arr = Caml_array.caml_make_vect(10, (function(param) do
        return --[[ () ]]0;
      end end));

function f(param) do
  n = 0;
  while(n < 10) do
    j = n;
    Caml_array.caml_array_set(arr, j, (function(j)do
        return function (param) do
          v.contents = v.contents + j | 0;
          return --[[ () ]]0;
        end end
        end end)(j));
    n = n + 1 | 0;
  end;
  return --[[ () ]]0;
end end

f(--[[ () ]]0);

__Array.iter((function(x) do
        return Curry._1(x, --[[ () ]]0);
      end end), arr);

__console.log(__String(v.contents));

if (v.contents ~= 45) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "test_while_closure.ml",
      63,
      4
    }
  })
end
 end 

count = 10;

exports = {};
exports.v = v;
exports.count = count;
exports.arr = arr;
exports.f = f;
return exports;
--[[  Not a pure module ]]
