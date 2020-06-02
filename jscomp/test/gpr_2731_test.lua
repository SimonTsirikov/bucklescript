console.log = print;


function f(x) do
  return x + 1 | 0;
end end

a = f(1);

b = f(2);

function g(param) do
  return 1;
end end

c = g(--[[ () ]]0);

d = g(--[[ () ]]0);

exports.f = f;
exports.a = a;
exports.b = b;
exports.g = g;
exports.c = c;
exports.d = d;
--[[ a Not a pure module ]]
