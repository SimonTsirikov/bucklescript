'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f0(x) do
  var tmp;
  if (x > 3) do
    tmp = (function (x) do
        return x + 1 | 0;
      end);
  end else do
    throw Caml_builtin_exceptions.not_found;
  end
  return tmp(3);
end

function f1(x) do
  throw Caml_builtin_exceptions.not_found;
  return Curry._1(undefined, x);
end

function f3(x) do
  var tmp;
  switch (x) do
    case 0 :
        tmp = (function (x) do
            return x + 1 | 0;
          end);
        break;
    case 1 :
        tmp = (function (x) do
            return x + 2 | 0;
          end);
        break;
    case 2 :
        tmp = (function (x) do
            return x + 3 | 0;
          end);
        break;
    case 3 :
        tmp = (function (x) do
            return x + 4 | 0;
          end);
        break;
    default:
      throw Caml_builtin_exceptions.not_found;
  end
  return tmp(3);
end

exports.f0 = f0;
exports.f1 = f1;
exports.f3 = f3;
--[ No side effect ]--
