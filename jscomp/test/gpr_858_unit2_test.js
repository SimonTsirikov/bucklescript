'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var delayed = do
  contents: (function (param) do
      return --[ () ]--0;
    end)
end;

for var i = 1 , 2 , 1 do
  var f = (function(i)do
  return function f(n, j) do
    if (j ~= 0) then do
      var prev = delayed.contents;
      delayed.contents = (function (param) do
          Curry._1(prev, --[ () ]--0);
          return f(((n + 1 | 0) + i | 0) - i | 0, j - 1 | 0);
        end);
      return --[ () ]--0;
    end else if (i == n) then do
      return 0;
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "gpr_858_unit2_test.ml",
              6,
              13
            ]
          ];
    end end  end 
  end
  end(i));
  f(0, i);
end

Curry._1(delayed.contents, --[ () ]--0);

--[  Not a pure module ]--
