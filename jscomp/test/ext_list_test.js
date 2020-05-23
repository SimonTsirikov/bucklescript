'use strict';

var List = require("../../lib/js/list.js");
var $$Array = require("../../lib/js/array.js");
var Curry = require("../../lib/js/curry.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Ext_string_test = require("./ext_string_test.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function filter_map(f, _xs) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var ys = xs[1];
      var match = Curry._1(f, xs[0]);
      if (match ~= undefined) then do
        return --[ :: ]--[
                Caml_option.valFromOption(match),
                filter_map(f, ys)
              ];
      end else do
        _xs = ys;
        continue ;
      end end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function excludes(p, l) do
  var excluded = do
    contents: false
  end;
  var aux = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var l = param[1];
        var x = param[0];
        if (Curry._1(p, x)) then do
          excluded.contents = true;
          _param = l;
          continue ;
        end else do
          _param = l;
          _accu = --[ :: ]--[
            x,
            accu
          ];
          continue ;
        end end 
      end else do
        return List.rev(accu);
      end end 
    end;
  end;
  var v = aux(--[ [] ]--0, l);
  if (excluded.contents) then do
    return --[ tuple ]--[
            true,
            v
          ];
  end else do
    return --[ tuple ]--[
            false,
            l
          ];
  end end 
end

function exclude_with_fact(p, l) do
  var excluded = do
    contents: undefined
  end;
  var aux = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var l = param[1];
        var x = param[0];
        if (Curry._1(p, x)) then do
          excluded.contents = Caml_option.some(x);
          _param = l;
          continue ;
        end else do
          _param = l;
          _accu = --[ :: ]--[
            x,
            accu
          ];
          continue ;
        end end 
      end else do
        return List.rev(accu);
      end end 
    end;
  end;
  var v = aux(--[ [] ]--0, l);
  return --[ tuple ]--[
          excluded.contents,
          excluded.contents ~= undefined ? v : l
        ];
end

function exclude_with_fact2(p1, p2, l) do
  var excluded1 = do
    contents: undefined
  end;
  var excluded2 = do
    contents: undefined
  end;
  var aux = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var l = param[1];
        var x = param[0];
        if (Curry._1(p1, x)) then do
          excluded1.contents = Caml_option.some(x);
          _param = l;
          continue ;
        end else if (Curry._1(p2, x)) then do
          excluded2.contents = Caml_option.some(x);
          _param = l;
          continue ;
        end else do
          _param = l;
          _accu = --[ :: ]--[
            x,
            accu
          ];
          continue ;
        end end  end 
      end else do
        return List.rev(accu);
      end end 
    end;
  end;
  var v = aux(--[ [] ]--0, l);
  return --[ tuple ]--[
          excluded1.contents,
          excluded2.contents,
          excluded1.contents ~= undefined and excluded2.contents ~= undefined ? v : l
        ];
end

function same_length(_xs, _ys) do
  while(true) do
    var ys = _ys;
    var xs = _xs;
    if (xs) then do
      if (ys) then do
        _ys = ys[1];
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (ys) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function filter_mapi(f, xs) do
  var aux = function (_i, _xs) do
    while(true) do
      var xs = _xs;
      var i = _i;
      if (xs) then do
        var ys = xs[1];
        var match = Curry._2(f, i, xs[0]);
        if (match ~= undefined) then do
          return --[ :: ]--[
                  Caml_option.valFromOption(match),
                  aux(i + 1 | 0, ys)
                ];
        end else do
          _xs = ys;
          _i = i + 1 | 0;
          continue ;
        end end 
      end else do
        return --[ [] ]--0;
      end end 
    end;
  end;
  return aux(0, xs);
end

function filter_map2(f, _xs, _ys) do
  while(true) do
    var ys = _ys;
    var xs = _xs;
    if (xs) then do
      if (ys) then do
        var vs = ys[1];
        var us = xs[1];
        var match = Curry._2(f, xs[0], ys[0]);
        if (match ~= undefined) then do
          return --[ :: ]--[
                  Caml_option.valFromOption(match),
                  filter_map2(f, us, vs)
                ];
        end else do
          _ys = vs;
          _xs = us;
          continue ;
        end end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Ext_list_test.filter_map2"
            ];
      end end 
    end else if (ys) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Ext_list_test.filter_map2"
          ];
    end else do
      return --[ [] ]--0;
    end end  end 
  end;
end

