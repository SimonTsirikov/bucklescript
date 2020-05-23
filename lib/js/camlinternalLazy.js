'use strict';

var Obj = require("./obj.js");
var Curry = require("./curry.js");
var Caml_obj = require("./caml_obj.js");
var Caml_exceptions = require("./caml_exceptions.js");

var Undefined = Caml_exceptions.create("CamlinternalLazy.Undefined");

function raise_undefined(param) do
  throw Undefined;
end

function force_lazy_block(blk) do
  var closure = blk[0];
  blk[0] = raise_undefined;
  try do
    var result = Curry._1(closure, --[ () ]--0);
    blk[0] = result;
    Caml_obj.caml_obj_set_tag(blk, Obj.forward_tag);
    return result;
  end
  catch (e)do
    blk[0] = (function (param) do
        throw e;
      end);
    throw e;
  end
end

function force_val_lazy_block(blk) do
  var closure = blk[0];
  blk[0] = raise_undefined;
  var result = Curry._1(closure, --[ () ]--0);
  blk[0] = result;
  Caml_obj.caml_obj_set_tag(blk, Obj.forward_tag);
  return result;
end

function force(lzv) do
  var t = lzv.tag | 0;
  if (t == Obj.forward_tag) do
    return lzv[0];
  end else if (t ~= Obj.lazy_tag) do
    return lzv;
  end else do
    return force_lazy_block(lzv);
  end
end

function force_val(lzv) do
  var t = lzv.tag | 0;
  if (t == Obj.forward_tag) do
    return lzv[0];
  end else if (t ~= Obj.lazy_tag) do
    return lzv;
  end else do
    return force_val_lazy_block(lzv);
  end
end

exports.Undefined = Undefined;
exports.force_lazy_block = force_lazy_block;
exports.force_val_lazy_block = force_val_lazy_block;
exports.force = force;
exports.force_val = force_val;
--[ No side effect ]--
