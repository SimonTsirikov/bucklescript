--[['use strict';]]

Caml_obj = require "../../lib/js/caml_obj.lua";
Caml_option = require "../../lib/js/caml_option.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

if (not Caml_obj.caml_equal(Caml_option.nullable_to_opt(""), "")) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "gpr_974_test.ml",
          5,
          4
        ]
      ];
end
 end 

if (not Caml_obj.caml_equal(Caml_option.undefined_to_opt(""), "")) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "gpr_974_test.ml",
          6,
          4
        ]
      ];
end
 end 

if (not Caml_obj.caml_equal(Caml_option.null_to_opt(""), "")) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "gpr_974_test.ml",
          7,
          4
        ]
      ];
end
 end 

--[[  Not a pure module ]]
