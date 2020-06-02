console.log = print;

Obj = require "../../lib/js/obj";
Sys = require "../../lib/js/sys";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Curry = require "../../lib/js/curry";
Caml_oo = require "../../lib/js/caml_oo";
Caml_obj = require "../../lib/js/caml_obj";
Caml_array = require "../../lib/js/caml_array";
Caml_int32 = require "../../lib/js/caml_int32";
Caml_option = require "../../lib/js/caml_option";
Caml_string = require "../../lib/js/caml_string";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function copy(o) do
  return Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(o));
end end

params = do
  compact_table: true,
  copy_parent: true,
  clean_when_copying: true,
  retry_count: 3,
  bucket_small_size: 16
end;

step = Sys.word_size / 16 | 0;

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

function height(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function singleton(x, d) do
  return --[[ Node ]]{
          --[[ l : Empty ]]0,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r : Empty ]]0,
          --[[ h ]]1
        };
end end

function bal(l, x, d, r) do
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
      rr = r[--[[ r ]]3];
      rd = r[--[[ d ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create(rl[--[[ r ]]3], rv, rd, rr));
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
end end

function is_empty(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return param[--[[ d ]]2];
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_opt(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_last(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_last_opt(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_opt(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return Caml_option.some(param[--[[ d ]]2]);
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
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
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function min_binding_opt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
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
end end

function max_binding(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_binding_opt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
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
end end

function remove_min_binding(param) do
  if (param) then do
    l = param[--[[ l ]]0];
    if (l) then do
      return bal(remove_min_binding(l), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
    end else do
      return param[--[[ r ]]3];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Map.remove_min_elt"
    })
  end end 
end end

function merge(t1, t2) do
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
end end

function remove(x, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
end end

function update(x, f, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
    match_1 = Curry._1(f, undefined);
    if (match_1 ~= undefined) then do
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
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter(f, param[--[[ l ]]0]);
      Curry._2(f, param[--[[ v ]]1], param[--[[ d ]]2]);
      _param = param[--[[ r ]]3];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map(f, param) do
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
end end

function mapi(f, param) do
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
end end

function fold(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[[ v ]]1], m[--[[ d ]]2], fold(f, m[--[[ l ]]0], accu));
      _m = m[--[[ r ]]3];
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
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) and for_all(p, param[--[[ l ]]0])) then do
        _param = param[--[[ r ]]3];
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
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) or exists(p, param[--[[ l ]]0])) then do
        return true;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding(k, x, param) do
  if (param) then do
    return bal(add_min_binding(k, x, param[--[[ l ]]0]), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
  end else do
    return singleton(k, x);
  end end 
end end

function add_max_binding(k, x, param) do
  if (param) then do
    return bal(param[--[[ l ]]0], param[--[[ v ]]1], param[--[[ d ]]2], add_max_binding(k, x, param[--[[ r ]]3]));
  end else do
    return singleton(k, x);
  end end 
end end

function join(l, v, d, r) do
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
    r = param[--[[ r ]]3];
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    l = param[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
      match_1 = split(x, r);
      return --[[ tuple ]]{
              join(l, v, d, match_1[0]),
              match_1[1],
              match_1[2]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            undefined,
            --[[ Empty ]]0
          };
  end end 
end end

function merge_1(f, s1, s2) do
  if (s1) then do
    v1 = s1[--[[ v ]]1];
    if (s1[--[[ h ]]4] >= height(s2)) then do
      match = split(v1, s2);
      return concat_or_join(merge_1(f, s1[--[[ l ]]0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]2]), match[1]), merge_1(f, s1[--[[ r ]]3], match[2]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[--[[ v ]]1];
    match_1 = split(v2, s1);
    return concat_or_join(merge_1(f, match_1[0], s2[--[[ l ]]0]), v2, Curry._3(f, v2, match_1[1], Caml_option.some(s2[--[[ d ]]2])), merge_1(f, match_1[2], s2[--[[ r ]]3]));
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
end end

function union(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      d2 = s2[--[[ d ]]2];
      v2 = s2[--[[ v ]]1];
      d1 = s1[--[[ d ]]2];
      v1 = s1[--[[ v ]]1];
      if (s1[--[[ h ]]4] >= s2[--[[ h ]]4]) then do
        match = split(v1, s2);
        d2_1 = match[1];
        l = union(f, s1[--[[ l ]]0], match[0]);
        r = union(f, s1[--[[ r ]]3], match[2]);
        if (d2_1 ~= undefined) then do
          return concat_or_join(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2_1)), r);
        end else do
          return join(l, v1, d1, r);
        end end 
      end else do
        match_1 = split(v2, s1);
        d1_1 = match_1[1];
        l_1 = union(f, match_1[0], s2[--[[ l ]]0]);
        r_1 = union(f, match_1[2], s2[--[[ r ]]3]);
        if (d1_1 ~= undefined) then do
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
end end

function filter(p, m) do
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
end end

function partition(p, param) do
  if (param) then do
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    match = partition(p, param[--[[ l ]]0]);
    lf = match[1];
    lt = match[0];
    pvd = Curry._2(p, v, d);
    match_1 = partition(p, param[--[[ r ]]3]);
    rf = match_1[1];
    rt = match_1[0];
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
        m[--[[ v ]]1],
        m[--[[ d ]]2],
        m[--[[ r ]]3],
        e
      };
      _m = m[--[[ l ]]0];
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
        c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[1], e2[1]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum(e2[2], e2[3]);
            _e1 = cons_enum(e1[2], e1[3]);
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
      if (e2 and Caml_primitive.caml_string_compare(e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum(e2[2], e2[3]);
        _e1 = cons_enum(e1[2], e1[3]);
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
    return (cardinal(param[--[[ l ]]0]) + 1 | 0) + cardinal(param[--[[ r ]]3]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux(_accu, _param) do
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
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings(s) do
  return bindings_aux(--[[ [] ]]0, s);
end end

Vars = do
  empty: --[[ Empty ]]0,
  is_empty: is_empty,
  mem: mem,
  add: add,
  update: update,
  singleton: singleton,
  remove: remove,
  merge: merge_1,
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

function height_1(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create_1(l, x, d, r) do
  hl = height_1(l);
  hr = height_1(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function singleton_1(x, d) do
  return --[[ Node ]]{
          --[[ l : Empty ]]0,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r : Empty ]]0,
          --[[ h ]]1
        };
end end

function bal_1(l, x, d, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      ld = l[--[[ d ]]2];
      lv = l[--[[ v ]]1];
      ll = l[--[[ l ]]0];
      if (height_1(ll) >= height_1(lr)) then do
        return create_1(ll, lv, ld, create_1(lr, x, d, r));
      end else if (lr) then do
        return create_1(create_1(ll, lv, ld, lr[--[[ l ]]0]), lr[--[[ v ]]1], lr[--[[ d ]]2], create_1(lr[--[[ r ]]3], x, d, r));
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
      rr = r[--[[ r ]]3];
      rd = r[--[[ d ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height_1(rr) >= height_1(rl)) then do
        return create_1(create_1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create_1(create_1(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create_1(rl[--[[ r ]]3], rv, rd, rr));
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
end end

function is_empty_1(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add_1(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
      ll = add_1(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_1(ll, v, d, r);
      end end 
    end else do
      rr = add_1(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_1(l, v, d, rr);
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
end end

function find_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return param[--[[ d ]]2];
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_opt_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_last_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_last_opt_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_opt_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return Caml_option.some(param[--[[ d ]]2]);
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function mem_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
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
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function min_binding_opt_1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
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
end end

function max_binding_1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_binding_opt_1(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
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
end end

function remove_min_binding_1(param) do
  if (param) then do
    l = param[--[[ l ]]0];
    if (l) then do
      return bal_1(remove_min_binding_1(l), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
    end else do
      return param[--[[ r ]]3];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Map.remove_min_elt"
    })
  end end 
end end

function merge_2(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding_1(t2);
      return bal_1(t1, match[0], match[1], remove_min_binding_1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function remove_1(x, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return merge_2(l, r);
    end else if (c < 0) then do
      ll = remove_1(x, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_1(ll, v, d, r);
      end end 
    end else do
      rr = remove_1(x, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function update_1(x, f, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_string_compare(x, v);
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
        return merge_2(l, r);
      end end 
    end else if (c < 0) then do
      ll = update_1(x, f, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_1(ll, v, d, r);
      end end 
    end else do
      rr = update_1(x, f, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    match_1 = Curry._1(f, undefined);
    if (match_1 ~= undefined) then do
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
end end

function iter_1(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter_1(f, param[--[[ l ]]0]);
      Curry._2(f, param[--[[ v ]]1], param[--[[ d ]]2]);
      _param = param[--[[ r ]]3];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map_1(f, param) do
  if (param) then do
    l$prime = map_1(f, param[--[[ l ]]0]);
    d$prime = Curry._1(f, param[--[[ d ]]2]);
    r$prime = map_1(f, param[--[[ r ]]3]);
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
end end

function mapi_1(f, param) do
  if (param) then do
    v = param[--[[ v ]]1];
    l$prime = mapi_1(f, param[--[[ l ]]0]);
    d$prime = Curry._2(f, v, param[--[[ d ]]2]);
    r$prime = mapi_1(f, param[--[[ r ]]3]);
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
end end

function fold_1(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[[ v ]]1], m[--[[ d ]]2], fold_1(f, m[--[[ l ]]0], accu));
      _m = m[--[[ r ]]3];
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
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) and for_all_1(p, param[--[[ l ]]0])) then do
        _param = param[--[[ r ]]3];
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
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) or exists_1(p, param[--[[ l ]]0])) then do
        return true;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding_1(k, x, param) do
  if (param) then do
    return bal_1(add_min_binding_1(k, x, param[--[[ l ]]0]), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
  end else do
    return singleton_1(k, x);
  end end 
end end

function add_max_binding_1(k, x, param) do
  if (param) then do
    return bal_1(param[--[[ l ]]0], param[--[[ v ]]1], param[--[[ d ]]2], add_max_binding_1(k, x, param[--[[ r ]]3]));
  end else do
    return singleton_1(k, x);
  end end 
end end

function join_1(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[--[[ h ]]4];
      lh = l[--[[ h ]]4];
      if (lh > (rh + 2 | 0)) then do
        return bal_1(l[--[[ l ]]0], l[--[[ v ]]1], l[--[[ d ]]2], join_1(l[--[[ r ]]3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal_1(join_1(l, v, d, r[--[[ l ]]0]), r[--[[ v ]]1], r[--[[ d ]]2], r[--[[ r ]]3]);
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
      return join_1(t1, match[0], match[1], remove_min_binding_1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join_1(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join_1(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat_1(t1, t2);
  end end 
end end

function split_1(x, param) do
  if (param) then do
    r = param[--[[ r ]]3];
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    l = param[--[[ l ]]0];
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
              match[0],
              match[1],
              join_1(match[2], v, d, r)
            };
    end else do
      match_1 = split_1(x, r);
      return --[[ tuple ]]{
              join_1(l, v, d, match_1[0]),
              match_1[1],
              match_1[2]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            undefined,
            --[[ Empty ]]0
          };
  end end 
end end

function merge_3(f, s1, s2) do
  if (s1) then do
    v1 = s1[--[[ v ]]1];
    if (s1[--[[ h ]]4] >= height_1(s2)) then do
      match = split_1(v1, s2);
      return concat_or_join_1(merge_3(f, s1[--[[ l ]]0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]2]), match[1]), merge_3(f, s1[--[[ r ]]3], match[2]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[--[[ v ]]1];
    match_1 = split_1(v2, s1);
    return concat_or_join_1(merge_3(f, match_1[0], s2[--[[ l ]]0]), v2, Curry._3(f, v2, match_1[1], Caml_option.some(s2[--[[ d ]]2])), merge_3(f, match_1[2], s2[--[[ r ]]3]));
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
end end

function union_1(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      d2 = s2[--[[ d ]]2];
      v2 = s2[--[[ v ]]1];
      d1 = s1[--[[ d ]]2];
      v1 = s1[--[[ v ]]1];
      if (s1[--[[ h ]]4] >= s2[--[[ h ]]4]) then do
        match = split_1(v1, s2);
        d2_1 = match[1];
        l = union_1(f, s1[--[[ l ]]0], match[0]);
        r = union_1(f, s1[--[[ r ]]3], match[2]);
        if (d2_1 ~= undefined) then do
          return concat_or_join_1(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2_1)), r);
        end else do
          return join_1(l, v1, d1, r);
        end end 
      end else do
        match_1 = split_1(v2, s1);
        d1_1 = match_1[1];
        l_1 = union_1(f, match_1[0], s2[--[[ l ]]0]);
        r_1 = union_1(f, match_1[2], s2[--[[ r ]]3]);
        if (d1_1 ~= undefined) then do
          return concat_or_join_1(l_1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1_1), d2), r_1);
        end else do
          return join_1(l_1, v2, d2, r_1);
        end end 
      end end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function filter_1(p, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    l$prime = filter_1(p, l);
    pvd = Curry._2(p, v, d);
    r$prime = filter_1(p, r);
    if (pvd) then do
      if (l == l$prime and r == r$prime) then do
        return m;
      end else do
        return join_1(l$prime, v, d, r$prime);
      end end 
    end else do
      return concat_1(l$prime, r$prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition_1(p, param) do
  if (param) then do
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    match = partition_1(p, param[--[[ l ]]0]);
    lf = match[1];
    lt = match[0];
    pvd = Curry._2(p, v, d);
    match_1 = partition_1(p, param[--[[ r ]]3]);
    rf = match_1[1];
    rt = match_1[0];
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
        m[--[[ v ]]1],
        m[--[[ d ]]2],
        m[--[[ r ]]3],
        e
      };
      _m = m[--[[ l ]]0];
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
        c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[1], e2[1]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum_1(e2[2], e2[3]);
            _e1 = cons_enum_1(e1[2], e1[3]);
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
      if (e2 and Caml_primitive.caml_string_compare(e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum_1(e2[2], e2[3]);
        _e1 = cons_enum_1(e1[2], e1[3]);
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
    return (cardinal_1(param[--[[ l ]]0]) + 1 | 0) + cardinal_1(param[--[[ r ]]3]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux_1(_accu, _param) do
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
        bindings_aux_1(accu, param[--[[ r ]]3])
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

Meths = do
  empty: --[[ Empty ]]0,
  is_empty: is_empty_1,
  mem: mem_1,
  add: add_1,
  update: update_1,
  singleton: singleton_1,
  remove: remove_1,
  merge: merge_3,
  union: union_1,
  compare: compare_1,
  equal: equal_1,
  iter: iter_1,
  fold: fold_1,
  for_all: for_all_1,
  exists: exists_1,
  filter: filter_1,
  partition: partition_1,
  cardinal: cardinal_1,
  bindings: bindings_1,
  min_binding: min_binding_1,
  min_binding_opt: min_binding_opt_1,
  max_binding: max_binding_1,
  max_binding_opt: max_binding_opt_1,
  choose: min_binding_1,
  choose_opt: min_binding_opt_1,
  split: split_1,
  find: find_1,
  find_opt: find_opt_1,
  find_first: find_first_1,
  find_first_opt: find_first_opt_1,
  find_last: find_last_1,
  find_last_opt: find_last_opt_1,
  map: map_1,
  mapi: mapi_1
end;

function height_2(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create_2(l, x, d, r) do
  hl = height_2(l);
  hr = height_2(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function singleton_2(x, d) do
  return --[[ Node ]]{
          --[[ l : Empty ]]0,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r : Empty ]]0,
          --[[ h ]]1
        };
end end

function bal_2(l, x, d, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      ld = l[--[[ d ]]2];
      lv = l[--[[ v ]]1];
      ll = l[--[[ l ]]0];
      if (height_2(ll) >= height_2(lr)) then do
        return create_2(ll, lv, ld, create_2(lr, x, d, r));
      end else if (lr) then do
        return create_2(create_2(ll, lv, ld, lr[--[[ l ]]0]), lr[--[[ v ]]1], lr[--[[ d ]]2], create_2(lr[--[[ r ]]3], x, d, r));
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
      rr = r[--[[ r ]]3];
      rd = r[--[[ d ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height_2(rr) >= height_2(rl)) then do
        return create_2(create_2(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create_2(create_2(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create_2(rl[--[[ r ]]3], rv, rd, rr));
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
end end

function is_empty_2(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function add_2(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_int_compare(x, v);
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
      ll = add_2(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_2(ll, v, d, r);
      end end 
    end else do
      rr = add_2(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_2(l, v, d, rr);
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
end end

function find_2(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return param[--[[ d ]]2];
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_2(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_opt_2(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ l ]]0];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]0];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
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
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_last_2(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_last_opt_2(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]1];
      if (Curry._1(f, v)) then do
        _v0 = v;
        _d0 = param[--[[ d ]]2];
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          d0 = _d0;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]1];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _d0 = param_1[--[[ d ]]2];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]0];
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
        _param = param[--[[ l ]]0];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_opt_2(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return Caml_option.some(param[--[[ d ]]2]);
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function mem_2(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function min_binding_2(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function min_binding_opt_2(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]0];
      if (l) then do
        _param = l;
        ::continue:: ;
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
end end

function max_binding_2(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return --[[ tuple ]]{
                param[--[[ v ]]1],
                param[--[[ d ]]2]
              };
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_binding_opt_2(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
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
end end

function remove_min_binding_2(param) do
  if (param) then do
    l = param[--[[ l ]]0];
    if (l) then do
      return bal_2(remove_min_binding_2(l), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
    end else do
      return param[--[[ r ]]3];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Map.remove_min_elt"
    })
  end end 
end end

function merge_4(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding_2(t2);
      return bal_2(t1, match[0], match[1], remove_min_binding_2(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function remove_2(x, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return merge_4(l, r);
    end else if (c < 0) then do
      ll = remove_2(x, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_2(ll, v, d, r);
      end end 
    end else do
      rr = remove_2(x, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function update_2(x, f, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = Caml_primitive.caml_int_compare(x, v);
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
        return merge_4(l, r);
      end end 
    end else if (c < 0) then do
      ll = update_2(x, f, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_2(ll, v, d, r);
      end end 
    end else do
      rr = update_2(x, f, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    match_1 = Curry._1(f, undefined);
    if (match_1 ~= undefined) then do
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
end end

function iter_2(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter_2(f, param[--[[ l ]]0]);
      Curry._2(f, param[--[[ v ]]1], param[--[[ d ]]2]);
      _param = param[--[[ r ]]3];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function map_2(f, param) do
  if (param) then do
    l$prime = map_2(f, param[--[[ l ]]0]);
    d$prime = Curry._1(f, param[--[[ d ]]2]);
    r$prime = map_2(f, param[--[[ r ]]3]);
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
end end

function mapi_2(f, param) do
  if (param) then do
    v = param[--[[ v ]]1];
    l$prime = mapi_2(f, param[--[[ l ]]0]);
    d$prime = Curry._2(f, v, param[--[[ d ]]2]);
    r$prime = mapi_2(f, param[--[[ r ]]3]);
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
end end

function fold_2(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[[ v ]]1], m[--[[ d ]]2], fold_2(f, m[--[[ l ]]0], accu));
      _m = m[--[[ r ]]3];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all_2(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) and for_all_2(p, param[--[[ l ]]0])) then do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists_2(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._2(p, param[--[[ v ]]1], param[--[[ d ]]2]) or exists_2(p, param[--[[ l ]]0])) then do
        return true;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function add_min_binding_2(k, x, param) do
  if (param) then do
    return bal_2(add_min_binding_2(k, x, param[--[[ l ]]0]), param[--[[ v ]]1], param[--[[ d ]]2], param[--[[ r ]]3]);
  end else do
    return singleton_2(k, x);
  end end 
end end

function add_max_binding_2(k, x, param) do
  if (param) then do
    return bal_2(param[--[[ l ]]0], param[--[[ v ]]1], param[--[[ d ]]2], add_max_binding_2(k, x, param[--[[ r ]]3]));
  end else do
    return singleton_2(k, x);
  end end 
end end

function join_2(l, v, d, r) do
  if (l) then do
    if (r) then do
      rh = r[--[[ h ]]4];
      lh = l[--[[ h ]]4];
      if (lh > (rh + 2 | 0)) then do
        return bal_2(l[--[[ l ]]0], l[--[[ v ]]1], l[--[[ d ]]2], join_2(l[--[[ r ]]3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal_2(join_2(l, v, d, r[--[[ l ]]0]), r[--[[ v ]]1], r[--[[ d ]]2], r[--[[ r ]]3]);
      end else do
        return create_2(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding_2(v, d, l);
    end end 
  end else do
    return add_min_binding_2(v, d, r);
  end end 
end end

function concat_2(t1, t2) do
  if (t1) then do
    if (t2) then do
      match = min_binding_2(t2);
      return join_2(t1, match[0], match[1], remove_min_binding_2(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function concat_or_join_2(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join_2(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat_2(t1, t2);
  end end 
end end

function split_2(x, param) do
  if (param) then do
    r = param[--[[ r ]]3];
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    l = param[--[[ l ]]0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]]{
              l,
              Caml_option.some(d),
              r
            };
    end else if (c < 0) then do
      match = split_2(x, l);
      return --[[ tuple ]]{
              match[0],
              match[1],
              join_2(match[2], v, d, r)
            };
    end else do
      match_1 = split_2(x, r);
      return --[[ tuple ]]{
              join_2(l, v, d, match_1[0]),
              match_1[1],
              match_1[2]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            undefined,
            --[[ Empty ]]0
          };
  end end 
end end

function merge_5(f, s1, s2) do
  if (s1) then do
    v1 = s1[--[[ v ]]1];
    if (s1[--[[ h ]]4] >= height_2(s2)) then do
      match = split_2(v1, s2);
      return concat_or_join_2(merge_5(f, s1[--[[ l ]]0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]2]), match[1]), merge_5(f, s1[--[[ r ]]3], match[2]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[--[[ v ]]1];
    match_1 = split_2(v2, s1);
    return concat_or_join_2(merge_5(f, match_1[0], s2[--[[ l ]]0]), v2, Curry._3(f, v2, match_1[1], Caml_option.some(s2[--[[ d ]]2])), merge_5(f, match_1[2], s2[--[[ r ]]3]));
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
end end

function union_2(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      d2 = s2[--[[ d ]]2];
      v2 = s2[--[[ v ]]1];
      d1 = s1[--[[ d ]]2];
      v1 = s1[--[[ v ]]1];
      if (s1[--[[ h ]]4] >= s2[--[[ h ]]4]) then do
        match = split_2(v1, s2);
        d2_1 = match[1];
        l = union_2(f, s1[--[[ l ]]0], match[0]);
        r = union_2(f, s1[--[[ r ]]3], match[2]);
        if (d2_1 ~= undefined) then do
          return concat_or_join_2(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2_1)), r);
        end else do
          return join_2(l, v1, d1, r);
        end end 
      end else do
        match_1 = split_2(v2, s1);
        d1_1 = match_1[1];
        l_1 = union_2(f, match_1[0], s2[--[[ l ]]0]);
        r_1 = union_2(f, match_1[2], s2[--[[ r ]]3]);
        if (d1_1 ~= undefined) then do
          return concat_or_join_2(l_1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1_1), d2), r_1);
        end else do
          return join_2(l_1, v2, d2, r_1);
        end end 
      end end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function filter_2(p, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    l$prime = filter_2(p, l);
    pvd = Curry._2(p, v, d);
    r$prime = filter_2(p, r);
    if (pvd) then do
      if (l == l$prime and r == r$prime) then do
        return m;
      end else do
        return join_2(l$prime, v, d, r$prime);
      end end 
    end else do
      return concat_2(l$prime, r$prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition_2(p, param) do
  if (param) then do
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    match = partition_2(p, param[--[[ l ]]0]);
    lf = match[1];
    lt = match[0];
    pvd = Curry._2(p, v, d);
    match_1 = partition_2(p, param[--[[ r ]]3]);
    rf = match_1[1];
    rt = match_1[0];
    if (pvd) then do
      return --[[ tuple ]]{
              join_2(lt, v, d, rt),
              concat_2(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              concat_2(lt, rt),
              join_2(lf, v, d, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

function cons_enum_2(_m, _e) do
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
      ::continue:: ;
    end else do
      return e;
    end end 
  end;
end end

function compare_2(cmp, m1, m2) do
  _e1 = cons_enum_2(m1, --[[ End ]]0);
  _e2 = cons_enum_2(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_int_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[1], e2[1]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum_2(e2[2], e2[3]);
            _e1 = cons_enum_2(e1[2], e1[3]);
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

function equal_2(cmp, m1, m2) do
  _e1 = cons_enum_2(m1, --[[ End ]]0);
  _e2 = cons_enum_2(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2 and e1[0] == e2[0] and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum_2(e2[2], e2[3]);
        _e1 = cons_enum_2(e1[2], e1[3]);
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

function cardinal_2(param) do
  if (param) then do
    return (cardinal_2(param[--[[ l ]]0]) + 1 | 0) + cardinal_2(param[--[[ r ]]3]) | 0;
  end else do
    return 0;
  end end 
end end

function bindings_aux_2(_accu, _param) do
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
        bindings_aux_2(accu, param[--[[ r ]]3])
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function bindings_2(s) do
  return bindings_aux_2(--[[ [] ]]0, s);
end end

Labs = do
  empty: --[[ Empty ]]0,
  is_empty: is_empty_2,
  mem: mem_2,
  add: add_2,
  update: update_2,
  singleton: singleton_2,
  remove: remove_2,
  merge: merge_5,
  union: union_2,
  compare: compare_2,
  equal: equal_2,
  iter: iter_2,
  fold: fold_2,
  for_all: for_all_2,
  exists: exists_2,
  filter: filter_2,
  partition: partition_2,
  cardinal: cardinal_2,
  bindings: bindings_2,
  min_binding: min_binding_2,
  min_binding_opt: min_binding_opt_2,
  max_binding: max_binding_2,
  max_binding_opt: max_binding_opt_2,
  choose: min_binding_2,
  choose_opt: min_binding_opt_2,
  split: split_2,
  find: find_2,
  find_opt: find_opt_2,
  find_first: find_first_2,
  find_first_opt: find_first_opt_2,
  find_last: find_last_2,
  find_last_opt: find_last_opt_2,
  map: map_2,
  mapi: mapi_2
end;

dummy_table = do
  size: 0,
  methods: {--[[ () ]]0},
  methods_by_name: --[[ Empty ]]0,
  methods_by_label: --[[ Empty ]]0,
  previous_states: --[[ [] ]]0,
  hidden_meths: --[[ [] ]]0,
  vars: --[[ Empty ]]0,
  initializers: --[[ [] ]]0
end;

table_count = do
  contents: 0
end;

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
  Caml_array.caml_array_set(methods, 1, (Caml_int32.imul(fit_size(len), Sys.word_size) / 8 | 0) - 1 | 0);
  for i = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(methods, (i << 1) + 3 | 0, Caml_array.caml_array_get(pub_labels, i));
  end
  return do
          size: 2,
          methods: methods,
          methods_by_name: --[[ Empty ]]0,
          methods_by_label: --[[ Empty ]]0,
          previous_states: --[[ [] ]]0,
          hidden_meths: --[[ [] ]]0,
          vars: --[[ Empty ]]0,
          initializers: --[[ [] ]]0
        end;
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

function put(array, label, element) do
  resize(array, label + 1 | 0);
  return Caml_array.caml_array_set(array.methods, label, element);
end end

method_count = do
  contents: 0
end;

inst_var_count = do
  contents: 0
end;

function new_method(table) do
  index = #table.methods;
  resize(table, index + 1 | 0);
  return index;
end end

function get_method_label(table, name) do
  xpcall(function() do
    return find_1(name, table.methods_by_name);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      label = new_method(table);
      table.methods_by_name = add_1(name, label, table.methods_by_name);
      table.methods_by_label = add_2(label, true, table.methods_by_label);
      return label;
    end else do
      error(exn)
    end end 
  end end)
end end

function get_method_labels(table, names) do
  return __Array.map((function (param) do
                return get_method_label(table, param);
              end end), names);
end end

function set_method(table, label, element) do
  method_count.contents = method_count.contents + 1 | 0;
  if (find_2(label, table.methods_by_label)) then do
    return put(table, label, element);
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
  virt_meth_labs = List.map((function (param) do
          return get_method_label(table, param);
        end end), virt_meths_1);
  concr_meth_labs = List.map((function (param) do
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
  table.vars = fold((function (lab, info, tvars) do
          if (List.mem(lab, vars_1)) then do
            return add(lab, info, tvars);
          end else do
            return tvars;
          end end 
        end end), table.vars, --[[ Empty ]]0);
  by_name = do
    contents: --[[ Empty ]]0
  end;
  by_label = do
    contents: --[[ Empty ]]0
  end;
  List.iter2((function (met, label) do
          by_name.contents = add_1(met, label, by_name.contents);
          tmp;
          xpcall(function() do
            tmp = find_2(label, table.methods_by_label);
          end end,function(exn) do
            if (exn == Caml_builtin_exceptions.not_found) then do
              tmp = true;
            end else do
              error(exn)
            end end 
          end end)
          by_label.contents = add_2(label, tmp, by_label.contents);
          return --[[ () ]]0;
        end end), concr_meths_1, concr_meth_labs);
  List.iter2((function (met, label) do
          by_name.contents = add_1(met, label, by_name.contents);
          by_label.contents = add_2(label, false, by_label.contents);
          return --[[ () ]]0;
        end end), virt_meths_1, virt_meth_labs);
  table.methods_by_name = by_name.contents;
  table.methods_by_label = by_label.contents;
  table.hidden_meths = List.fold_right((function (met, hm) do
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
  table.vars = List.fold_left((function (s, v) do
          return add(v, find(v, table.vars), s);
        end end), match[3], match[5]);
  table.methods_by_name = match[0];
  table.methods_by_label = match[1];
  table.hidden_meths = List.fold_right((function (met, hm) do
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
  xpcall(function() do
    return find(name, table.vars);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      index = new_slot(table);
      if (name ~= "") then do
        table.vars = add(name, index, table.vars);
      end
       end 
      return index;
    end else do
      error(exn)
    end end 
  end end)
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
  xpcall(function() do
    return find(name, table.vars);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "test_internalOO.ml",
          280,
          50
        }
      })
    end
     end 
    error(exn)
  end end)
end end

function get_variables(table, names) do
  return __Array.map((function (param) do
                return get_variable(table, param);
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
    __Array.iteri((function (i, met) do
            lab = (i << 1) + 2 | 0;
            table.methods_by_name = add_1(met, lab, table.methods_by_name);
            table.methods_by_label = add_2(lab, true, table.methods_by_label);
            return --[[ () ]]0;
          end end), public_methods);
    return table;
  end end 
end end

function init_class(table) do
  inst_var_count.contents = (inst_var_count.contents + table.size | 0) - 1 | 0;
  table.initializers = List.rev(table.initializers);
  return resize(table, 3 + Caml_int32.div((Caml_array.caml_array_get(table.methods, 1) << 4), Sys.word_size) | 0);
end end

function inherits(cla, vals, virt_meths, concr_meths, param, top) do
  __super = param[1];
  narrow(cla, vals, virt_meths, concr_meths);
  init = top and Curry._2(__super, cla, param[3]) or Curry._1(__super, cla);
  widen(cla);
  return Caml_array.caml_array_concat(--[[ :: ]]{
              {init},
              --[[ :: ]]{
                __Array.map((function (param) do
                        return get_variable(cla, param);
                      end end), to_array(vals)),
                --[[ :: ]]{
                  __Array.map((function (nm) do
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

function dummy_class(loc) do
  undef = function (param) do
    error({
      Caml_builtin_exceptions.undefined_recursive_module,
      loc
    })
  end end;
  return --[[ tuple ]]{
          undef,
          undef,
          undef,
          0
        };
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

function build_path(n, keys, tables) do
  res = do
    key: 0,
    data: --[[ Empty ]]0,
    next: --[[ Empty ]]0
  end;
  r = res;
  for i = 0 , n , 1 do
    r = --[[ Cons ]]{
      Caml_array.caml_array_get(keys, i),
      r,
      --[[ Empty ]]0
    };
  end
  tables.data = r;
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
      if (tables_1.key == key) then do
        return lookup_keys(i - 1 | 0, keys, tables_1.data);
      end else if (tables_1.next ~= --[[ Empty ]]0) then do
        _tables = tables_1.next;
        ::continue:: ;
      end else do
        next = --[[ Cons ]]{
          key,
          --[[ Empty ]]0,
          --[[ Empty ]]0
        };
        tables_1.next = next;
        return build_path(i - 1 | 0, keys, next);
      end end  end 
    end;
  end end 
end end

function lookup_tables(root, keys) do
  if (root.data ~= --[[ Empty ]]0) then do
    return lookup_keys(#keys - 1 | 0, keys, root.data);
  end else do
    return build_path(#keys - 1 | 0, keys, root);
  end end 
end end

function get_const(x) do
  return (function (obj) do
      return x;
    end end);
end end

function get_var(n) do
  return (function (obj) do
      return obj[n];
    end end);
end end

function get_env(e, n) do
  return (function (obj) do
      return obj[e][n];
    end end);
end end

function get_meth(n) do
  return (function (obj) do
      return Curry._1(obj[0][n], obj);
    end end);
end end

function set_var(n) do
  return (function (obj, x) do
      obj[n] = x;
      return --[[ () ]]0;
    end end);
end end

function app_const(f, x) do
  return (function (obj) do
      return Curry._1(f, x);
    end end);
end end

function app_var(f, n) do
  return (function (obj) do
      return Curry._1(f, obj[n]);
    end end);
end end

function app_env(f, e, n) do
  return (function (obj) do
      return Curry._1(f, obj[e][n]);
    end end);
end end

function app_meth(f, n) do
  return (function (obj) do
      return Curry._1(f, Curry._1(obj[0][n], obj));
    end end);
end end

function app_const_const(f, x, y) do
  return (function (obj) do
      return Curry._2(f, x, y);
    end end);
end end

function app_const_var(f, x, n) do
  return (function (obj) do
      return Curry._2(f, x, obj[n]);
    end end);
end end

function app_const_meth(f, x, n) do
  return (function (obj) do
      return Curry._2(f, x, Curry._1(obj[0][n], obj));
    end end);
end end

function app_var_const(f, n, x) do
  return (function (obj) do
      return Curry._2(f, obj[n], x);
    end end);
end end

function app_meth_const(f, n, x) do
  return (function (obj) do
      return Curry._2(f, Curry._1(obj[0][n], obj), x);
    end end);
end end

function app_const_env(f, x, e, n) do
  return (function (obj) do
      return Curry._2(f, x, obj[e][n]);
    end end);
end end

function app_env_const(f, e, n, x) do
  return (function (obj) do
      return Curry._2(f, obj[e][n], x);
    end end);
end end

function meth_app_const(n, x) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, x);
    end end);
end end

function meth_app_var(n, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, obj[m]);
    end end);
end end

function meth_app_env(n, e, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, obj[e][m]);
    end end);
end end

function meth_app_meth(n, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, Curry._1(obj[0][m], obj));
    end end);
end end

function send_const(m, x, c) do
  return (function (obj) do
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, x, m, 1), x);
    end end);
end end

function send_var(m, n, c) do
  return (function (obj) do
      tmp = obj[n];
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 2), tmp);
    end end);
end end

function send_env(m, e, n, c) do
  return (function (obj) do
      tmp = obj[e][n];
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 3), tmp);
    end end);
end end

function send_meth(m, n, c) do
  return (function (obj) do
      tmp = Curry._1(obj[0][n], obj);
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 4), tmp);
    end end);
end end

function new_cache(table) do
  n = new_method(table);
  n_1 = n % 2 == 0 or n > (2 + Caml_int32.div((Caml_array.caml_array_get(table.methods, 1) << 4), Sys.word_size) | 0) and n or new_method(table);
  Caml_array.caml_array_set(table.methods, n_1, 0);
  return n_1;
end end

function method_impl(table, i, arr) do
  next = function (param) do
    i.contents = i.contents + 1 | 0;
    return Caml_array.caml_array_get(arr, i.contents);
  end end;
  clo = next(--[[ () ]]0);
  if (typeof clo == "number") then do
    local ___conditional___=(clo);
    do
       if ___conditional___ = 0--[[ GetConst ]] then do
          x = next(--[[ () ]]0);
          return (function (obj) do
              return x;
            end end);end end end 
       if ___conditional___ = 1--[[ GetVar ]] then do
          n = next(--[[ () ]]0);
          return (function (obj) do
              return obj[n];
            end end);end end end 
       if ___conditional___ = 2--[[ GetEnv ]] then do
          e = next(--[[ () ]]0);
          n_1 = next(--[[ () ]]0);
          return get_env(e, n_1);end end end 
       if ___conditional___ = 3--[[ GetMeth ]] then do
          return get_meth(next(--[[ () ]]0));end end end 
       if ___conditional___ = 4--[[ SetVar ]] then do
          n_2 = next(--[[ () ]]0);
          return (function (obj, x) do
              obj[n_2] = x;
              return --[[ () ]]0;
            end end);end end end 
       if ___conditional___ = 5--[[ AppConst ]] then do
          f = next(--[[ () ]]0);
          x_1 = next(--[[ () ]]0);
          return (function (obj) do
              return Curry._1(f, x_1);
            end end);end end end 
       if ___conditional___ = 6--[[ AppVar ]] then do
          f_1 = next(--[[ () ]]0);
          n_3 = next(--[[ () ]]0);
          return (function (obj) do
              return Curry._1(f_1, obj[n_3]);
            end end);end end end 
       if ___conditional___ = 7--[[ AppEnv ]] then do
          f_2 = next(--[[ () ]]0);
          e_1 = next(--[[ () ]]0);
          n_4 = next(--[[ () ]]0);
          return app_env(f_2, e_1, n_4);end end end 
       if ___conditional___ = 8--[[ AppMeth ]] then do
          f_3 = next(--[[ () ]]0);
          n_5 = next(--[[ () ]]0);
          return app_meth(f_3, n_5);end end end 
       if ___conditional___ = 9--[[ AppConstConst ]] then do
          f_4 = next(--[[ () ]]0);
          x_2 = next(--[[ () ]]0);
          y = next(--[[ () ]]0);
          return (function (obj) do
              return Curry._2(f_4, x_2, y);
            end end);end end end 
       if ___conditional___ = 10--[[ AppConstVar ]] then do
          f_5 = next(--[[ () ]]0);
          x_3 = next(--[[ () ]]0);
          n_6 = next(--[[ () ]]0);
          return app_const_var(f_5, x_3, n_6);end end end 
       if ___conditional___ = 11--[[ AppConstEnv ]] then do
          f_6 = next(--[[ () ]]0);
          x_4 = next(--[[ () ]]0);
          e_2 = next(--[[ () ]]0);
          n_7 = next(--[[ () ]]0);
          return app_const_env(f_6, x_4, e_2, n_7);end end end 
       if ___conditional___ = 12--[[ AppConstMeth ]] then do
          f_7 = next(--[[ () ]]0);
          x_5 = next(--[[ () ]]0);
          n_8 = next(--[[ () ]]0);
          return app_const_meth(f_7, x_5, n_8);end end end 
       if ___conditional___ = 13--[[ AppVarConst ]] then do
          f_8 = next(--[[ () ]]0);
          n_9 = next(--[[ () ]]0);
          x_6 = next(--[[ () ]]0);
          return app_var_const(f_8, n_9, x_6);end end end 
       if ___conditional___ = 14--[[ AppEnvConst ]] then do
          f_9 = next(--[[ () ]]0);
          e_3 = next(--[[ () ]]0);
          n_10 = next(--[[ () ]]0);
          x_7 = next(--[[ () ]]0);
          return app_env_const(f_9, e_3, n_10, x_7);end end end 
       if ___conditional___ = 15--[[ AppMethConst ]] then do
          f_10 = next(--[[ () ]]0);
          n_11 = next(--[[ () ]]0);
          x_8 = next(--[[ () ]]0);
          return app_meth_const(f_10, n_11, x_8);end end end 
       if ___conditional___ = 16--[[ MethAppConst ]] then do
          n_12 = next(--[[ () ]]0);
          x_9 = next(--[[ () ]]0);
          return meth_app_const(n_12, x_9);end end end 
       if ___conditional___ = 17--[[ MethAppVar ]] then do
          n_13 = next(--[[ () ]]0);
          m = next(--[[ () ]]0);
          return meth_app_var(n_13, m);end end end 
       if ___conditional___ = 18--[[ MethAppEnv ]] then do
          n_14 = next(--[[ () ]]0);
          e_4 = next(--[[ () ]]0);
          m_1 = next(--[[ () ]]0);
          return meth_app_env(n_14, e_4, m_1);end end end 
       if ___conditional___ = 19--[[ MethAppMeth ]] then do
          n_15 = next(--[[ () ]]0);
          m_2 = next(--[[ () ]]0);
          return meth_app_meth(n_15, m_2);end end end 
       if ___conditional___ = 20--[[ SendConst ]] then do
          m_3 = next(--[[ () ]]0);
          x_10 = next(--[[ () ]]0);
          return send_const(m_3, x_10, new_cache(table));end end end 
       if ___conditional___ = 21--[[ SendVar ]] then do
          m_4 = next(--[[ () ]]0);
          n_16 = next(--[[ () ]]0);
          return send_var(m_4, n_16, new_cache(table));end end end 
       if ___conditional___ = 22--[[ SendEnv ]] then do
          m_5 = next(--[[ () ]]0);
          e_5 = next(--[[ () ]]0);
          n_17 = next(--[[ () ]]0);
          return send_env(m_5, e_5, n_17, new_cache(table));end end end 
       if ___conditional___ = 23--[[ SendMeth ]] then do
          m_6 = next(--[[ () ]]0);
          n_18 = next(--[[ () ]]0);
          return send_meth(m_6, n_18, new_cache(table));end end end 
       do
      
    end
  end else do
    return clo;
  end end 
end end

function set_methods(table, methods) do
  len = #methods;
  i = do
    contents: 0
  end;
  while(i.contents < len) do
    label = Caml_array.caml_array_get(methods, i.contents);
    clo = method_impl(table, i, methods);
    set_method(table, label, clo);
    i.contents = i.contents + 1 | 0;
  end;
  return --[[ () ]]0;
end end

function stats(param) do
  return do
          classes: table_count.contents,
          methods: method_count.contents,
          inst_vars: inst_var_count.contents
        end;
end end

initial_object_size = 2;

dummy_item = --[[ () ]]0;

exports.copy = copy;
exports.params = params;
exports.step = step;
exports.initial_object_size = initial_object_size;
exports.dummy_item = dummy_item;
exports.public_method_label = public_method_label;
exports.Vars = Vars;
exports.Meths = Meths;
exports.Labs = Labs;
exports.dummy_table = dummy_table;
exports.table_count = table_count;
exports.dummy_met = dummy_met;
exports.fit_size = fit_size;
exports.new_table = new_table;
exports.resize = resize;
exports.put = put;
exports.method_count = method_count;
exports.inst_var_count = inst_var_count;
exports.new_method = new_method;
exports.get_method_label = get_method_label;
exports.get_method_labels = get_method_labels;
exports.set_method = set_method;
exports.get_method = get_method;
exports.to_list = to_list;
exports.narrow = narrow;
exports.widen = widen;
exports.new_slot = new_slot;
exports.new_variable = new_variable;
exports.to_array = to_array;
exports.new_methods_variables = new_methods_variables;
exports.get_variable = get_variable;
exports.get_variables = get_variables;
exports.add_initializer = add_initializer;
exports.create_table = create_table;
exports.init_class = init_class;
exports.inherits = inherits;
exports.make_class = make_class;
exports.make_class_store = make_class_store;
exports.dummy_class = dummy_class;
exports.create_object = create_object;
exports.create_object_opt = create_object_opt;
exports.iter_f = iter_f;
exports.run_initializers = run_initializers;
exports.run_initializers_opt = run_initializers_opt;
exports.create_object_and_run_initializers = create_object_and_run_initializers;
exports.build_path = build_path;
exports.lookup_keys = lookup_keys;
exports.lookup_tables = lookup_tables;
exports.get_const = get_const;
exports.get_var = get_var;
exports.get_env = get_env;
exports.get_meth = get_meth;
exports.set_var = set_var;
exports.app_const = app_const;
exports.app_var = app_var;
exports.app_env = app_env;
exports.app_meth = app_meth;
exports.app_const_const = app_const_const;
exports.app_const_var = app_const_var;
exports.app_const_meth = app_const_meth;
exports.app_var_const = app_var_const;
exports.app_meth_const = app_meth_const;
exports.app_const_env = app_const_env;
exports.app_env_const = app_env_const;
exports.meth_app_const = meth_app_const;
exports.meth_app_var = meth_app_var;
exports.meth_app_env = meth_app_env;
exports.meth_app_meth = meth_app_meth;
exports.send_const = send_const;
exports.send_var = send_var;
exports.send_env = send_env;
exports.send_meth = send_meth;
exports.new_cache = new_cache;
exports.method_impl = method_impl;
exports.set_methods = set_methods;
exports.stats = stats;
--[[ No side effect ]]
