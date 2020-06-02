console.log = print;

List = require "../../lib/js/list";
Curry = require "../../lib/js/curry";
Pervasives = require "../../lib/js/pervasives";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function cons_enum(_s, _e) do
  while(true) do
    e = _e;
    s = _s;
    if (s) then do
      _e = --[[ More ]]{
        s[1],
        s[2],
        e
      };
      _s = s[0];
      ::continue:: ;
    end else do
      return e;
    end end 
  end;
end end

function height(param) do
  if (param) then do
    return param[3];
  end else do
    return 0;
  end end 
end end

function min_elt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[0];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return param[1];
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_elt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[2];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return param[1];
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function is_empty(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function cardinal_aux(_acc, _param) do
  while(true) do
    param = _param;
    acc = _acc;
    if (param) then do
      _param = param[0];
      _acc = cardinal_aux(acc + 1 | 0, param[2]);
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function cardinal(s) do
  return cardinal_aux(0, s);
end end

function elements_aux(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[0];
      _accu = --[[ :: ]]{
        param[1],
        elements_aux(accu, param[2])
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function elements(s) do
  return elements_aux(--[[ [] ]]0, s);
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter(f, param[0]);
      Curry._1(f, param[1]);
      _param = param[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fold(f, _s, _accu) do
  while(true) do
    accu = _accu;
    s = _s;
    if (s) then do
      _accu = Curry._2(f, s[1], fold(f, s[0], accu));
      _s = s[2];
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
      if (Curry._1(p, param[1]) and for_all(p, param[0])) then do
        _param = param[2];
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
      if (Curry._1(p, param[1]) or exists(p, param[0])) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function max_int3(a, b, c) do
  if (a >= b) then do
    if (a >= c) then do
      return a;
    end else do
      return c;
    end end 
  end else if (b >= c) then do
    return b;
  end else do
    return c;
  end end  end 
end end

function max_int_2(a, b) do
  if (a >= b) then do
    return a;
  end else do
    return b;
  end end 
end end

Height_invariant_broken = Caml_exceptions.create("Set_gen.Height_invariant_broken");

Height_diff_borken = Caml_exceptions.create("Set_gen.Height_diff_borken");

function check_height_and_diff(param) do
  if (param) then do
    h = param[3];
    hl = check_height_and_diff(param[0]);
    hr = check_height_and_diff(param[2]);
    if (h ~= (max_int_2(hl, hr) + 1 | 0)) then do
      error(Height_invariant_broken)
    end
     end 
    diff = Pervasives.abs(hl - hr | 0);
    if (diff > 2) then do
      error(Height_diff_borken)
    end
     end 
    return h;
  end else do
    return 0;
  end end 
end end

function check(tree) do
  check_height_and_diff(tree);
  return --[[ () ]]0;
end end

function create(l, v, r) do
  hl = l and l[3] or 0;
  hr = r and r[3] or 0;
  return --[[ Node ]]{
          l,
          v,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function internal_bal(l, v, r) do
  hl = l and l[3] or 0;
  hr = r and r[3] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[2];
      lv = l[1];
      ll = l[0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) then do
        return create(create(ll, lv, lr[0]), lr[1], create(lr[2], v, r));
      end else do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "set_gen.ml",
            235,
            19
          }
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "set_gen.ml",
          225,
          15
        }
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[2];
      rv = r[1];
      rl = r[0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) then do
        return create(create(l, v, rl[0]), rl[1], create(rl[2], rv, rr));
      end else do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "set_gen.ml",
            251,
            19
          }
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "set_gen.ml",
          245,
          15
        }
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
end end

function remove_min_elt(param) do
  if (param) then do
    l = param[0];
    if (l) then do
      return internal_bal(remove_min_elt(l), param[1], param[2]);
    end else do
      return param[2];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Set.remove_min_elt"
    })
  end end 
end end

function singleton(x) do
  return --[[ Node ]]{
          --[[ Empty ]]0,
          x,
          --[[ Empty ]]0,
          1
        };
end end

function internal_merge(l, r) do
  if (l) then do
    if (r) then do
      return internal_bal(l, min_elt(r), remove_min_elt(r));
    end else do
      return l;
    end end 
  end else do
    return r;
  end end 
end end

function add_min_element(v, param) do
  if (param) then do
    return internal_bal(add_min_element(v, param[0]), param[1], param[2]);
  end else do
    return singleton(v);
  end end 
end end

function add_max_element(v, param) do
  if (param) then do
    return internal_bal(param[0], param[1], add_max_element(v, param[2]));
  end else do
    return singleton(v);
  end end 