function filter_map2i(f, xs, ys) do
  var aux = function (_i, _xs, _ys) do
    while(true) do
      var ys = _ys;
      var xs = _xs;
      var i = _i;
      if (xs) then do
        if (ys) then do
          var vs = ys[1];
          var us = xs[1];
          var match = Curry._3(f, i, xs[0], ys[0]);
          if (match ~= undefined) then do
            return --[ :: ]--[
                    Caml_option.valFromOption(match),
                    aux(i + 1 | 0, us, vs)
                  ];
          end else do
            _ys = vs;
            _xs = us;
            _i = i + 1 | 0;
            continue ;
          end end 
        end else do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Ext_list_test.filter_map2i"
              ];
        end end 
      end else if (ys) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Ext_list_test.filter_map2i"
            ];
      end else do
        return --[ [] ]--0;
      end end  end 
    end;
  end;
  return aux(0, xs, ys);
end

function rev_map_append(f, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      _l2 = --[ :: ]--[
        Curry._1(f, l1[0]),
        l2
      ];
      _l1 = l1[1];
      continue ;
    end else do
      return l2;
    end end 
  end;
end

function flat_map2(f, lx, ly) do
  var _acc = --[ [] ]--0;
  var _lx = lx;
  var _ly = ly;
  while(true) do
    var ly$1 = _ly;
    var lx$1 = _lx;
    var acc = _acc;
    if (lx$1) then do
      if (ly$1) then do
        _ly = ly$1[1];
        _lx = lx$1[1];
        _acc = List.rev_append(Curry._2(f, lx$1[0], ly$1[0]), acc);
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Ext_list_test.flat_map2"
            ];
      end end 
    end else do
      if (ly$1) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Ext_list_test.flat_map2"
            ];
      end
       end 
      return List.rev(acc);
    end end 
  end;
end

function flat_map_aux(f, _acc, append, _lx) do
  while(true) do
    var lx = _lx;
    var acc = _acc;
    if (lx) then do
      _lx = lx[1];
      _acc = List.rev_append(Curry._1(f, lx[0]), acc);
      continue ;
    end else do
      return List.rev_append(acc, append);
    end end 
  end;
end

function flat_map(f, lx) do
  return flat_map_aux(f, --[ [] ]--0, --[ [] ]--0, lx);
end

function flat_map_acc(f, append, lx) do
  return flat_map_aux(f, --[ [] ]--0, append, lx);
end

function map2_last(f, l1, l2) do
  if (l1) then do
    var l1$1 = l1[1];
    var u = l1[0];
    if (!l1$1) then do
      if (l2) then do
        if (!l2[1]) then do
          return --[ :: ]--[
                  Curry._3(f, true, u, l2[0]),
                  --[ [] ]--0
                ];
        end
         end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.map2_last"
            ];
      end end 
    end
     end 
    if (l2) then do
      var r = Curry._3(f, false, u, l2[0]);
      return --[ :: ]--[
              r,
              map2_last(f, l1$1, l2[1])
            ];
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.map2_last"
          ];
    end end 
  end else if (l2) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.map2_last"
        ];
  end else do
    return --[ [] ]--0;
  end end  end 
end

function map_last(f, l1) do
  if (l1) then do
    var l1$1 = l1[1];
    var u = l1[0];
    if (l1$1) then do
      var r = Curry._2(f, false, u);
      return --[ :: ]--[
              r,
              map_last(f, l1$1)
            ];
    end else do
      return --[ :: ]--[
              Curry._2(f, true, u),
              --[ [] ]--0
            ];
    end end 
  end else do
    return --[ [] ]--0;
  end end 
end

function fold_right2_last(f, l1, l2, accu) do
  if (l1) then do
    var l1$1 = l1[1];
    var last1 = l1[0];
    if (!l1$1) then do
      if (l2) then do
        if (!l2[1]) then do
          return Curry._4(f, true, last1, l2[0], accu);
        end
         end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.fold_right2"
            ];
      end end 
    end
     end 
    if (l2) then do
      return Curry._4(f, false, last1, l2[0], fold_right2_last(f, l1$1, l2[1], accu));
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end end 
  end else do
    if (l2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end
     end 
    return accu;
  end end 
end

function init(n, f) do
  return $$Array.to_list($$Array.init(n, f));
end

function take(n, l) do
  var arr = $$Array.of_list(l);
  var arr_length = #arr;
  if (arr_length < n) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_list_test.take"
        ];
  end
   end 
  return --[ tuple ]--[
          $$Array.to_list($$Array.sub(arr, 0, n)),
          $$Array.to_list($$Array.sub(arr, n, arr_length - n | 0))
        ];
end

function try_take(n, l) do
  var arr = $$Array.of_list(l);
  var arr_length = #arr;
  if (arr_length <= n) then do
    return --[ tuple ]--[
            l,
            arr_length,
            --[ [] ]--0
          ];
  end else do
    return --[ tuple ]--[
            $$Array.to_list($$Array.sub(arr, 0, n)),
            n,
            $$Array.to_list($$Array.sub(arr, n, arr_length - n | 0))
          ];
  end end 
end

