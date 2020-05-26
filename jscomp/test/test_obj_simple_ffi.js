'use strict';

Caml_option = require("../../lib/js/caml_option.js");

function v(displayName, param) do
  tmp = do
    test: 3,
    config: 3,
    hi: "ghos"
  end;
  if (displayName ~= undefined) then do
    tmp.displayName = Caml_option.valFromOption(displayName);
  end
   end 
  return tmp;
end end

v2 = do
  test: 3,
  config: 3,
  hi: "ghos"
end;

v3 = do
  displayName: "display",
  test: 3,
  config: 3,
  hi: "ghos"
end;

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

exports.v = v;
exports.v2 = v2;
exports.v3 = v3;
exports.u = u;
exports.ff = ff;
exports.fff = fff;
exports.f = f;
--[[ No side effect ]]
