console = {log = print};

Obj = require "./obj";
List = require "./list";
__Array = require "./array";
Curry = require "./curry";
Caml_oo = require "./caml_oo";
Caml_obj = require "./caml_obj";
Caml_array = require "./caml_array";
Caml_int32 = require "./caml_int32";
Belt_MapInt = require "./belt_MapInt";
Caml_string = require "./caml_string";
Belt_MapString = require "./belt_MapString";
Caml_exceptions = require "./caml_exceptions";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function copy(o) do
  return Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(o));
end end

params = {
  compact_table = true,
  copy_parent = true,
  clean_when_copying = true,
  retry_count = 3,
  bucket_small_size = 16
};

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

dummy_table = {
  size = 0,
  methods = {--[[ () ]]0},
  methods_by_name = Belt_MapString.empty,
  methods_by_label = Belt_MapInt.empty,
  previous_states = --[[ [] ]]0,
  hidden_meths = --[[ [] ]]0,
  vars = Belt_MapString.empty,
  initializers = --[[ [] ]]0
};

table_count = {
  contents = 0
};

dummy_met = --[[ obj_block ]]{};

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
  return {
          size = 2,
          methods = methods,
          methods_by_name = Belt_MapString.empty,
          methods_by_label = Belt_MapInt.empty,
          previous_states = --[[ [] ]]0,
          hidden_meths = --[[ [] ]]0,
          vars = Belt_MapString.empty,
          initializers = --[[ [] ]]0
        };
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

method_count = {
  contents = 0
};

inst_var_count = {
  contents = 0
};

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
  return __Array.map((function(param) do
                return get_method_label(table, param);
              end end), names);
end end

function set_method(table, label, element) do
  method_count.contents = method_count.contents + 1 | 0;
  if (Belt_MapInt.getExn(table.methods_by_label, label)) then do
    array = table;
    label_1 = label;
    element_1 = element;
    resize(array, label_1 + 1 | 0);
    return Caml_array.caml_array_set(array.methods, label_1, element_1);
  end else do
    table.hidden_meths = --[[ :: ]]{
      --[[ tuple ]]{
        label,
        element
      },
      table.hidden_meths
    };
    return --[[ () ]]0;
  end end 
end end

function get_method(table, label) do
  xpcall(function() do
    return List.assoc(label, table.hidden_meths);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return Caml_array.caml_array_get(table.methods, label);
    end else do
      error(exn)
    end end 
  end end)
end end

function to_list(arr) do
  if (arr == 0) then do
    return --[[ [] ]]0;
  end else do
    return __Array.to_list(arr);
  end end 
end end

function narrow(table, vars, virt_meths, concr_meths) do
  vars_1 = to_list(vars);
  virt_meths_1 = to_list(virt_meths);
  concr_meths_1 = to_list(concr_meths);
  virt_meth_labs = List.map((function(param) do
          return get_method_label(table, param);
        end end), virt_meths_1);
  concr_meth_labs = List.map((function(param) do
          return get_method_label(table, param);
        end end), concr_meths_1);
  table.previous_states = --[[ :: ]]{
    --[[ tuple ]]{
      table.methods_by_name,
      table.methods_by_label,
      table.hidden_meths,
      table.vars,
      virt_meth_labs,
      vars_1
    },
    table.previous_states
  };
  table.vars = Belt_MapString.reduceU(table.vars, Belt_MapString.empty, (function(tvars, lab, info) do
          if (List.mem(lab, vars_1)) then do
            return Belt_MapString.set(tvars, lab, info);
          end else do
            return tvars;
          end end 
        end end));
  by_name = {
    contents = Belt_MapString.empty
  };
  by_label = {
    contents = Belt_MapInt.empty
  };
  List.iter2((function(met, label) do
          by_name.contents = Belt_MapString.set(by_name.contents, met, label);
          by_label.contents = Belt_MapInt.set(by_label.contents, label, Belt_MapInt.getWithDefault(table.methods_by_label, label, true));
          return --[[ () ]]0;
        end end), concr_meths_1, concr_meth_labs);
  List.iter2((function(met, label) do
          by_name.contents = Belt_MapString.set(by_name.contents, met, label);
          by_label.contents = Belt_MapInt.set(by_label.contents, label, false);
          return --[[ () ]]0;
        end end), virt_meths_1, virt_meth_labs);
  table.methods_by_name = by_name.contents;
  table.methods_by_label = by_label.contents;
  table.hidden_meths = List.fold_right((function(met, hm) do
          if (List.mem(met[0], virt_meth_labs)) then do
            return hm;
          end else do
            return --[[ :: ]]{
                    met,
                    hm
                  };
          end end 
        end end), table.hidden_meths, --[[ [] ]]0);
  return --[[ () ]]0;
