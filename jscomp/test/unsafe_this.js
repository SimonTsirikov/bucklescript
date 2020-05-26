'use strict';


u = do
  x: 3,
  y: 32,
  bark: (function ($$this, x, y) do
      console.log(--[ tuple ]--[
            $$this.length,
            $$this.x,
            $$this.y
          ]);
      return --[ () ]--0;
    end),
  length: 32
end;

u.bark(u, 1, 2);

function uux_this(x, y) do
  o = this ;
  return (o.length + x | 0) + y | 0;
end

js_obj = do
  x: 3,
  y: 32,
  bark: (function (x, y) do
      o = this ;
      console.log(--[ tuple ]--[
            o.length,
            o.x,
            o.y,
            x,
            y
          ]);
      return x + y | 0;
    end),
  length: 32
end;

exports.js_obj = js_obj;
exports.uux_this = uux_this;
--[  Not a pure module ]--
