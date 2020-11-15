

local Curry = require "..curry.lua";
local Caml_option = require "..caml_option.lua";
local Caml_builtin_exceptions = require "..caml_builtin_exceptions.lua";

function Make(funarg) do
  height = function(param) do
    if (param) then do
      return param[--[[ h ]]5];
    end else do
      return 0;
    end end 
  end end;
  create = function(l, x, d, r) do
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
  singleton = function(x, d) do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end;
  bal = function(l, x, d, r) do
    hl = l and l[--[[ h ]]5] or 0;
    hr = r and r[--[[ h ]]5] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[--[[ r ]]4];
        ld = l[--[[ d ]]3];
        lv = l[--[[ v ]]2];
        ll = l[--[[ l ]]1];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, ld, create(lr, x, d, r));
        end else if (lr) then do
          return create(create(ll, lv, ld, lr[--[[ l ]]1]), lr[--[[ v ]]2], lr[--[[ d ]]3], create(lr[--[[ r ]]4], x, d, r));
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
        rr = r[--[[ r ]]4];
        rd = r[--[[ d ]]3];
        rv = r[--[[ v ]]2];
        rl = r[--[[ l ]]1];
        if (height(rr) >= height(rl)) then do
          return create(create(l, x, d, rl), rv, rd, rr);
        end else if (rl) then do
          return create(create(l, x, d, rl[--[[ l ]]1]), rl[--[[ v ]]2], rl[--[[ d ]]3], create(rl[--[[ r ]]4], rv, rd, rr));
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
              --[[ l ]]l,
              --[[ v ]]x,
              --[[ d ]]d,
              --[[ r ]]r,
              --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
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
  add = function(x, data, m) do
    if (m) then do
      r = m[--[[ r ]]4];
      d = m[--[[ d ]]3];
      v = m[--[[ v ]]2];
      l = m[--[[ l ]]1];
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
                  --[[ h ]]m[--[[ h ]]5]
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
  find = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]2]);
        if (c == 0) then do
          return param[--[[ d ]]3];
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
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
          _d0 = param[--[[ d ]]3];
          f_1 = f;
          _param_1 = param[--[[ l ]]1];
          while(true) do
            param_1 = _param_1;
            d0 = _d0;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ l ]]1];
                _d0 = param_1[--[[ d ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ r ]]4];
                ::continue:: ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ r ]]4];
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
          _d0 = param[--[[ d ]]3];
          f_1 = f;
          _param_1 = param[--[[ l ]]1];
          while(true) do
            param_1 = _param_1;
            d0 = _d0;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ l ]]1];
                _d0 = param_1[--[[ d ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ r ]]4];
                ::continue:: ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
            end end 
          end;
        end else do
          _param = param[--[[ r ]]4];
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
          _d0 = param[--[[ d ]]3];
          f_1 = f;
          _param_1 = param[--[[ r ]]4];
          while(true) do
            param_1 = _param_1;
            d0 = _d0;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ r ]]4];
                _d0 = param_1[--[[ d ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ l ]]1];
                ::continue:: ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
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
          _d0 = param[--[[ d ]]3];
          f_1 = f;
          _param_1 = param[--[[ r ]]4];
          while(true) do
            param_1 = _param_1;
            d0 = _d0;
            v0 = _v0;
            if (param_1) then do
              v_1 = param_1[--[[ v ]]2];
              if (Curry._1(f_1, v_1)) then do
                _param_1 = param_1[--[[ r ]]4];
                _d0 = param_1[--[[ d ]]3];
                _v0 = v_1;
                ::continue:: ;
              end else do
                _param_1 = param_1[--[[ l ]]1];
                ::continue:: ;
              end end 
            end else do
              return --[[ tuple ]]{
                      v0,
                      d0
                    };
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
        c = Curry._2(funarg.compare, x, param[--[[ v ]]2]);
        if (c == 0) then do
          return Caml_option.some(param[--[[ d ]]3]);
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  mem = function(x, _param) do
    while(true) do
      param = _param;
      if (param) then do
        c = Curry._2(funarg.compare, x, param[--[[ v ]]2]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
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
        l = param[--[[ l ]]1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]2],
                  param[--[[ d ]]3]
                };
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  min_binding_opt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        l = param[--[[ l ]]1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]2],
                  param[--[[ d ]]3]
                };
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  max_binding = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]4];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]2],
                  param[--[[ d ]]3]
                };
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  max_binding_opt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[--[[ r ]]4];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  param[--[[ v ]]2],
                  param[--[[ d ]]3]
                };
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  remove_min_binding = function(param) do
    if (param) then do
      l = param[--[[ l ]]1];
      if (l) then do
        return bal(remove_min_binding(l), param[--[[ v ]]2], param[--[[ d ]]3], param[--[[ r ]]4]);
      end else do
        return param[--[[ r ]]4];
      end end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.remove_min_elt"
      })
    end end 
  end end;
  merge = function(t1, t2) do
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
  end end;
  remove = function(x, m) do
    if (m) then do
      r = m[--[[ r ]]4];
      d = m[--[[ d ]]3];
      v = m[--[[ v ]]2];
      l = m[--[[ l ]]1];
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
  update = function(x, f, m) do
    if (m) then do
      r = m[--[[ r ]]4];
      d = m[--[[ d ]]3];
      v = m[--[[ v ]]2];
      l = m[--[[ l ]]1];
      c = Curry._2(funarg.compare, x, v);
      if (c == 0) then do
        match = Curry._1(f, Caml_option.some(d));
        if (match ~= nil) then do
          data = Caml_option.valFromOption(match);
          if (d == data) then do
            return m;
          end else do
            return --[[ Node ]]{
                    --[[ l ]]l,
                    --[[ v ]]x,
                    --[[ d ]]data,
                    --[[ r ]]r,
                    --[[ h ]]m[--[[ h ]]5]
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
      match_1 = Curry._1(f, nil);
      if (match_1 ~= nil) then do
        return --[[ Node ]]{
                --[[ l : Empty ]]0,
                --[[ v ]]x,
                --[[ d ]]Caml_option.valFromOption(match_1),
                --[[ r : Empty ]]0,
                --[[ h ]]1
              };
      end else do
        return --[[ Empty ]]0;
      end end 
    end end 
  end end;
  iter = function(f, _param) do
    while(true) do
      param = _param;
      if (param) then do
        iter(f, param[--[[ l ]]1]);
        Curry._2(f, param[--[[ v ]]2], param[--[[ d ]]3]);
        _param = param[--[[ r ]]4];
        ::continue:: ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  map = function(f, param) do
    if (param) then do
      l_prime = map(f, param[--[[ l ]]1]);
      d_prime = Curry._1(f, param[--[[ d ]]3]);
      r_prime = map(f, param[--[[ r ]]4]);
      return --[[ Node ]]{
              --[[ l ]]l_prime,
              --[[ v ]]param[--[[ v ]]2],
              --[[ d ]]d_prime,
              --[[ r ]]r_prime,
              --[[ h ]]param[--[[ h ]]5]
            };
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  mapi = function(f, param) do
    if (param) then do
      v = param[--[[ v ]]2];
      l_prime = mapi(f, param[--[[ l ]]1]);
      d_prime = Curry._2(f, v, param[--[[ d ]]3]);
      r_prime = mapi(f, param[--[[ r ]]4]);
      return --[[ Node ]]{
              --[[ l ]]l_prime,
              --[[ v ]]v,
              --[[ d ]]d_prime,
              --[[ r ]]r_prime,
              --[[ h ]]param[--[[ h ]]5]
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
        _accu = Curry._3(f, m[--[[ v ]]2], m[--[[ d ]]3], fold(f, m[--[[ l ]]1], accu));
        _m = m[--[[ r ]]4];
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
        if (Curry._2(p, param[--[[ v ]]2], param[--[[ d ]]3]) and for_all(p, param[--[[ l ]]1])) then do
          _param = param[--[[ r ]]4];
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
        if (Curry._2(p, param[--[[ v ]]2], param[--[[ d ]]3]) or exists(p, param[--[[ l ]]1])) then do
          return true;
        end else do
          _param = param[--[[ r ]]4];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  add_min_binding = function(k, x, param) do
    if (param) then do
      return bal(add_min_binding(k, x, param[--[[ l ]]1]), param[--[[ v ]]2], param[--[[ d ]]3], param[--[[ r ]]4]);
    end else do
      return singleton(k, x);
    end end 
  end end;
  add_max_binding = function(k, x, param) do
    if (param) then do
      return bal(param[--[[ l ]]1], param[--[[ v ]]2], param[--[[ d ]]3], add_max_binding(k, x, param[--[[ r ]]4]));
    end else do
      return singleton(k, x);
    end end 
  end end;
  join = function(l, v, d, r) do
    if (l) then do
      if (r) then do
        rh = r[--[[ h ]]5];
        lh = l[--[[ h ]]5];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[--[[ l ]]1], l[--[[ v ]]2], l[--[[ d ]]3], join(l[--[[ r ]]4], v, d, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, d, r[--[[ l ]]1]), r[--[[ v ]]2], r[--[[ d ]]3], r[--[[ r ]]4]);
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
      r = param[--[[ r ]]4];
      d = param[--[[ d ]]3];
      v = param[--[[ v ]]2];
      l = param[--[[ l ]]1];
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
  merge_1 = function(f, s1, s2) do
    if (s1) then do
      v1 = s1[--[[ v ]]2];
      if (s1[--[[ h ]]5] >= height(s2)) then do
        match = split(v1, s2);
        return concat_or_join(merge_1(f, s1[--[[ l ]]1], match[1]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]3]), match[2]), merge_1(f, s1[--[[ r ]]4], match[3]));
      end
       end 
    end else if (not s2) then do
      return --[[ Empty ]]0;
    end
     end  end 
    if (s2) then do
      v2 = s2[--[[ v ]]2];
      match_1 = split(v2, s1);
      return concat_or_join(merge_1(f, match_1[1], s2[--[[ l ]]1]), v2, Curry._3(f, v2, match_1[2], Caml_option.some(s2[--[[ d ]]3])), merge_1(f, match_1[3], s2[--[[ r ]]4]));
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "map.ml",
          393,
          10
        }
      })
    end end 
  end end;
  union = function(f, s1, s2) do
    if (s1) then do
      if (s2) then do
        d2 = s2[--[[ d ]]3];
        v2 = s2[--[[ v ]]2];
        d1 = s1[--[[ d ]]3];
        v1 = s1[--[[ v ]]2];
        if (s1[--[[ h ]]5] >= s2[--[[ h ]]5]) then do
          match = split(v1, s2);
          d2_1 = match[2];
          l = union(f, s1[--[[ l ]]1], match[1]);
          r = union(f, s1[--[[ r ]]4], match[3]);
          if (d2_1 ~= nil) then do
            return concat_or_join(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2_1)), r);
          end else do
            return join(l, v1, d1, r);
          end end 
        end else do
          match_1 = split(v2, s1);
          d1_1 = match_1[2];
          l_1 = union(f, match_1[1], s2[--[[ l ]]1]);
          r_1 = union(f, match_1[3], s2[--[[ r ]]4]);
          if (d1_1 ~= nil) then do
            return concat_or_join(l_1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1_1), d2), r_1);
          end else do
            return join(l_1, v2, d2, r_1);
          end end 
        end end 
      end else do
        return s1;
      end end 
    end else do
      return s2;
    end end 
  end end;
  filter = function(p, m) do
    if (m) then do
      r = m[--[[ r ]]4];
      d = m[--[[ d ]]3];
      v = m[--[[ v ]]2];
      l = m[--[[ l ]]1];
      l_prime = filter(p, l);
      pvd = Curry._2(p, v, d);
      r_prime = filter(p, r);
      if (pvd) then do
        if (l == l_prime and r == r_prime) then do
          return m;
        end else do
          return join(l_prime, v, d, r_prime);
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
      d = param[--[[ d ]]3];
      v = param[--[[ v ]]2];
      match = partition(p, param[--[[ l ]]1]);
      lf = match[2];
      lt = match[1];
      pvd = Curry._2(p, v, d);
      match_1 = partition(p, param[--[[ r ]]4]);
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
          m[--[[ v ]]2],
          m[--[[ d ]]3],
          m[--[[ r ]]4],
          e
        };
        _m = m[--[[ l ]]1];
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
          c = Curry._2(funarg.compare, e1[1], e2[1]);
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
        if (e2 and Curry._2(funarg.compare, e1[1], e2[1]) == 0 and Curry._2(cmp, e1[2], e2[2])) then do
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
      return (cardinal(param[--[[ l ]]1]) + 1 | 0) + cardinal(param[--[[ r ]]4]) | 0;
    end else do
      return 0;
    end end 
  end end;
  bindings_aux = function(_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[--[[ l ]]1];
        _accu = --[[ :: ]]{
          --[[ tuple ]]{
            param[--[[ v ]]2],
            param[--[[ d ]]3]
          },
          bindings_aux(accu, param[--[[ r ]]4])
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
          empty = --[[ Empty ]]0,
          is_empty = is_empty,
          mem = mem,
          add = add,
          update = update,
          singleton = singleton,
          remove = remove,
          merge = merge_1,
          union = union,
          compare = compare,
          equal = equal,
          iter = iter,
          fold = fold,
          for_all = for_all,
          exists = exists,
          filter = filter,
          partition = partition,
          cardinal = cardinal,
          bindings = bindings,
          min_binding = min_binding,
          min_binding_opt = min_binding_opt,
          max_binding = max_binding,
          max_binding_opt = max_binding_opt,
          choose = min_binding,
          choose_opt = min_binding_opt,
          split = split,
          find = find,
          find_opt = find_opt,
          find_first = find_first,
          find_first_opt = find_first_opt,
          find_last = find_last,
          find_last_opt = find_last_opt,
          map = map,
          mapi = mapi
        };
end end

export do
  Make ,
  
end
--[[ No side effect ]]
