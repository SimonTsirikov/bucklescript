'use strict';

var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_option = require("../../lib/js/caml_option.js");

function eq_A(x, y) do
  if (x.tag or y.tag) do
    return false;
  end else do
    return x[0] == y[0];
  end
end

function Test($star) do
  console.log("no inline");
  var u = --[ A ]--Block.__(0, [3]);
  var Block$1 = { };
  var b = eq_A(--[ A ]--Block.__(0, [3]), u);
  return do
          u: u,
          Block: Block$1,
          y: 32,
          b: b
        end;
end

function Test2($star) do
  console.log("no inline");
  var Block$1 = { };
  var b = eq_A(--[ A ]--Block.__(0, [3]), --[ A ]--Block.__(0, [3]));
  return do
          Block: Block$1,
          y: 32,
          b: b
        end;
end

function f(i, y) do
  var x = --[ A ]--Block.__(0, [i]);
  return eq_A(x, y);
end

function Test3($star) do
  var f = Caml_obj.caml_equal;
  var Caml_obj$1 = { };
  return do
          f: f,
          Caml_obj: Caml_obj$1
        end;
end

function Test4($star) do
  var Caml_obj$1 = { };
  var f = Caml_obj.caml_equal;
  return do
          Caml_obj: Caml_obj$1,
          f: f
        end;
end

function Test5($star) do
  var f = function (x) do
    return Caml_option.some(x);
  end;
  var Caml_option$1 = { };
  return do
          f: f,
          Caml_option: Caml_option$1
        end;
end

function Test6($star) do
  var Caml_option$1 = { };
  var f = function (x) do
    return Caml_option.some(x);
  end;
  return do
          Caml_option: Caml_option$1,
          f: f
        end;
end

function Test7($star) do
  var Caml_option = { };
  return do
          Caml_option: Caml_option
        end;
end

function Test8($star) do
  var Curry$1 = { };
  var f = function (x) do
    return Curry._1(x, 1);
  end;
  return do
          Curry: Curry$1,
          f: f
        end;
end

function Test9($star) do
  var f = function (x) do
    return Curry._1(x, 1);
  end;
  var Curry$1 = { };
  return do
          f: f,
          Curry: Curry$1
        end;
end

function Test10($star) do
  var Curry = { };
  return do
          Curry: Curry
        end;
end

var x = 3;

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
