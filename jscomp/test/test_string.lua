console = {log = print};

Caml_bytes = require "../../lib/js/caml_bytes";
Caml_string = require "../../lib/js/caml_string";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == "aaaabb" then do
        return 0; end end 
     if ___conditional___ == "bbbb" then do
        return 1; end end 
    error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "test_string.ml",
          4,
          18
        }
      })
      
  end
end end

function a(x) do
  return "helloworldhello" .. x;
end end

function b(y, x) do
  return y .. ("helloworldhello" .. x);
end end

function c(x, y) do
  return x .. "hellohiuhi" .. y;
end end

function h(s, b) do
  if (Caml_string.get(s, 0) == --[[ "a" ]]97 and Caml_bytes.get(b, 0) == --[[ "b" ]]98) then do
    return Caml_string.get(s, 1) == Caml_bytes.get(b, 2);
  end else do
    return false;
  end end 
end end

v = 2;

exports = {}
exports.f = f;
exports.a = a;
exports.b = b;
exports.c = c;
exports.v = v;
exports.h = h;
--[[ No side effect ]]
