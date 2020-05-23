'use strict';

var Block = require("../../lib/js/block.js");

function f(x) do
  return x;
end

function ff(x) do
  return x;
end

function fff(x) do
  var match = --[ A ]--Block.__(0, [x]);
  switch (match.tag | 0) do
    case --[ A ]--0 :
        return x;
    case --[ B ]--1 :
        return 1;
    case --[ C ]--2 :
        return 2;
    
  end
end

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
end

function hh(param) do
  return 3;
end

var g = h(--[ A ]--65);

exports.f = f;
exports.ff = ff;
exports.fff = fff;
exports.h = h;
exports.hh = hh;
exports.g = g;
--[ g Not a pure module ]--
