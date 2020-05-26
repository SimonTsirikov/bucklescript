'use strict';

Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "noassert.ml",
          5,
          11
        ]
      ];
end

function h(param) do
  return 0;
end

exports.f = f;
exports.h = h;
--[ No side effect ]--
