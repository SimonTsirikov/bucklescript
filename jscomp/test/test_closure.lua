console = {log = print};

__Array = require "../../lib/js/array";
Curry = require "../../lib/js/curry";
Caml_array = require "../../lib/js/caml_array";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

v = {
  contents = 0
};

function f(param) do
  arr = Caml_array.caml_make_vect(10, (function(param) do
          return --[[ () ]]0;
        end end));
  for i = 0 , 9 , 1 do
    Caml_array.caml_array_set(arr, i, (function(i)do
        return function (param) do
          v.contents = v.contents + i | 0;
          return --[[ () ]]0;
        end end
        end end)(i));
  end
  return arr;
end end

u = f(--[[ () ]]0);

__Array.iter((function(x) do
        return Curry._1(x, --[[ () ]]0);
      end end), u);

if (v.contents ~= 45) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "test_closure.ml",
      53,
      2
    }
  })
end
 end 

exports = {}
exports.v = v;
exports.f = f;
--[[ u Not a pure module ]]
