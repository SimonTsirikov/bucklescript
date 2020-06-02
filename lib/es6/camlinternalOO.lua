

import * as Obj from "./obj.lua";
import * as List from "./list.lua";
import * as __Array from "./array.lua";
import * as Curry from "./curry.lua";
import * as Caml_oo from "./caml_oo.lua";
import * as Caml_obj from "./caml_obj.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_int32 from "./caml_int32.lua";
import * as Belt_MapInt from "./belt_MapInt.lua";
import * as Caml_string from "./caml_string.lua";
import * as Belt_MapString from "./belt_MapString.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function copy(o) do
  return Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(o));
end end

params = do
  compact_table: true,
  copy_parent: true,
  clean_when_copying: true,
  retry_count: 3,
  bucket_small_size: 16
end;

function public_method_label(s) do
  accu = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    accu = Caml_int32.imul(223, accu) + Caml_string.get(s, i) | 0;
  end
  accu = accu & 2147483647;
  if (accu > 1073741823) then do
    return accu - -2147483648 | 0;
  end else do
    return accu;
  end end 
end end

dummy_table = do
  size: 0,
  methods: [--[[ () ]]0],
  methods_by_name: Belt_MapString.empty,
  methods_by_label: Belt_MapInt.empty,
  previous_states: --[[ [] ]]0,
  hidden_meths: --[[ [] ]]0,
  vars: Belt_MapString.empty,
  initializers: --[[ [] ]]0
end;

table_count = do
  contents: 0
end;

dummy_met = --[[ obj_block ]][];

function fit_size(n) do
  if (n <= 2) then do
    return n;
  end else do
    return (fit_size((n + 1 | 0) / 2 | 0) << 1);
  end end 
end end

function new_table(pub_labels) do
  table_count.contents = table_count.contents + 1 | 0;
  len = #pub_labels;
  methods = Caml_array.caml_make_vect((len << 1) + 2 | 0, dummy_met);
  Caml_array.caml_array_set(methods, 0, len);
  Caml_array.caml_array_set(methods, 1, ((fit_size(len) << 5) / 8 | 0) - 1 | 0);
  for i = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(methods, (i << 1) + 3 | 0, Caml_array.caml_array_get(pub_labels, i));
  end
  return do
          size: 2,
          methods: methods,
          methods_by_name: Belt_MapString.empty,
          methods_by_label: Belt_MapInt.empty,
          previous_states: --[[ [] ]]0,
          hidden_meths: --[[ [] ]]0,
          vars: Belt_MapString.empty,
          initializers: --[[ [] ]]0
        end;
end end

function resize(array, new_size) do
  old_size = #array.methods;
  if (new_size > old_size) then do
    new_buck = Caml_array.caml_make_vect(new_size, dummy_met);
    __Array.blit(array.methods, 0, new_buck, 0, old_size);
    array.methods = new_buck;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

method_count = do
  contents: 0
end;

inst_var_count = do
  contents: 0
end;

function new_method(table) do
  index = #table.methods;
  resize(table, index + 1 | 0);
  return index;
end end

function get_method_label(table, name) do
  match = Belt_MapString.getUndefined(table.methods_by_name, name);
  if (match ~= undefined) then do
    return match;
  end else do
    label = new_method(table);
    table.methods_by_name = Belt_MapString.set(table.methods_by_name, name, label);
    table.methods_by_label = Belt_MapInt.set(table.methods_by_label, label, true);
    return label;
  end end 
end end

function get_method_labels(table, names) do
  return __Array.map((function (param) do
                return get_method_label(table, param);
              end end), names);
end end

function set_method(table, label, element) do
  method_count.contents = method_count.contents + 1 | 0;
  if (Belt_MapInt.getExn(table.methods_by_label, label)) then do
    array = table;
    label$1 = label;
    element$1 = element;
    resize(array, label$1 + 1 | 0);
    return Caml_array.caml_array_set(array.methods, label$1, element$1);
  end else do
    table.hidden_meths = --[[ :: ]][
      --[[ tuple ]][
        label,
        element
      ],
      table.hidden_meths
    ];
    return --[[ () ]]0;
  end end 
end end

