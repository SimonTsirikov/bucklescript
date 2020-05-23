'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");

var x = do
  contents: 1
end;

var y = do
  contents: 2
end;

function f(param) do
  var a = do
    contents: param[0]
  end;
  var b = do
    contents: param[1]
  end;
  console.log(a, b);
  return --[ () ]--0;
end

function g(param) do
  return 3;
end

function a0(f) do
  var u = Curry._1(f, --[ () ]--0);
  if (u ~= null) do
    console.log(u);
    console.log(u);
    return 1;
  end else do
    return 0;
  end
end

function a1(f) do
  var E = Caml_exceptions.create("E");
  try do
    return Curry._1(f, --[ () ]--0);
  end
  catch (exn)do
    if (exn == E) do
      return 1;
    end else do
      throw exn;
    end
  end
end

var a = 1;

var b = 2;

exports.a = a;
exports.b = b;
exports.x = x;
exports.y = y;
exports.f = f;
exports.g = g;
exports.a0 = a0;
exports.a1 = a1;
--[ No side effect ]--
