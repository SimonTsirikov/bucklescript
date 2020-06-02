--[['use strict';]]

List = require "../../lib/js/list.lua";
__Array = require "../../lib/js/array.lua";
Curry = require "../../lib/js/curry.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Caml_option = require "../../lib/js/caml_option.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function reverse_range(a, i, len) do
  if (len == 0) then do
    return --[[ () ]]0;
  end else do
    for k = 0 , (len - 1 | 0) / 2 | 0 , 1 do
      t = a[i + k | 0];
      a[i + k | 0] = a[((i + len | 0) - 1 | 0) - k | 0];
      a[((i + len | 0) - 1 | 0) - k | 0] = t;
    end
    return --[[ () ]]0;
  end end 
end end

function reverse_in_place(a) do
  return reverse_range(a, 0, #a);
end end

function reverse(a) do
  b_len = #a;
  if (b_len == 0) then do
    return [];
  end else do
    b = __Array.copy(a);
    for i = 0 , b_len - 1 | 0 , 1 do
      b[i] = a[(b_len - 1 | 0) - i | 0];
    end
    return b;
  end end 
end end

function reverse_of_list(l) do
  if (l) then do
    len = List.length(l);
    a = Caml_array.caml_make_vect(len, l[0]);
    _i = 0;
    _param = l[1];
    while(true) do
      param = _param;
      i = _i;
      if (param) then do
        a[(len - i | 0) - 2 | 0] = param[0];
        _param = param[1];
        _i = i + 1 | 0;
        continue ;
      end else do
        return a;
      end end 
    end;
  end else do
    return [];
  end end 
end end

function filter(f, a) do
  arr_len = #a;
  _acc = --[[ [] ]]0;
  _i = 0;
  while(true) do
    i = _i;
    acc = _acc;
    if (i == arr_len) then do
      return reverse_of_list(acc);
    end else do
      v = a[i];
      if (Curry._1(f, v)) then do
        _i = i + 1 | 0;
        _acc = --[[ :: ]][
          v,
          acc
        ];
        continue ;
      end else do
        _i = i + 1 | 0;
        continue ;
      end end 
    end end 
  end;
end end

function filter_map(f, a) do
  arr_len = #a;
  _acc = --[[ [] ]]0;
  _i = 0;
  while(true) do
    i = _i;
    acc = _acc;
    if (i == arr_len) then do
      return reverse_of_list(acc);
    end else do
      v = a[i];
      match = Curry._1(f, v);
      _i = i + 1 | 0;
      if (match ~= undefined) then do
        _acc = --[[ :: ]][
          Caml_option.valFromOption(match),
          acc
        ];
        continue ;
      end else do
        continue ;
      end end 
    end end 
  end;
end end

function range(from, to_) do
  if (from > to_) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_array_test.range"
        ];
  end
   end 
  return __Array.init((to_ - from | 0) + 1 | 0, (function (i) do
                return i + from | 0;
              end end));
end end

function map2i(f, a, b) do
  len = #a;
  if (len ~= #b) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_array_test.map2i"
        ];
  end
   end 
  return __Array.mapi((function (i, a) do
                return Curry._3(f, i, a, b[i]);
              end end), a);
end end

function tolist_aux(a, f, _i, _res) do
  while(true) do
    res = _res;
    i = _i;
    if (i < 0) then do
      return res;
    end else do
      v = a[i];
      match = Curry._1(f, v);
      _res = match ~= undefined and --[[ :: ]][
          Caml_option.valFromOption(match),
          res
        ] or res;
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end end

function to_list_map(f, a) do
  return tolist_aux(a, f, #a - 1 | 0, --[[ [] ]]0);
end end

function to_list_map_acc(f, a, acc) do
  return tolist_aux(a, f, #a - 1 | 0, acc);
end end

function of_list_map(f, a) do
  if (a) then do
    tl = a[1];
    hd = Curry._1(f, a[0]);
    len = List.length(tl) + 1 | 0;
    arr = Caml_array.caml_make_vect(len, hd);
    _i = 1;
    _param = tl;
    while(true) do
      param = _param;
      i = _i;
      if (param) then do
        arr[i] = Curry._1(f, param[0]);
        _param = param[1];
        _i = i + 1 | 0;
        continue ;
      end else do
        return arr;
      end end 
    end;
  end else do
    return [];
  end end 
end end

function rfind_with_index(arr, cmp, v) do
  len = #arr;
  _i = len - 1 | 0;
  while(true) do
    i = _i;
    if (i < 0 or Curry._2(cmp, arr[i], v)) then do
      return i;
    end else do
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end end

function rfind_and_split(arr, cmp, v) do
  i = rfind_with_index(arr, cmp, v);
  if (i < 0) then do
    return --[[ No_split ]]-226265796;
  end else do
    return --[[ `Split ]][
            345791162,
            --[[ tuple ]][
              __Array.sub(arr, 0, i),
              __Array.sub(arr, i + 1 | 0, (#arr - i | 0) - 1 | 0)
            ]
          ];
  end end 
end end

function find_with_index(arr, cmp, v) do
  len = #arr;
  _i = 0;
  len$1 = len;
  while(true) do
    i = _i;
    if (i >= len$1) then do
      return -1;
    end else if (Curry._2(cmp, arr[i], v)) then do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end end

function find_and_split(arr, cmp, v) do
  i = find_with_index(arr, cmp, v);
  if (i < 0) then do
    return --[[ No_split ]]-226265796;
  end else do
    return --[[ `Split ]][
            345791162,
            --[[ tuple ]][
              __Array.sub(arr, 0, i),
              __Array.sub(arr, i + 1 | 0, (#arr - i | 0) - 1 | 0)
            ]
          ];
  end end 
end end

function exists(p, a) do
  n = #a;
  _i = 0;
  while(true) do
    i = _i;
    if (i == n) then do
      return false;
    end else if (Curry._1(p, a[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end end

function is_empty(arr) do
  return #arr == 0;
end end

function unsafe_loop(_index, len, p, xs, ys) do
  while(true) do
    index = _index;
    if (index >= len) then do
      return true;
    end else if (Curry._2(p, xs[index], ys[index])) then do
      _index = index + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end end

function for_all2_no_exn(p, xs, ys) do
  len_xs = #xs;
  len_ys = #ys;
  if (len_xs == len_ys) then do
    return unsafe_loop(0, len_xs, p, xs, ys);
  end else do
    return false;
  end end 
end end

exports.reverse_range = reverse_range;
exports.reverse_in_place = reverse_in_place;
exports.reverse = reverse;
exports.reverse_of_list = reverse_of_list;
exports.filter = filter;
exports.filter_map = filter_map;
exports.range = range;
exports.map2i = map2i;
exports.tolist_aux = tolist_aux;
exports.to_list_map = to_list_map;
exports.to_list_map_acc = to_list_map_acc;
exports.of_list_map = of_list_map;
exports.rfind_with_index = rfind_with_index;
exports.rfind_and_split = rfind_and_split;
exports.find_with_index = find_with_index;
exports.find_and_split = find_and_split;
exports.exists = exists;
exports.is_empty = is_empty;
exports.unsafe_loop = unsafe_loop;
exports.for_all2_no_exn = for_all2_no_exn;
--[[ No side effect ]]
