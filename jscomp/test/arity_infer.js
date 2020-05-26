'use strict';

Curry = require("../../lib/js/curry.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f0(x) do
  tmp;
  if (x > 3) then do
    tmp = (function (x) do
        return x + 1 | 0;
      end end);
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
  return tmp(3);
end end

function f1(x) do
  throw Caml_builtin_exceptions.not_found;
  return Curry._1(undefined, x);
end end

function f3(x) do
  tmp;
  local ___conditional___=(x);
  do
     if ___conditional___ = 0 then do
        tmp = (function (x) do
            return x + 1 | 0;
          end end);end else 
     if ___conditional___ = 1 then do
        tmp = (function (x) do
            return x + 2 | 0;
          end end);end else 
     if ___conditional___ = 2 then do
        tmp = (function (x) do
            return x + 3 | 0;
          end end);end else 
     if ___conditional___ = 3 then do
        tmp = (function (x) do
            return x + 4 | 0;
          end end);end else 
     do end end end end end
    else do
      throw Caml_builtin_exceptions.not_found;
      end end
      
  end
  return tmp(3);
end end

exports.f0 = f0;
exports.f1 = f1;
exports.f3 = f3;
--[[ No side effect ]]
