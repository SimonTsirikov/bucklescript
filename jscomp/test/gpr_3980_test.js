'use strict';

var Js_math = require("../../lib/js/js_math.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var match = 1;

if (match ~= undefined) then do
  if (match ~= 1) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "gpr_3980_test.ml",
            16,
            10
          ]
        ];
  end
   end 
  var match$1 = 1;
  if (match$1 ~= 1) then do
    if (match$1 ~= 2) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "gpr_3980_test.ml",
              14,
              12
            ]
          ];
    end
     end 
    (do
        name: "bye",
        age: Js_math.floor(1)
      end);
  end
   end 
end else do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "gpr_3980_test.ml",
          16,
          10
        ]
      ];
end end 

--[  Not a pure module ]--
