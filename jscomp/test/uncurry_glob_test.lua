console = {log = print};

Caml_utils = require "../../lib/js/caml_utils";

v = Caml_utils.repeat(100, "x");

function M(U) do
  v = U.f(100, "x");
  return {
          v = v
        };
end end

function f() do
  return 3;
end end

f();

function $plus$great(a, h) do
  return h(a);
end end

function u(h) do
  return $plus$great(3, h);
end end

exports = {}
exports.v = v;
exports.M = M;
exports.f = f;
exports.$plus$great = $plus$great;
exports.u = u;
--[[ v Not a pure module ]]
