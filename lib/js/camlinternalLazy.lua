console = {log = print};

Obj = require "./obj";
Curry = require "./curry";
Caml_obj = require "./caml_obj";
Caml_exceptions = require "./caml_exceptions";

Undefined = Caml_exceptions.create("CamlinternalLazy.Undefined");

function raise_undefined(param) do
  error(Undefined)
end end

function force_lazy_block(blk) do
  closure = blk[0];
  blk[0] = raise_undefined;
  xpcall(function() do
    result = Curry._1(closure, --[[ () ]]0);
    blk[0] = result;
    Caml_obj.caml_obj_set_tag(blk, Obj.forward_tag);
    return result;
  end end,function(e) do
    blk[0] = (function(param) do
        error(e)
      end end);
    error(e)
  end end)
end end

function force_val_lazy_block(blk) do
  closure = blk[0];
  blk[0] = raise_undefined;
  result = Curry._1(closure, --[[ () ]]0);
  blk[0] = result;
  Caml_obj.caml_obj_set_tag(blk, Obj.forward_tag);
  return result;
end end

function force(lzv) do
  t = lzv.tag | 0;
  if (t == Obj.forward_tag) then do
    return lzv[0];
  end else if (t ~= Obj.lazy_tag) then do
    return lzv;
  end else do
    return force_lazy_block(lzv);
  end end  end 
end end

function force_val(lzv) do
  t = lzv.tag | 0;
  if (t == Obj.forward_tag) then do
    return lzv[0];
  end else if (t ~= Obj.lazy_tag) then do
    return lzv;
  end else do
    return force_val_lazy_block(lzv);
  end end  end 
end end

exports = {}
exports.Undefined = Undefined;
exports.force_lazy_block = force_lazy_block;
exports.force_val_lazy_block = force_val_lazy_block;
exports.force = force;
exports.force_val = force_val;
--[[ No side effect ]]
