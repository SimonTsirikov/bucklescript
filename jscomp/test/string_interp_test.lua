console = {log = print};


function hi2(xx, yy, zz) do
  return "\n" .. (String(xx) .. (" " .. (String(yy) .. ("\n\n" .. (String(zz) .. "\n")))));
end end

function hi(a0, b0, xx, yy, zz) do
  return "\n零一二三四五六七八九 " .. (String(a0) .. ("\n零一二三四五六七八九 123456789 " .. (String(b0) .. ("\n测试一段中文 " .. (String(xx) .. (", " .. (String(yy) .. ("\n" .. (String(zz) .. "\n\n")))))))));
end end

function a3(world) do
  return "Hello \\" .. (String(world) .. "");
end end

function a5(x) do
  return "" .. (String(x) .. "");
end end

function a6(x) do
  return "" .. (String(x) .. "");
end end

function a7(x0, x3, x5) do
  return "\\" .. (String(x0) .. (",\$x1,\\\$x2,\\\\" .. (String(x3) .. (", \\\\\$x4,\\\\\\" .. (String(x5) .. "")))));
end end

function ffff(a_1, a_2) do
  return " hello " .. (String(a_1) .. (", wlecome to " .. (String(a_2) .. "  ")));
end end

function f(x, y) do
  sum = x + y | 0;
  console.log(" " .. (String(x) .. (" + " .. (String(y) .. (" = " .. (String(sum) .. " "))))));
  return --[[ () ]]0;
end end

world = "世界";

hello_world = "你好，" .. (String(world) .. "");

function test1(x0) do
  return "你好，" .. (String(x0) .. "");
end end

function test3(_xg) do
  return "你好，" .. (String(_xg) .. "");
end end

function test5(x) do
  return "" .. (String(x) .. "");
end end

b = "test";

c = "test";

a = "test";

a0 = "Hello \\";

a1 = "Hello \\";

a2 = "Hello \$";

a4 = "";

exports = {}
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
--[[ hello_world Not a pure module ]]