--[['use strict';]]

List = require "../../lib/js/list";
List_1 = require "";
List_2 = require "re";
List_3 = require "re";
Local = require "./l";
WebpackConfigJs = require "../../../webpack.confi";
WebpackMiddlewareConfigJs = require "../../../webpack.middleware.confi";

configx = WebpackConfigJs;

WebpackConfig = do
  configx: configx
end;

configx_1 = WebpackMiddlewareConfigJs;

WebpackDevMiddlewareConfig = do
  configx: configx_1
end;

function configX(prim) do
  return WebpackMiddlewareConfigJs.configX();
end end

function configX_1(prim) do
  return WebpackConfigJs.configX();
end end

U = do
  configX: configX_1
end;

A = { };

B = { };

function f(param) do
  return --[[ tuple ]]{
          (function (prim) do
              List_3.ff();
              return --[[ () ]]0;
            end end),
          (function (prim) do
              List_3.ff2();
              return --[[ () ]]0;
            end end),
          (function (prim) do
              List_2.ff();
              return --[[ () ]]0;
            end end),
          (function (prim) do
              List_2.ff2();
              return --[[ () ]]0;
            end end)
        };
end end

List_1.xx();

List.length(--[[ :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ [] ]]0
      }
    });

List.length(--[[ [] ]]0);

function ff(prim) do
  return Local.ff();
end end

exports.WebpackConfig = WebpackConfig;
exports.WebpackDevMiddlewareConfig = WebpackDevMiddlewareConfig;
exports.configX = configX;
exports.U = U;
exports.A = A;
exports.B = B;
exports.f = f;
exports.ff = ff;
--[[ configx Not a pure module ]]
