--[['use strict';]]

Obj = require "./obj.lua";
Block = require "./block.lua";
Caml_obj = require "./caml_obj.lua";
CamlinternalLazy = require "./camlinternalLazy.lua";

function from_fun(f) do
  x = --[[ obj_block ]]Block.__(Obj.lazy_tag, {0});
  x[0] = f;
  return x;
end end

function from_val(v) do
  t = v.tag | 0;
  if (t == Obj.forward_tag or t == Obj.lazy_tag or t == Obj.double_tag) then do
    return Caml_obj.caml_lazy_make_forward(v);
  end else do
    return v;
  end end 
end end

function is_val(l) do
  return (l.tag | 0) ~= Obj.lazy_tag;
end end

Undefined = CamlinternalLazy.Undefined;

force_val = CamlinternalLazy.force_val;

lazy_from_fun = from_fun;

lazy_from_val = from_val;

lazy_is_val = is_val;

exports.Undefined = Undefined;
exports.force_val = force_val;
exports.from_fun = from_fun;
exports.from_val = from_val;
exports.is_val = is_val;
exports.lazy_from_fun = lazy_from_fun;
exports.lazy_from_val = lazy_from_val;
exports.lazy_is_val = lazy_is_val;
--[[ No side effect ]]
