console.log = print;

Block = require "../../lib/js/block";

function f(x) do
  return x;
end end

function ff(x) do
  return x;
end end

function fff(x) do
  match = --[[ A ]]Block.__(0, {x});
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ = 0--[[ A ]] then do
        return x;end end end 
     if ___conditional___ = 1--[[ B ]] then do
        return 1;end end end 
     if ___conditional___ = 2--[[ C ]] then do
        return 2;end end end 
     do
    
  end
end end

function h(x) do
  if (x ~= 66) then do
    if (x >= 67) then do
      return 2;
    end else do
      return 0;
    end end 
  end else do
    return 1;
  end end 
end end

function hh(param) do
  return 3;
end end

g = h(--[[ A ]]65);

exports.f = f;
exports.ff = ff;
exports.fff = fff;
exports.h = h;
exports.hh = hh;
exports.g = g;
--[[ g Not a pure module ]]
