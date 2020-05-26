'use strict';

Curry = require("../../lib/js/curry.js");
Caml_splice_call = require("../../lib/js/caml_splice_call.js");

Curry$1 = { };

Block = { };

xbs = Array.prototype.map.call([
      1,
      2,
      3,
      5
    ], (function (x) do
        return x + 1 | 0;
      end));

function f(cb) do
  return Array.prototype.map.call([
              1,
              2,
              3,
              4
            ], Curry.__1(cb));
end

xs = Array.prototype.map.call([
      1,
      1,
      2
    ], (function (x) do
        return (function (y) do
            return (y + x | 0) + 1 | 0;
          end);
      end));

function f_0(param) do
  return hi((function () do
                return --[ () ]--0;
              end));
end

function f_01(param) do
  return hi((function () do
                console.log("x");
                return --[ () ]--0;
              end));
end

function f_02(xs) do
  return hi((function () do
                xs.contents = --[ () ]--0;
                console.log("x");
                return --[ () ]--0;
              end));
end

function f_03(xs, u) do
  return hi((function () do
                return Curry._1(u, --[ () ]--0);
              end));
end

function fishy(x, y, z) do
  return map2(x, y, Curry.__2(z));
end

function h(x, y, z) do
  return map2(x, y, Curry.__2(z));
end

function h1(x, y, u, z) do
  partial_arg = Curry._1(z, u);
  return map2(x, y, Curry.__2(partial_arg));
end

function add3(x, y, z) do
  return (x + y | 0) + z | 0;
end

function h2(x) do
  return ff(x, (function (prim, prim$1) do
                return prim + prim$1 | 0;
              end));
end

function h3(x) do
  return ff(x, (function (param, param$1) do
                return add3(1, param, param$1);
              end));
end

function h4(x) do
  return ff1(x, 3, (function (param, param$1) do
                return add3(1, param, param$1);
              end));
end

function h5(x) do
  return ff2(x, "3", (function (param, param$1) do
                return add3(2, param, param$1);
              end));
end

function add(x, y) do
  console.log(--[ tuple ]--[
        x,
        y
      ]);
  return x + y | 0;
end

function h6(x) do
  return ff2(x, "3", add);
end

function unit_magic(param) do
  console.log("noinline");
  console.log("noinline");
  return 3;
end

f_unit_magic = unit_magic(--[ () ]--0);

function hh(xs) do
  return (function (param) do
      Caml_splice_call.spliceApply(f_0002, [
            xs,
            param
          ]);
      return --[ () ]--0;
    end);
end

exports.Curry = Curry$1;
exports.Block = Block;
exports.xbs = xbs;
exports.f = f;
exports.xs = xs;
exports.f_0 = f_0;
exports.f_01 = f_01;
exports.f_02 = f_02;
exports.f_03 = f_03;
exports.fishy = fishy;
exports.h = h;
exports.h1 = h1;
exports.add3 = add3;
exports.h2 = h2;
exports.h3 = h3;
exports.h4 = h4;
exports.h5 = h5;
exports.add = add;
exports.h6 = h6;
exports.unit_magic = unit_magic;
exports.f_unit_magic = f_unit_magic;
exports.hh = hh;
--[ xbs Not a pure module ]--
