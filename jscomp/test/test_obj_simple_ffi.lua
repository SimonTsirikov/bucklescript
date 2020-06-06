console = {log = print};

Caml_option = require "../../lib/js/caml_option";

function v(displayName, param) do
  tmp = {
    test = 3,
    config = 3,
    hi = "ghos"
  };
  if (displayName ~= nil) then do
    tmp.displayName = Caml_option.valFromOption(displayName);
  end
   end 
  return tmp;
end end

v2 = {
  test = 3,
  config = 3,
  hi = "ghos"
};

v3 = {
  displayName = "display",
  test = 3,
  config = 3,
  hi = "ghos"
};

function u(x) do
  return x;
end end

function ff(x) do
  return x;
end end

function fff(x) do
  return x;
end end

function f(x) do
  return x;
end end

exports = {}
exports.v = v;
exports.v2 = v2;
exports.v3 = v3;
exports.u = u;
exports.ff = ff;
exports.fff = fff;
exports.f = f;
--[[ No side effect ]]