function length_compare(_l, _n) do
  while(true) do
    var n = _n;
    var l = _l;
    if (n < 0) then do
      return --[ Gt ]--15949;
    end else if (l) then do
      _n = n - 1 | 0;
      _l = l[1];
      continue ;
    end else if (n == 0) then do
      return --[ Eq ]--15500;
    end else do
      return --[ Lt ]--17064;
    end end  end  end 
  end;
end

function length_larger_than_n(n, _xs, _ys) do
  while(true) do
    var ys = _ys;
    var xs = _xs;
    if (ys) then do
      if (xs) then do
        _ys = ys[1];
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return length_compare(xs, n) == --[ Eq ]--15500;
    end end 
  end;
end

function exclude_tail(x) do
  var _acc = --[ [] ]--0;
  var _x = x;
  while(true) do
    var x$1 = _x;
    var acc = _acc;
    if (x$1) then do
      var ys = x$1[1];
      var x$2 = x$1[0];
      if (ys) then do
        _x = ys;
        _acc = --[ :: ]--[
          x$2,
          acc
        ];
        continue ;
      end else do
        return --[ tuple ]--[
                x$2,
                List.rev(acc)
              ];
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Ext_list_test.exclude_tail"
          ];
    end end 
  end;
end

function group(cmp, lst) do
  if (lst) then do
    return aux(cmp, lst[0], group(cmp, lst[1]));
  end else do
    return --[ [] ]--0;
  end end 
end

function aux(cmp, x, xss) do
  if (xss) then do
    var ys = xss[1];
    var y = xss[0];
    if (Curry._2(cmp, x, List.hd(y))) then do
      return --[ :: ]--[
              --[ :: ]--[
                x,
                y
              ],
              ys
            ];
    end else do
      return --[ :: ]--[
              y,
              aux(cmp, x, ys)
            ];
    end end 
  end else do
    return --[ :: ]--[
            --[ :: ]--[
              x,
              --[ [] ]--0
            ],
            --[ [] ]--0
          ];
  end end 
end

function stable_group(cmp, lst) do
  return List.rev(group(cmp, lst));
end

function drop(_n, _h) do
  while(true) do
    var h = _h;
    var n = _n;
    if (n < 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Ext_list_test.drop"
          ];
    end
     end 
    if (n == 0) then do
      return h;
    end else do
      if (h == --[ [] ]--0) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Ext_list_test.drop"
            ];
      end
       end 
      _h = List.tl(h);
      _n = n - 1 | 0;
      continue ;
    end end 
  end;
end

