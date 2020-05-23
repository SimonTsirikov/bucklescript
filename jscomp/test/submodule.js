'use strict';


console.log(2);

function a0(x, y) do
  return (x + y | 0) + 1 | 0;
end

console.log(5);

function a1(x, y) do
  return a0(x, y) + 1 | 0;
end

console.log(8);

function a2(x, y) do
  return a1(x, y) + 1 | 0;
end

console.log(11);

function a3(x, y) do
  return a2(x, y) + 1 | 0;
end

console.log(14);

function a4(x, y) do
  return a3(x, y) + 1 | 0;
end

var A4 = do
  a4: a4
end;

var A3 = do
  a3: a3,
  A4: A4
end;

var A2 = do
  a2: a2,
  A3: A3
end;

var A1 = do
  a1: a1,
  A2: A2
end;

var A0 = do
  a0: a0,
  A1: A1
end;

var v1 = a1(1, 2);

var v2 = a2(1, 2);

var v3 = a3(1, 2);

var v4 = a4(1, 2);

var v0 = 4;

exports.A0 = A0;
exports.v0 = v0;
exports.v1 = v1;
exports.v2 = v2;
exports.v3 = v3;
exports.v4 = v4;
--[  Not a pure module ]--
