'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_option = require("../../lib/js/caml_option.js");
Caml_primitive = require("../../lib/js/caml_primitive.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function Make(Ord) do
  height = function (param) do
    if (param) then do
      return param[4];
    end else do
      return 0;
    end end 
  end end;
  create = function (l, x, d, r) do
    hl = height(l);
    hr = height(r);
    return --[[ Node ]][
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end;
  singleton = function (x, d) do
    return --[[ Node ]][
            --[[ Empty ]]0,
            x,
            d,
            --[[ Empty ]]0,
            1
          ];
  end end;
  bal = function (l, x, d, r) do
    hl = l and l[4] or 0;
    hr = r and r[4] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[3];
        ld = l[2];
        lv = l[1];
        ll = l[0];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, ld, create(lr, x, d, r));
        end else if (lr) then do
          return create(create(ll, lv, ld, lr[0]), lr[1], lr[2], create(lr[3], x, d, r));
        end else do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Map.bal"
              ];
        end end  end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end 
    end else if (hr > (hl + 2 | 0)) then do
      if (r) then do
        rr = r[3];
        rd = r[2];
        rv = r[1];
        rl = r[0];
        if (height(rr) >= height(rl)) then do
          return create(create(l, x, d, rl), rv, rd, rr);
        end else if (rl) then do
          return create(create(l, x, d, rl[0]), rl[1], rl[2], create(rl[3], rv, rd, rr));
        end else do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Map.bal"
              ];
        end end  end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end 
    end else do
      return --[[ Node ]][
              l,
              x,
              d,
              r,
              hl >= hr and hl + 1 | 0 or hr + 1 | 0
            ];
    end end  end 
  end end;
  is_empty = function (param) do
    if (param) then do
      return false;
    end else do
      return true;
    end end 
  end end;
  add = function (x, data, param) do
    if (param) then do
      r = param[3];
      d = param[2];
      v = param[1];
      l = param[0];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return --[[ Node ]][
                l,
                x,
                data,
                r,
                param[4]
              ];
      end else if (c < 0) then do
        return bal(add(x, data, l), v, d, r);
      end else do
        return bal(l, v, d, add(x, data, r));
      end end  end 
    end else do
      return --[[ Node ]][
              --[[ Empty ]]0,
              x,
              data,
              --[[ Empty ]]0,
              1
            ];
    end end 
  end end;
  find = function (x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(Ord.compare, x, param[1]);
        if (c == 0) then do
          return param[2];
        end else do
          _param = c < 0 and param[0] or param[3];
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  mem = function (x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(Ord.compare, x, param[1]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[0] or param[3];
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  min_binding = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[0];
        if (l) then do
          _param = l;
          continue ;
        end else do
          return --[[ tuple ]][
                  param[1],
                  param[2]
                ];
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  max_binding = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[3];
        if (r) then do
          _param = r;
          continue ;
        end else do
          return --[[ tuple ]][
                  param[1],
                  param[2]
                ];
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  remove_min_binding = function (param) do
    if (param) then do
      l = param[0];
      if (l) then do
        return bal(remove_min_binding(l), param[1], param[2], param[3]);
      end else do
        return param[3];
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.remove_min_elt"
          ];
    end end 
  end end;
  remove = function (x, param) do
    if (param) then do
      r = param[3];
      d = param[2];
      v = param[1];
      l = param[0];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        t1 = l;
        t2 = r;
        if (t1) then do
          if (t2) then do
            match = min_binding(t2);
            return bal(t1, match[0], match[1], remove_min_binding(t2));
          end else do
            return t1;
          end end 
        end else do
          return t2;
        end end 
      end else if (c < 0) then do
        return bal(remove(x, l), v, d, r);
      end else do
        return bal(l, v, d, remove(x, r));
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  iter = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        iter(f, param[0]);
        Curry._2(f, param[1], param[2]);
        _param = param[3];
        continue ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  map = function (f, param) do
    if (param) then do
      l$prime = map(f, param[0]);
      d$prime = Curry._1(f, param[2]);
      r$prime = map(f, param[3]);
      return --[[ Node ]][
              l$prime,
              param[1],
              d$prime,
              r$prime,
              param[4]
            ];
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  mapi = function (f, param) do
    if (param) then do
      v = param[1];
      l$prime = mapi(f, param[0]);
      d$prime = Curry._2(f, v, param[2]);
      r$prime = mapi(f, param[3]);
      return --[[ Node ]][
              l$prime,
              v,
              d$prime,
              r$prime,
              param[4]
            ];
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  fold = function (f, _m, _accu) do
    while(true) do
      accu = _accu;
      m = _m;
      if (m) then do
        _accu = Curry._3(f, m[1], m[2], fold(f, m[0], accu));
        _m = m[3];
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  for_all = function (p, _param) do
    while(true) do
      param = _param;
      if (param) then do
        if (Curry._2(p, param[1], param[2]) and for_all(p, param[0])) then do
          _param = param[3];
          continue ;
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end end;
  exists = function (p, _param) do
    while(true) do
      param = _param;
      if (param) then do
        if (Curry._2(p, param[1], param[2]) or exists(p, param[0])) then do
          return true;
        end else do
          _param = param[3];
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  add_min_binding = function (k, v, param) do
    if (param) then do
      return bal(add_min_binding(k, v, param[0]), param[1], param[2], param[3]);
    end else do
      return singleton(k, v);
    end end 
  end end;
  add_max_binding = function (k, v, param) do
    if (param) then do
      return bal(param[0], param[1], param[2], add_max_binding(k, v, param[3]));
    end else do
      return singleton(k, v);
    end end 
  end end;
  join = function (l, v, d, r) do
    if (l) then do
      if (r) then do
        rh = r[4];
        lh = l[4];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[0], l[1], l[2], join(l[3], v, d, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, d, r[0]), r[1], r[2], r[3]);
        end else do
          return create(l, v, d, r);
        end end  end 
      end else do
        return add_max_binding(v, d, l);
      end end 
    end else do
      return add_min_binding(v, d, r);
    end end 
  end end;
  concat = function (t1, t2) do
    if (t1) then do
      if (t2) then do
        match = min_binding(t2);
        return join(t1, match[0], match[1], remove_min_binding(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
    end end 
  end end;
  concat_or_join = function (t1, v, d, t2) do
    if (d ~= undefined) then do
      return join(t1, v, Caml_option.valFromOption(d), t2);
    end else do
      return concat(t1, t2);
    end end 
  end end;
  split = function (x, param) do
    if (param) then do
      r = param[3];
      d = param[2];
      v = param[1];
      l = param[0];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return --[[ tuple ]][
                l,
                Caml_option.some(d),
                r
              ];
      end else if (c < 0) then do
        match = split(x, l);
        return --[[ tuple ]][
                match[0],
                match[1],
                join(match[2], v, d, r)
              ];
      end else do
        match$1 = split(x, r);
        return --[[ tuple ]][
                join(l, v, d, match$1[0]),
                match$1[1],
                match$1[2]
              ];
      end end  end 
    end else do
      return --[[ tuple ]][
              --[[ Empty ]]0,
              undefined,
              --[[ Empty ]]0
            ];
    end end 
  end end;
  merge = function (f, s1, s2) do
    if (s1) then do
      v1 = s1[1];
      if (s1[4] >= height(s2)) then do
        match = split(v1, s2);
        return concat_or_join(merge(f, s1[0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[2]), match[1]), merge(f, s1[3], match[2]));
      end
       end 
    end else if (!s2) then do
      return --[[ Empty ]]0;
    end
     end  end 
    if (s2) then do
      v2 = s2[1];
      match$1 = split(v2, s1);
      return concat_or_join(merge(f, match$1[0], s2[0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[2])), merge(f, match$1[2], s2[3]));
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "inline_map2_test.ml",
              270,
              10
            ]
          ];
    end end 
  end end;
  filter = function (p, param) do
    if (param) then do
      d = param[2];
      v = param[1];
      l$prime = filter(p, param[0]);
      pvd = Curry._2(p, v, d);
      r$prime = filter(p, param[3]);
      if (pvd) then do
        return join(l$prime, v, d, r$prime);
      end else do
        return concat(l$prime, r$prime);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  partition = function (p, param) do
    if (param) then do
      d = param[2];
      v = param[1];
      match = partition(p, param[0]);
      lf = match[1];
      lt = match[0];
      pvd = Curry._2(p, v, d);
      match$1 = partition(p, param[3]);
      rf = match$1[1];
      rt = match$1[0];
      if (pvd) then do
        return --[[ tuple ]][
                join(lt, v, d, rt),
                concat(lf, rf)
              ];
      end else do
        return --[[ tuple ]][
                concat(lt, rt),
                join(lf, v, d, rf)
              ];
      end end 
    end else do
      return --[[ tuple ]][
              --[[ Empty ]]0,
              --[[ Empty ]]0
            ];
    end end 
  end end;
  cons_enum = function (_m, _e) do
    while(true) do
      e = _e;
      m = _m;
      if (m) then do
        _e = --[[ More ]][
          m[1],
          m[2],
          m[3],
          e
        ];
        _m = m[0];
        continue ;
      end else do
        return e;
      end end 
    end;
  end end;
  compare = function (cmp, m1, m2) do
    _e1 = cons_enum(m1, --[[ End ]]0);
    _e2 = cons_enum(m2, --[[ End ]]0);
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2) then do
          c = Curry._2(Ord.compare, e1[0], e2[0]);
          if (c ~= 0) then do
            return c;
          end else do
            c$1 = Curry._2(cmp, e1[1], e2[1]);
            if (c$1 ~= 0) then do
              return c$1;
            end else do
              _e2 = cons_enum(e2[2], e2[3]);
              _e1 = cons_enum(e1[2], e1[3]);
              continue ;
            end end 
          end end 
        end else do
          return 1;
        end end 
      end else if (e2) then do
        return -1;
      end else do
        return 0;
      end end  end 
    end;
  end end;
  equal = function (cmp, m1, m2) do
    _e1 = cons_enum(m1, --[[ End ]]0);
    _e2 = cons_enum(m2, --[[ End ]]0);
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2 and Curry._2(Ord.compare, e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
          _e2 = cons_enum(e2[2], e2[3]);
          _e1 = cons_enum(e1[2], e1[3]);
          continue ;
        end else do
          return false;
        end end 
      end else if (e2) then do
        return false;
      end else do
        return true;
      end end  end 
    end;
  end end;
  cardinal = function (param) do
    if (param) then do
      return (cardinal(param[0]) + 1 | 0) + cardinal(param[3]) | 0;
    end else do
      return 0;
    end end 
  end end;
  bindings_aux = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[0];
        _accu = --[[ :: ]][
          --[[ tuple ]][
            param[1],
            param[2]
          ],
          bindings_aux(accu, param[3])
        ];
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  bindings = function (s) do
    return bindings_aux(--[[ [] ]]0, s);
  end end;
  return do
          height: height,
          create: create,
          singleton: singleton,
          bal: bal,
          empty: --[[ Empty ]]0,
          is_empty: is_empty,
          add: add,
          find: find,
          mem: mem,
          min_binding: min_binding,
          max_binding: max_binding,
          remove_min_binding: remove_min_binding,
          remove: remove,
          iter: iter,
          map: map,
          mapi: mapi,
          fold: fold,
          for_all: for_all,
          exists: exists,
          add_min_binding: add_min_binding,
          add_max_binding: add_max_binding,
          join: join,
          concat: concat,
          concat_or_join: concat_or_join,
          split: split,
          merge: merge,
          filter: filter,
          partition: partition,
          cons_enum: cons_enum,
          compare: compare,
          equal: equal,
          cardinal: cardinal,
          bindings_aux: bindings_aux,
          bindings: bindings,
          choose: min_binding
        end;
end end

function height(param) do
  if (param) then do
    return param[4];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]][
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end end

function singleton(x, d) do
  return --[[ Node ]][
          --[[ Empty ]]0,
          x,
          d,
          --[[ Empty ]]0,
          1
        ];
end end

function bal(l, x, d, r) do
  hl = l and l[4] or 0;
  hr = r and r[4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[3];
      ld = l[2];
      lv = l[1];
      ll = l[0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[0]), lr[1], lr[2], create(lr[3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[3];
      rd = r[2];
      rv = r[1];
      rl = r[0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[0]), rl[1], rl[2], create(rl[3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[[ Node ]][
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end end

function is_empty(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add(x, data, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]][
              l,
              x,
              data,
              r,
              param[4]
            ];
    end else if (c < 0) then do
      return bal(add(x, data, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]][
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          ];
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[1]);
      if (c == 0) then do
        return param[2];
      end else do
        _param = c < 0 and param[0] or param[3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[0] or param[3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function min_binding(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[[ tuple ]][
                param[1],
                param[2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function max_binding(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[[ tuple ]][
                param[1],
                param[2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function remove_min_binding(param) do
  if (param) then do
    l = param[0];
    if (l) then do
      return bal(remove_min_binding(l), param[1], param[2], param[3]);
    end else do
      return param[3];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Map.remove_min_elt"
        ];
  end end 
end end

function remove(x, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      t1 = l;
      t2 = r;
      if (t1) then do
        if (t2) then do
          match = min_binding(t2);
          return bal(t1, match[0], match[1], remove_min_binding(t2));
        end else do
          return t1;
        end end 
      end else do
        return t2;
      end end 
    end else if (c < 0) then do
      return bal(remove(x, l), v, d, r);
    end else do
      return bal(l, v, d, remove(x, r));
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter(f, param[0]);
      Curry._2(f, param[1], param[2]);
      _param = param[3];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map(f, param) do
  if (param) then do
    l$prime = map(f, param[0]);
    d$prime = Curry._1(f, param[2]);
    r$prime = map(f, param[3]);
    return --[[ Node ]][
            l$prime,
            param[1],
            d$prime,
            r$prime,
            param[4]
          ];
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mapi(f, param) do
  if (param) then do
    v = param[1];
    l$prime = mapi(f, param[0]);
    d$prime = Curry._2(f, v, param[2]);
    r$prime = mapi(f, param[3]);
    return --[[ Node ]][
            l$prime,
            v,
            d$prime,
            r$prime,
            param[4]
          ];
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function fold(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[1], m[2], fold(f, m[0], accu));
      _m = m[3];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[1], param[2]) and for_all(p, param[0])) then do
        _param = param[3];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[1], param[2]) or exists(p, param[0])) then do
        return true;
      end else do
        _param = param[3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding(k, v, param) do
  if (param) then do
    return bal(add_min_binding(k, v, param[0]), param[1], param[2], param[3]);
  end else do
    return singleton(k, v);
  end end 
end end

function add_max_binding(k, v, param) do
  if (param) then do
    return bal(param[0], param[1], param[2], add_max_binding(k, v, param[3]));
  end else do
    return singleton(k, v);
  end end 
end end

function join(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[4];
      lh = l[4];
      if (lh > (rh + 2 | 0)) then do
        return bal(l[0], l[1], l[2], join(l[3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(join(l, v, d, r[0]), r[1], r[2], r[3]);
      end else do
        return create(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding(v, d, l);
    end end 
  end else do
    return add_min_binding(v, d, r);
  end end 
end end

function concat(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding(t2);
      return join(t1, match[0], match[1], remove_min_binding(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat(t1, t2);
  end end 
end end

function split(x, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]][
              l,
              Caml_option.some(d),
              r
            ];
    end else if (c < 0) then do
      match = split(x, l);
      return --[[ tuple ]][
              match[0],
              match[1],
              join(match[2], v, d, r)
            ];
    end else do
      match$1 = split(x, r);
      return --[[ tuple ]][
              join(l, v, d, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end end  end 
  end else do
    return --[[ tuple ]][
            --[[ Empty ]]0,
            undefined,
            --[[ Empty ]]0
          ];
  end end 
end end

function merge(f, s1, s2) do
  if (s1) then do
    v1 = s1[1];
    if (s1[4] >= height(s2)) then do
      match = split(v1, s2);
      return concat_or_join(merge(f, s1[0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[2]), match[1]), merge(f, s1[3], match[2]));
    end
     end 
  end else if (!s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[1];
    match$1 = split(v2, s1);
    return concat_or_join(merge(f, match$1[0], s2[0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[2])), merge(f, match$1[2], s2[3]));
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "inline_map2_test.ml",
            270,
            10
          ]
        ];
  end end 
end end

function filter(p, param) do
  if (param) then do
    d = param[2];
    v = param[1];
    l$prime = filter(p, param[0]);
    pvd = Curry._2(p, v, d);
    r$prime = filter(p, param[3]);
    if (pvd) then do
      return join(l$prime, v, d, r$prime);
    end else do
      return concat(l$prime, r$prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition(p, param) do
  if (param) then do
    d = param[2];
    v = param[1];
    match = partition(p, param[0]);
    lf = match[1];
    lt = match[0];
    pvd = Curry._2(p, v, d);
    match$1 = partition(p, param[3]);
    rf = match$1[1];
    rt = match$1[0];
    if (pvd) then do
      return --[[ tuple ]][
              join(lt, v, d, rt),
              concat(lf, rf)
            ];
    end else do
      return --[[ tuple ]][
              concat(lt, rt),
              join(lf, v, d, rf)
            ];
    end end 
  end else do
    return --[[ tuple ]][
            --[[ Empty ]]0,
            --[[ Empty ]]0
          ];
  end end 
end end

function cons_enum(_m, _e) do
  while(true) do
    e = _e;
    m = _m;
    if (m) then do
      _e = --[[ More ]][
        m[1],
        m[2],
        m[3],
        e
      ];
      _m = m[0];
      continue ;
    end else do
      return e;
    end end 
  end;
end end

function compare(cmp, m1, m2) do
  _e1 = cons_enum(m1, --[[ End ]]0);
  _e2 = cons_enum(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_int_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) then do
            return c$1;
          end else do
            _e2 = cons_enum(e2[2], e2[3]);
            _e1 = cons_enum(e1[2], e1[3]);
            continue ;
          end end 
        end end 
      end else do
        return 1;
      end end 
    end else if (e2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function equal(cmp, m1, m2) do
  _e1 = cons_enum(m1, --[[ End ]]0);
  _e2 = cons_enum(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2 and e1[0] == e2[0] and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum(e2[2], e2[3]);
        _e1 = cons_enum(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function cardinal(param) do
  if (param) then do
    return (cardinal(param[0]) + 1 | 0) + cardinal(param[3]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[0];
      _accu = --[[ :: ]][
        --[[ tuple ]][
          param[1],
          param[2]
        ],
        bindings_aux(accu, param[3])
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings(s) do
  return bindings_aux(--[[ [] ]]0, s);
end end

IntMap = do
  height: height,
  create: create,
  singleton: singleton,
  bal: bal,
  empty: --[[ Empty ]]0,
  is_empty: is_empty,
  add: add,
  find: find,
  mem: mem,
  min_binding: min_binding,
  max_binding: max_binding,
  remove_min_binding: remove_min_binding,
  remove: remove,
  iter: iter,
  map: map,
  mapi: mapi,
  fold: fold,
  for_all: for_all,
  exists: exists,
  add_min_binding: add_min_binding,
  add_max_binding: add_max_binding,
  join: join,
  concat: concat,
  concat_or_join: concat_or_join,
  split: split,
  merge: merge,
  filter: filter,
  partition: partition,
  cons_enum: cons_enum,
  compare: compare,
  equal: equal,
  cardinal: cardinal,
  bindings_aux: bindings_aux,
  bindings: bindings,
  choose: min_binding
end;

m = List.fold_left((function (acc, param) do
        return add(param[0], param[1], acc);
      end end), --[[ Empty ]]0, --[[ :: ]][
      --[[ tuple ]][
        10,
        --[[ "a" ]]97
      ],
      --[[ :: ]][
        --[[ tuple ]][
          3,
          --[[ "b" ]]98
        ],
        --[[ :: ]][
          --[[ tuple ]][
            7,
            --[[ "c" ]]99
          ],
          --[[ :: ]][
            --[[ tuple ]][
              20,
              --[[ "d" ]]100
            ],
            --[[ [] ]]0
          ]
        ]
      ]
    ]);

function height$1(param) do
  if (param) then do
    return param[4];
  end else do
    return 0;
  end end 
end end

function create$1(l, x, d, r) do
  hl = height$1(l);
  hr = height$1(r);
  return --[[ Node ]][
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end end

function singleton$1(x, d) do
  return --[[ Node ]][
          --[[ Empty ]]0,
          x,
          d,
          --[[ Empty ]]0,
          1
        ];
end end

function bal$1(l, x, d, r) do
  hl = l and l[4] or 0;
  hr = r and r[4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[3];
      ld = l[2];
      lv = l[1];
      ll = l[0];
      if (height$1(ll) >= height$1(lr)) then do
        return create$1(ll, lv, ld, create$1(lr, x, d, r));
      end else if (lr) then do
        return create$1(create$1(ll, lv, ld, lr[0]), lr[1], lr[2], create$1(lr[3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[3];
      rd = r[2];
      rv = r[1];
      rl = r[0];
      if (height$1(rr) >= height$1(rl)) then do
        return create$1(create$1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create$1(create$1(l, x, d, rl[0]), rl[1], rl[2], create$1(rl[3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[[ Node ]][
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end end

function is_empty$1(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add$1(x, data, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]][
              l,
              x,
              data,
              r,
              param[4]
            ];
    end else if (c < 0) then do
      return bal$1(add$1(x, data, l), v, d, r);
    end else do
      return bal$1(l, v, d, add$1(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]][
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          ];
  end end 
end end

function find$1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[1]);
      if (c == 0) then do
        return param[2];
      end else do
        _param = c < 0 and param[0] or param[3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function mem$1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[0] or param[3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function min_binding$1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[[ tuple ]][
                param[1],
                param[2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function max_binding$1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[[ tuple ]][
                param[1],
                param[2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

function remove_min_binding$1(param) do
  if (param) then do
    l = param[0];
    if (l) then do
      return bal$1(remove_min_binding$1(l), param[1], param[2], param[3]);
    end else do
      return param[3];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Map.remove_min_elt"
        ];
  end end 
end end

function remove$1(x, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      t1 = l;
      t2 = r;
      if (t1) then do
        if (t2) then do
          match = min_binding$1(t2);
          return bal$1(t1, match[0], match[1], remove_min_binding$1(t2));
        end else do
          return t1;
        end end 
      end else do
        return t2;
      end end 
    end else if (c < 0) then do
      return bal$1(remove$1(x, l), v, d, r);
    end else do
      return bal$1(l, v, d, remove$1(x, r));
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function iter$1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter$1(f, param[0]);
      Curry._2(f, param[1], param[2]);
      _param = param[3];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map$1(f, param) do
  if (param) then do
    l$prime = map$1(f, param[0]);
    d$prime = Curry._1(f, param[2]);
    r$prime = map$1(f, param[3]);
    return --[[ Node ]][
            l$prime,
            param[1],
            d$prime,
            r$prime,
            param[4]
          ];
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mapi$1(f, param) do
  if (param) then do
    v = param[1];
    l$prime = mapi$1(f, param[0]);
    d$prime = Curry._2(f, v, param[2]);
    r$prime = mapi$1(f, param[3]);
    return --[[ Node ]][
            l$prime,
            v,
            d$prime,
            r$prime,
            param[4]
          ];
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function fold$1(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[1], m[2], fold$1(f, m[0], accu));
      _m = m[3];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all$1(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[1], param[2]) and for_all$1(p, param[0])) then do
        _param = param[3];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists$1(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[1], param[2]) or exists$1(p, param[0])) then do
        return true;
      end else do
        _param = param[3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding$1(k, v, param) do
  if (param) then do
    return bal$1(add_min_binding$1(k, v, param[0]), param[1], param[2], param[3]);
  end else do
    return singleton$1(k, v);
  end end 
end end

function add_max_binding$1(k, v, param) do
  if (param) then do
    return bal$1(param[0], param[1], param[2], add_max_binding$1(k, v, param[3]));
  end else do
    return singleton$1(k, v);
  end end 
end end

function join$1(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[4];
      lh = l[4];
      if (lh > (rh + 2 | 0)) then do
        return bal$1(l[0], l[1], l[2], join$1(l[3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal$1(join$1(l, v, d, r[0]), r[1], r[2], r[3]);
      end else do
        return create$1(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding$1(v, d, l);
    end end 
  end else do
    return add_min_binding$1(v, d, r);
  end end 
end end

function concat$1(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding$1(t2);
      return join$1(t1, match[0], match[1], remove_min_binding$1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join$1(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join$1(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat$1(t1, t2);
  end end 
end end

function split$1(x, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]][
              l,
              Caml_option.some(d),
              r
            ];
    end else if (c < 0) then do
      match = split$1(x, l);
      return --[[ tuple ]][
              match[0],
              match[1],
              join$1(match[2], v, d, r)
            ];
    end else do
      match$1 = split$1(x, r);
      return --[[ tuple ]][
              join$1(l, v, d, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end end  end 
  end else do
    return --[[ tuple ]][
            --[[ Empty ]]0,
            undefined,
            --[[ Empty ]]0
          ];
  end end 
end end

function merge$1(f, s1, s2) do
  if (s1) then do
    v1 = s1[1];
    if (s1[4] >= height$1(s2)) then do
      match = split$1(v1, s2);
      return concat_or_join$1(merge$1(f, s1[0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[2]), match[1]), merge$1(f, s1[3], match[2]));
    end
     end 
  end else if (!s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[1];
    match$1 = split$1(v2, s1);
    return concat_or_join$1(merge$1(f, match$1[0], s2[0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[2])), merge$1(f, match$1[2], s2[3]));
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "inline_map2_test.ml",
            270,
            10
          ]
        ];
  end end 
end end

function filter$1(p, param) do
  if (param) then do
    d = param[2];
    v = param[1];
    l$prime = filter$1(p, param[0]);
    pvd = Curry._2(p, v, d);
    r$prime = filter$1(p, param[3]);
    if (pvd) then do
      return join$1(l$prime, v, d, r$prime);
    end else do
      return concat$1(l$prime, r$prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition$1(p, param) do
  if (param) then do
    d = param[2];
    v = param[1];
    match = partition$1(p, param[0]);
    lf = match[1];
    lt = match[0];
    pvd = Curry._2(p, v, d);
    match$1 = partition$1(p, param[3]);
    rf = match$1[1];
    rt = match$1[0];
    if (pvd) then do
      return --[[ tuple ]][
              join$1(lt, v, d, rt),
              concat$1(lf, rf)
            ];
    end else do
      return --[[ tuple ]][
              concat$1(lt, rt),
              join$1(lf, v, d, rf)
            ];
    end end 
  end else do
    return --[[ tuple ]][
            --[[ Empty ]]0,
            --[[ Empty ]]0
          ];
  end end 
end end

function cons_enum$1(_m, _e) do
  while(true) do
    e = _e;
    m = _m;
    if (m) then do
      _e = --[[ More ]][
        m[1],
        m[2],
        m[3],
        e
      ];
      _m = m[0];
      continue ;
    end else do
      return e;
    end end 
  end;
end end

function compare$1(cmp, m1, m2) do
  _e1 = cons_enum$1(m1, --[[ End ]]0);
  _e2 = cons_enum$1(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) then do
            return c$1;
          end else do
            _e2 = cons_enum$1(e2[2], e2[3]);
            _e1 = cons_enum$1(e1[2], e1[3]);
            continue ;
          end end 
        end end 
      end else do
        return 1;
      end end 
    end else if (e2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function equal$1(cmp, m1, m2) do
  _e1 = cons_enum$1(m1, --[[ End ]]0);
  _e2 = cons_enum$1(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2 and Caml_primitive.caml_string_compare(e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum$1(e2[2], e2[3]);
        _e1 = cons_enum$1(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function cardinal$1(param) do
  if (param) then do
    return (cardinal$1(param[0]) + 1 | 0) + cardinal$1(param[3]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux$1(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[0];
      _accu = --[[ :: ]][
        --[[ tuple ]][
          param[1],
          param[2]
        ],
        bindings_aux$1(accu, param[3])
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings$1(s) do
  return bindings_aux$1(--[[ [] ]]0, s);
end end

SMap = do
  height: height$1,
  create: create$1,
  singleton: singleton$1,
  bal: bal$1,
  empty: --[[ Empty ]]0,
  is_empty: is_empty$1,
  add: add$1,
  find: find$1,
  mem: mem$1,
  min_binding: min_binding$1,
  max_binding: max_binding$1,
  remove_min_binding: remove_min_binding$1,
  remove: remove$1,
  iter: iter$1,
  map: map$1,
  mapi: mapi$1,
  fold: fold$1,
  for_all: for_all$1,
  exists: exists$1,
  add_min_binding: add_min_binding$1,
  add_max_binding: add_max_binding$1,
  join: join$1,
  concat: concat$1,
  concat_or_join: concat_or_join$1,
  split: split$1,
  merge: merge$1,
  filter: filter$1,
  partition: partition$1,
  cons_enum: cons_enum$1,
  compare: compare$1,
  equal: equal$1,
  cardinal: cardinal$1,
  bindings_aux: bindings_aux$1,
  bindings: bindings$1,
  choose: min_binding$1
end;

s = List.fold_left((function (acc, param) do
        return add$1(param[0], param[1], acc);
      end end), --[[ Empty ]]0, --[[ :: ]][
      --[[ tuple ]][
        "10",
        --[[ "a" ]]97
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "3",
          --[[ "b" ]]98
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "7",
            --[[ "c" ]]99
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "20",
              --[[ "d" ]]100
            ],
            --[[ [] ]]0
          ]
        ]
      ]
    ]);

Mt.from_pair_suites("Inline_map2_test", --[[ :: ]][
      --[[ tuple ]][
        "assertion1",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      find(10, m),
                      --[[ "a" ]]97
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "assertion2",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        find$1("10", s),
                        --[[ "a" ]]97
                      ]);
            end end)
        ],
        --[[ [] ]]0
      ]
    ]);

empty = --[[ Empty ]]0;

exports.Make = Make;
exports.IntMap = IntMap;
exports.empty = empty;
exports.m = m;
exports.SMap = SMap;
exports.s = s;
--[[ m Not a pure module ]]
