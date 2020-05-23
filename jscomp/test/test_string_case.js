'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param) do
  switch (param) do
    case "abcd" :
        return 0;
    case "bcde" :
        return 1;
    default:
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "test_string_case.ml",
              4,
              9
            ]
          ];
  end
end

exports.f = f;
--[ No side effect ]--