end end

function internal_join(l, v, r) do
  if (l) then do
    if (r) then do
      rh = r[3];
      lh = l[3];
      if (lh > (rh + 2 | 0)) then do
        return internal_bal(l[0], l[1], internal_join(l[2], v, r));
      end else if (rh > (lh + 2 | 0)) then do
        return internal_bal(internal_join(l, v, r[0]), r[1], r[2]);
      end else do
        return create(l, v, r);
      end end  end 
    end else do
      return add_max_element(v, l);
    end end 
  end else do
    return add_min_element(v, r);
  end end 
end end

function internal_concat(t1, t2) do
  if (t1) then do
    if (t2) then do
      return internal_join(t1, min_elt(t2), remove_min_elt(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function filter(p, param) do
  if (param) then do
    v = param[1];
    l$prime = filter(p, param[0]);
    pv = Curry._1(p, v);
    r$prime = filter(p, param[2]);
    if (pv) then do
      return internal_join(l$prime, v, r$prime);
    end else do
      return internal_concat(l$prime, r$prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition(p, param) do
  if (param) then do
    v = param[1];
    match = partition(p, param[0]);
    lf = match[1];
    lt = match[0];
    pv = Curry._1(p, v);
    match_1 = partition(p, param[2]);
    rf = match_1[1];
    rt = match_1[0];
    if (pv) then do
      return --[[ tuple ]]{
              internal_join(lt, v, rt),
              internal_concat(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              internal_concat(lt, rt),
              internal_join(lf, v, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

function of_sorted_list(l) do
  sub = function (n, l) do
    local ___conditional___=(n);
    do
       if ___conditional___ = 0 then do
          return --[[ tuple ]]{
                  --[[ Empty ]]0,
                  l
                };end end end 
       if ___conditional___ = 1 then do
          if (l) then do
            return --[[ tuple ]]{
                    --[[ Node ]]{
                      --[[ Empty ]]0,
                      l[0],
                      --[[ Empty ]]0,
                      1
                    },
                    l[1]
                  };
          end
           end end else 
       if ___conditional___ = 2 then do
          if (l) then do
            match = l[1];
            if (match) then do
              return --[[ tuple ]]{
                      --[[ Node ]]{
                        --[[ Node ]]{
                          --[[ Empty ]]0,
                          l[0],
                          --[[ Empty ]]0,
                          1
                        },
                        match[0],
                        --[[ Empty ]]0,
                        2
                      },
                      match[1]
                    };
            end
             end 
          end
           end end else 
       if ___conditional___ = 3 then do
          if (l) then do
            match_1 = l[1];
            if (match_1) then do
              match_2 = match_1[1];
              if (match_2) then do
                return --[[ tuple ]]{
                        --[[ Node ]]{
                          --[[ Node ]]{
                            --[[ Empty ]]0,
                            l[0],
                            --[[ Empty ]]0,
                            1
                          },
                          match_1[0],
                          --[[ Node ]]{
                            --[[ Empty ]]0,
                            match_2[0],
                            --[[ Empty ]]0,
                            1
                          },
                          2
                        },
                        match_2[1]
                      };
              end
               end 
            end
             end 
          end
           end end else 
       do end end end
      else do
        end end
        
    end
    nl = n / 2 | 0;
    match_3 = sub(nl, l);
    l_1 = match_3[1];
    if (l_1) then do
      match_4 = sub((n - nl | 0) - 1 | 0, l_1[1]);
      return --[[ tuple ]]{
              create(match_3[0], l_1[0], match_4[0]),
              match_4[1]
            };
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "set_gen.ml",
          361,
          14
        }
      })
    end end 
  end end;
  return sub(List.length(l), l)[0];
end end

function of_sorted_array(l) do
  sub = function (start, n, l) do
    if (n == 0) then do
      return --[[ Empty ]]0;
    end else if (n == 1) then do
      x0 = l[start];
      return --[[ Node ]]{
              --[[ Empty ]]0,
              x0,
              --[[ Empty ]]0,
              1
            };
    end else if (n == 2) then do
      x0_1 = l[start];
      x1 = l[start + 1 | 0];
      return --[[ Node ]]{
              --[[ Node ]]{
                --[[ Empty ]]0,
                x0_1,
                --[[ Empty ]]0,
                1
              },
              x1,
              --[[ Empty ]]0,
              2
            };
    end else if (n == 3) then do
      x0_2 = l[start];
      x1_1 = l[start + 1 | 0];
      x2 = l[start + 2 | 0];
      return --[[ Node ]]{
              --[[ Node ]]{
                --[[ Empty ]]0,
                x0_2,
                --[[ Empty ]]0,
                1
              },
              x1_1,
              --[[ Node ]]{
                --[[ Empty ]]0,
                x2,
                --[[ Empty ]]0,
                1
              },
              2
            };
    end else do
      nl = n / 2 | 0;
      left = sub(start, nl, l);
      mid = start + nl | 0;
      v = l[mid];
      right = sub(mid + 1 | 0, (n - nl | 0) - 1 | 0, l);
      return create(left, v, right);
    end end  end  end  end 
  end end;
  return sub(0, #l, l);
end end

function is_ordered(cmp, tree) do
  is_ordered_min_max = function (tree) do
    if (tree) then do
      r = tree[2];
      v = tree[1];
      match = is_ordered_min_max(tree[0]);
      if (typeof match == "number") then do
        if (match >= 50834029) then do
          match_1 = is_ordered_min_max(r);
          if (typeof match_1 == "number") then do
            if (match_1 >= 50834029) then do
              return --[[ `V ]]{
                      86,
                      --[[ tuple ]]{
                        v,
                        v
                      }
                    };
            end else do
              return --[[ No ]]17505;
            end end 
          end else do
            match_2 = match_1[1];
            if (Curry._2(cmp, v, match_2[0]) < 0) then do
              return --[[ `V ]]{
                      86,
                      --[[ tuple ]]{
                        v,
                        match_2[1]
                      }
                    };
            end else do
              return --[[ No ]]17505;
            end end 
          end end 
        end else do
          return --[[ No ]]17505;
        end end 
      end else do
        match_3 = match[1];
        max_v = match_3[1];
        min_v = match_3[0];
        match_4 = is_ordered_min_max(r);
        if (typeof match_4 == "number") then do
          if (match_4 >= 50834029 and Curry._2(cmp, max_v, v) < 0) then do
            return --[[ `V ]]{
                    86,
                    --[[ tuple ]]{
                      min_v,
                      v
                    }
                  };
          end else do
            return --[[ No ]]17505;
          end end 
        end else do
          match_5 = match_4[1];
          if (Curry._2(cmp, max_v, match_5[0]) < 0) then do
            return --[[ `V ]]{
                    86,
                    --[[ tuple ]]{
                      min_v,
                      match_5[1]
                    }
                  };
          end else do
            return --[[ No ]]17505;
          end end 
        end end 
      end end 
    end else do
      return --[[ Empty ]]50834029;
    end end 
  end end;
  return is_ordered_min_max(tree) ~= --[[ No ]]17505;
end end

function invariant(cmp, t) do
  check_height_and_diff(t);
  return is_ordered(cmp, t);
end end

function compare_aux(cmp, _e1, _e2) do
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Curry._2(cmp, e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          _e2 = cons_enum(e2[1], e2[2]);
          _e1 = cons_enum(e1[1], e1[2]);
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
end end

function compare(cmp, s1, s2) do
  return compare_aux(cmp, cons_enum(s1, --[[ End ]]0), cons_enum(s2, --[[ End ]]0));
end end

empty = --[[ Empty ]]0;

choose = min_elt;

exports.cons_enum = cons_enum;
exports.height = height;
exports.min_elt = min_elt;
exports.max_elt = max_elt;
exports.empty = empty;
exports.is_empty = is_empty;
exports.cardinal_aux = cardinal_aux;
exports.cardinal = cardinal;
exports.elements_aux = elements_aux;
exports.elements = elements;
exports.choose = choose;
exports.iter = iter;
exports.fold = fold;
exports.for_all = for_all;
exports.exists = exists;
exports.max_int3 = max_int3;
exports.max_int_2 = max_int_2;
exports.Height_invariant_broken = Height_invariant_broken;
exports.Height_diff_borken = Height_diff_borken;
exports.check_height_and_diff = check_height_and_diff;
exports.check = check;
exports.create = create;
exports.internal_bal = internal_bal;
exports.remove_min_elt = remove_min_elt;
exports.singleton = singleton;
exports.internal_merge = internal_merge;
exports.add_min_element = add_min_element;
exports.add_max_element = add_max_element;
exports.internal_join = internal_join;
exports.internal_concat = internal_concat;
exports.filter = filter;
exports.partition = partition;
exports.of_sorted_list = of_sorted_list;
exports.of_sorted_array = of_sorted_array;
exports.is_ordered = is_ordered;
exports.invariant = invariant;
exports.compare_aux = compare_aux;
exports.compare = compare;
--[[ No side effect ]]
