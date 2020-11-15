

local List = require "..list.lua";
local Curry = require "..curry.lua";
local Caml_option = require "..caml_option.lua";
local Caml_builtin_exceptions = require "..caml_builtin_exceptions.lua";

function Make(funarg) do
  height = function(param) do
    if (param) then do
      return param[--[[ h ]]4];
    end else do
      return 0;
    end end 
  end end;
  create = function(l, v, r) do
    hl = l and l[--[[ h ]]4] or 0;
    hr = r and r[--[[ h ]]4] or 0;
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]v,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end;
  bal = function(l, v, r) do
    hl = l and l[--[[ h ]]4] or 0;
    hr = r and r[--[[ h ]]4] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[--[[ r ]]3];
        lv = l[--[[ v ]]2];
        ll = l[--[[ l ]]1];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, create(lr, v, r));
        end else if (lr) then do
          return create(create(ll, lv, lr[--[[ l ]]1]), lr[--[[ v ]]2], create(lr[--[[ r ]]3], v, r));
        end else do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Set.bal"
          })
        end end  end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end 
    end else if (hr > (hl + 2 | 0)) then do
      if (r) then do
        rr = r[--[[ r ]]3];
        rv = r[--[[ v ]]2];
        rl = r[--[[ l ]]1];
        if (height(rr) >= height(rl)) then do
          return create(create(l, v, rl), rv, rr);
        end else if (rl) then do
          return create(create(l, v, rl[--[[ l ]]1]), rl[--[[ v ]]2], create(rl[--[[ r ]]3], rv, rr));
        end else do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Set.bal"
          })
        end end  end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end 
    end else do
      return --[[ Node ]]{
              --[[ l ]]l,
              --[[ v ]]v,
              --[[ r ]]r,
              --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
            };
    end end  end 
  end end;
  add = function(x, t) do
    if (t) then do
      r = t[--[[ r ]]3];
      v = t[--[[ v ]]2];
      l = t[--[[ l ]]1];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        return t;
      end else if (c < 0) then do
        ll = add(x, l);
        if (l == ll) then do
          return t;
        end else do
          return bal(ll, v, r);
        end end 
      end else do
        rr = add(x, r);
        if (r == rr) then do
          return t;
        end else do
          return bal(l, v, rr);
        end end 
      end end  end 
    end else do
      return --[[ Node ]]{
              --[[ l : Empty ]]0,
              --[[ v ]]x,
              --[[ r : Empty ]]0,
              --[[ h ]]1
            };
    end end 
  end end;
  singleton = function(x) do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end;
  add_min_element = function(x, param) do
    if (param) then do
      return bal(add_min_element(x, param[--[[ l ]]1]), param[--[[ v ]]2], param[--[[ r ]]3]);
    end else do
      return singleton(x);
    end end 
  end end;
  add_max_element = function(x, param) do
    if (param) then do
      return bal(param[--[[ l ]]1], param[--[[ v ]]2], add_max_element(x, param[--[[ r ]]3]));
    end else do
      return singleton(x);
    end end 
  end end;
  join = function(l, v, r) do
    if (l) then do
      if (r) then do
        rh = r[--[[ h ]]4];
        lh = l[--[[ h ]]4];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[--[[ l ]]1], l[--[[ v ]]2], join(l[--[[ r ]]3], v, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, r[--[[ l ]]1]), r[--[[ v ]]2], r[--[[ r ]]3]);
        end else do
          return create(l, v, r);
        end end  end 
      end else do
        return add_max_element(v, l);
      end end 
    end else do
      return add_min_element(v, r);
    end end 
  end end;
  min_elt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[--[[ l ]]1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return param[--[[ v ]]2];
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  min_elt_opt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[--[[ l ]]1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return Caml_option.some(param[--[[ v ]]2]);
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  max_elt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]3];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return param[--[[ v ]]2];
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  max_elt_opt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]3];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return Caml_option.some(param[--[[ v ]]2]);
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  remove_min_elt = function(param) do
    if (param) then do
      l = param[--[[ l ]]1];
      if (l) then do
        return bal(remove_min_elt(l), param[--[[ v ]]2], param[--[[ r ]]3]);
      end else do
        return param[--[[ r ]]3];
      end end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.remove_min_elt"
      })
    end end 
  end end;
  concat = function(t1, t2) do
    if (t1) then do
      if (t2) then do
        return join(t1, min_elt(t2), remove_min_elt(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
    end end 
  end end;
  split = function(x, param) do
    if (param) then do
      r = param[--[[ r ]]3];
      v = param[--[[ v ]]2];
      l = param[--[[ l ]]1];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        return --[[ tuple ]]{
                l,
                true,
                r
              };
      end else if (c < 0) then do
        match = split(x, l);
        return --[[ tuple ]]{
                match[1],
                match[2],
                join(match[3], v, r)
              };
      end else do
        match_1 = split(x, r);
        return --[[ tuple ]]{
                join(l, v, match_1[1]),
                match_1[2],
                match_1[3]
              };
      end end  end 
    end else do
      return --[[ tuple ]]{
              --[[ Empty ]]0,
              false,
              --[[ Empty ]]0
            };
    end end 
  end end;
  is_empty = function(param) do
    if (param) then do
      return false;
    end else do
      return true;
    end end 
  end end;
  mem = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]2]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  remove = function(x, t) do
    if (t) then do
      r = t[--[[ r ]]3];
      v = t[--[[ v ]]2];
      l = t[--[[ l ]]1];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        t1 = l;
        t2 = r;
        if (t1) then do
          if (t2) then do
            return bal(t1, min_elt(t2), remove_min_elt(t2));
          end else do
            return t1;
          end end 
        end else do
          return t2;
        end end 
      end else if (c < 0) then do
        ll = remove(x, l);
        if (l == ll) then do
          return t;
        end else do
          return bal(ll, v, r);
        end end 
      end else do
        rr = remove(x, r);
        if (r == rr) then do
          return t;
        end else do
          return bal(l, v, rr);
        end end 
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  union = function(s1, s2) do
    if (s1) then do
      if (s2) then do
        h2 = s2[--[[ h ]]4];
        v2 = s2[--[[ v ]]2];
        h1 = s1[--[[ h ]]4];
        v1 = s1[--[[ v ]]2];
        if (h1 >= h2) then do
          if (h2 == 1) then do
            return add(v2, s1);
          end else do
            match = split(v1, s2);
            return join(union(s1[--[[ l ]]1], match[1]), v1, union(s1[--[[ r ]]3], match[3]));
          end end 
        end else if (h1 == 1) then do
          return add(v1, s2);
        end else do
          match_1 = split(v2, s1);
          return join(union(match_1[1], s2[--[[ l ]]1]), v2, union(match_1[3], s2[--[[ r ]]3]));
        end end  end 
      end else do
        return s1;
      end end 
    end else do
      return s2;
    end end 
  end end;
  inter = function(s1, s2) do
    if (s1 and s2) then do
      r1 = s1[--[[ r ]]3];
      v1 = s1[--[[ v ]]2];
      l1 = s1[--[[ l ]]1];
      match = split(v1, s2);
      l2 = match[1];
      if (match[2]) then do
        return join(inter(l1, l2), v1, inter(r1, match[3]));
      end else do
        return concat(inter(l1, l2), inter(r1, match[3]));
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  diff = function(s1, s2) do
    if (s1) then do
      if (s2) then do
        r1 = s1[--[[ r ]]3];
        v1 = s1[--[[ v ]]2];
        l1 = s1[--[[ l ]]1];
        match = split(v1, s2);
        l2 = match[1];
        if (match[2]) then do
          return concat(diff(l1, l2), diff(r1, match[3]));
        end else do
          return join(diff(l1, l2), v1, diff(r1, match[3]));
        end end 
      end else do
        return s1;
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  cons_enum = function(_s, _e) do
    while(true) do
      e = _e;
      s = _s;
      if (s) then do
        _e = --[[ More ]]{
          s[--[[ v ]]2],
          s[--[[ r ]]3],
          e
        };
        _s = s[--[[ l ]]1];
        ::continue:: ;
      end else do
        return e;
      end end 
    end;
  end end;
  compare = function(s1, s2) do
    _e1 = cons_enum(s1, --[[ End ]]0);
    _e2 = cons_enum(s2, --[[ End ]]0);
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2) then do
          c = Curry._2(funarg.compare, e1[1], e2[1]);
          if (c ~= 0) then do
            return c;
          end else do
            _e2 = cons_enum(e2[2], e2[3]);
            _e1 = cons_enum(e1[2], e1[3]);
            ::continue:: ;
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
  equal = function(s1, s2) do
    return compare(s1, s2) == 0;
  end end;
  subset = function(_s1, _s2) do
    while(true) do
      s2 = _s2;
      s1 = _s1;
      if (s1) then do
        if (s2) then do
          r2 = s2[--[[ r ]]3];
          l2 = s2[--[[ l ]]1];
          r1 = s1[--[[ r ]]3];
          v1 = s1[--[[ v ]]2];
          l1 = s1[--[[ l ]]1];
          c = Curry._2(funarg.compare, v1, s2[--[[ v ]]2]);
          if (c == 0) then do
            if (subset(l1, l2)) then do
              _s2 = r2;
              _s1 = r1;
              ::continue:: ;
            end else do
              return false;
            end end 
          end else if (c < 0) then do
            if (subset(--[[ Node ]]{
                    --[[ l ]]l1,
                    --[[ v ]]v1,
                    --[[ r : Empty ]]0,
                    --[[ h ]]0
                  }, l2)) then do
              _s1 = r1;
              ::continue:: ;
            end else do
              return false;
            end end 
          end else if (subset(--[[ Node ]]{
                  --[[ l : Empty ]]0,
                  --[[ v ]]v1,
                  --[[ r ]]r1,
                  --[[ h ]]0
                }, r2)) then do
            _s1 = l1;
            ::continue:: ;
          end else do
            return false;
          end end  end  end 
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end end;
  iter = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        iter(f, param[--[[ l ]]1]);
        Curry._1(f, param[--[[ v ]]2]);
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  fold = function(f, _s, _accu) do
    while(true) do
      accu = _accu;
      s = _s;
      if (s) then do
        _accu = Curry._2(f, s[--[[ v ]]2], fold(f, s[--[[ l ]]1], accu));
        _s = s[--[[ r ]]3];
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
        if (Curry._1(p, param[--[[ v ]]2]) and for_all(p, param[--[[ l ]]1])) then do
          _param = param[--[[ r ]]3];
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
        if (Curry._1(p, param[--[[ v ]]2]) or exists(p, param[--[[ l ]]1])) then do
          return true;
        end else do
          _param = param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  filter = function(p, t) do
    if (t) then do
      r = t[--[[ r ]]3];
      v = t[--[[ v ]]2];
      l = t[--[[ l ]]1];
      l_prime = filter(p, l);
      pv = Curry._1(p, v);
      r_prime = filter(p, r);
      if (pv) then do
        if (l == l_prime and r == r_prime) then do
          return t;
        end else do
          return join(l_prime, v, r_prime);
        end end 
      end else do
        return concat(l_prime, r_prime);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  partition = function(p, param) do
    if (param) then do
      v = param[--[[ v ]]2];
      match = partition(p, param[--[[ l ]]1]);
      lf = match[2];
      lt = match[1];
      pv = Curry._1(p, v);
      match_1 = partition(p, param[--[[ r ]]3]);
      rf = match_1[2];
      rt = match_1[1];
      if (pv) then do
        return --[[ tuple ]]{
                join(lt, v, rt),
                concat(lf, rf)
              };
      end else do
        return --[[ tuple ]]{
                concat(lt, rt),
                join(lf, v, rf)
              };
      end end 
    end else do
      return --[[ tuple ]]{
              --[[ Empty ]]0,
              --[[ Empty ]]0
            };
    end end 
  end end;
  cardinal = function(param) do
    if (param) then do
      return (cardinal(param[--[[ l ]]1]) + 1 | 0) + cardinal(param[--[[ r ]]3]) | 0;
    end else do
      return 0;
    end end 
  end end;
  elements_aux = function(_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[--[[ l ]]1];
        _accu = --[[ :: ]]{
          param[--[[ v ]]2],
          elements_aux(accu, param[--[[ r ]]3])
        };
        ::continue:: ;
      end else do
        return accu;
      end end 
    end;
  end end;
  elements = function(s) do
    return elements_aux(--[[ [] ]]0, s);
  end end;
  find = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        c = Curry._2(funarg.compare, x, v);
        if (c == 0) then do
          return v;
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  find_first = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        if (Curry._1(f, v)) then do
          _v0 = v;
          f_1 = f;
          _param_1 = param[--[[ l ]]1];
          while(true) do
            param_1 = _param_1;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ l ]]1];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ r ]]3];
                ::continue:: ;
              end end 
            end else do
              return v0;
            end end 
          end;
        end else do
          _param = param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  find_first_opt = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        if (Curry._1(f, v)) then do
          _v0 = v;
          f_1 = f;
          _param_1 = param[--[[ l ]]1];
          while(true) do
            param_1 = _param_1;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ l ]]1];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ r ]]3];
                ::continue:: ;
              end end 
            end else do
              return Caml_option.some(v0);
            end end 
          end;
        end else do
          _param = param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_last = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        if (Curry._1(f, v)) then do
          _v0 = v;
          f_1 = f;
          _param_1 = param[--[[ r ]]3];
          while(true) do
            param_1 = _param_1;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ r ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ l ]]1];
                ::continue:: ;
              end end 
            end else do
              return v0;
            end end 
          end;
        end else do
          _param = param[--[[ l ]]1];
          ::continue:: ;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  find_last_opt = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        if (Curry._1(f, v)) then do
          _v0 = v;
          f_1 = f;
          _param_1 = param[--[[ r ]]3];
          while(true) do
            param_1 = _param_1;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ r ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ l ]]1];
                ::continue:: ;
              end end 
            end else do
              return Caml_option.some(v0);
            end end 
          end;
        end else do
          _param = param[--[[ l ]]1];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_opt = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        v = param[--[[ v ]]2];
        c = Curry._2(funarg.compare, x, v);
        if (c == 0) then do
          return Caml_option.some(v);
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  map = function(f, t) do
    if (t) then do
      r = t[--[[ r ]]3];
      v = t[--[[ v ]]2];
      l = t[--[[ l ]]1];
      l_prime = map(f, l);
      v_prime = Curry._1(f, v);
      r_prime = map(f, r);
      if (l == l_prime and v == v_prime and r == r_prime) then do
        return t;
      end else do
        l_1 = l_prime;
        v_1 = v_prime;
        r_1 = r_prime;
        if ((l_1 == --[[ Empty ]]0 or Curry._2(funarg.compare, max_elt(l_1), v_1) < 0) and (r_1 == --[[ Empty ]]0 or Curry._2(funarg.compare, v_1, min_elt(r_1)) < 0)) then do
          return join(l_1, v_1, r_1);
        end else do
          return union(l_1, add(v_1, r_1));
        end end 
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  of_list = function(l) do
    if (l) then do
      match = l[2];
      x0 = l[1];
      if (match) then do
        match_1 = match[2];
        x1 = match[1];
        if (match_1) then do
          match_2 = match_1[2];
          x2 = match_1[1];
          if (match_2) then do
            match_3 = match_2[2];
            x3 = match_2[1];
            if (match_3) then do
              if (match_3[2]) then do
                l_1 = List.sort_uniq(funarg.compare, l);
                sub = function(n, l) do
                  local ___conditional___=(n);
                  do
                     if ___conditional___ == 0 then do
                        return --[[ tuple ]]{
                                --[[ Empty ]]0,
                                l
                              }; end end 
                     if ___conditional___ == 1 then do
                        if (l) then do
                          return --[[ tuple ]]{
                                  --[[ Node ]]{
                                    --[[ l : Empty ]]0,
                                    --[[ v ]]l[1],
                                    --[[ r : Empty ]]0,
                                    --[[ h ]]1
                                  },
                                  l[2]
                                };
                        end
                         end  end else 
                     if ___conditional___ == 2 then do
                        if (l) then do
                          match = l[2];
                          if (match) then do
                            return --[[ tuple ]]{
                                    --[[ Node ]]{
                                      --[[ l : Node ]]{
                                        --[[ l : Empty ]]0,
                                        --[[ v ]]l[1],
                                        --[[ r : Empty ]]0,
                                        --[[ h ]]1
                                      },
                                      --[[ v ]]match[1],
                                      --[[ r : Empty ]]0,
                                      --[[ h ]]2
                                    },
                                    match[2]
                                  };
                          end
                           end 
                        end
                         end  end else 
                     if ___conditional___ == 3 then do
                        if (l) then do
                          match_1 = l[2];
                          if (match_1) then do
                            match_2 = match_1[2];
                            if (match_2) then do
                              return --[[ tuple ]]{
                                      --[[ Node ]]{
                                        --[[ l : Node ]]{
                                          --[[ l : Empty ]]0,
                                          --[[ v ]]l[1],
                                          --[[ r : Empty ]]0,
                                          --[[ h ]]1
                                        },
                                        --[[ v ]]match_1[1],
                                        --[[ r : Node ]]{
                                          --[[ l : Empty ]]0,
                                          --[[ v ]]match_2[1],
                                          --[[ r : Empty ]]0,
                                          --[[ h ]]1
                                        },
                                        --[[ h ]]2
                                      },
                                      match_2[2]
                                    };
                            end
                             end 
                          end
                           end 
                        end
                         end  end else 
                     end end end end end end
                    
                  end
                  nl = n / 2 | 0;
                  match_3 = sub(nl, l);
                  l_1 = match_3[2];
                  if (l_1) then do
                    match_4 = sub((n - nl | 0) - 1 | 0, l_1[2]);
                    return --[[ tuple ]]{
                            create(match_3[1], l_1[1], match_4[1]),
                            match_4[2]
                          };
                  end else do
                    error({
                      Caml_builtin_exceptions.assert_failure,
                      --[[ tuple ]]{
                        "set.ml",
                        510,
                        18
                      }
                    })
                  end end 
                end end;
                return sub(List.length(l_1), l_1)[1];
              end else do
                return add(match_3[1], add(x3, add(x2, add(x1, singleton(x0)))));
              end end 
            end else do
              return add(x3, add(x2, add(x1, singleton(x0))));
            end end 
          end else do
            return add(x2, add(x1, singleton(x0)));
          end end 
        end else do
          return add(x1, singleton(x0));
        end end 
      end else do
        return singleton(x0);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  return {
          empty = --[[ Empty ]]0,
          is_empty = is_empty,
          mem = mem,
          add = add,
          singleton = singleton,
          remove = remove,
          union = union,
          inter = inter,
          diff = diff,
          compare = compare,
          equal = equal,
          subset = subset,
          iter = iter,
          map = map,
          fold = fold,
          for_all = for_all,
          exists = exists,
          filter = filter,
          partition = partition,
          cardinal = cardinal,
          elements = elements,
          min_elt = min_elt,
          min_elt_opt = min_elt_opt,
          max_elt = max_elt,
          max_elt_opt = max_elt_opt,
          choose = min_elt,
          choose_opt = min_elt_opt,
          split = split,
          find = find,
          find_opt = find_opt,
          find_first = find_first,
          find_first_opt = find_first_opt,
          find_last = find_last,
          find_last_opt = find_last_opt,
          of_list = of_list
        };
end end

export do
  Make ,
  
end
--[[ No side effect ]]
