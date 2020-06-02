console = {log = print};

__Array = require "../../lib/js/array";
Caml_array = require "../../lib/js/caml_array";

function f(a, b, param) do
  return a + b | 0;
end end

function f2(a) do
  return (function(param) do
      return a + 1 | 0;
    end end);
end end

a = String(3);

b = 101;

arr = __Array.init(2, (function(param) do
        return 0;
      end end));

for i = 0 , 1 , 1 do
  Caml_array.caml_array_set(arr, i, i + 1 | 0);
end

console.log(--[[ tuple ]]{
      a,
      b,
      arr
    });

c = arr;

exports = {}
exports.f = f;
exports.f2 = f2;
exports.a = a;
exports.b = b;
exports.c = c;
--[[ a Not a pure module ]]
