'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(x) do
  return x + 1 | 0;
end

function f_0(x) do
  return x - 1 | 0;
end

function f2(param) do
  if (param >= 3) do
    return --[ T003 ]--3;
  end else do
    return param;
  end
end

function f3(param) do
  return param;
end

function f4(param) do
  return 3;
end

function f5(param) do
  if (typeof param == "number") do
    switch (param) do
      case --[ A ]--0 :
          return 1;
      case --[ B ]--1 :
          return 3;
      case --[ F ]--2 :
          return 4;
      
    end
  end else do
    switch (param.tag | 0) do
      case --[ C ]--0 :
      case --[ D ]--1 :
          return 1;
      case --[ E ]--2 :
          return 2;
      
    end
  end
end

function f6(param) do
  if (typeof param == "number") do
    if (param >= 2) do
      return 2;
    end else do
      return 0;
    end
  end else do
    return 1;
  end
end

function f7(param) do
  if (typeof param == "number") do
    switch (param) do
      case --[ A ]--0 :
          return 1;
      case --[ B ]--1 :
          return 2;
      case --[ F ]--2 :
          return -1;
      
    end
  end else do
    switch (param.tag | 0) do
      case --[ C ]--0 :
          return 3;
      case --[ D ]--1 :
          return 4;
      case --[ E ]--2 :
          return -1;
      
    end
  end
end

function f8(param) do
  if (typeof param == "number") do
    switch (param) do
      case --[ T60 ]--0 :
      case --[ T61 ]--1 :
          return 1;
      default:
        return 3;
    end
  end else do
    switch (param.tag | 0) do
      case --[ T64 ]--0 :
      case --[ T65 ]--1 :
          return 2;
      default:
        return 3;
    end
  end
end

function f9(param) do
  if (typeof param == "number") do
    if (param == --[ T63 ]--3) do
      return 3;
    end else do
      return 1;
    end
  end else do
    switch (param.tag | 0) do
      case --[ T64 ]--0 :
      case --[ T65 ]--1 :
          return 2;
      case --[ T66 ]--2 :
      case --[ T68 ]--3 :
          return 3;
      
    end
  end
end

function f10(param) do
  if (typeof param == "number") do
    switch (param) do
      case --[ T60 ]--0 :
          return 0;
      case --[ T61 ]--1 :
          return 2;
      case --[ T62 ]--2 :
          return 4;
      case --[ T63 ]--3 :
          return 1;
      
    end
  end else do
    switch (param.tag | 0) do
      case --[ T64 ]--0 :
      case --[ T65 ]--1 :
          return 2;
      case --[ T66 ]--2 :
      case --[ T68 ]--3 :
          return 3;
      
    end
  end
end

function f11(x) do
  if (typeof x == "number") do
    return 2;
  end else if (x.tag) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "adt_optimize_test.ml",
            191,
            9
          ]
        ];
  end else do
    return 1;
  end
end

exports.f = f;
exports.f_0 = f_0;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
exports.f9 = f9;
exports.f10 = f10;
exports.f11 = f11;
--[ No side effect ]--
