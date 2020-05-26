'use strict';

List = require("../../lib/js/list.js");
Curry = require("../../lib/js/curry.js");
Caml_int32 = require("../../lib/js/caml_int32.js");

function h0(x) do
  return x();
end end

function h00(x) do
  return Curry._1(x(), --[ () ]--0);
end end

function h1(x) do
  return (function (param) do
      return x(param);
    end end);
end end

function h10(x) do
  return x(3);
end end

function h30(x) do
  return (function (param) do
      return x(3, 3, param);
    end end);
end end

function h33(x) do
  return x(1, 2, 3);
end end

function h34(x) do
  return Curry._1(x(1, 2, 3), 4);
end end

function ocaml_run(param, param$1) do
  return (function (x, y, z) do
              return (x + y | 0) + z | 0;
            end end)(1, param, param$1);
end end

function a0() do
  console.log("hi");
  return --[ () ]--0;
end end

function a1(param) do
  return (function (x) do
      return x;
    end end);
end end

function a2(x, y) do
  return x + y | 0;
end end

function a3(x, y, z) do
  return (x + y | 0) + z | 0;
end end

function a4(x, y, z, param) do
  u = (Caml_int32.imul(x, x) + Caml_int32.imul(y, y) | 0) + Caml_int32.imul(z, z) | 0;
  return (function (d) do
              return u + d | 0;
            end end)(param);
end end

function a44(x, y, z, d) do
  u = (Caml_int32.imul(x, x) + Caml_int32.imul(y, y) | 0) + Caml_int32.imul(z, z) | 0;
  return u + d | 0;
end end

function b44(param) do
  return (function (x, y, z, d) do
      return --[ tuple ]--[
              x,
              y,
              z,
              d
            ];
    end end);
end end

function xx(param) do
  return (function (param) do
      console.log(3);
      return --[ () ]--0;
    end end);
end end

test_as = List.map;

exports.h0 = h0;
exports.h00 = h00;
exports.h1 = h1;
exports.h10 = h10;
exports.h30 = h30;
exports.h33 = h33;
exports.h34 = h34;
exports.ocaml_run = ocaml_run;
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.a3 = a3;
exports.a4 = a4;
exports.a44 = a44;
exports.b44 = b44;
exports.test_as = test_as;
exports.xx = xx;
--[ No side effect ]--
