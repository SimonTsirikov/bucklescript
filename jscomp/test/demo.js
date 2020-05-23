'use strict';

var UI = require("@ui");
var Curry = require("../../lib/js/curry.js");
var BUI = require("@blp/ui");
var Runtime = require("@runtime");

var data = [
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
  var init = Curry._1(compile, "bid  - ask");
  var computeFunction = do
    contents: (function (env) do
        return Curry._1(init, (function (key) do
                      return Curry._2(lookup, env, key);
                    end));
      end)
  end;
  var hw1 = new BUI.HostedWindow();
  var hc = new BUI.HostedContent();
  var stackPanel = new UI.StackPanel();
  var inputCode = new UI.TextArea();
  var button = new UI.Button();
  var grid = new UI.Grid();
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
  var mk_titleRow = function (text) do
    return do
            label: do
              text: text
            end
          end;
  end;
  var u = do
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
            var hot_function = Curry._1(compile, inputCode.text);
            computeFunction.contents = (function (env) do
                return Curry._1(hot_function, (function (key) do
                              return Curry._2(lookup, env, key);
                            end));
              end);
            return --[ () ]--0;
          end
          catch (e)do
            return --[ () ]--0;
          end
        end));
  Runtime.setInterval((function () do
          grid.dataSource = Array.prototype.map.call(data, (function (param) do
                  var price = param.price;
                  var bid = price + 20 * Math.random();
                  var ask = price + 20 * Math.random();
                  var result = Curry._1(computeFunction.contents, do
                        bid: bid,
                        ask: ask
                      end);
                  return [
                          mk_titleRow(param.ticker),
                          mk_titleRow(bid.toFixed(2)),
                          mk_titleRow(ask.toFixed(2)),
                          mk_titleRow(result.toFixed(2))
                        ];
                end));
          return --[ () ]--0;
        end), 100);
  return hw1;
end

exports.data = data;
exports.ui_layout = ui_layout;
--[ @ui Not a pure module ]--
