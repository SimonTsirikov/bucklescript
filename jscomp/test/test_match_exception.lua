--[['use strict';]]

Curry = require "../../lib/js/curry";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(g, x) do
  xpcall(function() do
    return Curry._1(g, x);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return 3;
    end else do
      error(exn)
    end end 
  end end)
end end

exports.f = f;
--[[ No side effect ]]
