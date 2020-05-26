'use strict';


function uux_this(x, y) do
  o = this ;
  return (o.length + x | 0) + y | 0; end
end

function even(x) do
  o = this ;
  return x + o | 0; end
end

function bark(param) do
  return (function (x, y) do
      o = this ;
      console.log(--[[ tuple ]][
            o.length,
            o.x,
            o.y,
            x,
            y
          ]);
      return x + y | 0; end
    end);
end end

js_obj = do
  bark: (function (x, y) do
      o = this ;
      console.log(o);
      return x + y | 0; end
    end)
end;

function f(x) do
  x.onload = (function () do
      o = this ;
      console.log(o);
      return --[[ () ]]0; end
    end);
  return x.addEventListener("onload", (function () do
                o = this ;
                console.log(o.response);
                return --[[ () ]]0; end
              end));
end end

function u(x) do
  return x; end
end

exports.uux_this = uux_this;
exports.even = even;
exports.bark = bark;
exports.js_obj = js_obj;
exports.f = f;
exports.u = u;
--[[ uux_this Not a pure module ]]
