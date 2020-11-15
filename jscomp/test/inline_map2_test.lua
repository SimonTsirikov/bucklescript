__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_option = require "......lib.js.caml_option";
Caml_primitive = require "......lib.js.caml_primitive";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function Make(Ord) do
  height = function(param) do
    if (param) then do
      return param[5];
    end else do
      return 0;
    end end 
  end end;
  create = function(l, x, d, r) do
    hl = height(l);
    hr = height(r);
    return --[[ Node ]]{
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end;
  singleton = function(x, d) do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            d,
            --[[ Empty ]]0,
            1
          };
  end end;
  bal = function(l, x, d, r) do
    hl = l and l[5] or 0;
    hr = r and r[5] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[4];
        ld = l[3];
        lv = l[2];
        ll = l[1];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, ld, create(lr, x, d, r));
        end else if (lr) then do
          return create(create(ll, lv, ld, lr[1]), lr[2], lr[3], create(lr[4], x, d, r));
        end else do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          })
        end end  end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end 
    end else if (hr > (hl + 2 | 0)) then do
      if (r) then do
        rr = r[4];
        rd = r[3];
        rv = r[2];
        rl = r[1];
        if (height(rr) >= height(rl)) then do
          return create(create(l, x, d, rl), rv, rd, rr);
        end else if (rl) then do
          return create(create(l, x, d, rl[1]), rl[2], rl[3], create(rl[4], rv, rd, rr));
        end else do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          })
        end end  end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end 
    end else do
      return --[[ Node ]]{
              l,
              x,
              d,
              r,
              hl >= hr and hl + 1 | 0 or hr + 1 | 0
            };
    end end  end 
  end end;
  is_empty = function(param) do
    if (param) then do
      return false;
    end else do
      return true;
    end end 
  end end;
  add = function(x, data, param) do
    if (param) then do
      r = param[4];
      d = param[3];
      v = param[2];
      l = param[1];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return --[[ Node ]]{
                l,
                x,
                data,
                r,
                param[5]
              };
      end else if (c < 0) then do
        return bal(add(x, data, l), v, d, r);
      end else do
        return bal(l, v, d, add(x, data, r));
      end end  end 
    end else do
      return --[[ Node ]]{
              --[[ Empty ]]0,
              x,
              data,
              --[[ Empty ]]0,
              1
            };
    end end 
  end end;
  find = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(Ord.compare, x, param[2]);
        if (c == 0) then do
          return param[3];
        end else do
          _param = c < 0 and param[1] or param[4];
          ::continue:: ;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  mem = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(Ord.compare, x, param[2]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[1] or param[4];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  min_binding = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[2],
                  param[3]
                };
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  max_binding = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[4];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[2],
                  param[3]
                };
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  remove_min_binding = function(param) do
    if (param) then do
      l = param[1];
      if (l) then do
        return bal(remove_min_binding(l), param[2], param[3], param[4]);
      end else do
        return param[4];
      end end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.remove_min_elt"
      })
    end end 
  end end;
  remove = function(x, param) do
    if (param) then do
      r = param[4];
      d = param[3];
      v = param[2];
      l = param[1];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        t1 = l;
        t2 = r;
        if (t1) then do
          if (t2) then do
            match = min_binding(t2);
            return bal(t1, match[1], match[2], remove_min_binding(t2));
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
  iter = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        iter(f, param[1]);
        Curry._2(f, param[2], param[3]);
        _param = param[4];
        ::continue:: ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  map = function(f, param) do
    if (param) then do
      l_prime = map(f, param[1]);
      d_prime = Curry._1(f, param[3]);
      r_prime = map(f, param[4]);
      return --[[ Node ]]{
              l_prime,
              param[2],
              d_prime,
              r_prime,
              param[5]
            };
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  mapi = function(f, param) do
    if (param) then do
      v = param[2];
      l_prime = mapi(f, param[1]);
      d_prime = Curry._2(f, v, param[3]);
      r_prime = mapi(f, param[4]);
      return --[[ Node ]]{
              l_prime,
              v,
              d_prime,
              r_prime,
              param[5]
            };
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  fold = function(f, _m, _accu) do
    while(true) do
      accu = _accu;
      m = _m;
      if (m) then do
        _accu = Curry._3(f, m[2], m[3], fold(f, m[1], accu));
        _m = m[4];
        ::continue:: ;
      end else do
        return accu;
      end end 
    end;
  end end;
  for_all = function(p, _param) do
    while(true) do
      param = _param;
      if (param) then do
        if (Curry._2(p, param[2], param[3]) and for_all(p, param[1])) then do
          _param = param[4];
          ::continue:: ;
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end end;
  exists = function(p, _param) do
    while(true) do
      param = _param;
      if (param) then do
        if (Curry._2(p, param[2], param[3]) or exists(p, param[1])) then do
          return true;
        end else do
          _param = param[4];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  add_min_binding = function(k, v, param) do
    if (param) then do
      return bal(add_min_binding(k, v, param[1]), param[2], param[3], param[4]);
    end else do
      return singleton(k, v);
    end end 
  end end;
  add_max_binding = function(k, v, param) do
    if (param) then do
      return bal(param[1], param[2], param[3], add_max_binding(k, v, param[4]));
    end else do
      return singleton(k, v);
    end end 
  end end;
  join = function(l, v, d, r) do
    if (l) then do
      if (r) then do
        rh = r[5];
        lh = l[5];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[1], l[2], l[3], join(l[4], v, d, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, d, r[1]), r[2], r[3], r[4]);
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
  concat = function(t1, t2) do
    if (t1) then do
      if (t2) then do
        match = min_binding(t2);
        return join(t1, match[1], match[2], remove_min_binding(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
    end end 
  end end;
  concat_or_join = function(t1, v, d, t2) do
    if (d ~= nil) then do
      return join(t1, v, Caml_option.valFromOption(d), t2);
    end else do
      return concat(t1, t2);
    end end 
  end end;
  split = function(x, param) do
    if (param) then do
      r = param[4];
      d = param[3];
      v = param[2];
      l = param[1];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return --[[ tuple ]]{
                l,
                Caml_option.some(d),
                r
              };
      end else if (c < 0) then do
        match = split(x, l);
        return --[[ tuple ]]{
                match[1],
                match[2],
                join(match[3], v, d, r)
              };
      end else do
        match_1 = split(x, r);
        return --[[ tuple ]]{
                join(l, v, d, match_1[1]),
                match_1[2],
                match_1[3]
              };
      end end  end 
    end else do
      return --[[ tuple ]]{
              --[[ Empty ]]0,
              nil,
              --[[ Empty ]]0
            };
    end end 
  end end;
  merge = function(f, s1, s2) do
    if (s1) then do
      v1 = s1[2];
      if (s1[5] >= height(s2)) then do
        match = split(v1, s2);
        return concat_or_join(merge(f, s1[1], match[1]), v1, Curry._3(f, v1, Caml_option.some(s1[3]), match[2]), merge(f, s1[4], match[3]));
      end
       end 
    end else if (not s2) then do
      return --[[ Empty ]]0;
    end
     end  end 
    if (s2) then do
      v2 = s2[2];
      match_1 = split(v2, s1);
      return concat_or_join(merge(f, match_1[1], s2[1]), v2, Curry._3(f, v2, match_1[2], Caml_option.some(s2[3])), merge(f, match_1[3], s2[4]));
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "inline_map2_test.ml",
          270,
          10
        }
      })
    end end 
  end end;
  filter = function(p, param) do
    if (param) then do
      d = param[3];
      v = param[2];
      l_prime = filter(p, param[1]);
      pvd = Curry._2(p, v, d);
      r_prime = filter(p, param[4]);
      if (pvd) then do
        return join(l_prime, v, d, r_prime);
      end else do
        return concat(l_prime, r_prime);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  partition = function(p, param) do
    if (param) then do
      d = param[3];
      v = param[2];
      match = partition(p, param[1]);
      lf = match[2];
      lt = match[1];
      pvd = Curry._2(p, v, d);
      match_1 = partition(p, param[4]);
      rf = match_1[2];
      rt = match_1[1];
      if (pvd) then do
        return --[[ tuple ]]{
                join(lt, v, d, rt),
                concat(lf, rf)
              };
      end else do
        return --[[ tuple ]]{
                concat(lt, rt),
                join(lf, v, d, rf)
              };
      end end 
    end else do
      return --[[ tuple ]]{
              --[[ Empty ]]0,
              --[[ Empty ]]0
            };
    end end 
  end end;
  cons_enum = function(_m, _e) do
    while(true) do
      e = _e;
      m = _m;
      if (m) then do
        _e = --[[ More ]]{
          m[2],
          m[3],
          m[4],
          e
        };
        _m = m[1];
        ::continue:: ;
      end else do
        return e;
      end end 
    end;
  end end;
  compare = function(cmp, m1, m2) do
    _e1 = cons_enum(m1, --[[ End ]]0);
    _e2 = cons_enum(m2, --[[ End ]]0);
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2) then do
          c = Curry._2(Ord.compare, e1[1], e2[1]);
          if (c ~= 0) then do
            return c;
          end else do
            c_1 = Curry._2(cmp, e1[2], e2[2]);
            if (c_1 ~= 0) then do
              return c_1;
            end else do
              _e2 = cons_enum(e2[3], e2[4]);
              _e1 = cons_enum(e1[3], e1[4]);
              ::continue:: ;
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
  equal = function(cmp, m1, m2) do
    _e1 = cons_enum(m1, --[[ End ]]0);
    _e2 = cons_enum(m2, --[[ End ]]0);
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2 and Curry._2(Ord.compare, e1[1], e2[1]) == 0 and Curry._2(cmp, e1[2], e2[2])) then do
          _e2 = cons_enum(e2[3], e2[4]);
          _e1 = cons_enum(e1[3], e1[4]);
          ::continue:: ;
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
  cardinal = function(param) do
    if (param) then do
      return (cardinal(param[1]) + 1 | 0) + cardinal(param[4]) | 0;
    end else do
      return 0;
    end end 
  end end;
  bindings_aux = function(_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[1];
        _accu = --[[ :: ]]{
          --[[ tuple ]]{
            param[2],
            param[3]
          },
          bindings_aux(accu, param[4])
        };
        ::continue:: ;
      end else do
        return accu;
      end end 
    end;
  end end;
  bindings = function(s) do
    return bindings_aux(--[[ [] ]]0, s);
  end end;
  return {
          height = height,
          create = create,
          singleton = singleton,
          bal = bal,
          empty = --[[ Empty ]]0,
          is_empty = is_empty,
          add = add,
          find = find,
          mem = mem,
          min_binding = min_binding,
          max_binding = max_binding,
          remove_min_binding = remove_min_binding,
          remove = remove,
          iter = iter,
          map = map,
          mapi = mapi,
          fold = fold,
          for_all = for_all,
          exists = exists,
          add_min_binding = add_min_binding,
          add_max_binding = add_max_binding,
          join = join,
          concat = concat,
          concat_or_join = concat_or_join,
          split = split,
          merge = merge,
          filter = filter,
          partition = partition,
          cons_enum = cons_enum,
          compare = compare,
          equal = equal,
          cardinal = cardinal,
          bindings_aux = bindings_aux,
          bindings = bindings,
          choose = min_binding
        };
end end

function height(param) do
  if (param) then do
    return param[5];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function singleton(x, d) do
  return --[[ Node ]]{
          --[[ Empty ]]0,
          x,
          d,
          --[[ Empty ]]0,
          1
        };
end end

function bal(l, x, d, r) do
  hl = l and l[5] or 0;
  hr = r and r[5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[4];
      ld = l[3];
      lv = l[2];
      ll = l[1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[1]), lr[2], lr[3], create(lr[4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[4];
      rd = r[3];
      rv = r[2];
      rl = r[1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[1]), rl[2], rl[3], create(rl[4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
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
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]]{
              l,
              x,
              data,
              r,
              param[5]
            };
    end else if (c < 0) then do
      return bal(add(x, data, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          };
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[2]);
      if (c == 0) then do
        return param[3];
      end else do
        _param = c < 0 and param[1] or param[4];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[1] or param[4];
        ::continue:: ;
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
      l = param[1];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[2],
                param[3]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_binding(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[4];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[2],
                param[3]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function remove_min_binding(param) do
  if (param) then do
    l = param[1];
    if (l) then do
      return bal(remove_min_binding(l), param[2], param[3], param[4]);
    end else do
      return param[4];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Map.remove_min_elt"
    })
  end end 
end end

function remove(x, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      t1 = l;
      t2 = r;
      if (t1) then do
        if (t2) then do
          match = min_binding(t2);
          return bal(t1, match[1], match[2], remove_min_binding(t2));
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
      iter(f, param[1]);
      Curry._2(f, param[2], param[3]);
      _param = param[4];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map(f, param) do
  if (param) then do
    l_prime = map(f, param[1]);
    d_prime = Curry._1(f, param[3]);
    r_prime = map(f, param[4]);
    return --[[ Node ]]{
            l_prime,
            param[2],
            d_prime,
            r_prime,
            param[5]
          };
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mapi(f, param) do
  if (param) then do
    v = param[2];
    l_prime = mapi(f, param[1]);
    d_prime = Curry._2(f, v, param[3]);
    r_prime = mapi(f, param[4]);
    return --[[ Node ]]{
            l_prime,
            v,
            d_prime,
            r_prime,
            param[5]
          };
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function fold(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[2], m[3], fold(f, m[1], accu));
      _m = m[4];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[2], param[3]) and for_all(p, param[1])) then do
        _param = param[4];
        ::continue:: ;
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
      if (Curry._2(p, param[2], param[3]) or exists(p, param[1])) then do
        return true;
      end else do
        _param = param[4];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding(k, v, param) do
  if (param) then do
    return bal(add_min_binding(k, v, param[1]), param[2], param[3], param[4]);
  end else do
    return singleton(k, v);
  end end 
end end

function add_max_binding(k, v, param) do
  if (param) then do
    return bal(param[1], param[2], param[3], add_max_binding(k, v, param[4]));
  end else do
    return singleton(k, v);
  end end 
end end

function join(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[5];
      lh = l[5];
      if (lh > (rh + 2 | 0)) then do
        return bal(l[1], l[2], l[3], join(l[4], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(join(l, v, d, r[1]), r[2], r[3], r[4]);
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
      return join(t1, match[1], match[2], remove_min_binding(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join(t1, v, d, t2) do
  if (d ~= nil) then do
    return join(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat(t1, t2);
  end end 
end end

function split(x, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]]{
              l,
              Caml_option.some(d),
              r
            };
    end else if (c < 0) then do
      match = split(x, l);
      return --[[ tuple ]]{
              match[1],
              match[2],
              join(match[3], v, d, r)
            };
    end else do
      match_1 = split(x, r);
      return --[[ tuple ]]{
              join(l, v, d, match_1[1]),
              match_1[2],
              match_1[3]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            nil,
            --[[ Empty ]]0
          };
  end end 
end end

function merge(f, s1, s2) do
  if (s1) then do
    v1 = s1[2];
    if (s1[5] >= height(s2)) then do
      match = split(v1, s2);
      return concat_or_join(merge(f, s1[1], match[1]), v1, Curry._3(f, v1, Caml_option.some(s1[3]), match[2]), merge(f, s1[4], match[3]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[2];
    match_1 = split(v2, s1);
    return concat_or_join(merge(f, match_1[1], s2[1]), v2, Curry._3(f, v2, match_1[2], Caml_option.some(s2[3])), merge(f, match_1[3], s2[4]));
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "inline_map2_test.ml",
        270,
        10
      }
    })
  end end 
end end

function filter(p, param) do
  if (param) then do
    d = param[3];
    v = param[2];
    l_prime = filter(p, param[1]);
    pvd = Curry._2(p, v, d);
    r_prime = filter(p, param[4]);
    if (pvd) then do
      return join(l_prime, v, d, r_prime);
    end else do
      return concat(l_prime, r_prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition(p, param) do
  if (param) then do
    d = param[3];
    v = param[2];
    match = partition(p, param[1]);
    lf = match[2];
    lt = match[1];
    pvd = Curry._2(p, v, d);
    match_1 = partition(p, param[4]);
    rf = match_1[2];
    rt = match_1[1];
    if (pvd) then do
      return --[[ tuple ]]{
              join(lt, v, d, rt),
              concat(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              concat(lt, rt),
              join(lf, v, d, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

function cons_enum(_m, _e) do
  while(true) do
    e = _e;
    m = _m;
    if (m) then do
      _e = --[[ More ]]{
        m[2],
        m[3],
        m[4],
        e
      };
      _m = m[1];
      ::continue:: ;
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
        c = Caml_primitive.caml_int_compare(e1[1], e2[1]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[2], e2[2]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum(e2[3], e2[4]);
            _e1 = cons_enum(e1[3], e1[4]);
            ::continue:: ;
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
      if (e2 and e1[1] == e2[1] and Curry._2(cmp, e1[2], e2[2])) then do
        _e2 = cons_enum(e2[3], e2[4]);
        _e1 = cons_enum(e1[3], e1[4]);
        ::continue:: ;
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
    return (cardinal(param[1]) + 1 | 0) + cardinal(param[4]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[1];
      _accu = --[[ :: ]]{
        --[[ tuple ]]{
          param[2],
          param[3]
        },
        bindings_aux(accu, param[4])
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings(s) do
  return bindings_aux(--[[ [] ]]0, s);
end end

IntMap = {
  height = height,
  create = create,
  singleton = singleton,
  bal = bal,
  empty = --[[ Empty ]]0,
  is_empty = is_empty,
  add = add,
  find = find,
  mem = mem,
  min_binding = min_binding,
  max_binding = max_binding,
  remove_min_binding = remove_min_binding,
  remove = remove,
  iter = iter,
  map = map,
  mapi = mapi,
  fold = fold,
  for_all = for_all,
  exists = exists,
  add_min_binding = add_min_binding,
  add_max_binding = add_max_binding,
  join = join,
  concat = concat,
  concat_or_join = concat_or_join,
  split = split,
  merge = merge,
  filter = filter,
  partition = partition,
  cons_enum = cons_enum,
  compare = compare,
  equal = equal,
  cardinal = cardinal,
  bindings_aux = bindings_aux,
  bindings = bindings,
  choose = min_binding
};

m = List.fold_left((function(acc, param) do
        return add(param[1], param[2], acc);
      end end), --[[ Empty ]]0, --[[ :: ]]{
      --[[ tuple ]]{
        10,
        --[[ "a" ]]97
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          3,
          --[[ "b" ]]98
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            7,
            --[[ "c" ]]99
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              20,
              --[[ "d" ]]100
            },
            --[[ [] ]]0
          }
        }
      }
    });

function height_1(param) do
  if (param) then do
    return param[5];
  end else do
    return 0;
  end end 
end end

function create_1(l, x, d, r) do
  hl = height_1(l);
  hr = height_1(r);
  return --[[ Node ]]{
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function singleton_1(x, d) do
  return --[[ Node ]]{
          --[[ Empty ]]0,
          x,
          d,
          --[[ Empty ]]0,
          1
        };
end end

function bal_1(l, x, d, r) do
  hl = l and l[5] or 0;
  hr = r and r[5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[4];
      ld = l[3];
      lv = l[2];
      ll = l[1];
      if (height_1(ll) >= height_1(lr)) then do
        return create_1(ll, lv, ld, create_1(lr, x, d, r));
      end else if (lr) then do
        return create_1(create_1(ll, lv, ld, lr[1]), lr[2], lr[3], create_1(lr[4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[4];
      rd = r[3];
      rv = r[2];
      rl = r[1];
      if (height_1(rr) >= height_1(rl)) then do
        return create_1(create_1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create_1(create_1(l, x, d, rl[1]), rl[2], rl[3], create_1(rl[4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function is_empty_1(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add_1(x, data, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]]{
              l,
              x,
              data,
              r,
              param[5]
            };
    end else if (c < 0) then do
      return bal_1(add_1(x, data, l), v, d, r);
    end else do
      return bal_1(l, v, d, add_1(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          };
  end end 
end end

function find_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[2]);
      if (c == 0) then do
        return param[3];
      end else do
        _param = c < 0 and param[1] or param[4];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function mem_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[1] or param[4];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function min_binding_1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[1];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[2],
                param[3]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_binding_1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[4];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[2],
                param[3]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function remove_min_binding_1(param) do
  if (param) then do
    l = param[1];
    if (l) then do
      return bal_1(remove_min_binding_1(l), param[2], param[3], param[4]);
    end else do
      return param[4];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Map.remove_min_elt"
    })
  end end 
end end

function remove_1(x, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      t1 = l;
      t2 = r;
      if (t1) then do
        if (t2) then do
          match = min_binding_1(t2);
          return bal_1(t1, match[1], match[2], remove_min_binding_1(t2));
        end else do
          return t1;
        end end 
      end else do
        return t2;
      end end 
    end else if (c < 0) then do
      return bal_1(remove_1(x, l), v, d, r);
    end else do
      return bal_1(l, v, d, remove_1(x, r));
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function iter_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter_1(f, param[1]);
      Curry._2(f, param[2], param[3]);
      _param = param[4];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map_1(f, param) do
  if (param) then do
    l_prime = map_1(f, param[1]);
    d_prime = Curry._1(f, param[3]);
    r_prime = map_1(f, param[4]);
    return --[[ Node ]]{
            l_prime,
            param[2],
            d_prime,
            r_prime,
            param[5]
          };
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mapi_1(f, param) do
  if (param) then do
    v = param[2];
    l_prime = mapi_1(f, param[1]);
    d_prime = Curry._2(f, v, param[3]);
    r_prime = mapi_1(f, param[4]);
    return --[[ Node ]]{
            l_prime,
            v,
            d_prime,
            r_prime,
            param[5]
          };
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function fold_1(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[2], m[3], fold_1(f, m[1], accu));
      _m = m[4];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all_1(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[2], param[3]) and for_all_1(p, param[1])) then do
        _param = param[4];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists_1(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[2], param[3]) or exists_1(p, param[1])) then do
        return true;
      end else do
        _param = param[4];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding_1(k, v, param) do
  if (param) then do
    return bal_1(add_min_binding_1(k, v, param[1]), param[2], param[3], param[4]);
  end else do
    return singleton_1(k, v);
  end end 
end end

function add_max_binding_1(k, v, param) do
  if (param) then do
    return bal_1(param[1], param[2], param[3], add_max_binding_1(k, v, param[4]));
  end else do
    return singleton_1(k, v);
  end end 
end end

function join_1(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[5];
      lh = l[5];
      if (lh > (rh + 2 | 0)) then do
        return bal_1(l[1], l[2], l[3], join_1(l[4], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal_1(join_1(l, v, d, r[1]), r[2], r[3], r[4]);
      end else do
        return create_1(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding_1(v, d, l);
    end end 
  end else do
    return add_min_binding_1(v, d, r);
  end end 
end end

function concat_1(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding_1(t2);
      return join_1(t1, match[1], match[2], remove_min_binding_1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join_1(t1, v, d, t2) do
  if (d ~= nil) then do
    return join_1(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat_1(t1, t2);
  end end 
end end

function split_1(x, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]]{
              l,
              Caml_option.some(d),
              r
            };
    end else if (c < 0) then do
      match = split_1(x, l);
      return --[[ tuple ]]{
              match[1],
              match[2],
              join_1(match[3], v, d, r)
            };
    end else do
      match_1 = split_1(x, r);
      return --[[ tuple ]]{
              join_1(l, v, d, match_1[1]),
              match_1[2],
              match_1[3]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            nil,
            --[[ Empty ]]0
          };
  end end 
end end

function merge_1(f, s1, s2) do
  if (s1) then do
    v1 = s1[2];
    if (s1[5] >= height_1(s2)) then do
      match = split_1(v1, s2);
      return concat_or_join_1(merge_1(f, s1[1], match[1]), v1, Curry._3(f, v1, Caml_option.some(s1[3]), match[2]), merge_1(f, s1[4], match[3]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[2];
    match_1 = split_1(v2, s1);
    return concat_or_join_1(merge_1(f, match_1[1], s2[1]), v2, Curry._3(f, v2, match_1[2], Caml_option.some(s2[3])), merge_1(f, match_1[3], s2[4]));
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "inline_map2_test.ml",
        270,
        10
      }
    })
  end end 
end end

function filter_1(p, param) do
  if (param) then do
    d = param[3];
    v = param[2];
    l_prime = filter_1(p, param[1]);
    pvd = Curry._2(p, v, d);
    r_prime = filter_1(p, param[4]);
    if (pvd) then do
      return join_1(l_prime, v, d, r_prime);
    end else do
      return concat_1(l_prime, r_prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition_1(p, param) do
  if (param) then do
    d = param[3];
    v = param[2];
    match = partition_1(p, param[1]);
    lf = match[2];
    lt = match[1];
    pvd = Curry._2(p, v, d);
    match_1 = partition_1(p, param[4]);
    rf = match_1[2];
    rt = match_1[1];
    if (pvd) then do
      return --[[ tuple ]]{
              join_1(lt, v, d, rt),
              concat_1(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              concat_1(lt, rt),
              join_1(lf, v, d, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

function cons_enum_1(_m, _e) do
  while(true) do
    e = _e;
    m = _m;
    if (m) then do
      _e = --[[ More ]]{
        m[2],
        m[3],
        m[4],
        e
      };
      _m = m[1];
      ::continue:: ;
    end else do
      return e;
    end end 
  end;
end end

function compare_1(cmp, m1, m2) do
  _e1 = cons_enum_1(m1, --[[ End ]]0);
  _e2 = cons_enum_1(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_string_compare(e1[1], e2[1]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[2], e2[2]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum_1(e2[3], e2[4]);
            _e1 = cons_enum_1(e1[3], e1[4]);
            ::continue:: ;
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

function equal_1(cmp, m1, m2) do
  _e1 = cons_enum_1(m1, --[[ End ]]0);
  _e2 = cons_enum_1(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2 and Caml_primitive.caml_string_compare(e1[1], e2[1]) == 0 and Curry._2(cmp, e1[2], e2[2])) then do
        _e2 = cons_enum_1(e2[3], e2[4]);
        _e1 = cons_enum_1(e1[3], e1[4]);
        ::continue:: ;
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

function cardinal_1(param) do
  if (param) then do
    return (cardinal_1(param[1]) + 1 | 0) + cardinal_1(param[4]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux_1(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[1];
      _accu = --[[ :: ]]{
        --[[ tuple ]]{
          param[2],
          param[3]
        },
        bindings_aux_1(accu, param[4])
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings_1(s) do
  return bindings_aux_1(--[[ [] ]]0, s);
end end

SMap = {
  height = height_1,
  create = create_1,
  singleton = singleton_1,
  bal = bal_1,
  empty = --[[ Empty ]]0,
  is_empty = is_empty_1,
  add = add_1,
  find = find_1,
  mem = mem_1,
  min_binding = min_binding_1,
  max_binding = max_binding_1,
  remove_min_binding = remove_min_binding_1,
  remove = remove_1,
  iter = iter_1,
  map = map_1,
  mapi = mapi_1,
  fold = fold_1,
  for_all = for_all_1,
  exists = exists_1,
  add_min_binding = add_min_binding_1,
  add_max_binding = add_max_binding_1,
  join = join_1,
  concat = concat_1,
  concat_or_join = concat_or_join_1,
  split = split_1,
  merge = merge_1,
  filter = filter_1,
  partition = partition_1,
  cons_enum = cons_enum_1,
  compare = compare_1,
  equal = equal_1,
  cardinal = cardinal_1,
  bindings_aux = bindings_aux_1,
  bindings = bindings_1,
  choose = min_binding_1
};

s = List.fold_left((function(acc, param) do
        return add_1(param[1], param[2], acc);
      end end), --[[ Empty ]]0, --[[ :: ]]{
      --[[ tuple ]]{
        "10",
        --[[ "a" ]]97
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "3",
          --[[ "b" ]]98
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "7",
            --[[ "c" ]]99
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "20",
              --[[ "d" ]]100
            },
            --[[ [] ]]0
          }
        }
      }
    });

Mt.from_pair_suites("Inline_map2_test", --[[ :: ]]{
      --[[ tuple ]]{
        "assertion1",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      find(10, m),
                      --[[ "a" ]]97
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "assertion2",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        find_1("10", s),
                        --[[ "a" ]]97
                      });
            end end)
        },
        --[[ [] ]]0
      }
    });

empty = --[[ Empty ]]0;

exports = {};
exports.Make = Make;
exports.IntMap = IntMap;
exports.empty = empty;
exports.m = m;
exports.SMap = SMap;
exports.s = s;
return exports;
--[[ m Not a pure module ]]
