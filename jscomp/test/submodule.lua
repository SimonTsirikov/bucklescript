console = {log = print};


console.log(2);

function a0(x, y) do
  return (x + y | 0) + 1 | 0;
end end

console.log(5);

function a1(x, y) do
  return a0(x, y) + 1 | 0;
end end

console.log(8);

function a2(x, y) do
  return a1(x, y) + 1 | 0;
end end

console.log(11);

function a3(x, y) do
  return a2(x, y) + 1 | 0;
end end

console.log(14);

function a4(x, y) do
  return a3(x, y) + 1 | 0;
end end

A4 = {
  a4 = a4
};

A3 = {
  a3 = a3,
  A4 = A4
};

A2 = {
  a2 = a2,
  A3 = A3
};

A1 = {
  a1 = a1,
  A2 = A2
};

A0 = {
  a0 = a0,
  A1 = A1
};

v1 = a1(1, 2);

v2 = a2(1, 2);

v3 = a3(1, 2);

v4 = a4(1, 2);

v0 = 4;

exports = {}
exports.A0 = A0;
exports.v0 = v0;
exports.v1 = v1;
exports.v2 = v2;
exports.v3 = v3;
exports.v4 = v4;
--[[  Not a pure module ]]
