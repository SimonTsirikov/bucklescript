--[['use strict';]]

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

u = 3;

function f(param) do
  throw [
        Caml_builtin_exceptions.invalid_argument,
        "hi"
      ];
end end

exports.u = u;
exports.f = f;
--[[ No side effect ]]
