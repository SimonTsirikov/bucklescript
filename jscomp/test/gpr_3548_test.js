'use strict';

var Js_mapperRt = require("../../lib/js/js_mapperRt.js");

var jsMapperConstantArray = [
  --[ tuple ]--[
    -1010337642,
    "vertical"
  ],
  --[ tuple ]--[
    208994564,
    "horizontal"
  ]
];

function orientationToJs(param) do
  return Js_mapperRt.binarySearch(2, param, jsMapperConstantArray);
end

function orientationFromJs(param) do
  return Js_mapperRt.revSearch(2, jsMapperConstantArray, param);
end

console.log(orientationToJs(--[ Horizontal ]--208994564));

exports.orientationToJs = orientationToJs;
exports.orientationFromJs = orientationFromJs;
--[  Not a pure module ]--
