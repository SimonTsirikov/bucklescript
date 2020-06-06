console = {log = print};


x = ({
    x = 3,
    y = 4
  }).x;

({
    x = 3,
    y = 4
  }).x;

zz = ({
    "5" = 3
  })["5"];

({
    "5" = 3
  })["5"];

console.log(({
          "5" = 3
        }).tag | 0);

exports = {}
exports.x = x;
exports.zz = zz;
--[[ x Not a pure module ]]
