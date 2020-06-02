--[['use strict';]]

Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function f(x) do
  if (x ~= 98) then do
    if (x >= 99) then do
      return "c";
    end else do
      return "a";
    end end 
  end else do
    return "b";
  end end 
end end

function ff(x) do
  local ___conditional___=(x);
  do
     if ___conditional___ = "a" then do
        return --[[ a ]]97;end end end 
     if ___conditional___ = "b" then do
        return --[[ b ]]98;end end end 
     if ___conditional___ = "c" then do
        return --[[ c ]]99;end end end 
     do
    else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bb.ml",
              17,
              9
            ]
          ];
      end end
      
  end
end end

function test(x) do
  match;
  local ___conditional___=(x);
  do
     if ___conditional___ = "a" then do
        match = --[[ a ]]97;end else 
     if ___conditional___ = "b" then do
        match = --[[ b ]]98;end else 
     if ___conditional___ = "c" then do
        match = --[[ c ]]99;end else 
     do end end end end
    else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bb.ml",
              26,
              13
            ]
          ];
      end end
      
  end
  if (match ~= 98) then do
    if (match >= 99) then do
      return "c";
    end else do
      return "a";
    end end 
  end else do
    return "b";
  end end 
end end

test_poly = "a";

c = f(--[[ a ]]97);

d = f(--[[ b ]]98);

e = f(--[[ c ]]99);

exports.f = f;
exports.ff = ff;
exports.test = test;
exports.test_poly = test_poly;
exports.c = c;
exports.d = d;
exports.e = e;
--[[ c Not a pure module ]]
