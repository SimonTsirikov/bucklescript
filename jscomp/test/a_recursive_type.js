'use strict';

Curry = require("../../lib/js/curry.js");

function g(x) do
  return Curry._1(x[0], x);
end

loop = g(--[ A ]--[g]);

x = --[ A ]--[g];

non_terminate = g(x);

exports.loop = loop;
exports.non_terminate = non_terminate;
--[ loop Not a pure module ]--
