'use strict';

var Caml_utils = require("../../lib/js/caml_utils.js");

var v = Caml_utils.repeat(100, "x");

function M(U) do
  var v = U.f(100, "x");
  return do
          v: v
        end;
end

function f() do
  return 3;
end

f();

function $plus$great(a, h) do
  return h(a);
end

function u(h) do
  return $plus$great(3, h);
end

exports.v = v;
exports.M = M;
exports.f = f;
exports.$plus$great = $plus$great;
exports.u = u;
--[ v Not a pure module ]--
