'use strict';

var Curry = require("../../lib/js/curry.js");

function test_hi(x) do
  var match = x.hi(1, 2, 3);
  if (match ~= null) then do
    console.log(match);
    return 2;
  end else do
    return 1;
  end end 
end

function test_hi__2(x) do
  var match = x.hi__2();
  if (match == null) then do
    return 1;
  end else do
    return 2;
  end end 
end

function test_cb(x) do
  Curry._1(x.cb("hI", 1, 2, 3), 3);
  Curry._1(x.cb("hI", 1, 2, 3), 3);
  return x.cb2("hI", 1, 2, 3)(3);
end

function f(x) do
  v(x);
  return --[ () ]--0;
end

exports.test_hi = test_hi;
exports.test_hi__2 = test_hi__2;
exports.test_cb = test_cb;
exports.f = f;
--[ No side effect ]--
