__console = {log = print};

Caml_utils = require "......lib.js.caml_utils";

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

function _plus_great(a, h) do
  return h(a);
end end

function u(h) do
  return _plus_great(3, h);
end end

exports = {};
exports.v = v;
exports.M = M;
exports.f = f;
exports._plus_great = _plus_great;
exports.u = u;
return exports;
--[[ v Not a pure module ]]
