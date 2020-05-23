'use strict';

var $$Array = require("../../lib/js/array.js");
var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var v = do
  contents: 0
end;

function f(param) do
  var arr = Caml_array.caml_make_vect(10, (function (param) do
          return --[ () ]--0;
        end));
  for(var i = 0; i <= 9; ++i)do
    Caml_array.caml_array_set(arr, i, (function(i)do
        return function (param) do
          v.contents = v.contents + i | 0;
          return --[ () ]--0;
        end
        end(i)));
  end
  return arr;
end

var u = f(--[ () ]--0);

$$Array.iter((function (x) do
        return Curry._1(x, --[ () ]--0);
      end), u);

if (v.contents ~= 45) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "test_closure.ml",
          53,
          2
        ]
      ];
end
 end 

exports.v = v;
exports.f = f;
--[ u Not a pure module ]--
