'use strict';

var Curry = require("../../lib/js/curry.js");

function on1(foo, $$event) do
  foo.on((function () do
            switch ($$event[0]) do
              case 4895187 :
                  return "bar";
              case 5097222 :
                  return "foo";
              
            end
          end)(), $$event[1]);
  return --[ () ]--0;
end

function on2(foo, h, $$event) do
  foo.on((function () do
            switch (Curry._1(h, $$event)[0]) do
              case 4895187 :
                  return "bar";
              case 5097222 :
                  return "foo";
              
            end
          end)(), Curry._1(h, $$event)[1]);
  return --[ () ]--0;
end

exports.on1 = on1;
exports.on2 = on2;
--[ No side effect ]--