function get_method(table, label) do
  try do
    return List.assoc(label, table.hidden_meths);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return Caml_array.caml_array_get(table.methods, label);
    end else do
      throw exn;
    end end 
  end
end end

function to_list(arr) do
  if (arr == 0) then do
    return --[[ [] ]]0;
  end else do
    return __Array.to_list(arr);
  end end 
end end

function narrow(table, vars, virt_meths, concr_meths) do
  vars$1 = to_list(vars);
  virt_meths$1 = to_list(virt_meths);
  concr_meths$1 = to_list(concr_meths);
  virt_meth_labs = List.map((function (param) do
          return get_method_label(table, param);
        end end), virt_meths$1);
  concr_meth_labs = List.map((function (param) do
          return get_method_label(table, param);
        end end), concr_meths$1);
  table.previous_states = --[[ :: ]][
    --[[ tuple ]][
      table.methods_by_name,
      table.methods_by_label,
      table.hidden_meths,
      table.vars,
      virt_meth_labs,
      vars$1
    ],
    table.previous_states
  ];
  table.vars = Belt_MapString.reduceU(table.vars, Belt_MapString.empty, (function (tvars, lab, info) do
          if (List.mem(lab, vars$1)) then do
            return Belt_MapString.set(tvars, lab, info);
          end else do
            return tvars;
          end end 
        end end));
  by_name = do
    contents: Belt_MapString.empty
  end;
  by_label = do
    contents: Belt_MapInt.empty
  end;
  List.iter2((function (met, label) do
          by_name.contents = Belt_MapString.set(by_name.contents, met, label);
          by_label.contents = Belt_MapInt.set(by_label.contents, label, Belt_MapInt.getWithDefault(table.methods_by_label, label, true));
          return --[[ () ]]0;
        end end), concr_meths$1, concr_meth_labs);
  List.iter2((function (met, label) do
          by_name.contents = Belt_MapString.set(by_name.contents, met, label);
          by_label.contents = Belt_MapInt.set(by_label.contents, label, false);
          return --[[ () ]]0;
        end end), virt_meths$1, virt_meth_labs);
  table.methods_by_name = by_name.contents;
  table.methods_by_label = by_label.contents;
  table.hidden_meths = List.fold_right((function (met, hm) do
          if (List.mem(met[0], virt_meth_labs)) then do
            return hm;
          end else do
            return --[[ :: ]][
                    met,
                    hm
                  ];
          end end 
        end end), table.hidden_meths, --[[ [] ]]0);
  return --[[ () ]]0;
end end

function widen(table) do
  match = List.hd(table.previous_states);
  virt_meths = match[4];
  table.previous_states = List.tl(table.previous_states);
  table.vars = List.fold_left((function (s, v) do
          return Belt_MapString.set(s, v, Belt_MapString.getExn(table.vars, v));
        end end), match[3], match[5]);
  table.methods_by_name = match[0];
  table.methods_by_label = match[1];
  table.hidden_meths = List.fold_right((function (met, hm) do
          if (List.mem(met[0], virt_meths)) then do
            return hm;
          end else do
            return --[[ :: ]][
                    met,
                    hm
                  ];
          end end 
        end end), table.hidden_meths, match[2]);
  return --[[ () ]]0;
end end

function new_slot(table) do
  index = table.size;
  table.size = index + 1 | 0;
  return index;
end end

function new_variable(table, name) do
  match = Belt_MapString.getUndefined(table.vars, name);
  if (match ~= undefined) then do
    return match;
  end else do
    index = new_slot(table);
    if (name ~= "") then do
      table.vars = Belt_MapString.set(table.vars, name, index);
    end
     end 
    return index;
  end end 
end end

function to_array(arr) do
  if (Caml_obj.caml_equal(arr, 0)) then do
    return [];
  end else do
    return arr;
  end end 
end end

function new_methods_variables(table, meths, vals) do
  meths$1 = to_array(meths);
  nmeths = #meths$1;
  nvals = #vals;
  res = Caml_array.caml_make_vect(nmeths + nvals | 0, 0);
  for i = 0 , nmeths - 1 | 0 , 1 do
    Caml_array.caml_array_set(res, i, get_method_label(table, Caml_array.caml_array_get(meths$1, i)));
  end
  for i$1 = 0 , nvals - 1 | 0 , 1 do
    Caml_array.caml_array_set(res, i$1 + nmeths | 0, new_variable(table, Caml_array.caml_array_get(vals, i$1)));
  end
  return res;
