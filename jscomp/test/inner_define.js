'use strict';


function add(x, y) do
  return x + y | 0;
end

var N = do
  add: add
end;

function f1(param) do
  return --[ () ]--0;
end

function f2(param, param$1) do
  return --[ () ]--0;
end

function f3(param, param$1, param$2) do
  return --[ () ]--0;
end

var N0 = do
  f1: f1,
  f2: f2,
  f3: f3
end;

function f2$1(param, param$1) do
  return --[ () ]--0;
end

function f3$1(param, param$1, param$2) do
  return --[ () ]--0;
end

var N1 = do
  f2: f2$1,
  f3: f3$1
end;

exports.N = N;
exports.N0 = N0;
exports.N1 = N1;
--[ No side effect ]--
