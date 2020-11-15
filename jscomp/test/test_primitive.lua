__console = {log = print};

Curry = require "......lib.js.curry";
Caml_array = require "......lib.js.caml_array";
Pervasives = require "......lib.js.pervasives";
CamlinternalLazy = require "......lib.js.camlinternalLazy";

function a4(prim) do
  return --[[ tuple ]]{
          "File \"test_primitive.ml\", line 30, characters 9-19",
          prim
        };
end end

function a5(prim) do
  return --[[ tuple ]]{
          31,
          prim
        };
end end

function a6(prim) do
  return --[[ tuple ]]{
          --[[ tuple ]]{
            "test_primitive.ml",
            32,
            9,
            19
          },
          prim
        };
end end

test_float = 3;

test_abs = __Math.abs(3.0);

v = {
  1.0,
  2.0
};

xxx = "a";

a = --[[ "a" ]]97;

function u(b) do
  if (b) then do
    Pervasives.print_int(1);
    return 32;
  end else do
    return 7;
  end end 
end end

function f2(h, b, param) do
  return Curry._1(h, b and 32 or 7);
end end

Caml_array.caml_array_set(v, 1, 3.0);

unboxed_x = {
  u = 0,
  v = 0
};

function gg(x) do
  x.u = 0;
  return --[[ () ]]0;
end end

function f(x) do
  return #x;
end end

is_lazy_force = CamlinternalLazy.force;

function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    fib1 = fib(n - 1 | 0);
    fib2 = fib(n - 2 | 0);
    return (fib1 + fib2 | 0) + 3 | 0;
  end end 
end end

a0 = "File \"test_primitive.ml\", line 26, characters 9-16";

a1 = "Test_primitive";

a2 = 28;

a3 = "Test_primitive";

xx = --[[ tuple ]]{
  0,
  0
};

exports = {};
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.a3 = a3;
exports.a4 = a4;
exports.a5 = a5;
exports.a6 = a6;
exports.test_float = test_float;
exports.test_abs = test_abs;
exports.v = v;
exports.xxx = xxx;
exports.a = a;
exports.u = u;
exports.f2 = f2;
exports.xx = xx;
exports.unboxed_x = unboxed_x;
exports.gg = gg;
exports.f = f;
exports.is_lazy_force = is_lazy_force;
exports.fib = fib;
return exports;
--[[ test_abs Not a pure module ]]
