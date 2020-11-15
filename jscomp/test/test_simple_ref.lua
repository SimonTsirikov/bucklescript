__console = {log = print};

Curry = require "......lib.js.curry";

v = {
  contents = 0
};

function gen(param) do
  v.contents = v.contents + 1 | 0;
  return v.contents;
end end

h = {
  contents = 0
};

a = 0;

c = {
  contents = 0
};

not_real_escape = a;

function real_escape(f, v) do
  return Curry._1(f, c);
end end

u = h;

exports = {};
exports.u = u;
exports.gen = gen;
exports.not_real_escape = not_real_escape;
exports.real_escape = real_escape;
return exports;
--[[ No side effect ]]
