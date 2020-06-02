console = {log = print};

Js_mapperRt = require "../../lib/js/js_mapperRt";

jsMapperConstantArray = {
  --[[ tuple ]]{
    -1010337642,
    "vertical"
  },
  --[[ tuple ]]{
    208994564,
    "horizontal"
  }
};

function orientationToJs(param) do
  return Js_mapperRt.binarySearch(2, param, jsMapperConstantArray);
end end

function orientationFromJs(param) do
  return Js_mapperRt.revSearch(2, jsMapperConstantArray, param);
end end

console.log(orientationToJs(--[[ Horizontal ]]208994564));

exports = {}
exports.orientationToJs = orientationToJs;
exports.orientationFromJs = orientationFromJs;
--[[  Not a pure module ]]
