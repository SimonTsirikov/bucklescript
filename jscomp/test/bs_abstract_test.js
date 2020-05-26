'use strict';

Curry = require("../../lib/js/curry.js");

v = do
  hd: 3,
  tl: null
end;

v.tl = v;

f = do
  k: (function (x, y) do
      return x == y;
    end end),
  y: "x"
end;

function uf(u) do
  return Curry._1(u.y0, 1);
end end

function uf1(u) do
  return Curry._1(u.y1, 1);
end end

function uf2(u) do
  return Curry._2(u.y1, 1, 2);
end end

function uff(f) do
  return f.yyyy(1);
end end

function uff2(f) do
  return f.yyyy1(1, 2);
end end

function uff3(f) do
  match = f.yyyy2;
  if (match ~= undefined) then do
    return Curry._1(match, 0);
  end else do
    return 0;
  end end 
end end

function fx(v) do
  return v.x;
end end

exports.f = f;
exports.uf = uf;
exports.uf1 = uf1;
exports.uf2 = uf2;
exports.uff = uff;
exports.uff2 = uff2;
exports.uff3 = uff3;
exports.fx = fx;
--[[  Not a pure module ]]