end end

function widen(table) do
  match = List.hd(table.previous_states);
  virt_meths = match[4];
  table.previous_states = List.tl(table.previous_states);
  table.vars = List.fold_left((function(s, v) do
          return Belt_MapString.set(s, v, Belt_MapString.getExn(table.vars, v));
        end end), match[3], match[5]);
  table.methods_by_name = match[0];
  table.methods_by_label = match[1];
  table.hidden_meths = List.fold_right((function(met, hm) do
          if (List.mem(met[0], virt_meths)) then do
            return hm;
          end else do
            return --[[ :: ]]{
                    met,
                    hm
                  };
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
    return {};
  end else do
    return arr;
  end end 
end end

function new_methods_variables(table, meths, vals) do
  meths_1 = to_array(meths);
  nmeths = #meths_1;
  nvals = #vals;
  res = Caml_array.caml_make_vect(nmeths + nvals | 0, 0);
  for i = 0 , nmeths - 1 | 0 , 1 do
    Caml_array.caml_array_set(res, i, get_method_label(table, Caml_array.caml_array_get(meths_1, i)));
  end
  for i_1 = 0 , nvals - 1 | 0 , 1 do
    Caml_array.caml_array_set(res, i_1 + nmeths | 0, new_variable(table, Caml_array.caml_array_get(vals, i_1)));
  end
  return res;
end end

function get_variable(table, name) do
  return Belt_MapString.getExn(table.vars, name);
end end

function get_variables(table, names) do
  return __Array.map((function(param) do
                return Belt_MapString.getExn(table.vars, param);
              end end), names);
end end

function add_initializer(table, f) do
  table.initializers = --[[ :: ]]{
    f,
    table.initializers
  };
  return --[[ () ]]0;
end end

function create_table(public_methods) do
  if (public_methods == 0) then do
    return new_table({});
  end else do
    tags = __Array.map(public_method_label, public_methods);
    table = new_table(tags);
    __Array.iteri((function(i, met) do
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
  return Caml_array.caml_array_concat(--[[ :: ]]{
              {init},
              --[[ :: ]]{
                __Array.map((function(param) do
                        return Belt_MapString.getExn(cla.vars, param);
                      end end), to_array(vals)),
                --[[ :: ]]{
                  __Array.map((function(nm) do
                          return get_method(cla, get_method_label(cla, nm));
                        end end), to_array(concr_meths)),
                  --[[ [] ]]0
                }
              }
            });
end end

function make_class(pub_meths, class_init) do
  table = create_table(pub_meths);
  env_init = Curry._1(class_init, table);
  init_class(table);
  return --[[ tuple ]]{
          Curry._1(env_init, 0),
          class_init,
          env_init,
          0
        };
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
      ::continue:: ;
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
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalOO.ml",
        484,
        13
      }
    })
  end end 
end end

function set_next(tables, v) do
  if (tables) then do
    tables[--[[ next ]]2] = v;
    return --[[ () ]]0;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalOO.ml",
        487,
        13
      }
    })
  end end 
end end

function get_key(param) do
  if (param) then do
    return param[--[[ key ]]0];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalOO.ml",
        490,
        13
      }
    })
  end end 
end end

