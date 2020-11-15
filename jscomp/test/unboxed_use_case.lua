__console = {log = print};

Curry = require "......lib.js.curry";

function map_pair(r, param) do
  return --[[ tuple ]]{
          Curry._1(r, param[1]),
          Curry._1(r, param[2])
        };
end end

function u(x) do
  return x;
end end

map_pair(u, --[[ tuple ]]{
      3,
      true
    });

hi = {
  3,
  2,
  "x"
};

__console.log(3);

__console.log("x");

v0 = {};

v0[0] = 65;

v0[1] = v0;

v1 = --[[ `A ]]{
  65,
  --[[ B ]]66
};

exports = {};
exports.hi = hi;
exports.v0 = v0;
exports.v1 = v1;
return exports;
--[[  Not a pure module ]]
