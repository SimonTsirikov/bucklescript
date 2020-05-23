


var id = do
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
  var v_001 = caml_fresh_oo_id(--[ () ]--0);
  var v = --[ tuple ]--[
    str,
    v_001
  ];
  v.tag = 248;
  return v;
end

function caml_is_extension(e) do
  if (e == undefined) do
    return false;
  end else if (e.tag == 248) do
    return true;
  end else do
    var slot = e[0];
    if (slot ~= undefined) do
      return slot.tag == 248;
    end else do
      return false;
    end
  end
end

export do
  caml_set_oo_id ,
  caml_fresh_oo_id ,
  create ,
  caml_is_extension ,
  
end
--[ No side effect ]--
