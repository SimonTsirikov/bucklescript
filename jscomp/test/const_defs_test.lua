--[['use strict';]]

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

u = 3;

function f(param) do
  error ({
    Caml_builtin_exceptions.invalid_argument,
    "hi"
  })
end end

exports.u = u;
exports.f = f;
--[[ No side effect ]]
