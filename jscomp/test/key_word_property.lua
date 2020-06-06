console = {log = print};

Vscode = require "vs";
SomeEs6Module = require "some-es6-mo";

__default = SomeEs6Module.default;

__window = Vscode.window;

function mk(__window, __default) do
  return {
          window = __window,
          default = __default
        };
end end

function mk2(__window, __default) do
  return --[[ :: ]]{
          {
            window = __window,
            default = __default
          },
          --[[ [] ]]0
        };
end end

function des(v) do
  return {
          window = v.window,
          default = v.default
        };
end end

test = {
  case = 3,
  window = 3
};

function u(param) do
  return __window.switch();
end end

__case = 3;

exports = {}
exports.__default = __default;
exports.default = __default;
exports.__esModule = true;
exports.__window = __window;
exports.mk = mk;
exports.mk2 = mk2;
exports.des = des;
exports.__case = __case;
exports.test = test;
exports.u = u;
--[[ default Not a pure module ]]
