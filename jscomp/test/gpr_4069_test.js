'use strict';

var Curry = require("../../lib/js/curry.js");

function f(value) do
  if (value == null) then do
    return ;
  end else do
    return value;
  end end 
end

function fxx(v) do
  var match = Curry._1(v, --[ () ]--0);
  local ___conditional___=(match);
  do
     if ___conditional___ = 1 then do
        return --[ "a" ]--97;end end end 
     if ___conditional___ = 2 then do
        return --[ "b" ]--98;end end end 
     if ___conditional___ = 3 then do
        return --[ "c" ]--99;end end end 
     do
    else do
      return --[ "d" ]--100;
      end end
      
  end
end

function fxxx2(v) do
  if (Curry._1(v, --[ () ]--0)) then do
    return 2;
  end else do
    return 1;
  end end 
end

function fxxx3(v) do
  if (Curry._1(v, --[ () ]--0)) then do
    return 2;
  end else do
    return 1;
  end end 
end

exports.f = f;
exports.fxx = fxx;
exports.fxxx2 = fxxx2;
exports.fxxx3 = fxxx3;
--[ No side effect ]--
