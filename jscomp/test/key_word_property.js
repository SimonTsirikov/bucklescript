'use strict';

Vscode = require("vscode");
SomeEs6Module = require("some-es6-module");

$$default = SomeEs6Module.default;

$$window = Vscode.window;

function mk($$window, $$default) do
  return do
          window: $$window,
          default: $$default
        end;
end end

function mk2($$window, $$default) do
  return --[[ :: ]][
          do
            window: $$window,
            default: $$default
          end,
          --[[ [] ]]0
        ];
end end

function des(v) do
  return do
          window: v.window,
          default: v.default
        end;
end end

test = do
  case: 3,
  window: 3
end;

function u(param) do
  return $$window.switch();
end end

$$case = 3;

exports.$$default = $$default;
exports.default = $$default;
exports.__esModule = true;
exports.$$window = $$window;
exports.mk = mk;
exports.mk2 = mk2;
exports.des = des;
exports.$$case = $$case;
exports.test = test;
exports.u = u;
--[[ default Not a pure module ]]
