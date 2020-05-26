'use strict';

Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = "abcd" then do
        return 0;end end end 
     if ___conditional___ = "bcde" then do
        return 1;end end end 
     do
    else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "test_string_case.ml",
              4,
              9
            ]
          ];
      end end
      
  end
end end

exports.f = f;
--[[ No side effect ]]
