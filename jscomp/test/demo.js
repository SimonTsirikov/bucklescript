'use strict';

UI = require("@ui");
Curry = require("../../lib/js/curry.js");
BUI = require("@blp/ui");
Runtime = require("@runtime");

data = [
  do
    ticker: "GOOG",
    price: 700.0
  end,
  do
    ticker: "AAPL",
    price: 500.0
  end,
  do
    ticker: "MSFT",
    price: 300.0
  end
];

function ui_layout(compile, lookup, appContext) do
  init = Curry._1(compile, "bid  - ask");
  computeFunction = do
    contents: (function (env) do
        return Curry._1(init, (function (key) do
                      return Curry._2(lookup, env, key);
                    end end));
      end end)
  end;
  hw1 = new BUI.HostedWindow();
  hc = new BUI.HostedContent();
  stackPanel = new UI.StackPanel();
  inputCode = new UI.TextArea();
  button = new UI.Button();
  grid = new UI.Grid();
  hw1.appContext = appContext;
  hw1.title = "Test Application From OCaml";
  hw1.content = hc;
  hc.contentWidth = 700;
  hc.content = stackPanel;
  stackPanel.orientation = "vertical";
  stackPanel.minHeight = 10000;
  stackPanel.minWidth = 4000;
  stackPanel.addChild(grid);
  stackPanel.addChild(inputCode);
  stackPanel.addChild(button);
  mk_titleRow = function (text) do
    return do
            label: do
              text: text
            end
          end;
  end end;
  u = do
    width: 200
  end;
  grid.minHeight = 300;
  grid.titleRows = [
    do
      label: do
        text: "Ticker"
      end
    end,
    do
      label: do
        text: "Bid"
      end
    end,
    do
      label: do
        text: "Ask"
      end
    end,
    do
      label: do
        text: "Result"
      end
    end
  ];
  grid.columns = [
    u,
    u,
    u,
    u
  ];
  inputCode.text = " bid - ask";
  inputCode.minHeight = 100;
  button.text = "update formula";
  button.minHeight = 20;
  button.on("click", (function (_event) do
          try do
            hot_function = Curry._1(compile, inputCode.text);
            computeFunction.contents = (function (env) do
                return Curry._1(hot_function, (function (key) do
                              return Curry._2(lookup, env, key);
                            end end));
              end end);
            return --[[ () ]]0;
          end
          catch (e)do
            return --[[ () ]]0;
          end
        end end));
  Runtime.setInterval((function () do
          grid.dataSource = Array.prototype.map.call(data, (function (param) do
                  price = param.price;
                  bid = price + 20 * Math.random();
                  ask = price + 20 * Math.random();
                  result = Curry._1(computeFunction.contents, do
                        bid: bid,
                        ask: ask
                      end);
                  return [
                          mk_titleRow(param.ticker),
                          mk_titleRow(bid.toFixed(2)),
                          mk_titleRow(ask.toFixed(2)),
                          mk_titleRow(result.toFixed(2))
                        ];
                end end));
          return --[[ () ]]0;
        end end), 100);
  return hw1;
end end

exports.data = data;
exports.ui_layout = ui_layout;
--[[ @ui Not a pure module ]]
