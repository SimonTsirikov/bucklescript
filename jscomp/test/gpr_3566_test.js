'use strict';

Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_option = require("../../lib/js/caml_option.js");

function eq_A(x, y) do
  if (x.tag or y.tag) then do
    return false;
  end else do
    return x[0] == y[0];
  end end 
end

function Test($star) do
  console.log("no inline");
  u = --[ A ]--Block.__(0, [3]);
  Block$1 = { };
  b = eq_A(--[ A ]--Block.__(0, [3]), u);
  return do
          u: u,
          Block: Block$1,
          y: 32,
          b: b
        end;
end

function Test2($star) do
  console.log("no inline");
  Block$1 = { };
  b = eq_A(--[ A ]--Block.__(0, [3]), --[ A ]--Block.__(0, [3]));
  return do
          Block: Block$1,
          y: 32,
          b: b
        end;
end

function f(i, y) do
  x = --[ A ]--Block.__(0, [i]);
  return eq_A(x, y);
end

function Test3($star) do
  f = Caml_obj.caml_equal;
  Caml_obj$1 = { };
  return do
          f: f,
          Caml_obj: Caml_obj$1
        end;
end

function Test4($star) do
  Caml_obj$1 = { };
  f = Caml_obj.caml_equal;
  return do
          Caml_obj: Caml_obj$1,
          f: f
        end;
end

function Test5($star) do
  f = function (x) do
    return Caml_option.some(x);
  end;
  Caml_option$1 = { };
  return do
          f: f,
          Caml_option: Caml_option$1
        end;
end

function Test6($star) do
  Caml_option$1 = { };
  f = function (x) do
    return Caml_option.some(x);
  end;
  return do
          Caml_option: Caml_option$1,
          f: f
        end;
end

function Test7($star) do
  Caml_option = { };
  return do
          Caml_option: Caml_option
        end;
end

function Test8($star) do
  Curry$1 = { };
  f = function (x) do
    return Curry._1(x, 1);
  end;
  return do
          Curry: Curry$1,
          f: f
        end;
end

function Test9($star) do
  f = function (x) do
    return Curry._1(x, 1);
  end;
  Curry$1 = { };
  return do
          f: f,
          Curry: Curry$1
        end;
end

function Test10($star) do
  Curry = { };
  return do
          Curry: Curry
        end;
end

x = 3;

exports.eq_A = eq_A;
exports.Test = Test;
exports.Test2 = Test2;
exports.x = x;
exports.f = f;
exports.Test3 = Test3;
exports.Test4 = Test4;
exports.Test5 = Test5;
exports.Test6 = Test6;
exports.Test7 = Test7;
exports.Test8 = Test8;
exports.Test9 = Test9;
exports.Test10 = Test10;
--[ No side effect ]--
