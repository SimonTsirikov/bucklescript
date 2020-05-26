

import * as Obj from "./obj.js";
import * as Block from "./block.js";
import * as Caml_obj from "./caml_obj.js";
import * as CamlinternalLazy from "./camlinternalLazy.js";

function from_fun(f) do
  x = --[ obj_block ]--Block.__(Obj.lazy_tag, [0]);
  x[0] = f;
  return x;
end

function from_val(v) do
  t = v.tag | 0;
  if (t == Obj.forward_tag or t == Obj.lazy_tag or t == Obj.double_tag) then do
    return Caml_obj.caml_lazy_make_forward(v);
  end else do
    return v;
  end end 
end

function is_val(l) do
  return (l.tag | 0) ~= Obj.lazy_tag;
end

Undefined = CamlinternalLazy.Undefined;

force_val = CamlinternalLazy.force_val;

lazy_from_fun = from_fun;

lazy_from_val = from_val;

lazy_is_val = is_val;

export do
  Undefined ,
  force_val ,
  from_fun ,
  from_val ,
  is_val ,
  lazy_from_fun ,
  lazy_from_val ,
  lazy_is_val ,
  
end
--[ No side effect ]--
