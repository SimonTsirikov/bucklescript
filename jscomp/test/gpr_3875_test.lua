console.log = print;

Mt = require "./mt";
Curry = require "../../lib/js/curry";

result = do
  contents: ""
end;

function log(x) do
  result.contents = x;
  return --[[ () ]]0;
end end

Xx = do
  log: log
end;

function compilerBug(a, b, c, f) do
  exit = 0;
  if (a ~= "x") then do
    exit = 2;
  end
   end 
  if (exit == 2) then do
    if (b ~= undefined) then do
      if (b ~= "x") then do
        if (c) then do
          result.contents = "No x, c is true";
          return --[[ () ]]0;
        end else do
          result.contents = "No x, c is false";
          return --[[ () ]]0;
        end end 
      end
       end 
    end else if (c) then do
      result.contents = "No x, c is true";
      return --[[ () ]]0;
    end else do
      result.contents = "No x, c is false";
      return --[[ () ]]0;
    end end  end 
  end
   end 
  if (Curry._1(f, --[[ () ]]0)) then do
    result.contents = "Some x, f returns true";
    return --[[ () ]]0;
  end else do
    result.contents = "Some x, f returns false";
    return --[[ () ]]0;
  end end 
end end

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

compilerBug("x", undefined, true, (function (param) do
        return true;
      end end));

eq("File \"gpr_3875_test.ml\", line 36, characters 5-12", result.contents, "Some x, f returns true");

Mt.from_pair_suites("gpr_3875_test.ml", suites.contents);

exports.result = result;
exports.Xx = Xx;
exports.compilerBug = compilerBug;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
