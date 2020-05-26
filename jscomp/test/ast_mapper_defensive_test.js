'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Js_mapperRt = require("../../lib/js/js_mapperRt.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function $$throw(loc, x) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ ThrowAny ]--Block.__(7, [x]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function aToJs(param) do
  return param + 0 | 0;
end

function aFromJs(param) do
  if (!(param <= 2 and 0 <= param)) then do
    throw new Error("ASSERT FAILURE");
  end
   end 
  return param - 0 | 0;
end

jsMapperConstantArray = [
  0,
  3,
  4
];

function bToJs(param) do
  return jsMapperConstantArray[param];
end

function bFromJs(param) do
  return Js_mapperRt.fromIntAssert(3, jsMapperConstantArray, param);
end

jsMapperConstantArray$1 = [
  --[ tuple ]--[
    22125,
    "c0"
  ],
  --[ tuple ]--[
    22126,
    "c1"
  ],
  --[ tuple ]--[
    22127,
    "c2"
  ]
];

function cToJs(param) do
  return Js_mapperRt.binarySearch(3, param, jsMapperConstantArray$1);
end

function cFromJs(param) do
  return Js_mapperRt.revSearchAssert(3, jsMapperConstantArray$1, param);
end

$$throw("File \"ast_mapper_defensive_test.ml\", line 28, characters 16-23", (function (param) do
        aFromJs(3);
        return --[ () ]--0;
      end));

$$throw("File \"ast_mapper_defensive_test.ml\", line 29, characters 15-22", (function (param) do
        bFromJs(2);
        return --[ () ]--0;
      end));

$$throw("File \"ast_mapper_defensive_test.ml\", line 30, characters 15-22", (function (param) do
        cFromJs(33);
        return --[ () ]--0;
      end));

Mt.from_pair_suites("Ast_mapper_defensive_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.$$throw = $$throw;
exports.aToJs = aToJs;
exports.aFromJs = aFromJs;
exports.bToJs = bToJs;
exports.bFromJs = bFromJs;
exports.cToJs = cToJs;
exports.cFromJs = cFromJs;
--[  Not a pure module ]--
