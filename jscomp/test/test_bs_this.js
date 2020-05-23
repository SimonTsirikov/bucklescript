'use strict';


function uux_this(x, y) do
  var o = this ;
  return (o.length + x | 0) + y | 0;
end

function even(x) do
  var o = this ;
  return x + o | 0;
end

function bark(param) do
  return (function (x, y) do
      var o = this ;
      console.log(--[ tuple ]--[
            o.length,
            o.x,
            o.y,
            x,
            y
          ]);
      return x + y | 0;
    end);
end

var js_obj = do
  bark: (function (x, y) do
      var o = this ;
      console.log(o);
      return x + y | 0;
    end)
end;

function f(x) do
  x.onload = (function () do
      var o = this ;
      console.log(o);
      return --[ () ]--0;
    end);
  return x.addEventListener("onload", (function () do
                var o = this ;
                console.log(o.response);
                return --[ () ]--0;
              end));
end

function u(x) do
  return x;
end

exports.uux_this = uux_this;
exports.even = even;
exports.bark = bark;
exports.js_obj = js_obj;
exports.f = f;
exports.u = u;
--[ uux_this Not a pure module ]--
