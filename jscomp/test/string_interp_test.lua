__console = {log = print};


function hi2(xx, yy, zz) do
  return "\n" .. (__String(xx) .. (" " .. (__String(yy) .. ("\n\n" .. (__String(zz) .. "\n")))));
end end

function hi(a0, b0, xx, yy, zz) do
  return "\n零一二三四五六七八九 " .. (__String(a0) .. ("\n零一二三四五六七八九 123456789 " .. (__String(b0) .. ("\n测试一段中文 " .. (__String(xx) .. (", " .. (__String(yy) .. ("\n" .. (__String(zz) .. "\n\n")))))))));
end end

function a3(world) do
  return "Hello \\" .. (__String(world) .. "");
end end

function a5(x) do
  return "" .. (__String(x) .. "");
end end

function a6(x) do
  return "" .. (__String(x) .. "");
end end

function a7(x0, x3, x5) do
  return "\\" .. (__String(x0) .. (",\$x1,\\\$x2,\\\\" .. (__String(x3) .. (", \\\\\$x4,\\\\\\" .. (__String(x5) .. "")))));
end end

function ffff(a_1, a_2) do
  return " hello " .. (__String(a_1) .. (", wlecome to " .. (__String(a_2) .. "  ")));
end end

function f(x, y) do
  sum = x + y | 0;
  __console.log(" " .. (__String(x) .. (" + " .. (__String(y) .. (" = " .. (__String(sum) .. " "))))));
  return --[[ () ]]0;
end end

world = "世界";

hello_world = "你好，" .. (__String(world) .. "");

function test1(x0) do
  return "你好，" .. (__String(x0) .. "");
end end

function test3(_xg) do
  return "你好，" .. (__String(_xg) .. "");
end end

function test5(x) do
  return "" .. (__String(x) .. "");
end end

b = "test";

c = "test";

a = "test";

a0 = "Hello \\";

a1 = "Hello \\";

a2 = "Hello \$";

a4 = "";

exports = {};
exports.hi2 = hi2;
exports.hi = hi;
exports.b = b;
exports.c = c;
exports.a = a;
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.a3 = a3;
exports.a4 = a4;
exports.a5 = a5;
exports.a6 = a6;
exports.a7 = a7;
exports.ffff = ffff;
exports.f = f;
exports.world = world;
exports.hello_world = hello_world;
exports.test1 = test1;
exports.test3 = test3;
exports.test5 = test5;
return exports;
--[[ hello_world Not a pure module ]]
