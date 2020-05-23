'use strict';

var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");

function f(param) do
  if (typeof param == "number") do
    if (param == --[ G ]--0) do
      return 4;
    end else do
      return 5;
    end
  end else do
    switch (param.tag | 0) do
      case --[ A ]--0 :
          return 0;
      case --[ B ]--1 :
          return 1;
      case --[ C ]--2 :
          return 2;
      case --[ F ]--3 :
          return 3;
      
    end
  end
end

function bind(x, f) do
  if (x.tag) do
    return x;
  end else do
    return --[ Left ]--Block.__(0, [Curry._1(f, x[0])]);
  end
end

exports.f = f;
exports.bind = bind;
--[ No side effect ]--
