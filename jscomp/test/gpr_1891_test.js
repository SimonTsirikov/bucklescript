'use strict';

Curry = require("../../lib/js/curry.js");

function foo(x) do
  if (typeof x == "number" or x[0] ~= 3505894 or x[1] ~= 3) then do
    console.log("2");
    return --[[ () ]]0;
  end else do
    console.log("1");
    return --[[ () ]]0;
  end end 
end end

function foo2(x) do
  if (typeof x == "number" or x[0] ~= 3505894 or x[1] ~= 3) then do
    return "xxx";
  end else do
    return "xxxx";
  end end 
end end

function foo3(x) do
  if (typeof x == "number" or x[0] ~= 3505894 or x[1] ~= 3) then do
    return 2;
  end else do
    return 1;
  end end 
end end

function foo4(x, h) do
  if (typeof x == "number" or x[0] ~= 3505894 or x[1] ~= 3) then do
    return --[[ () ]]0;
  end else do
    return Curry._1(h, --[[ () ]]0);
  end end 
end end

function foo5(x) do
  if (typeof x == "number" or x[0] ~= 3505894 or x[1] ~= 3) then do
    console.log("x");
    return --[[ () ]]0;
  end else do
    console.log("hi");
    return --[[ () ]]0;
  end end 
end end

exports.foo = foo;
exports.foo2 = foo2;
exports.foo3 = foo3;
exports.foo4 = foo4;
exports.foo5 = foo5;
--[[ No side effect ]]
