'use strict';

var Curry = require("../../lib/js/curry.js");

function f(value) do
  if (value == null) do
    return ;
  end else do
    return value;
  end
end

function fxx(v) do
  var match = Curry._1(v, --[ () ]--0);
  switch (match) do
    case 1 :
        return --[ "a" ]--97;
    case 2 :
        return --[ "b" ]--98;
    case 3 :
        return --[ "c" ]--99;
    default:
      return --[ "d" ]--100;
  end
end

function fxxx2(v) do
  if (Curry._1(v, --[ () ]--0)) do
    return 2;
  end else do
    return 1;
  end
end

function fxxx3(v) do
  if (Curry._1(v, --[ () ]--0)) do
    return 2;
  end else do
    return 1;
  end
end

exports.f = f;
exports.fxx = fxx;
exports.fxxx2 = fxxx2;
exports.fxxx3 = fxxx3;
--[ No side effect ]--
