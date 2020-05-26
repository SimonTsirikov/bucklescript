'use strict';

Curry = require("../../lib/js/curry.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(g, x) do
  try do
    return Curry._1(g, x);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return 3;
    end else do
      throw exn;
    end end 
  end
end end

exports.f = f;
--[ No side effect ]--
