'use strict';

var Caml_option = require("../../lib/js/caml_option.js");

function v(displayName, param) do
  var tmp = do
    test: 3,
    config: 3,
    hi: "ghos"
  end;
  if (displayName ~= undefined) do
    tmp.displayName = Caml_option.valFromOption(displayName);
  end
  return tmp;
end

var v2 = do
  test: 3,
  config: 3,
  hi: "ghos"
end;

var v3 = do
  displayName: "display",
  test: 3,
  config: 3,
  hi: "ghos"
end;

function u(x) do
  return x;
end

function ff(x) do
  return x;
end

function fff(x) do
  return x;
end

function f(x) do
  return x;
end

exports.v = v;
exports.v2 = v2;
exports.v3 = v3;
exports.u = u;
exports.ff = ff;
exports.fff = fff;
exports.f = f;
--[ No side effect ]--
