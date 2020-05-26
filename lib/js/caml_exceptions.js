'use strict';


id = do
  contents: 0
end;

function caml_set_oo_id(b) do
  b[1] = id.contents;
  id.contents = id.contents + 1;
  return b;
end

function caml_fresh_oo_id(param) do
  id.contents = id.contents + 1;
  return id.contents;
end

function create(str) do
  v_001 = caml_fresh_oo_id(--[ () ]--0);
  v = --[ tuple ]--[
    str,
    v_001
  ];
  v.tag = 248;
  return v;
end

function caml_is_extension(e) do
  if (e == undefined) then do
    return false;
  end else if (e.tag == 248) then do
    return true;
  end else do
    slot = e[0];
    if (slot ~= undefined) then do
      return slot.tag == 248;
    end else do
      return false;
    end end 
  end end  end 
end

exports.caml_set_oo_id = caml_set_oo_id;
exports.caml_fresh_oo_id = caml_fresh_oo_id;
exports.create = create;
exports.caml_is_extension = caml_is_extension;
--[ No side effect ]--