function find_first_not(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var a = param[0];
      if (Curry._1(p, a)) then do
        _param = param[1];
        continue ;
      end else do
        return Caml_option.some(a);
      end end 
    end else do
      return ;
    end end 
  end;
end

function for_all_opt(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = Curry._1(p, param[0]);
      if (v ~= undefined) then do
        return v;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function fold(f, l, init) do
  return List.fold_left((function (acc, i) do
                return Curry._2(f, i, init);
              end), init, l);
end

function rev_map_acc(acc, f, l) do
  var _accu = acc;
  var _param = l;
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) then do
      _param = param[1];
      _accu = --[ :: ]--[
        Curry._1(f, param[0]),
        accu
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function map_acc(acc, f, l) do
  if (l) then do
    return --[ :: ]--[
            Curry._1(f, l[0]),
            map_acc(acc, f, l[1])
          ];
  end else do
    return acc;
  end end 
end

function rev_iter(f, xs) do
  if (xs) then do
    rev_iter(f, xs[1]);
    return Curry._1(f, xs[0]);
  end else do
    return --[ () ]--0;
  end end 
end

function for_all2_no_exn(p, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      if (l2 and Curry._2(p, l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function find_no_exn(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var x = param[0];
      if (Curry._1(p, x)) then do
        return Caml_option.some(x);
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_opt(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = Curry._1(p, param[0]);
      if (v ~= undefined) then do
        return v;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function split_map(f, xs) do
  var _bs = --[ [] ]--0;
  var _cs = --[ [] ]--0;
  var _xs = xs;
  while(true) do
    var xs$1 = _xs;
    var cs = _cs;
    var bs = _bs;
    if (xs$1) then do
      var match = Curry._1(f, xs$1[0]);
      _xs = xs$1[1];
      _cs = --[ :: ]--[
        match[1],
        cs
      ];
      _bs = --[ :: ]--[
        match[0],
        bs
      ];
      continue ;
    end else do
      return --[ tuple ]--[
              List.rev(bs),
              List.rev(cs)
            ];
    end end 
  end;
end

function reduce_from_right(fn, lst) do
  var match = List.rev(lst);
  if (match) then do
    return List.fold_left((function (x, y) do
                  return Curry._2(fn, y, x);
                end), match[0], match[1]);
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_list_test.reduce"
        ];
  end end 
end

function reduce_from_left(fn, lst) do
  if (lst) then do
    return List.fold_left(fn, lst[0], lst[1]);
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_list_test.reduce_from_left"
        ];
  end end 
end

function create_ref_empty(param) do
  return do
          contents: --[ [] ]--0
        end;
end

function ref_top(x) do
  var match = x.contents;
  if (match) then do
    return match[0];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_list_test.ref_top"
        ];
  end end 
end

function ref_empty(x) do
  var match = x.contents;
  if (match) then do
    return false;
  end else do
    return true;
  end end 
end

function ref_push(x, refs) do
  refs.contents = --[ :: ]--[
    x,
    refs.contents
  ];
  return --[ () ]--0;
end

function ref_pop(refs) do
  var match = refs.contents;
  if (match) then do
    refs.contents = match[1];
    return match[0];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Ext_list_test.ref_pop"
        ];
  end end 
end

function rev_except_last(xs) do
  var _acc = --[ [] ]--0;
  var _xs = xs;
  while(true) do
    var xs$1 = _xs;
    var acc = _acc;
    if (xs$1) then do
      var xs$2 = xs$1[1];
      var x = xs$1[0];
      if (xs$2) then do
        _xs = xs$2;
        _acc = --[ :: ]--[
          x,
          acc
        ];
        continue ;
      end else do
        return --[ tuple ]--[
                acc,
                x
              ];
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Ext_list_test.rev_except_last"
          ];
    end end 
  end;
end

function sort_via_array(cmp, lst) do
  var arr = $$Array.of_list(lst);
  $$Array.sort(cmp, arr);
  return $$Array.to_list(arr);
end

function last(_xs) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var tl = xs[1];
      if (tl) then do
        _xs = tl;
        continue ;
      end else do
        return xs[0];
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Ext_list_test.last"
          ];
    end end 
  end;
end

function assoc_by_string(def, k, _lst) do
  while(true) do
    var lst = _lst;
    if (lst) then do
      var match = lst[0];
      if (match[0] == k) then do
        return match[1];
      end else do
        _lst = lst[1];
        continue ;
      end end 
    end else if (def ~= undefined) then do
      return Caml_option.valFromOption(def);
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "ext_list_test.ml",
              399,
              14
            ]
          ];
    end end  end 
  end;
end

function assoc_by_int(def, k, _lst) do
  while(true) do
    var lst = _lst;
    if (lst) then do
      var match = lst[0];
      if (match[0] == k) then do
        return match[1];
      end else do
        _lst = lst[1];
        continue ;
      end end 
    end else if (def ~= undefined) then do
      return Caml_option.valFromOption(def);
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "ext_list_test.ml",
              409,
              14
            ]
          ];
    end end  end 
  end;
end

exports.filter_map = filter_map;
exports.excludes = excludes;
exports.exclude_with_fact = exclude_with_fact;
exports.exclude_with_fact2 = exclude_with_fact2;
exports.same_length = same_length;
exports.filter_mapi = filter_mapi;
exports.filter_map2 = filter_map2;
exports.filter_map2i = filter_map2i;
exports.rev_map_append = rev_map_append;
exports.flat_map2 = flat_map2;
exports.flat_map_aux = flat_map_aux;
exports.flat_map = flat_map;
exports.flat_map_acc = flat_map_acc;
exports.map2_last = map2_last;
exports.map_last = map_last;
exports.fold_right2_last = fold_right2_last;
exports.init = init;
exports.take = take;
exports.try_take = try_take;
exports.length_compare = length_compare;
exports.length_larger_than_n = length_larger_than_n;
exports.exclude_tail = exclude_tail;
exports.group = group;
exports.aux = aux;
exports.stable_group = stable_group;
exports.drop = drop;
exports.find_first_not = find_first_not;
exports.for_all_opt = for_all_opt;
exports.fold = fold;
exports.rev_map_acc = rev_map_acc;
exports.map_acc = map_acc;
exports.rev_iter = rev_iter;
exports.for_all2_no_exn = for_all2_no_exn;
exports.find_no_exn = find_no_exn;
exports.find_opt = find_opt;
exports.split_map = split_map;
exports.reduce_from_right = reduce_from_right;
exports.reduce_from_left = reduce_from_left;
exports.create_ref_empty = create_ref_empty;
exports.ref_top = ref_top;
exports.ref_empty = ref_empty;
exports.ref_push = ref_push;
exports.ref_pop = ref_pop;
exports.rev_except_last = rev_except_last;
exports.sort_via_array = sort_via_array;
exports.last = last;
exports.assoc_by_string = assoc_by_string;
exports.assoc_by_int = assoc_by_int;
--[ Ext_string_test Not a pure module ]--
