--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Js_mapperRt = require "../../lib/js/js_mapperRt.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

x = List.length(--[[ :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ :: ]]{
          3,
          --[[ [] ]]0
        }
      }
    });

jsMapperConstantArray = {
  --[[ tuple ]]{
    -988374136,
    "http"
  },
  --[[ tuple ]]{
    5243943,
    "idb"
  },
  --[[ tuple ]]{
    561436162,
    "leveldb"
  }
};

function adapterToJs(param) do
  return Js_mapperRt.binarySearch(3, param, jsMapperConstantArray);
end end

function adapterFromJs(param) do
  return Js_mapperRt.revSearch(3, jsMapperConstantArray, param);
end end

eq("File \"re_first_test.re\", line 18, characters 3-10", adapterToJs(--[[ idb ]]5243943), "idb");

Mt.from_pair_suites("Re_first_test", suites.contents);

u = 3;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.x = x;
exports.u = u;
exports.adapterToJs = adapterToJs;
exports.adapterFromJs = adapterFromJs;
--[[ x Not a pure module ]]
