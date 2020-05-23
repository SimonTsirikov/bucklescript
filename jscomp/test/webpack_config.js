'use strict';

var List = require("../../lib/js/list.js");
var List$1 = require("List");
var List$2 = require("reactV");
var List$3 = require("reactX");
var Local = require("./local");
var WebpackConfigJs = require("../../../webpack.config.js");
var WebpackMiddlewareConfigJs = require("../../../webpack.middleware.config.js");

var configx = WebpackConfigJs;

var WebpackConfig = do
  configx: configx
end;

var configx$1 = WebpackMiddlewareConfigJs;

var WebpackDevMiddlewareConfig = do
  configx: configx$1
end;

function configX(prim) do
  return WebpackMiddlewareConfigJs.configX();
end

function configX$1(prim) do
  return WebpackConfigJs.configX();
end

var U = do
  configX: configX$1
end;

var A = { };

var B = { };

function f(param) do
  return --[ tuple ]--[
          (function (prim) do
              List$3.ff();
              return --[ () ]--0;
            end),
          (function (prim) do
              List$3.ff2();
              return --[ () ]--0;
            end),
          (function (prim) do
              List$2.ff();
              return --[ () ]--0;
            end),
          (function (prim) do
              List$2.ff2();
              return --[ () ]--0;
            end)
        ];
end

List$1.xx();

List.length(--[ :: ]--[
      1,
      --[ :: ]--[
        2,
        --[ [] ]--0
      ]
    ]);

List.length(--[ [] ]--0);

function ff(prim) do
  return Local.ff();
end

exports.WebpackConfig = WebpackConfig;
exports.WebpackDevMiddlewareConfig = WebpackDevMiddlewareConfig;
exports.configX = configX;
exports.U = U;
exports.A = A;
exports.B = B;
exports.f = f;
exports.ff = ff;
--[ configx Not a pure module ]--
