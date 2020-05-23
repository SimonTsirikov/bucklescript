'use strict';

var Curry = require("../../lib/js/curry.js");
var React = require("react");
var ReactDom = require("react-dom");

function fib(n) do
  if (n == 2 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end

function sum(n) do
  var v = 0;
  for(var i = 0; i <= n; ++i)do
    v = v + i | 0;
  end
  return v;
end

function map(f, param) do
  if (param) then do
    return --[ Cons ]--[
            Curry._1(f, param[0]),
            map(f, param[1])
          ];
  end else do
    return --[ Nil ]--0;
  end end 
end

function test_curry(x, y) do
  return x + y | 0;
end

function f(param) do
  return 32 + param | 0;
end

ReactDom.render(React.createClass(do
          render: (function (param) do
              return React.DOM.div(do
                          alt: "pic"
                        end, React.DOM.h1(undefined, "hello react"), React.DOM.h2(undefined, "type safe!"));
            end)
        end), document.getElementById("hi"));

exports.fib = fib;
exports.sum = sum;
exports.map = map;
exports.test_curry = test_curry;
exports.f = f;
--[  Not a pure module ]--
