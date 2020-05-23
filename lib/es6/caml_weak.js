

import * as Caml_obj from "./caml_obj.js";
import * as Caml_array from "./caml_array.js";
import * as Caml_option from "./caml_option.js";

function caml_weak_create(n) do
  return new Array(n);
end

function caml_weak_set(xs, i, v) do
  if (v ~= undefined) then do
    xs[i] = Caml_option.valFromOption(v);
    return --[ () ]--0;
  end else do
    return --[ () ]--0;
  end end 
end

function caml_weak_get(xs, i) do
  return Caml_option.undefined_to_opt(xs[i]);
end

function caml_weak_get_copy(xs, i) do
  var match = xs[i];
  if (match ~= undefined) then do
    return Caml_option.some(Caml_obj.caml_obj_dup(match));
  end
   end 
end

function caml_weak_check(xs, i) do
  return xs[i] ~= undefined;
end

var caml_weak_blit = Caml_array.caml_array_blit;

export do
  caml_weak_create ,
  caml_weak_set ,
  caml_weak_get ,
  caml_weak_get_copy ,
  caml_weak_check ,
  caml_weak_blit ,
  
end
--[ No side effect ]--
