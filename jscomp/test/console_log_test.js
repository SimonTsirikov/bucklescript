'use strict';

Caml_obj = require("../../lib/js/caml_obj.js");

function min_int(prim, prim$1) do
  return Math.min(prim, prim$1);
end

function say(prim, prim$1) do
  return prim$1.say(prim);
end

v = Caml_obj.caml_compare;

exports.min_int = min_int;
exports.say = say;
exports.v = v;
--[ No side effect ]--
