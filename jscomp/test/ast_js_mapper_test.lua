__console = {log = print};

Js_mapperRt = require "......lib.js.js_mapperRt";

function tToJs(param) do
  return {
          xx = param.xx,
          yy = param.yy,
          zz = param.zz
        };
end end

function tFromJs(param) do
  return {
          xx = param.xx,
          yy = param.yy,
          zz = param.zz
        };
end end

u = tToJs({
      xx = 3,
      yy = "x",
      zz = --[[ tuple ]]{
        1,
        2
      }
    });

tFromJs(u);

tFromJs({
      xx = 3,
      yy = "2",
      zz = --[[ tuple ]]{
        1,
        2
      },
      cc = 3
    });

function searchForSureExists(xs, k) do
  _i = 0;
  xs_1 = xs;
  k_1 = k;
  while(true) do
    i = _i;
    match = xs_1[i];
    if (match[1] == k_1) then do
      return match[2];
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

jsMapperConstantArray = {
  0,
  3,
  4,
  5
};

function aToJs(param) do
  return jsMapperConstantArray[param];
end end

function aFromJs(param) do
  return Js_mapperRt.fromIntAssert(4, jsMapperConstantArray, param);
end end

jsMapperConstantArray_1 = {
  --[[ tuple ]]{
    21902,
    "b0"
  },
  --[[ tuple ]]{
    21903,
    "b1"
  },
  --[[ tuple ]]{
    21904,
    "b2"
  },
  --[[ tuple ]]{
    21905,
    "b3"
  }
};

function bToJs(param) do
  return Js_mapperRt.binarySearch(4, param, jsMapperConstantArray_1);
end end

function bFromJs(param) do
  return Js_mapperRt.revSearchAssert(4, jsMapperConstantArray_1, param);
end end

bToJs(--[[ b0 ]]21902);

exports = {};
exports.tToJs = tToJs;
exports.tFromJs = tFromJs;
exports.searchForSureExists = searchForSureExists;
exports.aToJs = aToJs;
exports.aFromJs = aFromJs;
exports.bToJs = bToJs;
exports.bFromJs = bFromJs;
return exports;
--[[ u Not a pure module ]]
