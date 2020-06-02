--[['use strict';]]

Curry = require "../../lib/js/curry";

function on1(foo, __event) do
  foo.on((function () do
            local ___conditional___=(__event[0]);
            do
               if ___conditional___ = 4895187 then do
                  return "bar";end end end 
               if ___conditional___ = 5097222 then do
                  return "foo";end end end 
               do
              
            end
          end end)(), __event[1]);
  return --[[ () ]]0;
end end

function on2(foo, h, __event) do
  foo.on((function () do
            local ___conditional___=(Curry._1(h, __event)[0]);
            do
               if ___conditional___ = 4895187 then do
                  return "bar";end end end 
               if ___conditional___ = 5097222 then do
                  return "foo";end end end 
               do
              
            end
          end end)(), Curry._1(h, __event)[1]);
  return --[[ () ]]0;
end end

exports.on1 = on1;
exports.on2 = on2;
--[[ No side effect ]]
