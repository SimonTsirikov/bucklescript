

import * as Obj from "./obj.js";
import * as Block from "./block.js";
import * as Caml_obj from "./caml_obj.js";
import * as CamlinternalLazy from "./camlinternalLazy.js";

function from_fun(f) do
  var x = --[ obj_block ]--Block.__(Obj.lazy_tag, [0]);
  x[0] = f;
  return x;
end

function from_val(v) do
  var t = v.tag | 0;
  if (t == Obj.forward_tag or t == Obj.lazy_tag or t == Obj.double_tag) do
    return Caml_obj.caml_lazy_make_forward(v);
  end else do
    return v;
  end
end

function is_val(l) do
  return (l.tag | 0) ~= Obj.lazy_tag;
end

var Undefined = CamlinternalLazy.Undefined;

var force_val = CamlinternalLazy.force_val;

var lazy_from_fun = from_fun;

var lazy_from_val = from_val;

var lazy_is_val = is_val;

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
