

import * as Marshal from "./marshal.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_external_polyfill from "./caml_external_polyfill.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function is_block(a) do
  return typeof a ~= "number";
end end

double_field = Caml_array.caml_array_get;

set_double_field = Caml_array.caml_array_set;

function marshal(obj) do
  return Caml_external_polyfill.resolve("caml_output_value_to_string")(obj, --[[ [] ]]0);
end end

function unmarshal(str, pos) do
  return --[[ tuple ]]{
          Marshal.from_bytes(str, pos),
          pos + Marshal.total_size(str, pos) | 0
        };
end end

function extension_constructor(x) do
  slot = typeof x ~= "number" and (x.tag | 0) ~= 248 and #x >= 1 and x[0] or x;
  name;
  if (typeof slot ~= "number" and slot.tag == 248) then do
    name = slot[0];
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Obj.extension_constructor"
    })
  end end 
  if (name.tag == 252) then do
    return slot;
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Obj.extension_constructor"
    })
  end end 
end end

function extension_name(slot) do
  return slot[0];
end end

function extension_id(slot) do
  return slot[1];
end end

function length(x) do
  return #x - 2 | 0;
end end

first_non_constant_constructor_tag = 0;

last_non_constant_constructor_tag = 245;

lazy_tag = 246;

closure_tag = 247;

object_tag = 248;

infix_tag = 249;

forward_tag = 250;

no_scan_tag = 251;

abstract_tag = 251;

string_tag = 252;

double_tag = 253;

double_array_tag = 254;

custom_tag = 255;

final_tag = 255;

int_tag = 1000;

out_of_heap_tag = 1001;

unaligned_tag = 1002;

function Ephemeron_create(prim) do
  return Caml_external_polyfill.resolve("caml_ephe_create")(prim);
end end

function Ephemeron_get_key(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_get_key")(prim, prim_1);
end end

function Ephemeron_get_key_copy(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_get_key_copy")(prim, prim_1);
end end

function Ephemeron_set_key(prim, prim_1, prim_2) do
  return Caml_external_polyfill.resolve("caml_ephe_set_key")(prim, prim_1, prim_2);
end end

function Ephemeron_unset_key(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_unset_key")(prim, prim_1);
end end

function Ephemeron_check_key(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_check_key")(prim, prim_1);
end end

function Ephemeron_blit_key(prim, prim_1, prim_2, prim_3, prim_4) do
  return Caml_external_polyfill.resolve("caml_ephe_blit_key")(prim, prim_1, prim_2, prim_3, prim_4);
end end

function Ephemeron_get_data(prim) do
  return Caml_external_polyfill.resolve("caml_ephe_get_data")(prim);
end end

function Ephemeron_get_data_copy(prim) do
  return Caml_external_polyfill.resolve("caml_ephe_get_data_copy")(prim);
end end

function Ephemeron_set_data(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_set_data")(prim, prim_1);
end end

function Ephemeron_unset_data(prim) do
  return Caml_external_polyfill.resolve("caml_ephe_unset_data")(prim);
end end

function Ephemeron_check_data(prim) do
  return Caml_external_polyfill.resolve("caml_ephe_check_data")(prim);
end end

function Ephemeron_blit_data(prim, prim_1) do
  return Caml_external_polyfill.resolve("caml_ephe_blit_data")(prim, prim_1);
end end

Ephemeron = do
  create: Ephemeron_create,
  length: length,
  get_key: Ephemeron_get_key,
  get_key_copy: Ephemeron_get_key_copy,
  set_key: Ephemeron_set_key,
  unset_key: Ephemeron_unset_key,
  check_key: Ephemeron_check_key,
  blit_key: Ephemeron_blit_key,
  get_data: Ephemeron_get_data,
  get_data_copy: Ephemeron_get_data_copy,
  set_data: Ephemeron_set_data,
  unset_data: Ephemeron_unset_data,
  check_data: Ephemeron_check_data,
  blit_data: Ephemeron_blit_data
end;

export do
  is_block ,
  double_field ,
  set_double_field ,
  first_non_constant_constructor_tag ,
  last_non_constant_constructor_tag ,
  lazy_tag ,
  closure_tag ,
  object_tag ,
  infix_tag ,
  forward_tag ,
  no_scan_tag ,
  abstract_tag ,
  string_tag ,
  double_tag ,
  double_array_tag ,
  custom_tag ,
  final_tag ,
  int_tag ,
  out_of_heap_tag ,
  unaligned_tag ,
  extension_constructor ,
  extension_name ,
  extension_id ,
  marshal ,
  unmarshal ,
  Ephemeron ,
  
end
--[[ No side effect ]]
