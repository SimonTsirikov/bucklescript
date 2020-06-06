console = {log = print};

Curry = require "../../lib/js/curry";
React = require "r";
ReactDom = require "react";

function fib(n) do
  if (n == 2 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end end

function sum(n) do
  v = 0;
  for i = 0 , n , 1 do
    v = v + i | 0;
  end
  return v;
end end

function map(f, param) do
  if (param) then do
    return --[[ Cons ]]{
            Curry._1(f, param[0]),
            map(f, param[1])
          };
  end else do
    return --[[ Nil ]]0;
  end end 
end end

function test_curry(x, y) do
  return x + y | 0;
end end

function f(param) do
  return 32 + param | 0;
end end

ReactDom.render(React.createClass({
          render = (function(param) do
              return React.DOM.div({
                          alt = "pic"
                        }, React.DOM.h1(nil, "hello react"), React.DOM.h2(nil, "type safe!"));
            end end)
        }), document.getElementById("hi"));

exports = {}
exports.fib = fib;
exports.sum = sum;
exports.map = map;
exports.test_curry = test_curry;
exports.f = f;
--[[  Not a pure module ]]
