console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Js_mapperRt = require "../../lib/js/js_mapperRt";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function tToJs(param) do
  return {
          x = param.x,
          y = param.y,
          z = param.z
        };
end end

function tFromJs(param) do
  return {
          x = param.x,
          y = param.y,
          z = param.z
        };
end end

v0 = {
  x = 3,
  y = false,
  z = false
};

v1 = {
  x = 3,
  y = false,
  z = ""
};

jsMapperConstantArray = {
  --[[ tuple ]]{
    97,
    "a"
  },
  --[[ tuple ]]{
    98,
    "b"
  },
  --[[ tuple ]]{
    99,
    "c"
  }
};

function xToJs(param) do
  return Js_mapperRt.binarySearch(3, param, jsMapperConstantArray);
end end

function xFromJs(param) do
  return Js_mapperRt.revSearchAssert(3, jsMapperConstantArray, param);
end end

function idx(v) do
  return eq("File \"ast_abstract_test.ml\", line 32, characters 17-24", xFromJs(xToJs(v)), v);
end end

x0 = xToJs(--[[ a ]]97);

x1 = xToJs(--[[ b ]]98);

idx(--[[ a ]]97);

idx(--[[ b ]]98);

idx(--[[ c ]]99);

jsMapperConstantArray_1 = {
  0,
  3,
  4
};

function aToJs(param) do
  return jsMapperConstantArray_1[param];
end end

function aFromJs(param) do
  return Js_mapperRt.fromIntAssert(3, jsMapperConstantArray_1, param);
end end

function id(x) do
  return eq("File \"ast_abstract_test.ml\", line 49, characters 8-15", aFromJs(aToJs(x)), x);
end end

a0 = aToJs(--[[ A ]]0);

a1 = aToJs(--[[ B ]]1);

id(--[[ A ]]0);

id(--[[ B ]]1);

id(--[[ C ]]2);

function bToJs(param) do
  return param + 0 | 0;
end end

function bFromJs(param) do
  if (not (param <= 3 and 0 <= param)) then do
    error(new Error("ASSERT FAILURE"))
  end
   end 
  return param - 0 | 0;
end end

b0 = 0;

b1 = 1;

function idb(v) do
  return eq("File \"ast_abstract_test.ml\", line 71, characters 5-12", bFromJs(v + 0 | 0), v);
end end

idb(--[[ D0 ]]0);

idb(--[[ D1 ]]1);

idb(--[[ D2 ]]2);

idb(--[[ D3 ]]3);

function cToJs(param) do
  return param + 3 | 0;
end end

function cFromJs(param) do
  if (not (param <= 6 and 3 <= param)) then do
    error(new Error("ASSERT FAILURE"))
  end
   end 
  return param - 3 | 0;
end end

c0 = 3;

function idc(v) do
  return eq("File \"ast_abstract_test.ml\", line 83, characters 15-22", cFromJs(v + 3 | 0), v);
end end

idc(--[[ D0 ]]0);

idc(--[[ D1 ]]1);

idc(--[[ D2 ]]2);

idc(--[[ D3 ]]3);

function hToJs(param) do
  return param + 0 | 0;
end end

function hFromJs(param) do
  if (not (param <= 1 and 0 <= param)) then do
    error(new Error("ASSERT FAILURE"))
  end
   end 
  return param - 0 | 0;
end end

function zToJs(param) do
  return param + 0 | 0;
end end

function zFromJs(param) do
  if (param <= 2 and 0 <= param) then do
    return param - 0 | 0;
  end
   end 
end end

Mt.from_pair_suites("Ast_abstract_test", suites.contents);

jsMapperEraseType = --[[ JsMapperEraseType ]]0;

b = --[[ B ]]1;

zXx = --[[ ZXx ]]2;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.tToJs = tToJs;
exports.tFromJs = tFromJs;
exports.v0 = v0;
exports.v1 = v1;
exports.xToJs = xToJs;
exports.xFromJs = xFromJs;
exports.idx = idx;
exports.x0 = x0;
exports.x1 = x1;
exports.aToJs = aToJs;
exports.aFromJs = aFromJs;
exports.id = id;
exports.a0 = a0;
exports.a1 = a1;
exports.bToJs = bToJs;
exports.bFromJs = bFromJs;
exports.b0 = b0;
exports.b1 = b1;
exports.idb = idb;
exports.cToJs = cToJs;
exports.cFromJs = cFromJs;
exports.c0 = c0;
exports.idc = idc;
exports.jsMapperEraseType = jsMapperEraseType;
exports.b = b;
exports.hToJs = hToJs;
exports.hFromJs = hFromJs;
exports.zXx = zXx;
exports.zToJs = zToJs;
exports.zFromJs = zFromJs;
--[[ x0 Not a pure module ]]
