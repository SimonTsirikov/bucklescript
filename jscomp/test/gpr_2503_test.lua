console = {log = print};

Mt = require "./mt";
Caml_option = require "../../lib/js/caml_option";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, b_1) do
  return Mt.bool_suites(test_id, suites, loc, b_1);
end end

function makeWrapper(foo, param) do
  tmp = { };
  if (foo ~= undefined) then do
    tmp.foo = (function() do
          local ___conditional___=(Caml_option.valFromOption(foo));
          do
             if ___conditional___ == 97 then do
                return "a"; end end 
             if ___conditional___ == 98 then do
                return "b"; end end 
            
          end
        end end)();
  end
   end 
  console.log(tmp);
  return --[[ () ]]0;
end end

function makeWrapper2(foo, param) do
  console.log({
        foo = (function() do
              local ___conditional___=(foo);
              do
                 if ___conditional___ == 97 then do
                    return "a"; end end 
                 if ___conditional___ == 98 then do
                    return "b"; end end 
                
              end
            end end)()
      });
  return --[[ () ]]0;
end end

makeWrapper2(--[[ a ]]97, --[[ () ]]0);

function makeWrapper3(foo, param) do
  console.log(2);
  tmp = { };
  if (foo ~= undefined) then do
    tmp.foo = (function() do
          local ___conditional___=(Caml_option.valFromOption(foo));
          do
             if ___conditional___ == 97 then do
                return "a"; end end 
             if ___conditional___ == 98 then do
                return "b"; end end 
            
          end
        end end)();
  end
   end 
  return tmp;
end end

function makeWrapper4(foo, param) do
  console.log(2);
  tmp = { };
  tmp_1 = foo > 100 and undefined or (
      foo > 10 and --[[ b ]]98 or --[[ a ]]97
    );
  if (tmp_1 ~= undefined) then do
    tmp.foo = (function() do
          local ___conditional___=(Caml_option.valFromOption(tmp_1));
          do
             if ___conditional___ == 97 then do
                return "a"; end end 
             if ___conditional___ == 98 then do
                return "b"; end end 
            
          end
        end end)();
  end
   end 
  return tmp;
end end

b("File \"gpr_2503_test.ml\", line 31, characters 5-12", "a" == makeWrapper3(--[[ a ]]97, --[[ () ]]0).foo);

b("File \"gpr_2503_test.ml\", line 34, characters 5-12", undefined == makeWrapper3(undefined, --[[ () ]]0).foo);

b("File \"gpr_2503_test.ml\", line 37, characters 5-12", "a" == makeWrapper4(1, --[[ () ]]0).foo);

b("File \"gpr_2503_test.ml\", line 40, characters 5-12", "b" == makeWrapper4(11, --[[ () ]]0).foo);

b("File \"gpr_2503_test.ml\", line 43, characters 5-12", undefined == makeWrapper4(111, --[[ () ]]0).foo);

Mt.from_pair_suites("Gpr_2503_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.makeWrapper = makeWrapper;
exports.makeWrapper2 = makeWrapper2;
exports.makeWrapper3 = makeWrapper3;
exports.makeWrapper4 = makeWrapper4;
--[[  Not a pure module ]]
