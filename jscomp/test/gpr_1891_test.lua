__console = {log = print};

Curry = require "......lib.js.curry";

function foo(x) do
  if (type(x) == "number" or x[1] ~= 3505894 or x[2] ~= 3) then do
    __console.log("2");
    return --[[ () ]]0;
  end else do
    __console.log("1");
    return --[[ () ]]0;
  end end 
end end

function foo2(x) do
  if (type(x) == "number" or x[1] ~= 3505894 or x[2] ~= 3) then do
    return "xxx";
  end else do
    return "xxxx";
  end end 
end end

function foo3(x) do
  if (type(x) == "number" or x[1] ~= 3505894 or x[2] ~= 3) then do
    return 2;
  end else do
    return 1;
  end end 
end end

function foo4(x, h) do
  if (type(x) == "number" or x[1] ~= 3505894 or x[2] ~= 3) then do
    return --[[ () ]]0;
  end else do
    return Curry._1(h, --[[ () ]]0);
  end end 
end end

function foo5(x) do
  if (type(x) == "number" or x[1] ~= 3505894 or x[2] ~= 3) then do
    __console.log("x");
    return --[[ () ]]0;
  end else do
    __console.log("hi");
    return --[[ () ]]0;
  end end 
end end

exports = {};
exports.foo = foo;
exports.foo2 = foo2;
exports.foo3 = foo3;
exports.foo4 = foo4;
exports.foo5 = foo5;
return exports;
--[[ No side effect ]]
