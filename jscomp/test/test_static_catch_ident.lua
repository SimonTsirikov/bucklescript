--[['use strict';]]

Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Scan_failure = Caml_exceptions.create("Test_static_catch_ident.Scan_failure");

function scanf_bad_input(ib, x) do
  s;
  if (x[0] == Scan_failure or x[0] == Caml_builtin_exceptions.failure) then do
    s = x[1];
  end else do
    error(x)
  end end 
  for i = 0 , 100 , 1 do
    console.log(s);
    console.log("don't inlinie");
  end
  return --[[ () ]]0;
end end

exports.Scan_failure = Scan_failure;
exports.scanf_bad_input = scanf_bad_input;
--[[ No side effect ]]