end end

function get_variable(table, name) do
  return Belt_MapString.getExn(table.vars, name);
end end

function get_variables(table, names) do
  return __Array.map((function (param) do
                return Belt_MapString.getExn(table.vars, param);
              end end), names);
end end

function add_initializer(table, f) do
  table.initializers = --[[ :: ]][
    f,
    table.initializers
  ];
  return --[[ () ]]0;
end end

function create_table(public_methods) do
  if (public_methods == 0) then do
    return new_table([]);
  end else do
    tags = __Array.map(public_method_label, public_methods);
    table = new_table(tags);
    __Array.iteri((function (i, met) do
            lab = (i << 1) + 2 | 0;
            table.methods_by_name = Belt_MapString.set(table.methods_by_name, met, lab);
            table.methods_by_label = Belt_MapInt.set(table.methods_by_label, lab, true);
            return --[[ () ]]0;
          end end), public_methods);
    return table;
  end end 
end end

function init_class(table) do
  inst_var_count.contents = (inst_var_count.contents + table.size | 0) - 1 | 0;
  table.initializers = List.rev(table.initializers);
  return resize(table, 3 + ((Caml_array.caml_array_get(table.methods, 1) << 4) / 32 | 0) | 0);
end end

function inherits(cla, vals, virt_meths, concr_meths, param, top) do
  __super = param[1];
  narrow(cla, vals, virt_meths, concr_meths);
  init = top and Curry._2(__super, cla, param[3]) or Curry._1(__super, cla);
  widen(cla);
  return Caml_array.caml_array_concat(--[[ :: ]][
              [init],
              --[[ :: ]][
                __Array.map((function (param) do
                        return Belt_MapString.getExn(cla.vars, param);
                      end end), to_array(vals)),
                --[[ :: ]][
                  __Array.map((function (nm) do
                          return get_method(cla, get_method_label(cla, nm));
                        end end), to_array(concr_meths)),
                  --[[ [] ]]0
                ]
              ]
            ]);
end end

function make_class(pub_meths, class_init) do
  table = create_table(pub_meths);
  env_init = Curry._1(class_init, table);
  init_class(table);
  return --[[ tuple ]][
          Curry._1(env_init, 0),
          class_init,
          env_init,
          0
        ];
end end

function make_class_store(pub_meths, class_init, init_table) do
  table = create_table(pub_meths);
  env_init = Curry._1(class_init, table);
  init_class(table);
  init_table.class_init = class_init;
  init_table.env_init = env_init;
  return --[[ () ]]0;
end end

function create_object(table) do
  obj = Caml_obj.caml_obj_block(Obj.object_tag, table.size);
  obj[0] = table.methods;
  return Caml_exceptions.caml_set_oo_id(obj);
end end

function create_object_opt(obj_0, table) do
  if (obj_0) then do
    return obj_0;
  end else do
    obj = Caml_obj.caml_obj_block(Obj.object_tag, table.size);
    obj[0] = table.methods;
    return Caml_exceptions.caml_set_oo_id(obj);
  end end 
end end

function iter_f(obj, _param) do
  while(true) do
    param = _param;
    if (param) then do
      Curry._1(param[0], obj);
      _param = param[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function run_initializers(obj, table) do
  inits = table.initializers;
  if (inits ~= --[[ [] ]]0) then do
    return iter_f(obj, inits);
  end else do
    return 0;
  end end 
end end

function run_initializers_opt(obj_0, obj, table) do
  if (obj_0) then do
    return obj;
  end else do
    inits = table.initializers;
    if (inits ~= --[[ [] ]]0) then do
      iter_f(obj, inits);
    end
     end 
    return obj;
  end end 
end end

function create_object_and_run_initializers(obj_0, table) do
  if (obj_0) then do
    return obj_0;
  end else do
    obj = create_object(table);
    run_initializers(obj, table);
    return obj;
  end end 
end end

function set_data(tables, v) do
  if (tables) then do
    tables[--[[ data ]]1] = v;
    return --[[ () ]]0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "camlinternalOO.ml",
            484,
            13
          ]
        ];
  end end 
