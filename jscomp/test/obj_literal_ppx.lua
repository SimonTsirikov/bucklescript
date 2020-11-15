__console = {log = print};


a = {
  x = 3,
  y = {1}
};

b = {
  x = 3,
  y = {1},
  z = 3,
  u = (function(x, y) do
      return x + y | 0;
    end end)
};

function f(obj) do
  return obj.x + #obj.y | 0;
end end

function h(obj) do
  return obj.u(1, 2);
end end

u = f(a);

v = f(b);

vv = h(b);

exports = {};
exports.a = a;
exports.b = b;
exports.f = f;
exports.h = h;
exports.u = u;
exports.v = v;
exports.vv = vv;
return exports;
--[[ u Not a pure module ]]