function get_data(param) do
  if (param) then do
    return param[--[[ data ]]1];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalOO.ml",
        493,
        13
      }
    })
  end end 
end end

function get_next(param) do
  if (param) then do
    return param[--[[ next ]]2];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalOO.ml",
        496,
        13
      }
    })
  end end 
end end

function build_path(n, keys, tables) do
  res = --[[ Cons ]]{
    --[[ key ]]0,
    --[[ data : Empty ]]0,
    --[[ next : Empty ]]0
  };
  r = res;
  for i = 0 , n , 1 do
    r = --[[ Cons ]]{
      --[[ key ]]Caml_array.caml_array_get(keys, i),
      --[[ data ]]r,
      --[[ next : Empty ]]0
    };
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
      tables_1 = _tables;
      if (get_key(tables_1) == key) then do
        tables_data = get_data(tables_1);
        if (tables_data) then do
          return lookup_keys(i - 1 | 0, keys, tables_data);
        end else do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "camlinternalOO.ml",
              514,
              17
            }
          })
        end end 
      end else do
        next = get_next(tables_1);
        if (next) then do
          _tables = next;
          ::continue:: ;
        end else do
          next_1 = --[[ Cons ]]{
            --[[ key ]]key,
            --[[ data : Empty ]]0,
            --[[ next : Empty ]]0
          };
          set_next(tables_1, next_1);
          return build_path(i - 1 | 0, keys, next_1);
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
  n_1 = n % 2 == 0 or n > (2 + ((Caml_array.caml_array_get(table.methods, 1) << 4) / 32 | 0) | 0) and n or new_method(table);
  Caml_array.caml_array_set(table.methods, n_1, 0);
  return n_1;
end end