end end

function set_next(tables, v) do
  if (tables) then do
    tables[--[[ next ]]2] = v;
    return --[[ () ]]0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "camlinternalOO.ml",
            487,
            13
          ]
        ];
  end end 
end end

function get_key(param) do
  if (param) then do
    return param[--[[ key ]]0];
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "camlinternalOO.ml",
            490,
            13
          ]
        ];
  end end 
end end

function get_data(param) do
  if (param) then do
    return param[--[[ data ]]1];
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "camlinternalOO.ml",
            493,
            13
          ]
        ];
  end end 
end end

function get_next(param) do
  if (param) then do
    return param[--[[ next ]]2];
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "camlinternalOO.ml",
            496,
            13
          ]
        ];
  end end 
end end

function build_path(n, keys, tables) do
  res = --[[ Cons ]][
    --[[ key ]]0,
    --[[ data : Empty ]]0,
    --[[ next : Empty ]]0
  ];
  r = res;
  for i = 0 , n , 1 do
    r = --[[ Cons ]][
      --[[ key ]]Caml_array.caml_array_get(keys, i),
      --[[ data ]]r,
      --[[ next : Empty ]]0
    ];
  end
  set_data(tables, r);
  return res;
end end

function lookup_keys(i, keys, tables) do
  if (i < 0) then do
    return tables;
  end else do
    key = Caml_array.caml_array_get(keys, i);
    _tables = tables;
    while(true) do
      tables$1 = _tables;
      if (get_key(tables$1) == key) then do
        tables_data = get_data(tables$1);
        if (tables_data) then do
          return lookup_keys(i - 1 | 0, keys, tables_data);
        end else do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]][
                  "camlinternalOO.ml",
                  514,
                  17
                ]
              ];
        end end 
      end else do
        next = get_next(tables$1);
        if (next) then do
          _tables = next;
          continue ;
        end else do
          next$1 = --[[ Cons ]][
            --[[ key ]]key,
            --[[ data : Empty ]]0,
            --[[ next : Empty ]]0
          ];
          set_next(tables$1, next$1);
          return build_path(i - 1 | 0, keys, next$1);
        end end 
      end end 
    end;
  end end 
end end

