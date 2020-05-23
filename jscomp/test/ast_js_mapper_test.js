'use strict';

var Js_mapperRt = require("../../lib/js/js_mapperRt.js");

function tToJs(param) do
  return do
          xx: param.xx,
          yy: param.yy,
          zz: param.zz
        end;
end

function tFromJs(param) do
  return do
          xx: param.xx,
          yy: param.yy,
          zz: param.zz
        end;
end

var u = tToJs(do
      xx: 3,
      yy: "x",
      zz: --[ tuple ]--[
        1,
        2
      ]
    end);

tFromJs(u);

tFromJs(do
      xx: 3,
      yy: "2",
      zz: --[ tuple ]--[
        1,
        2
      ],
      cc: 3
    end);

function searchForSureExists(xs, k) do
  var _i = 0;
  var xs$1 = xs;
  var k$1 = k;
  while(true) do
    var i = _i;
    var match = xs$1[i];
    if (match[0] == k$1) then do
      return match[1];
    end else do
      _i = i + 1 | 0;
      continue ;
    end end 
  end;
end

var jsMapperConstantArray = [
  0,
  3,
  4,
  5
];

function aToJs(param) do
  return jsMapperConstantArray[param];
end

function aFromJs(param) do
  return Js_mapperRt.fromIntAssert(4, jsMapperConstantArray, param);
end

var jsMapperConstantArray$1 = [
  --[ tuple ]--[
    21902,
    "b0"
  ],
  --[ tuple ]--[
    21903,
    "b1"
  ],
  --[ tuple ]--[
    21904,
    "b2"
  ],
  --[ tuple ]--[
    21905,
    "b3"
  ]
];

function bToJs(param) do
  return Js_mapperRt.binarySearch(4, param, jsMapperConstantArray$1);
end

function bFromJs(param) do
  return Js_mapperRt.revSearchAssert(4, jsMapperConstantArray$1, param);
end

bToJs(--[ b0 ]--21902);

exports.tToJs = tToJs;
exports.tFromJs = tFromJs;
exports.searchForSureExists = searchForSureExists;
exports.aToJs = aToJs;
exports.aFromJs = aFromJs;
exports.bToJs = bToJs;
exports.bFromJs = bFromJs;
--[ u Not a pure module ]--
