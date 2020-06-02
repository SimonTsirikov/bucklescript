console.log = print;

Caml_obj = require "../../lib/js/caml_obj";

function min_int(prim, prim_1) do
  return Math.min(prim, prim_1);
end end

function say(prim, prim_1) do
  return prim_1.say(prim);
end end

v = Caml_obj.caml_compare;

exports.min_int = min_int;
exports.say = say;
exports.v = v;
--[[ No side effect ]]
