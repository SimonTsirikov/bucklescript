console = {log = print};

Mt = require "./mt";
Curry = require "../../lib/js/curry";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function f(x) do
  match = Curry._1(x, --[[ () ]]0);
  local ___conditional___=(match);
  do
     if ___conditional___ == 1 then do
        return --[[ "a" ]]97; end end 
     if ___conditional___ == 2 then do
        return --[[ "b" ]]98; end end 
     if ___conditional___ == 3 then do
        return --[[ "c" ]]99; end end 
    return --[[ "x" ]]120;
      
  end
end end

function f22(x) do
  match = Curry._1(x, --[[ () ]]0);
  local ___conditional___=(match);
  do
     if ___conditional___ == 1 then do
        return --[[ "a" ]]97; end end 
     if ___conditional___ == 2 then do
        return --[[ "b" ]]98; end end 
     if ___conditional___ == 3 then do
        return --[[ "c" ]]99; end end 
    return --[[ "x" ]]120;
      
  end
end end

function f33(x) do
  match = Curry._1(x, --[[ () ]]0);
  local ___conditional___=(match);
  do
     if ___conditional___ == 0--[[ A ]] then do
        return --[[ "a" ]]97; end end 
     if ___conditional___ == 1--[[ B ]] then do
        return --[[ "b" ]]98; end end 
     if ___conditional___ == 2--[[ C ]] then do
        return --[[ "c" ]]99; end end 
     if ___conditional___ == 3--[[ D ]] then do
        return --[[ "x" ]]120; end end 
    
  end
end end

eq("File \"int_switch_test.ml\", line 35, characters 6-13", f((function(param) do
            return 1;
          end end)), --[[ "a" ]]97);

eq("File \"int_switch_test.ml\", line 36, characters 6-13", f((function(param) do
            return 2;
          end end)), --[[ "b" ]]98);

eq("File \"int_switch_test.ml\", line 37, characters 6-13", f((function(param) do
            return 3;
          end end)), --[[ "c" ]]99);

eq("File \"int_switch_test.ml\", line 38, characters 6-13", f((function(param) do
            return 0;
          end end)), --[[ "x" ]]120);

eq("File \"int_switch_test.ml\", line 39, characters 6-13", f((function(param) do
            return -1;
          end end)), --[[ "x" ]]120);

Mt.from_pair_suites("Int_switch_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.f = f;
exports.f22 = f22;
exports.f33 = f33;
--[[  Not a pure module ]]
