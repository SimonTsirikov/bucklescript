__console = {log = print};

ZZ = require "X";
Z = require "z";
Vscode = require "vs";
GlMatrix = require "gl-ma";

function f(a, b, c) do
  Vscode.commands.executeCommands("hi", a, b, c);
  return __process.env;
end end

function f2(param) do
  return --[[ tuple ]]{
          Z.a0.a1.a2.hi,
          a0.a1.a2.ho,
          __Math.imul(1, 2)
        };
end end

function f3(x) do
  new (__global.__Buffer)(20);
  new (__global.a0.a1.a2.__Buffer)(20);
  new (ZZ.__global.a0.a1.a2.__Buffer)(100);
  new (ZZ.__global.a0.a1.a2.makeBuffer3)(20);
  __console.log(__Math.max(1.0, 2.0));
  __console.log(x.a0[0]);
  __console.log(x.a0.a1[0]);
  __console.log(x.a0.a1.a2[0]);
  x.a0[0] = "x";
  x.a0.a1[0] = "x";
  x.a0.a1.a2[0] = "x";
  __console.log(x.a0.getX1);
  __console.log(x.a0.a1.getX2);
  __console.log(x.a0.a1.a2.getX3);
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

exports = {};
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
return exports;
--[[ X Not a pure module ]]