function method_impl(table, i, arr) do
  next = function(param) do
    i.contents = i.contents + 1 | 0;
    return Caml_array.caml_array_get(arr, i.contents);
  end end;
  clo = next(--[[ () ]]0);
  if (typeof clo == "number") then do
    local ___conditional___=(clo);
    do
       if ___conditional___ == 0--[[ GetConst ]] then do
          x = next(--[[ () ]]0);
          return (function(_obj) do
              return x;
            end end); end end 
       if ___conditional___ == 1--[[ GetVar ]] then do
          n = next(--[[ () ]]0);
          return (function(obj) do
              return obj[n];
            end end); end end 
       if ___conditional___ == 2--[[ GetEnv ]] then do
          e = next(--[[ () ]]0);
          n_1 = next(--[[ () ]]0);
          e_1 = e;
          n_2 = n_1;
          return (function(obj) do
              return obj[e_1][n_2];
            end end); end end 
       if ___conditional___ == 3--[[ GetMeth ]] then do
          n_3 = next(--[[ () ]]0);
          return (function(obj) do
              return Curry._1(obj[0][n_3], obj);
            end end); end end 
       if ___conditional___ == 4--[[ SetVar ]] then do
          n_4 = next(--[[ () ]]0);
          return (function(obj, x) do
              obj[n_4] = x;
              return --[[ () ]]0;
            end end); end end 
       if ___conditional___ == 5--[[ AppConst ]] then do
          f = next(--[[ () ]]0);
          x_1 = next(--[[ () ]]0);
          return (function(_obj) do
              return Curry._1(f, x_1);
            end end); end end 
       if ___conditional___ == 6--[[ AppVar ]] then do
          f_1 = next(--[[ () ]]0);
          n_5 = next(--[[ () ]]0);
          return (function(obj) do
              return Curry._1(f_1, obj[n_5]);
            end end); end end 
       if ___conditional___ == 7--[[ AppEnv ]] then do
          f_2 = next(--[[ () ]]0);
          e_2 = next(--[[ () ]]0);
          n_6 = next(--[[ () ]]0);
          f_3 = f_2;
          e_3 = e_2;
          n_7 = n_6;
          return (function(obj) do
              return Curry._1(f_3, obj[e_3][n_7]);
            end end); end end 
       if ___conditional___ == 8--[[ AppMeth ]] then do
          f_4 = next(--[[ () ]]0);
          n_8 = next(--[[ () ]]0);
          f_5 = f_4;
          n_9 = n_8;
          return (function(obj) do
              return Curry._1(f_5, Curry._1(obj[0][n_9], obj));
            end end); end end 
       if ___conditional___ == 9--[[ AppConstConst ]] then do
          f_6 = next(--[[ () ]]0);
          x_2 = next(--[[ () ]]0);
          y = next(--[[ () ]]0);
          return (function(_obj) do
              return Curry._2(f_6, x_2, y);
            end end); end end 
       if ___conditional___ == 10--[[ AppConstVar ]] then do
          f_7 = next(--[[ () ]]0);
          x_3 = next(--[[ () ]]0);
          n_10 = next(--[[ () ]]0);
          f_8 = f_7;
          x_4 = x_3;
          n_11 = n_10;
          return (function(obj) do
              return Curry._2(f_8, x_4, obj[n_11]);
            end end); end end 
       if ___conditional___ == 11--[[ AppConstEnv ]] then do
          f_9 = next(--[[ () ]]0);
          x_5 = next(--[[ () ]]0);
          e_4 = next(--[[ () ]]0);
          n_12 = next(--[[ () ]]0);
          f_10 = f_9;
          x_6 = x_5;
          e_5 = e_4;
          n_13 = n_12;
          return (function(obj) do
              return Curry._2(f_10, x_6, obj[e_5][n_13]);
            end end); end end 
       if ___conditional___ == 12--[[ AppConstMeth ]] then do
          f_11 = next(--[[ () ]]0);
          x_7 = next(--[[ () ]]0);
          n_14 = next(--[[ () ]]0);
          f_12 = f_11;
          x_8 = x_7;
          n_15 = n_14;
          return (function(obj) do
              return Curry._2(f_12, x_8, Curry._1(obj[0][n_15], obj));
            end end); end end 
       if ___conditional___ == 13--[[ AppVarConst ]] then do
          f_13 = next(--[[ () ]]0);
          n_16 = next(--[[ () ]]0);
          x_9 = next(--[[ () ]]0);
          f_14 = f_13;
          n_17 = n_16;
          x_10 = x_9;
          return (function(obj) do
              return Curry._2(f_14, obj[n_17], x_10);
            end end); end end 
       if ___conditional___ == 14--[[ AppEnvConst ]] then do
          f_15 = next(--[[ () ]]0);
          e_6 = next(--[[ () ]]0);
          n_18 = next(--[[ () ]]0);
          x_11 = next(--[[ () ]]0);
          f_16 = f_15;
          e_7 = e_6;
          n_19 = n_18;
          x_12 = x_11;
          return (function(obj) do
              return Curry._2(f_16, obj[e_7][n_19], x_12);
            end end); end end 
       if ___conditional___ == 15--[[ AppMethConst ]] then do
          f_17 = next(--[[ () ]]0);
          n_20 = next(--[[ () ]]0);
          x_13 = next(--[[ () ]]0);
          f_18 = f_17;
          n_21 = n_20;
          x_14 = x_13;
          return (function(obj) do
              return Curry._2(f_18, Curry._1(obj[0][n_21], obj), x_14);
            end end); end end 
       if ___conditional___ == 16--[[ MethAppConst ]] then do
          n_22 = next(--[[ () ]]0);
          x_15 = next(--[[ () ]]0);
          n_23 = n_22;
          x_16 = x_15;
          return (function(obj) do
              return Curry._2(obj[0][n_23], obj, x_16);
            end end); end end 
       if ___conditional___ == 17--[[ MethAppVar ]] then do
          n_24 = next(--[[ () ]]0);
          m = next(--[[ () ]]0);
          n_25 = n_24;
          m_1 = m;
          return (function(obj) do
              return Curry._2(obj[0][n_25], obj, obj[m_1]);
            end end); end end 
       if ___conditional___ == 18--[[ MethAppEnv ]] then do
          n_26 = next(--[[ () ]]0);
          e_8 = next(--[[ () ]]0);
          m_2 = next(--[[ () ]]0);
          n_27 = n_26;
          e_9 = e_8;
          m_3 = m_2;
          return (function(obj) do
              return Curry._2(obj[0][n_27], obj, obj[e_9][m_3]);
            end end); end end 
       if ___conditional___ == 19--[[ MethAppMeth ]] then do
          n_28 = next(--[[ () ]]0);
          m_4 = next(--[[ () ]]0);
          n_29 = n_28;
          m_5 = m_4;
          return (function(obj) do
              return Curry._2(obj[0][n_29], obj, Curry._1(obj[0][m_5], obj));
            end end); end end 
       if ___conditional___ == 20--[[ SendConst ]] then do
          m_6 = next(--[[ () ]]0);
          x_17 = next(--[[ () ]]0);
          m_7 = m_6;
          x_18 = x_17;
          new_cache(table);
          return (function(obj) do
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, x_18, m_7, 1), x_18);
            end end); end end 
       if ___conditional___ == 21--[[ SendVar ]] then do
          m_8 = next(--[[ () ]]0);
          n_30 = next(--[[ () ]]0);
          m_9 = m_8;
          n_31 = n_30;
          new_cache(table);
          return (function(obj) do
              tmp = obj[n_31];
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m_9, 2), tmp);
            end end); end end 
       if ___conditional___ == 22--[[ SendEnv ]] then do
          m_10 = next(--[[ () ]]0);
          e_10 = next(--[[ () ]]0);
          n_32 = next(--[[ () ]]0);
          m_11 = m_10;
          e_11 = e_10;
          n_33 = n_32;
          new_cache(table);
          return (function(obj) do
              tmp = obj[e_11][n_33];
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m_11, 3), tmp);
            end end); end end 
       if ___conditional___ == 23--[[ SendMeth ]] then do
          m_12 = next(--[[ () ]]0);
          n_34 = next(--[[ () ]]0);
          m_13 = m_12;
          n_35 = n_34;
          new_cache(table);
          return (function(obj) do
              tmp = Curry._1(obj[0][n_35], obj);
              return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m_13, 4), tmp);
            end end); end end 
      
    end
  end else do
    return clo;
  end end 
