__console = {log = print};


u = {
  x = 3,
  y = 32,
  bark = (function(__this, x, y) do
      __console.log(--[[ tuple ]]{
            __this.length,
            __this.x,
            __this.y
          });
      return --[[ () ]]0;
    end end),
  length = 32
};

u.bark(u, 1, 2);

function uux_this(x, y) do
  o = this ;
  return (o.length + x | 0) + y | 0; end
end

js_obj = {
  x = 3,
  y = 32,
  bark = (function(x, y) do
      o = this ;
      __console.log(--[[ tuple ]]{
            o.length,
            o.x,
            o.y,
            x,
            y
          });
      return x + y | 0; end
    end),
  length = 32
};

exports = {};
exports.js_obj = js_obj;
exports.uux_this = uux_this;
return exports;
--[[  Not a pure module ]]
