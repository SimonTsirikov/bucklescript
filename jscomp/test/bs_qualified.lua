console = {log = print};

ZZ = require "";
Z = require "";
Vscode = require "vs";
GlMatrix = require "gl-ma";

function f(a, b, c) do
  Vscode.commands.executeCommands("hi", a, b, c);
  return process.env;
end end

function f2(param) do
  return --[[ tuple ]]{
          Z.a0.a1.a2.hi,
          a0.a1.a2.ho,
          Math.imul(1, 2)
        };
end end

function f3(x) do
  new (global.Buffer)(20);
  new (global.a0.a1.a2.Buffer)(20);
  new (ZZ.global.a0.a1.a2.Buffer)(100);
  new (ZZ.global.a0.a1.a2.makeBuffer3)(20);
  console.log(Math.max(1.0, 2.0));
  console.log(x.a0[0]);
  console.log(x.a0.a1[0]);
  console.log(x.a0.a1.a2[0]);
  x.a0[0] = "x";
  x.a0.a1[0] = "x";
  x.a0.a1.a2[0] = "x";
  console.log(x.a0.getX1);
  console.log(x.a0.a1.getX2);
  console.log(x.a0.a1.a2.getX3);
  x.a0.setX1 = 0;
  x.a0.a1.setX2 = 0;
  x.a0.a1.a2.setX3 = 0;
  x["a0-hi"].a1.a2.setXWeird3 = 0;
  x.a0.send1(0);
  x.a0.a1.send2(0);
  x.a0.a1.send3(0);
  x.a0.psend1(0);
  x.a0.a1.psend2(0);
  x.a0.a1.psend3(0);
  return GlMatrix.mat4.create();
end end

exports = {}
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[[ X Not a pure module ]]
