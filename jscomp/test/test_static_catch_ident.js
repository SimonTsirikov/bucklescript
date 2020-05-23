'use strict';

var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var Scan_failure = Caml_exceptions.create("Test_static_catch_ident.Scan_failure");

function scanf_bad_input(ib, x) do
  var s;
  if (x[0] == Scan_failure or x[0] == Caml_builtin_exceptions.failure) then do
    s = x[1];
  end else do
    throw x;
  end end 
  for(var i = 0; i <= 100; ++i)do
    console.log(s);
    console.log("don't inlinie");
  end
  return --[ () ]--0;
end

exports.Scan_failure = Scan_failure;
exports.scanf_bad_input = scanf_bad_input;
--[ No side effect ]--
