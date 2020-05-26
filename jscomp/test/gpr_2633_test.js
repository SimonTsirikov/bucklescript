'use strict';

var Curry = require("../../lib/js/curry.js");

function on1(foo, $$event) do
  foo.on((function () do
            local ___conditional___=($$event[0]);
            do
               if ___conditional___ = 4895187 then do
                  return "bar";end end end 
               if ___conditional___ = 5097222 then do
                  return "foo";end end end 
               do
              
            end
          end)(), $$event[1]);
  return --[ () ]--0;
end

function on2(foo, h, $$event) do
  foo.on((function () do
            local ___conditional___=(Curry._1(h, $$event)[0]);
            do
               if ___conditional___ = 4895187 then do
                  return "bar";end end end 
               if ___conditional___ = 5097222 then do
                  return "foo";end end end 
               do
              
            end
          end)(), Curry._1(h, $$event)[1]);
  return --[ () ]--0;
end

exports.on1 = on1;
exports.on2 = on2;
--[ No side effect ]--
