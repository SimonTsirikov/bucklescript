'use strict';

Caml_obj = require("./caml_obj.lua");
Caml_array = require("./caml_array.lua");
Caml_option = require("./caml_option.lua");

function caml_weak_create(n) do
  return new Array(n);
end end

function caml_weak_set(xs, i, v) do
  if (v ~= undefined) then do
    xs[i] = Caml_option.valFromOption(v);
    return --[[ () ]]0;
  end else do
    return --[[ () ]]0;
  end end 
end end

function caml_weak_get(xs, i) do
  return Caml_option.undefined_to_opt(xs[i]);
end end

function caml_weak_get_copy(xs, i) do
  match = xs[i];
  if (match ~= undefined) then do
    return Caml_option.some(Caml_obj.caml_obj_dup(match));
  end
   end 
end end

function caml_weak_check(xs, i) do
  return xs[i] ~= undefined;
end end

caml_weak_blit = Caml_array.caml_array_blit;

exports.caml_weak_create = caml_weak_create;
exports.caml_weak_set = caml_weak_set;
exports.caml_weak_get = caml_weak_get;
exports.caml_weak_get_copy = caml_weak_get_copy;
exports.caml_weak_check = caml_weak_check;
exports.caml_weak_blit = caml_weak_blit;
--[[ No side effect ]]
