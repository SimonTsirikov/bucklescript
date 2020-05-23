'use strict';

var Curry = require("../../lib/js/curry.js");

function map_pair(r, param) do
  return --[ tuple ]--[
          Curry._1(r, param[0]),
          Curry._1(r, param[1])
        ];
end

function u(x) do
  return x;
end

map_pair(u, --[ tuple ]--[
      3,
      true
    ]);

var hi = [
  3,
  2,
  "x"
];

console.log(3);

console.log("x");

var v0 = [];

v0[0] = 65;

v0[1] = v0;

var v1 = --[ `A ]--[
  65,
  --[ B ]--66
];

exports.hi = hi;
exports.v0 = v0;
exports.v1 = v1;
--[  Not a pure module ]--
