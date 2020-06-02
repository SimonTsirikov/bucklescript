console = {log = print};


x = (do
    x: 3,
    y: 4
  end).x;

(do
    x: 3,
    y: 4
  end).x;

zz = (do
    "5": 3
  end)["5"];

(do
    "5": 3
  end)["5"];

console.log((do
          "5": 3
        end).tag | 0);

exports = {}
exports.x = x;
exports.zz = zz;
--[[ x Not a pure module ]]
