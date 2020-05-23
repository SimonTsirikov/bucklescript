'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(x) do
  if (x > 3 or x < 1) do
    throw [
          Caml_builtin_exceptions.match_failure,
          --[ tuple ]--[
            "test_incomplete.ml",
            3,
            2
          ]
        ];
  end else do
    return --[ "a" ]--97;
  end
end

function f2(x) do
  if (x ~= undefined) do
    return 0;
  end else do
    return 1;
  end
end

function f3(x) do
  switch (x.tag | 0) do
    case --[ A ]--0 :
    case --[ C ]--2 :
        return x[0] + 1 | 0;
    case --[ B ]--1 :
    case --[ D ]--3 :
        return x[0] + 2 | 0;
    
  end
end

exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[ No side effect ]--
