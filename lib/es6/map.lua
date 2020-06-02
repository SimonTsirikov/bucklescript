

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function Make(funarg) do
  height = function (param) do
    if (param) then do
      return param[--[[ h ]]4];
    end else do
      return 0;
    end end 
  end end;
  create = function (l, x, d, r) do
    hl = height(l);
    hr = height(r);
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end;
  singleton = function (x, d) do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end;
  bal = function (l, x, d, r) do
    hl = l and l[--[[ h ]]4] or 0;
    hr = r and r[--[[ h ]]4] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[--[[ r ]]3];
        ld = l[--[[ d ]]2];
        lv = l[--[[ v ]]1];
        ll = l[--[[ l ]]0];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, ld, create(lr, x, d, r));
        end else if (lr) then do
          return create(create(ll, lv, ld, lr[--[[ l ]]0]), lr[--[[ v ]]1], lr[--[[ d ]]2], create(lr[--[[ r ]]3], x, d, r));
        end else do
          throw {
                Caml_builtin_exceptions.invalid_argument,
                "Map.bal"
              };
        end end  end 
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end 
    end else if (hr > (hl + 2 | 0)) then do
      if (r) then do
        rr = r[--[[ r ]]3];
        rd = r[--[[ d ]]2];
        rv = r[--[[ v ]]1];
        rl = r[--[[ l ]]0];
        if (height(rr) >= height(rl)) then do
          return create(create(l, x, d, rl), rv, rd, rr);
        end else if (rl) then do
          return create(create(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create(rl[--[[ r ]]3], rv, rd, rr));
        end else do
          throw {
                Caml_builtin_exceptions.invalid_argument,
                "Map.bal"
              };
        end end  end 
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end 
    end else do
      return --[[ Node ]]{
              --[[ l ]]l,
              --[[ v ]]x,
              --[[ d ]]d,
              --[[ r ]]r,
              --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
            };
    end end  end 
  end end;
  is_empty = function (param) do
    if (param) then do
      return false;
    end else do
      return true;
    end end 
  end end;
  add = function (x, data, m) do
    if (m) then do
      r = m[--[[ r ]]3];
      d = m[--[[ d ]]2];
      v = m[--[[ v ]]1];
      l = m[--[[ l ]]0];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        if (d == data) then do
          return m;
        end else do
          return --[[ Node ]]{
                  --[[ l ]]l,
                  --[[ v ]]x,
                  --[[ d ]]data,
                  --[[ r ]]r,
                  --[[ h ]]m[--[[ h ]]4]
                };
        end end 
      end else if (c < 0) then do
        ll = add(x, data, l);
        if (l == ll) then do
          return m;
        end else do
          return bal(ll, v, d, r);
        end end 
      end else do
        rr = add(x, data, r);
        if (r == rr) then do
          return m;
        end else do
          return bal(l, v, d, rr);
        end end 
      end end  end 
    end else do
      return --[[ Node ]]{
              --[[ l : Empty ]]0,
              --[[ v ]]x,
              --[[ d ]]data,
              --[[ r : Empty ]]0,
              --[[ h ]]1
            };
    end end 
  end end;
  find = function (x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]1]);
        if (c == 0) then do
          return param[--[[ d ]]2];
        end else do
          _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_first = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]1];
        if (Curry._1(f, v)) then do
          _v0 = v;
          _d0 = param[--[[ d ]]2];
          f$1 = f;
          _param$1 = param[--[[ l ]]0];
          while(true) do
            param$1 = _param$1;
            d0 = _d0;
            v0 = _v0;
            if (param$1) then do
              v$1 = param$1[--[[ v ]]1];
              if (Curry._1(f$1, v$1)) then do
                _param$1 = param$1[--[[ l ]]0];
                _d0 = param$1[--[[ d ]]2];
                _v0 = v$1;
                continue ;
              end else do
                _param$1 = param$1[--[[ r ]]3];
                continue ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ r ]]3];
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_first_opt = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]1];
        if (Curry._1(f, v)) then do
          _v0 = v;
          _d0 = param[--[[ d ]]2];
          f$1 = f;
          _param$1 = param[--[[ l ]]0];
          while(true) do
            param$1 = _param$1;
            d0 = _d0;
            v0 = _v0;
            if (param$1) then do
              v$1 = param$1[--[[ v ]]1];
              if (Curry._1(f$1, v$1)) then do
                _param$1 = param$1[--[[ l ]]0];
                _d0 = param$1[--[[ d ]]2];
                _v0 = v$1;
                continue ;
              end else do
                _param$1 = param$1[--[[ r ]]3];
                continue ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ r ]]3];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_last = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]1];
        if (Curry._1(f, v)) then do
          _v0 = v;
          _d0 = param[--[[ d ]]2];
          f$1 = f;
          _param$1 = param[--[[ r ]]3];
          while(true) do
            param$1 = _param$1;
            d0 = _d0;
            v0 = _v0;
            if (param$1) then do
              v$1 = param$1[--[[ v ]]1];
              if (Curry._1(f$1, v$1)) then do
                _param$1 = param$1[--[[ r ]]3];
                _d0 = param$1[--[[ d ]]2];
                _v0 = v$1;
                continue ;
              end else do
                _param$1 = param$1[--[[ l ]]0];
                continue ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ l ]]0];
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_last_opt = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]1];
        if (Curry._1(f, v)) then do
          _v0 = v;
          _d0 = param[--[[ d ]]2];
          f$1 = f;
          _param$1 = param[--[[ r ]]3];
          while(true) do
            param$1 = _param$1;
            d0 = _d0;
            v0 = _v0;
            if (param$1) then do
              v$1 = param$1[--[[ v ]]1];
              if (Curry._1(f$1, v$1)) then do
                _param$1 = param$1[--[[ r ]]3];
                _d0 = param$1[--[[ d ]]2];
                _v0 = v$1;
                continue ;
              end else do
                _param$1 = param$1[--[[ l ]]0];
                continue ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ l ]]0];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_opt = function (x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]1]);
        if (c == 0) then do
          return Caml_option.some(param[--[[ d ]]2]);
        end else do
          _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  mem = function (x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]1]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
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
        l = param[--[[ l ]]0];
        if (l) then do
          _param = l;
          continue ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]1],
                  param[--[[ d ]]2]
                };
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  min_binding_opt = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[--[[ l ]]0];
        if (l) then do
          _param = l;
          continue ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]1],
                  param[--[[ d ]]2]
                };
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  max_binding = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]3];
        if (r) then do
          _param = r;
          continue ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]1],
                  param[--[[ d ]]2]
                };
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  max_binding_opt = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]3];
        if (r) then do
          _param = r;
          continue ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]1],
                  param[--[[ d ]]2]
                };
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  remove_min_binding = function (param) do
    if (param) then do
      l = param[--[[ l ]]0];
      if (l) then do
        return bal(remove_min_binding(l), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
      end else do
        return param[--[[ r ]]3];
      end end 
    end else do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Map.remove_min_elt"
          };
    end end 
  end end;
  merge = function (t1, t2) do
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
  end end;
  remove = function (x, m) do
    if (m) then do
      r = m[--[[ r ]]3];
      d = m[--[[ d ]]2];
      v = m[--[[ v ]]1];
      l = m[--[[ l ]]0];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        return merge(l, r);
      end else if (c < 0) then do
        ll = remove(x, l);
        if (l == ll) then do
          return m;
        end else do
          return bal(ll, v, d, r);
        end end 
      end else do
        rr = remove(x, r);
        if (r == rr) then do
          return m;
        end else do
          return bal(l, v, d, rr);
        end end 
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  update = function (x, f, m) do
    if (m) then do
      r = m[--[[ r ]]3];
      d = m[--[[ d ]]2];
      v = m[--[[ v ]]1];
      l = m[--[[ l ]]0];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        match = Curry._1(f, Caml_option.some(d));
        if (match ~= undefined) then do
          data = Caml_option.valFromOption(match);
          if (d == data) then do
            return m;
          end else do
            return --[[ Node ]]{
                    --[[ l ]]l,
                    --[[ v ]]x,
                    --[[ d ]]data,
                    --[[ r ]]r,
                    --[[ h ]]m[--[[ h ]]4]
                  };
          end end 
        end else do
          return merge(l, r);
        end end 
      end else if (c < 0) then do
        ll = update(x, f, l);
        if (l == ll) then do
          return m;
        end else do
          return bal(ll, v, d, r);
        end end 
      end else do
        rr = update(x, f, r);
        if (r == rr) then do
          return m;
        end else do
          return bal(l, v, d, rr);
        end end 
      end end  end 
    end else do
      match$1 = Curry._1(f, undefined);
      if (match$1 ~= undefined) then do
        return --[[ Node ]]{
                --[[ l : Empty ]]0,
                --[[ v ]]x,
                --[[ d ]]Caml_option.valFromOption(match$1),
                --[[ r : Empty ]]0,
                --[[ h ]]1
              };
      end else do
        return --[[ Empty ]]0;
      end end 
    end end 
  end end;
  iter = function (f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        iter(f, param[--[[ l ]]0]);
        Curry._2(f, param[--[[ v ]]1], param[--[[ d ]]2]);
        _param = param[--[[ r ]]3];
        continue ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  map = function (f, param) do
    if (param) then do
      l$prime = map(f, param[--[[ l ]]0]);
      d$prime = Curry._1(f, param[--[[ d ]]2]);
      r$prime = map(f, param[--[[ r ]]3]);
      return --[[ Node ]]{
              --[[ l ]]l$prime,
              --[[ v ]]param[--[[ v ]]1],
              --[[ d ]]d$prime,
              --[[ r ]]r$prime,
              --[[ h ]]param[--[[ h ]]4]
            };
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  mapi = function (f, param) do
    if (param) then do
      v = param[--[[ v ]]1];
      l$prime = mapi(f, param[--[[ l ]]0]);
      d$prime = Curry._2(f, v, param[--[[ d ]]2]);
      r$prime = mapi(f, param[--[[ r ]]3]);
      return --[[ Node ]]{
              --[[ l ]]l$prime,
              --[[ v ]]v,
              --[[ d ]]d$prime,
              --[[ r ]]r$prime,
              --[[ h ]]param[--[[ h ]]4]
            };
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  fold = function (f, _m, _accu) do
    while(true) do
      accu = _accu;
      m = _m;
      if (m) then do
        _accu = Curry._3(f, m[--[[ v ]]1], m[--[[ d ]]2], fold(f, m[--[[ l ]]0], accu));
        _m = m[--[[ r ]]3];
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
        if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) and for_all(p, param[--[[ l ]]0])) then do
          _param = param[--[[ r ]]3];
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
        if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) or exists(p, param[--[[ l ]]0])) then do
          return true;
        end else do
          _param = param[--[[ r ]]3];
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  add_min_binding = function (k, x, param) do
    if (param) then do
      return bal(add_min_binding(k, x, param[--[[ l ]]0]), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
    end else do
      return singleton(k, x);
    end end 
  end end;
  add_max_binding = function (k, x, param) do
    if (param) then do
      return bal(param[--[[ l ]]0], param[--[[ v ]]1], param[--[[ d ]]2], add_max_binding(k, x, param[--[[ r ]]3]));
    end else do
      return singleton(k, x);
    end end 
  end end;
  join = function (l, v, d, r) do
    if (l) then do
      if (r) then do
        rh = r[--[[ h ]]4];
        lh = l[--[[ h ]]4];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[--[[ l ]]0], l[--[[ v ]]1], l[--[[ d ]]2], join(l[--[[ r ]]3], v, d, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, d, r[--[[ l ]]0]), r[--[[ v ]]1], r[--[[ d ]]2], r[--[[ r ]]3]);
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
      r = param[--[[ r ]]3];
      d = param[--[[ d ]]2];
      v = param[--[[ v ]]1];
      l = param[--[[ l ]]0];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        return --[[ tuple ]]{
                l,
                Caml_option.some(d),
                r
              };
      end else if (c < 0) then do
        match = split(x, l);
        return --[[ tuple ]]{
                match[0],
                match[1],
                join(match[2], v, d, r)
              };
      end else do
        match$1 = split(x, r);
        return --[[ tuple ]]{
                join(l, v, d, match$1[0]),
                match$1[1],
                match$1[2]
              };
      end end  end 
    end else do
      return --[[ tuple ]]{
              --[[ Empty ]]0,
              undefined,
              --[[ Empty ]]0
            };
    end end 
  end end;
  merge$1 = function (f, s1, s2) do
    if (s1) then do
      v1 = s1[--[[ v ]]1];
      if (s1[--[[ h ]]4] >= height(s2)) then do
        match = split(v1, s2);
        return concat_or_join(merge$1(f, s1[--[[ l ]]0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]2]), match[1]), merge$1(f, s1[--[[ r ]]3], match[2]));
      end
       end 
    end else if (not s2) then do
      return --[[ Empty ]]0;
    end
     end  end 
    if (s2) then do
      v2 = s2[--[[ v ]]1];
      match$1 = split(v2, s1);
      return concat_or_join(merge$1(f, match$1[0], s2[--[[ l ]]0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[--[[ d ]]2])), merge$1(f, match$1[2], s2[--[[ r ]]3]));
    end else do
      throw {
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "map.ml",
              393,
              10
            }
          };
    end end 
  end end;
  union = function (f, s1, s2) do
    if (s1) then do
      if (s2) then do
        d2 = s2[--[[ d ]]2];
        v2 = s2[--[[ v ]]1];
        d1 = s1[--[[ d ]]2];
        v1 = s1[--[[ v ]]1];
        if (s1[--[[ h ]]4] >= s2[--[[ h ]]4]) then do
          match = split(v1, s2);
          d2$1 = match[1];
          l = union(f, s1[--[[ l ]]0], match[0]);
          r = union(f, s1[--[[ r ]]3], match[2]);
          if (d2$1 ~= undefined) then do
            return concat_or_join(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2$1)), r);
          end else do
            return join(l, v1, d1, r);
          end end 
        end else do
          match$1 = split(v2, s1);
          d1$1 = match$1[1];
          l$1 = union(f, match$1[0], s2[--[[ l ]]0]);
          r$1 = union(f, match$1[2], s2[--[[ r ]]3]);
          if (d1$1 ~= undefined) then do
            return concat_or_join(l$1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1$1), d2), r$1);
          end else do
            return join(l$1, v2, d2, r$1);
          end end 
        end end 
      end else do
        return s1;
      end end 
    end else do
      return s2;
    end end 
  end end;
  filter = function (p, m) do
    if (m) then do
      r = m[--[[ r ]]3];
      d = m[--[[ d ]]2];
      v = m[--[[ v ]]1];
      l = m[--[[ l ]]0];
      l$prime = filter(p, l);
      pvd = Curry._2(p, v, d);
      r$prime = filter(p, r);
      if (pvd) then do
        if (l == l$prime and r == r$prime) then do
          return m;
        end else do
          return join(l$prime, v, d, r$prime);
        end end 
      end else do
        return concat(l$prime, r$prime);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  partition = function (p, param) do
    if (param) then do
      d = param[--[[ d ]]2];
      v = param[--[[ v ]]1];
      match = partition(p, param[--[[ l ]]0]);
      lf = match[1];
      lt = match[0];
      pvd = Curry._2(p, v, d);
      match$1 = partition(p, param[--[[ r ]]3]);
      rf = match$1[1];
      rt = match$1[0];
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
  cons_enum = function (_m, _e) do
    while(true) do
      e = _e;
      m = _m;
      if (m) then do
        _e = --[[ More ]]{
          m[--[[ v ]]1],
          m[--[[ d ]]2],
          m[--[[ r ]]3],
          e
        };
        _m = m[--[[ l ]]0];
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
          c = Curry._2(funarg.compare, e1[0], e2[0]);
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
        if (e2 and Curry._2(funarg.compare, e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
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
      return (cardinal(param[--[[ l ]]0]) + 1 | 0) + cardinal(param[--[[ r ]]3]) | 0;
    end else do
      return 0;
    end end 
  end end;
  bindings_aux = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[--[[ l ]]0];
        _accu = --[[ :: ]]{
          --[[ tuple ]]{
            param[--[[ v ]]1],
            param[--[[ d ]]2]
          },
          bindings_aux(accu, param[--[[ r ]]3])
        };
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
          empty: --[[ Empty ]]0,
          is_empty: is_empty,
          mem: mem,
          add: add,
          update: update,
          singleton: singleton,
          remove: remove,
          merge: merge$1,
          union: union,
          compare: compare,
          equal: equal,
          iter: iter,
          fold: fold,
          for_all: for_all,
          exists: exists,
          filter: filter,
          partition: partition,
          cardinal: cardinal,
          bindings: bindings,
          min_binding: min_binding,
          min_binding_opt: min_binding_opt,
          max_binding: max_binding,
          max_binding_opt: max_binding_opt,
          choose: min_binding,
          choose_opt: min_binding_opt,
          split: split,
          find: find,
          find_opt: find_opt,
          find_first: find_first,
          find_first_opt: find_first_opt,
          find_last: find_last,
          find_last_opt: find_last_opt,
          map: map,
          mapi: mapi
        end;
end end

export do
  Make ,
  
end
--[[ No side effect ]]
