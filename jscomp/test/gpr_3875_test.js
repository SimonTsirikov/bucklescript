'use strict';

var Mt = require("./mt.js");
var Curry = require("../../lib/js/curry.js");

var result = do
  contents: ""
end;

function log(x) do
  result.contents = x;
  return --[ () ]--0;
end

var Xx = do
  log: log
end;

function compilerBug(a, b, c, f) do
  var exit = 0;
  if (a ~= "x") do
    exit = 2;
  end
  if (exit == 2) do
    if (b ~= undefined) do
      if (b ~= "x") do
        if (c) do
          result.contents = "No x, c is true";
          return --[ () ]--0;
        end else do
          result.contents = "No x, c is false";
          return --[ () ]--0;
        end
      end
      
    end else if (c) do
      result.contents = "No x, c is true";
      return --[ () ]--0;
    end else do
      result.contents = "No x, c is false";
      return --[ () ]--0;
    end
  end
  if (Curry._1(f, --[ () ]--0)) do
    result.contents = "Some x, f returns true";
    return --[ () ]--0;
  end else do
    result.contents = "Some x, f returns false";
    return --[ () ]--0;
  end
end

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

compilerBug("x", undefined, true, (function (param) do
        return true;
      end));

eq("File \"gpr_3875_test.ml\", line 36, characters 5-12", result.contents, "Some x, f returns true");

Mt.from_pair_suites("gpr_3875_test.ml", suites.contents);

exports.result = result;
exports.Xx = Xx;
exports.compilerBug = compilerBug;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