end end

function set_methods(table, methods) do
  len = #methods;
  i = {
    contents = 0
  };
  while(i.contents < len) do
    label = Caml_array.caml_array_get(methods, i.contents);
    clo = method_impl(table, i, methods);
    set_method(table, label, clo);
    i.contents = i.contents + 1 | 0;
  end;
  return --[[ () ]]0;
end end

function stats(param) do
  return {
          classes = table_count.contents,
          methods = method_count.contents,
          inst_vars = inst_var_count.contents
        };
end end

exports = {}
exports.public_method_label = public_method_label;
exports.new_method = new_method;
exports.new_variable = new_variable;
exports.new_methods_variables = new_methods_variables;
exports.get_variable = get_variable;
exports.get_variables = get_variables;
exports.get_method_label = get_method_label;
exports.get_method_labels = get_method_labels;
exports.get_method = get_method;
exports.set_method = set_method;
exports.set_methods = set_methods;
exports.narrow = narrow;
exports.widen = widen;
exports.add_initializer = add_initializer;
exports.dummy_table = dummy_table;
exports.create_table = create_table;
exports.init_class = init_class;
exports.inherits = inherits;
exports.make_class = make_class;
exports.make_class_store = make_class_store;
exports.copy = copy;
exports.create_object = create_object;
exports.create_object_opt = create_object_opt;
exports.run_initializers = run_initializers;
exports.run_initializers_opt = run_initializers_opt;
exports.create_object_and_run_initializers = create_object_and_run_initializers;
exports.lookup_tables = lookup_tables;
exports.params = params;
exports.stats = stats;
--[[ No side effect ]]
