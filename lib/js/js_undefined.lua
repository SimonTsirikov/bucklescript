--[['use strict';]]

Caml_option = require "./caml_option.lua";

function test(x) do
  return x == undefined;
end end

function testAny(x) do
  return x == undefined;
end end

function getExn(f) do
  if (f ~= undefined) then do
    return f;
  end else do
    throw new Error("Js.Undefined.getExn");
  end end 
end end

function bind(x, f) do
  if (x ~= undefined) then do
    return f(x);
  end
   end 
end end

function iter(x, f) do
  if (x ~= undefined) then do
    return f(x);
  end else do
    return --[[ () ]]0;
  end end 
end end

function fromOption(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end
   end 
end end

from_opt = fromOption;

exports.test = test;
exports.testAny = testAny;
exports.getExn = getExn;
exports.bind = bind;
exports.iter = iter;
exports.fromOption = fromOption;
exports.from_opt = from_opt;
--[[ No side effect ]]
