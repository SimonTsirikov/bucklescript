__console = {log = print};

Mt = require "..mt";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function fake_c2(a_type, b_type) do
  local ___conditional___=(a_type);
  do
     if ___conditional___ == "number" then do
        if (b_type == "number") then do
          return 33;
        end
         end  end else 
     if ___conditional___ == "string" then do
        return 1; end end end end 
     if ___conditional___ == "undefined" then do
        return -1; end end 
    
  end
  if (b_type == "undefined") then do
    return 1;
  end else if (a_type == "number") then do
    return 3;
  end else do
    return 0;
  end end  end 
end end

eq("File \"gpr_2931_test.ml\", line 19, characters 6-13", 3, fake_c2("number", "xx"));

Mt.from_pair_suites("Gpr_2931_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fake_c2 = fake_c2;
return exports;
--[[  Not a pure module ]]
