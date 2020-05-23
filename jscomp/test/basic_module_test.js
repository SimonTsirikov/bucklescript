'use strict';

var Mt = require("./mt.js");
var Curry = require("../../lib/js/curry.js");
var Offset = require("./offset.js");
var Mt_global = require("./mt_global.js");

var count = do
  contents: 0
end;

function test(set) do
  count.contents = Offset.$$Set.cardinal(set) + count.contents | 0;
  return --[ () ]--0;
end

test(Curry._1(Offset.M.$$Set.singleton, "42"));

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(f, a, b) do
  return Mt_global.collect_eq(test_id, suites, f, a, b);
end

eq("File \"basic_module_test.ml\", line 39, characters 12-19", count.contents, 1);

Mt.from_pair_suites("Basic_module_test", suites.contents);

--[  Not a pure module ]--
