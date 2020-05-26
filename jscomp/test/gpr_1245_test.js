'use strict';

Curry = require("../../lib/js/curry.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");

x = do
  contents: 1
end;

y = do
  contents: 2
end;

function f(param) do
  a = do
    contents: param[0]
  end;
  b = do
    contents: param[1]
  end;
  console.log(a, b);
  return --[ () ]--0;
end

function g(param) do
  return 3;
end

function a0(f) do
  u = Curry._1(f, --[ () ]--0);
  if (u ~= null) then do
    console.log(u);
    console.log(u);
    return 1;
  end else do
    return 0;
  end end 
end

function a1(f) do
  E = Caml_exceptions.create("E");
  try do
    return Curry._1(f, --[ () ]--0);
  end
  catch (exn)do
    if (exn == E) then do
      return 1;
    end else do
      throw exn;
    end end 
  end
end

a = 1;

b = 2;

exports.a = a;
exports.b = b;
exports.x = x;
exports.y = y;
exports.f = f;
exports.g = g;
exports.a0 = a0;
exports.a1 = a1;
--[ No side effect ]--
