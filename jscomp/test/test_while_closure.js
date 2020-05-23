'use strict';

var $$Array = require("../../lib/js/array.js");
var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var v = do
  contents: 0
end;

var arr = Caml_array.caml_make_vect(10, (function (param) do
        return --[ () ]--0;
      end));

function f(param) do
  var n = 0;
  while(n < 10) do
    var j = n;
    Caml_array.caml_array_set(arr, j, (function(j)do
        return function (param) do
          v.contents = v.contents + j | 0;
          return --[ () ]--0;
        end
        end(j)));
    n = n + 1 | 0;
  end;
  return --[ () ]--0;
end

f(--[ () ]--0);

$$Array.iter((function (x) do
        return Curry._1(x, --[ () ]--0);
      end), arr);

console.log(String(v.contents));

if (v.contents ~= 45) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "test_while_closure.ml",
          63,
          4
        ]
      ];
end
 end 

var count = 10;

exports.v = v;
exports.count = count;
exports.arr = arr;
exports.f = f;
--[  Not a pure module ]--
