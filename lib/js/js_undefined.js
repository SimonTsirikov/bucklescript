'use strict';

var Caml_option = require("./caml_option.js");

function test(x) do
  return x == undefined;
end

function testAny(x) do
  return x == undefined;
end

function getExn(f) do
  if (f ~= undefined) do
    return f;
  end else do
    throw new Error("Js.Undefined.getExn");
  end
end

function bind(x, f) do
  if (x ~= undefined) do
    return f(x);
  end
  
end

function iter(x, f) do
  if (x ~= undefined) do
    return f(x);
  end else do
    return --[ () ]--0;
  end
end

function fromOption(x) do
  if (x ~= undefined) do
    return Caml_option.valFromOption(x);
  end
  
end

var from_opt = fromOption;

exports.test = test;
exports.testAny = testAny;
exports.getExn = getExn;
exports.bind = bind;
exports.iter = iter;
exports.fromOption = fromOption;
exports.from_opt = from_opt;
--[ No side effect ]--
