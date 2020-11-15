__console = {log = print};

List = require "......lib.js.list";
Curry = require "......lib.js.curry";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function Make(Ord) do
  height = function(param) do
    if (param) then do
      return param[4];
    end else do
      return 0;
    end end 
  end end;
  create = function(l, v, r) do
    hl = l and l[4] or 0;
    hr = r and r[4] or 0;
    return --[[ Node ]]{
            l,
            v,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end;
  bal = function(l, v, r) do
    hl = l and l[4] or 0;
    hr = r and r[4] or 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        lr = l[3];
        lv = l[2];
        ll = l[1];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, create(lr, v, r));
        end else if (lr) then do
          return create(create(ll, lv, lr[1]), lr[2], create(lr[3], v, r));
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
        rr = r[3];
        rv = r[2];
        rl = r[1];
        if (height(rr) >= height(rl)) then do
          return create(create(l, v, rl), rv, rr);
        end else if (rl) then do
          return create(create(l, v, rl[1]), rl[2], create(rl[3], rv, rr));
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
              l,
              v,
              r,
              hl >= hr and hl + 1 | 0 or hr + 1 | 0
            };
    end end  end 
  end end;
  add = function(x, t) do
    if (t) then do
      r = t[3];
      v = t[2];
      l = t[1];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return t;
      end else if (c < 0) then do
        return bal(add(x, l), v, r);
      end else do
        return bal(l, v, add(x, r));
      end end  end 
    end else do
      return --[[ Node ]]{
              --[[ Empty ]]0,
              x,
              --[[ Empty ]]0,
              1
            };
    end end 
  end end;
  singleton = function(x) do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            --[[ Empty ]]0,
            1
          };
  end end;
  add_min_element = function(v, param) do
    if (param) then do
      return bal(add_min_element(v, param[1]), param[2], param[3]);
    end else do
      return singleton(v);
    end end 
  end end;
  add_max_element = function(v, param) do
    if (param) then do
      return bal(param[1], param[2], add_max_element(v, param[3]));
    end else do
      return singleton(v);
    end end 
  end end;
  join = function(l, v, r) do
    if (l) then do
      if (r) then do
        rh = r[4];
        lh = l[4];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[1], l[2], join(l[3], v, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, r[1]), r[2], r[3]);
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
        l = param[1];
        if (l) then do
          _param = l;
          ::continue:: ;
        end else do
          return param[2];
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  max_elt = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        r = param[3];
        if (r) then do
          _param = r;
          ::continue:: ;
        end else do
          return param[2];
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  remove_min_elt = function(param) do
    if (param) then do
      l = param[1];
      if (l) then do
        return bal(remove_min_elt(l), param[2], param[3]);
      end else do
        return param[3];
      end end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.remove_min_elt"
      })
    end end 
  end end;
  merge = function(t1, t2) do
    if (t1) then do
      if (t2) then do
        return bal(t1, min_elt(t2), remove_min_elt(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
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
      r = param[3];
      v = param[2];
      l = param[1];
      c = Curry._2(Ord.compare, x, v);
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
        c = Curry._2(Ord.compare, x, param[2]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 and param[1] or param[3];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  remove = function(x, param) do
    if (param) then do
      r = param[3];
      v = param[2];
      l = param[1];
      c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return merge(l, r);
      end else if (c < 0) then do
        return bal(remove(x, l), v, r);
      end else do
        return bal(l, v, remove(x, r));
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  union = function(s1, s2) do
    if (s1) then do
      if (s2) then do
        h2 = s2[4];
        v2 = s2[2];
        h1 = s1[4];
        v1 = s1[2];
        if (h1 >= h2) then do
          if (h2 == 1) then do
            return add(v2, s1);
          end else do
            match = split(v1, s2);
            return join(union(s1[1], match[1]), v1, union(s1[3], match[3]));
          end end 
        end else if (h1 == 1) then do
          return add(v1, s2);
        end else do
          match_1 = split(v2, s1);
          return join(union(match_1[1], s2[1]), v2, union(match_1[3], s2[3]));
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
      r1 = s1[3];
      v1 = s1[2];
      l1 = s1[1];
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
        r1 = s1[3];
        v1 = s1[2];
        l1 = s1[1];
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
          s[2],
          s[3],
          e
        };
        _s = s[1];
        ::continue:: ;
      end else do
        return e;
      end end 
    end;
  end end;
  compare_aux = function(_e1, _e2) do
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1) then do
        if (e2) then do
          c = Curry._2(Ord.compare, e1[1], e2[1]);
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
  compare = function(s1, s2) do
    return compare_aux(cons_enum(s1, --[[ End ]]0), cons_enum(s2, --[[ End ]]0));
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
          r2 = s2[3];
          l2 = s2[1];
          r1 = s1[3];
          v1 = s1[2];
          l1 = s1[1];
          c = Curry._2(Ord.compare, v1, s2[2]);
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
                    l1,
                    v1,
                    --[[ Empty ]]0,
                    0
                  }, l2)) then do
              _s1 = r1;
              ::continue:: ;
            end else do
              return false;
            end end 
          end else if (subset(--[[ Node ]]{
                  --[[ Empty ]]0,
                  v1,
                  r1,
                  0
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
        iter(f, param[1]);
        Curry._1(f, param[2]);
        _param = param[3];
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
        _accu = Curry._2(f, s[2], fold(f, s[1], accu));
        _s = s[3];
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
        if (Curry._1(p, param[2]) and for_all(p, param[1])) then do
          _param = param[3];
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
        if (Curry._1(p, param[2]) or exists(p, param[1])) then do
          return true;
        end else do
          _param = param[3];
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  filter = function(p, param) do
    if (param) then do
      v = param[2];
      l_prime = filter(p, param[1]);
      pv = Curry._1(p, v);
      r_prime = filter(p, param[3]);
      if (pv) then do
        return join(l_prime, v, r_prime);
      end else do
        return concat(l_prime, r_prime);
      end end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end end;
  partition = function(p, param) do
    if (param) then do
      v = param[2];
      match = partition(p, param[1]);
      lf = match[2];
      lt = match[1];
      pv = Curry._1(p, v);
      match_1 = partition(p, param[3]);
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
      return (cardinal(param[1]) + 1 | 0) + cardinal(param[3]) | 0;
    end else do
      return 0;
    end end 
  end end;
  elements_aux = function(_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[1];
        _accu = --[[ :: ]]{
          param[2],
          elements_aux(accu, param[3])
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
        v = param[2];
        c = Curry._2(Ord.compare, x, v);
        if (c == 0) then do
          return v;
        end else do
          _param = c < 0 and param[1] or param[3];
          ::continue:: ;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end 
    end;
  end end;
  of_sorted_list = function(l) do
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
                        --[[ Empty ]]0,
                        l[1],
                        --[[ Empty ]]0,
                        1
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
                          --[[ Node ]]{
                            --[[ Empty ]]0,
                            l[1],
                            --[[ Empty ]]0,
                            1
                          },
                          match[1],
                          --[[ Empty ]]0,
                          2
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
                            --[[ Node ]]{
                              --[[ Empty ]]0,
                              l[1],
                              --[[ Empty ]]0,
                              1
                            },
                            match_1[1],
                            --[[ Node ]]{
                              --[[ Empty ]]0,
                              match_2[1],
                              --[[ Empty ]]0,
                              1
                            },
                            2
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
            "test_set.ml",
            372,
            18
          }
        })
      end end 
    end end;
    return sub(List.length(l), l)[1];
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
                return of_sorted_list(List.sort_uniq(Ord.compare, l));
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
          height = height,
          create = create,
          bal = bal,
          add = add,
          singleton = singleton,
          add_min_element = add_min_element,
          add_max_element = add_max_element,
          join = join,
          min_elt = min_elt,
          max_elt = max_elt,
          remove_min_elt = remove_min_elt,
          merge = merge,
          concat = concat,
          split = split,
          empty = --[[ Empty ]]0,
          is_empty = is_empty,
          mem = mem,
          remove = remove,
          union = union,
          inter = inter,
          diff = diff,
          cons_enum = cons_enum,
          compare_aux = compare_aux,
          compare = compare,
          equal = equal,
          subset = subset,
          iter = iter,
          fold = fold,
          for_all = for_all,
          exists = exists,
          filter = filter,
          partition = partition,
          cardinal = cardinal,
          elements_aux = elements_aux,
          elements = elements,
          choose = min_elt,
          find = find,
          of_sorted_list = of_sorted_list,
          of_list = of_list
        };
end end

N = {
  a = 3
};

exports = {};
exports.Make = Make;
exports.N = N;
return exports;
--[[ No side effect ]]
