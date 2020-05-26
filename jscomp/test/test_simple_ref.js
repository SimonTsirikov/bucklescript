'use strict';

Curry = require("../../lib/js/curry.js");

v = do
  contents: 0
end;

function gen(param) do
  v.contents = v.contents + 1 | 0;
  return v.contents;
end end

h = do
  contents: 0
end;

a = 0;

c = do
  contents: 0
end;

not_real_escape = a;

function real_escape(f, v) do
  return Curry._1(f, c);
end end

u = h;

exports.u = u;
exports.gen = gen;
exports.not_real_escape = not_real_escape;
exports.real_escape = real_escape;
--[ No side effect ]--
