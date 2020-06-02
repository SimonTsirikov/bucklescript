--[['use strict';]]

Foo_class = require "xx/foo_class";

function f(param) do
  return new Foo_class(3);
end end

function v(param) do
  return Foo_class.ff(3);
end end

exports.f = f;
exports.v = v;
--[[ xx/foo_class Not a pure module ]]
