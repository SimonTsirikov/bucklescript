console.log = print;

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(param) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "noassert.ml",
      5,
      11
    }
  })
end end

function h(param) do
  return 0;
end end

exports.f = f;
exports.h = h;
--[[ No side effect ]]
