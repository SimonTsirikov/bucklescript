console = {log = print};

Format = require "../../lib/js/format";
Caml_exceptions = require "../../lib/js/caml_exceptions";

v = {
  a = 3,
  b = {
    xx = 2,
    yy = 3
  }
};

u_a = 2;

u_b = {
  xx = 2,
  yy = 3
};

u = {
  a = u_a,
  b = u_b
};

A = Caml_exceptions.create("Record_debug_test.A");

B = Caml_exceptions.create("Record_debug_test.B");

v0 = {
  A,
  3
};

v1 = {
  B,
  3,
  2
};

N = {
  a = 0,
  b = 1
};

function N0_f(prim) do
  return prim;
end end

N0 = {
  a = 0,
  b = 1,
  f = N0_f
};

console.log(" hei " .. (String(v) .. " "));

a = --[[ tuple ]]{
  1,
  2,
  2,
  4,
  3
};

c = {
  1,
  2,
  3,
  4,
  5
};

console.log(" " .. (String(Format.std_formatter) .. (" " .. (String(a) .. (" " .. (String(c) .. " "))))));

h = --[[ :: ]]{
  1,
  --[[ :: ]]{
    2,
    --[[ :: ]]{
      3,
      --[[ :: ]]{
        4,
        --[[ [] ]]0
      }
    }
  }
};

v2 = --[[ `C ]]{
  67,
  2
};

v3 = --[[ `C ]]{
  67,
  --[[ tuple ]]{
    2,
    3
  }
};

fmt = Format.std_formatter;

exports = {}
exports.v = v;
exports.u = u;
exports.h = h;
exports.A = A;
exports.B = B;
exports.v0 = v0;
exports.v1 = v1;
exports.v2 = v2;
exports.v3 = v3;
exports.N = N;
exports.N0 = N0;
exports.fmt = fmt;
exports.a = a;
exports.c = c;
--[[  Not a pure module ]]