function lookup_tables(root, keys) do
  root_data = get_data(root);
  if (root_data) then do
    return lookup_keys(#keys - 1 | 0, keys, root_data);
  end else do
    return build_path(#keys - 1 | 0, keys, root);
  end end 
end end

function new_cache(table) do
  n = new_method(table);
  n$1 = n % 2 == 0 or n > (2 + ((Caml_array.caml_array_get(table.methods, 1) << 4) / 32 | 0) | 0) and n or new_method(table);
  Caml_array.caml_array_set(table.methods, n$1, 0);
  return n$1;
end end

function method_impl(table, i, arr) do
  next = function (param) do
    i.contents = i.contents + 1 | 0;
    return Caml_array.caml_array_get(arr, i.contents);
  end end;
  clo = next(--[[ () ]]0);
  if (typeof clo == "number") then do
    local ___conditional___=(clo);
    do
       if ___conditional___ = 0--[[ GetConst ]] then do
          x = next(--[[ () ]]0);
          return (function (_obj) do
              return x;
            end end);end end end 
       if ___conditional___ = 1--[[ GetVar ]] then do
          n = next(--[[ () ]]0);
          return (function (obj) do
              return obj[n];
            end end);end end end 
       if ___conditional___ = 2--[[ GetEnv ]] then do
          e = next(--[[ () ]]0);
          n$1 = next(--[[ () ]]0);
          e$1 = e;
          n$2 = n$1;
          return (function (obj) do
              return obj[e$1][n$2];
            end end);end end end 
       if ___conditional___ = 3--[[ GetMeth ]] then do
          n$3 = next(--[[ () ]]0);
          return (function (obj) do
              return Curry._1(obj[0][n$3], obj);
            end end);end end end 
       if ___conditional___ = 4--[[ SetVar ]] then do
          n$4 = next(--[[ () ]]0);
          return (function (obj, x) do
              obj[n$4] = x;
              return --[[ () ]]0;
            end end);end end end 
       if ___conditional___ = 5--[[ AppConst ]] then do
          f = next(--[[ () ]]0);
          x$1 = next(--[[ () ]]0);
          return (function (_obj) do
              return Curry._1(f, x$1);
            end end);end end end 
       if ___conditional___ = 6--[[ AppVar ]] then do
          f$1 = next(--[[ () ]]0);
          n$5 = next(--[[ () ]]0);
          return (function (obj) do
              return Curry._1(f$1, obj[n$5]);
            end end);end end end 
       if ___conditional___ = 7--[[ AppEnv ]] then do
          f$2 = next(--[[ () ]]0);
          e$2 = next(--[[ () ]]0);
          n$6 = next(--[[ () ]]0);
          f$3 = f$2;
          e$3 = e$2;
          n$7 = n$6;
          return (function (obj) do
              return Curry._1(f$3, obj[e$3][n$7]);
            end end);end end end 
       if ___conditional___ = 8--[[ AppMeth ]] then do
          f$4 = next(--[[ () ]]0);
          n$8 = next(--[[ () ]]0);
          f$5 = f$4;
          n$9 = n$8;
          return (function (obj) do
              return Curry._1(f$5, Curry._1(obj[0][n$9], obj));
            end end);end end end 
       if ___conditional___ = 9--[[ AppConstConst ]] then do
          f$6 = next(--[[ () ]]0);
          x$2 = next(--[[ () ]]0);
          y = next(--[[ () ]]0);
          return (function (_obj) do
              return Curry._2(f$6, x$2, y);
            end end);end end end 
       if ___conditional___ = 10--[[ AppConstVar ]] then do
          f$7 = next(--[[ () ]]0);
          x$3 = next(--[[ () ]]0);
          n$10 = next(--[[ () ]]0);
          f$8 = f$7;
          x$4 = x$3;
          n$11 = n$10;
          return (function (obj) do
              return Curry._2(f$8, x$4, obj[n$11]);
            end end);end end end 
       if ___conditional___ = 11--[[ AppConstEnv ]] then do
          f$9 = next(--[[ () ]]0);
          x$5 = next(--[[ () ]]0);
          e$4 = next(--[[ () ]]0);
          n$12 = next(--[[ () ]]0);
          f$10 = f$9;
          x$6 = x$5;
          e$5 = e$4;
          n$13 = n$12;
          return (function (obj) do
              return Curry._2(f$10, x$6, obj[e$5][n$13]);
            end end);end end end 
       if ___conditional___ = 12--[[ AppConstMeth ]] then do
          f$11 = next(--[[ () ]]0);
          x$7 = next(--[[ () ]]0);
          n$14 = next(--[[ () ]]0);
          f$12 = f$11;
          x$8 = x$7;
          n$15 = n$14;
          return (function (obj) do
              return Curry._2(f$12, x$8, Curry._1(obj[0][n$15], obj));
            end end);end end end 
       if ___conditional___ = 13--[[ AppVarConst ]] then do
          f$13 = next(--[[ () ]]0);
          n$16 = next(--[[ () ]]0);
          x$9 = next(--[[ () ]]0);
          f$14 = f$13;
          n$17 = n$16;
          x$10 = x$9;
          return (function (obj) do
              return Curry._2(f$14, obj[n$17], x$10);
            end end);end end end 
       if ___conditional___ = 14--[[ AppEnvConst ]] then do
          f$15 = next(--[[ () ]]0);
          e$6 = next(--[[ () ]]0);
          n$18 = next(--[[ () ]]0);
          x$11 = next(--[[ () ]]0);
          f$16 = f$15;
          e$7 = e$6;
          n$19 = n$18;
          x$12 = x$11;
          return (function (obj) do
              return Curry._2(f$16, obj[e$7][n$19], x$12);
            end end);end end end 
       if ___conditional___ = 15--[[ AppMethConst ]] then do
          f$17 = next(--[[ () ]]0);
          n$20 = next(--[[ () ]]0);
          x$13 = next(--[[ () ]]0);
          f$18 = f$17;
          n$21 = n$20;
          x$14 = x$13;
          return (function (obj) do
              return Curry._2(f$18, Curry._1(obj[0][n$21], obj), x$14);
            end end);end end end 
       if ___conditional___ = 16--[[ MethAppConst ]] then do
          n$22 = next(--[[ () ]]0);
          x$15 = next(--[[ () ]]0);
          n$23 = n$22;
          x$16 = x$15;
          return (function (obj) do
              return Curry._2(obj[0][n$23], obj, x$16);
            end end);end end end 
       if ___conditional___ = 17--[[ MethAppVar ]] then do
          n$24 = next(--[[ () ]]0);
          m = next(--[[ () ]]0);
          n$25 = n$24;
          m$1 = m;
          return (function (obj) do
              return Curry._2(obj[0][n$25], obj, obj[m$1]);
            end end);end end end 
       if ___conditional___ = 18--[[ MethAppEnv ]] then do
          n$26 = next(--[[ () ]]0);
          e$8 = next(--[[ () ]]0);
          m$2 = next(--[[ () ]]0);
          n$27 = n$26;
          e$9 = e$8;
          m$3 = m$2;
          return (function (obj) do
              return Curry._2(obj[0][n$27], obj, obj[e$9][m$3]);
            end end);end end end 
       if ___conditional___ = 19--[[ MethAppMeth ]] then do
          n$28 = next(--[[ () ]]0);
          m$4 = next(--[[ () ]]0);
          n$29 = n$28;
          m$5 = m$4;
          return (function (obj) do
              return Curry._2(obj[0][n$29], obj, Curry._1(obj[0][m$5], obj));
            end end);end end end 
       if ___conditional___ = 20--[[ SendConst ]] then do
          m$6 = next(--[[ () ]]0);
          x$17 = next(--[[ () ]]0);
          m$7 = m$6;
          x$18 = x$17;
          new_cache(table);
          return (function (obj) do
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, x$18, m$7, 1), x$18);
            end end);end end end 
       if ___conditional___ = 21--[[ SendVar ]] then do
          m$8 = next(--[[ () ]]0);
          n$30 = next(--[[ () ]]0);
          m$9 = m$8;
          n$31 = n$30;
          new_cache(table);
          return (function (obj) do
              tmp = obj[n$31];
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m$9, 2), tmp);
            end end);end end end 
       if ___conditional___ = 22--[[ SendEnv ]] then do
          m$10 = next(--[[ () ]]0);
          e$10 = next(--[[ () ]]0);
          n$32 = next(--[[ () ]]0);
          m$11 = m$10;
          e$11 = e$10;
          n$33 = n$32;
          new_cache(table);
          return (function (obj) do
              tmp = obj[e$11][n$33];
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m$11, 3), tmp);
            end end);end end end 
       if ___conditional___ = 23--[[ SendMeth ]] then do
          m$12 = next(--[[ () ]]0);
          n$34 = next(--[[ () ]]0);
          m$13 = m$12;
          n$35 = n$34;
          new_cache(table);
          return (function (obj) do
              tmp = Curry._1(obj[0][n$35], obj);
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m$13, 4), tmp);
            end end);end end end 
       do
      
    end
  end else do
    return clo;
  end end 
end end

function set_methods(table, methods) do
  len = #methods;
  i = do
    contents: 0
  end;
  while(i.contents < len) do
    label = Caml_array.caml_array_get(methods, i.contents);
    clo = method_impl(table, i, methods);
    set_method(table, label, clo);
    i.contents = i.contents + 1 | 0;
  end;
  return --[[ () ]]0;
end end

function stats(param) do
  return do
          classes: table_count.contents,
          methods: method_count.contents,
          inst_vars: inst_var_count.contents
        end;
end end

export do
  public_method_label ,
  new_method ,
  new_variable ,
  new_methods_variables ,
  get_variable ,
  get_variables ,
  get_method_label ,
  get_method_labels ,
  get_method ,
  set_method ,
  set_methods ,
  narrow ,
  widen ,
  add_initializer ,
  dummy_table ,
  create_table ,
  init_class ,
  inherits ,
  make_class ,
  make_class_store ,
  copy ,
  create_object ,
  create_object_opt ,
  run_initializers ,
  run_initializers_opt ,
  create_object_and_run_initializers ,
  lookup_tables ,
  params ,
  stats ,
  
end
--[[ No side effect ]]
