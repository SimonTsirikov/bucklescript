console = {log = print};

Js_math = require "../../lib/js/js_math";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

match = 1;

if (match ~= undefined) then do
  if (match ~= 1) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "gpr_3980_test.ml",
        16,
        10
      }
    })
  end
   end 
  match_1 = 1;
  if (match_1 ~= 1) then do
    if (match_1 ~= 2) then do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "gpr_3980_test.ml",
          14,
          12
        }
      })
    end
     end 
    (do
        name: "bye",
        age: Js_math.floor(1)
      end);
  end
   end 
end else do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "gpr_3980_test.ml",
      16,
      10
    }
  })
end end 

exports = {}
--[[  Not a pure module ]]
