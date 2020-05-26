'use strict';

Caml_array = require("../../lib/js/caml_array.js");

function g(x) do
  return [
          3,
          x
        ];
end end

function ff(v, u) do
  return do
          v: v,
          u: u
        end;
end end

function fff(vv, uu) do
  return do
          vv: vv,
          uu: uu
        end;
end end

function a(x) do
  return Caml_array.caml_array_get(x, 0);
end end

function aa(x) do
  return Caml_array.caml_array_get(x, 0);
end end

function aaa(x) do
  return x.v;
end end

function aaaa(x) do
  return x.vv;
end end

function f(x) do
  for i = 0 , 10 , 1 do
    Caml_array.caml_array_set(x, i, i);
  end
  return --[ () ]--0;
end end

exports.g = g;
exports.ff = ff;
exports.fff = fff;
exports.a = a;
exports.aa = aa;
exports.aaa = aaa;
exports.aaaa = aaaa;
exports.f = f;
--[ No side effect ]--
