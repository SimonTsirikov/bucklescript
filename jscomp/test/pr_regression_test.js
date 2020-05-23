'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");

var v = do
  contents: 3
end;

function f(h) do
  v.contents = v.contents + 1 | 0;
  var partial_arg = 3;
  return (function (param) do
      return Curry._2(h, partial_arg, param);
    end);
end

f((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

f((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

var a = v.contents;

var v$1 = do
  contents: 3
end;

function f$1(h) do
  v$1.contents = v$1.contents + 1 | 0;
  var partial_arg = 3;
  return (function (param) do
      return Curry._2(h, partial_arg, param);
    end);
end

f$1((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

f$1((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

var b = v$1.contents;

var v$2 = do
  contents: 3
end;

function f$2(h) do
  return Curry._2(h, 2, (v$2.contents = v$2.contents + 1 | 0, 3));
end

f$2((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

f$2((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end));

var c = v$2.contents;

var v$3 = do
  contents: 3
end;

function f$3(h, g) do
  v$3.contents = v$3.contents + 1 | 0;
  var partial_arg = 9;
  return (function (param) do
      return Curry._2(h, partial_arg, param);
    end);
end

f$3((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end), 3);

f$3((function (prim, prim$1) do
        return prim + prim$1 | 0;
      end), 3);

var d = v$3.contents;

Mt.from_pair_suites("Pr_regression_test", --[ :: ]--[
      --[ tuple ]--[
        "partial",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      --[ tuple ]--[
                        5,
                        5,
                        5,
                        5
                      ],
                      --[ tuple ]--[
                        a,
                        b,
                        c,
                        d
                      ]
                    ]);
          end)
      ],
      --[ [] ]--0
    ]);

exports.a = a;
exports.b = b;
exports.c = c;
exports.d = d;
--[  Not a pure module ]--
