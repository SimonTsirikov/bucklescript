console.log = print;


a = do
  x: 3,
  y: {1}
end;

b = do
  x: 3,
  y: {1},
  z: 3,
  u: (function (x, y) do
      return x + y | 0;
    end end)
end;

function f(obj) do
  return obj.x + #obj.y | 0;
end end

function h(obj) do
  return obj.u(1, 2);
end end

u = f(a);

v = f(b);

vv = h(b);

exports.a = a;
exports.b = b;
exports.f = f;
exports.h = h;
exports.u = u;
exports.v = v;
exports.vv = vv;
--[[ u Not a pure module ]]
