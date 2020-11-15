__console = {log = print};

Foo_class = require "xx.foo_c";

function f(param) do
  return new Foo_class(3);
end end

function v(param) do
  return Foo_class.ff(3);
end end

exports = {};
exports.f = f;
exports.v = v;
return exports;
--[[ xx/foo_class Not a pure module ]]
