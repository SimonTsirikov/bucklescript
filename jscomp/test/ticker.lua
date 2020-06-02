console.log = print;

List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Printf = require "../../lib/js/printf";
__String = require "../../lib/js/string";
Caml_obj = require "../../lib/js/caml_obj";
Pervasives = require "../../lib/js/pervasives";
Caml_format = require "../../lib/js/caml_format";
Caml_option = require "../../lib/js/caml_option";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function split(delim, s) do
  len = #s;
  if (len ~= 0) then do
    _l = --[[ [] ]]0;
    _i = len;
    while(true) do
      i = _i;
      l = _l;
      if (i ~= 0) then do
        i$prime;
        xpcall(function() do
          i$prime = __String.rindex_from(s, i - 1 | 0, delim);
        end end,function(exn) do
          if (exn == Caml_builtin_exceptions.not_found) then do
            return --[[ :: ]]{
                    __String.sub(s, 0, i),
                    l
                  };
          end else do
            error(exn)
          end end 
        end end)
        l_000 = __String.sub(s, i$prime + 1 | 0, (i - i$prime | 0) - 1 | 0);
        l_1 = --[[ :: ]]{
          l_000,
          l
        };
        l_2 = i$prime == 0 and --[[ :: ]]{
            "",
            l_1
          } or l_1;
        _i = i$prime;
        _l = l_2;
        ::continue:: ;
      end else do
        return l;
      end end 
    end;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function string_of_float_option(param) do
  if (param ~= undefined) then do
    return Pervasives.string_of_float(param);
  end else do
    return "nan";
  end end 
end end

Util = do
  split: split,
  string_of_float_option: string_of_float_option
end;

function string_of_rank(param) do
  if (typeof param == "number") then do
    if (param ~= 0) then do
      return "Visited";
    end else do
      return "Uninitialized";
    end end 
  end else do
    return Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "Ranked(",
                        --[[ Int ]]Block.__(4, {
                            --[[ Int_i ]]3,
                            --[[ No_padding ]]0,
                            --[[ No_precision ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ ")" ]]41,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "Ranked(%i)"
                  }), param[0]);
  end end 
end end

function find_ticker_by_name(all_tickers, ticker) do
  return List.find((function (param) do
                return param.ticker_name == ticker;
              end end), all_tickers);
end end

function print_all_composite(all_tickers) do
  return List.iter((function (param) do
                if (param.type_) then do
                  console.log(param.ticker_name);
                  return --[[ () ]]0;
                end else do
                  return --[[ () ]]0;
                end end 
              end end), all_tickers);
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
    c = Caml_obj.caml_compare(x, v);
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
      c = Caml_obj.caml_compare(x, param[--[[ v ]]1]);
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
      c = Caml_obj.caml_compare(x, param[--[[ v ]]1]);
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
      c = Caml_obj.caml_compare(x, param[--[[ v ]]1]);
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
    c = Caml_obj.caml_compare(x, v);
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
    c = Caml_obj.caml_compare(x, v);
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

function split_1(x, param) do
  if (param) then do
    r = param[--[[ r ]]3];
    d = param[--[[ d ]]2];
    v = param[--[[ v ]]1];
    l = param[--[[ l ]]0];
    c = Caml_obj.caml_compare(x, v);
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
              join(match[2], v, d, r)
            };
    end else do
      match_1 = split_1(x, r);
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
      match = split_1(v1, s2);
      return concat_or_join(merge_1(f, s1[--[[ l ]]0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[[ d ]]2]), match[1]), merge_1(f, s1[--[[ r ]]3], match[2]));
    end
     end 
  end else if (not s2) then do
    return --[[ Empty ]]0;
  end
   end  end 
  if (s2) then do
    v2 = s2[--[[ v ]]1];
    match_1 = split_1(v2, s1);
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
        match = split_1(v1, s2);
        d2_1 = match[1];
        l = union(f, s1[--[[ l ]]0], match[0]);
        r = union(f, s1[--[[ r ]]3], match[2]);
        if (d2_1 ~= undefined) then do
          return concat_or_join(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2_1)), r);
        end else do
          return join(l, v1, d1, r);
        end end 
      end else do
        match_1 = split_1(v2, s1);
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
        c = Caml_obj.caml_compare(e1[0], e2[0]);
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
      if (e2 and Caml_obj.caml_equal(e1[0], e2[0]) and Curry._2(cmp, e1[1], e2[1])) then do
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

Ticker_map = do
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
  split: split_1,
  find: find,
  find_opt: find_opt,
  find_first: find_first,
  find_first_opt: find_first_opt,
  find_last: find_last,
  find_last_opt: find_last_opt,
  map: map,
  mapi: mapi
end;

function compute_update_sequences(all_tickers) do
  List.fold_left((function (counter, ticker) do
          loop = function (counter, ticker) do
            rank = ticker.rank;
            if (typeof rank == "number" and rank == 0) then do
              ticker.rank = --[[ Visited ]]1;
              match = ticker.type_;
              if (match) then do
                match_1 = match[0];
                counter_1 = loop(counter, match_1.lhs);
                counter_2 = loop(counter_1, match_1.rhs);
                counter_3 = counter_2 + 1 | 0;
                ticker.rank = --[[ Ranked ]]{counter_3};
                return counter_3;
              end else do
                counter_4 = counter + 1 | 0;
                ticker.rank = --[[ Ranked ]]{counter_4};
                return counter_4;
              end end 
            end else do
              return counter;
            end end 
          end end;
          return loop(counter, ticker);
        end end), 0, all_tickers);
  map = List.fold_left((function (map, ticker) do
          if (ticker.type_) then do
            loop = function (_up, _map, _ticker) do
              while(true) do
                ticker = _ticker;
                map = _map;
                up = _up;
                type_ = ticker.type_;
                ticker_name = ticker.ticker_name;
                if (type_) then do
                  match = type_[0];
                  map_1 = loop(--[[ :: ]]{
                        ticker,
                        up
                      }, map, match.lhs);
                  _ticker = match.rhs;
                  _map = map_1;
                  _up = --[[ :: ]]{
                    ticker,
                    up
                  };
                  ::continue:: ;
                end else do
                  l = find(ticker_name, map);
                  return add(ticker_name, Pervasives.$at(up, l), map);
                end end 
              end;
            end end;
            return loop(--[[ [] ]]0, map, ticker);
          end else do
            return add(ticker.ticker_name, --[[ :: ]]{
                        ticker,
                        --[[ [] ]]0
                      }, map);
          end end 
        end end), --[[ Empty ]]0, List.rev(all_tickers));
  return fold((function (k, l, map) do
                l_1 = List.sort_uniq((function (lhs, rhs) do
                        match = lhs.rank;
                        if (typeof match == "number") then do
                          error({
                            Caml_builtin_exceptions.failure,
                            "All nodes should be ranked"
                          })
                        end
                         end 
                        match_1 = rhs.rank;
                        if (typeof match_1 == "number") then do
                          error({
                            Caml_builtin_exceptions.failure,
                            "All nodes should be ranked"
                          })
                        end
                         end 
                        return Caml_primitive.caml_int_compare(match[0], match_1[0]);
                      end end), l);
                return add(k, l_1, map);
              end end), map, map);
end end

function process_quote(ticker_map, new_ticker, new_value) do
  update_sequence = find(new_ticker, ticker_map);
  return List.iter((function (ticker) do
                match = ticker.type_;
                if (match) then do
                  match_1 = match[0];
                  match_2 = match_1.lhs.value;
                  match_3 = match_1.rhs.value;
                  value;
                  if (match_2 ~= undefined and match_3 ~= undefined) then do
                    y = match_3;
                    x = match_2;
                    value = match_1.op and x - y or x + y;
                  end else do
                    value = undefined;
                  end end 
                  ticker.value = value;
                  return --[[ () ]]0;
                end else if (ticker.ticker_name == new_ticker) then do
                  ticker.value = new_value;
                  return --[[ () ]]0;
                end else do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Only single Market ticker should be udpated upon a new quote"
                  })
                end end  end 
              end end), update_sequence);
end end

function process_input_line(ticker_map, all_tickers, line) do
  make_binary_op = function (ticker_name, lhs, rhs, op) do
    lhs_1 = find_ticker_by_name(all_tickers, lhs);
    rhs_1 = find_ticker_by_name(all_tickers, rhs);
    return do
            value: undefined,
            rank: --[[ Uninitialized ]]0,
            ticker_name: ticker_name,
            type_: --[[ Binary_op ]]{do
                op: op,
                rhs: rhs_1,
                lhs: lhs_1
              end}
          end;
  end end;
  tokens = split(--[[ "|" ]]124, line);
  if (tokens) then do
    local ___conditional___=(tokens[0]);
    do
       if ___conditional___ = "Q" then do
          match = tokens[1];
          if (match) then do
            match_1 = match[1];
            if (match_1) then do
              if (match_1[1]) then do
                error({
                  Caml_builtin_exceptions.failure,
                  "Invalid input line"
                })
              end
               end 
              ticker_map_1 = ticker_map ~= undefined and Caml_option.valFromOption(ticker_map) or compute_update_sequences(all_tickers);
              value = Caml_format.caml_float_of_string(match_1[0]);
              process_quote(ticker_map_1, match[0], value);
              return --[[ tuple ]]{
                      all_tickers,
                      Caml_option.some(ticker_map_1)
                    };
            end else do
              error({
                Caml_builtin_exceptions.failure,
                "Invalid input line"
              })
            end end 
          end else do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid input line"
            })
          end end end end end 
       if ___conditional___ = "R" then do
          match_2 = tokens[1];
          if (match_2) then do
            match_3 = match_2[1];
            if (match_3) then do
              ticker_name = match_2[0];
              local ___conditional___=(match_3[0]);
              do
                 if ___conditional___ = "+" then do
                    match_4 = match_3[1];
                    if (match_4) then do
                      match_5 = match_4[1];
                      if (match_5) then do
                        if (match_5[1]) then do
                          error({
                            Caml_builtin_exceptions.failure,
                            "Invalid input line"
                          })
                        end
                         end 
                        return --[[ tuple ]]{
                                --[[ :: ]]{
                                  make_binary_op(ticker_name, match_4[0], match_5[0], --[[ PLUS ]]0),
                                  all_tickers
                                },
                                ticker_map
                              };
                      end else do
                        error({
                          Caml_builtin_exceptions.failure,
                          "Invalid input line"
                        })
                      end end 
                    end else do
                      error({
                        Caml_builtin_exceptions.failure,
                        "Invalid input line"
                      })
                    end end end end end 
                 if ___conditional___ = "-" then do
                    match_6 = match_3[1];
                    if (match_6) then do
                      match_7 = match_6[1];
                      if (match_7) then do
                        if (match_7[1]) then do
                          error({
                            Caml_builtin_exceptions.failure,
                            "Invalid input line"
                          })
                        end
                         end 
                        return --[[ tuple ]]{
                                --[[ :: ]]{
                                  make_binary_op(ticker_name, match_6[0], match_7[0], --[[ MINUS ]]1),
                                  all_tickers
                                },
                                ticker_map
                              };
                      end else do
                        error({
                          Caml_builtin_exceptions.failure,
                          "Invalid input line"
                        })
                      end end 
                    end else do
                      error({
                        Caml_builtin_exceptions.failure,
                        "Invalid input line"
                      })
                    end end end end end 
                 if ___conditional___ = "S" then do
                    if (match_3[1]) then do
                      error({
                        Caml_builtin_exceptions.failure,
                        "Invalid input line"
                      })
                    end
                     end 
                    return --[[ tuple ]]{
                            --[[ :: ]]{
                              do
                                value: undefined,
                                rank: --[[ Uninitialized ]]0,
                                ticker_name: ticker_name,
                                type_: --[[ Market ]]0
                              end,
                              all_tickers
                            },
                            ticker_map
                          };end end end 
                 do
                else do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Invalid input line"
                  })
                  end end
                  
              end
            end else do
              error({
                Caml_builtin_exceptions.failure,
                "Invalid input line"
              })
            end end 
          end else do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid input line"
            })
          end end end end end 
       do
      else do
        error({
          Caml_builtin_exceptions.failure,
          "Invalid input line"
        })
        end end
        
    end
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Invalid input line"
    })
  end end 
end end

function loop(_lines, _param) do
  while(true) do
    param = _param;
    lines = _lines;
    all_tickers = param[0];
    if (lines) then do
      _param = process_input_line(param[1], all_tickers, lines[0]);
      _lines = lines[1];
      ::continue:: ;
    end else do
      return print_all_composite(all_tickers);
    end end 
  end;
end end

lines = --[[ :: ]]{
  "R|MSFT|S",
  --[[ :: ]]{
    "R|IBM|S",
    --[[ :: ]]{
      "R|FB|S",
      --[[ :: ]]{
        "R|CP1|+|MSFT|IBM",
        --[[ :: ]]{
          "R|CP2|-|FB|IBM",
          --[[ :: ]]{
            "R|CP12|+|CP1|CP2",
            --[[ :: ]]{
              "Q|MSFT|120.",
              --[[ :: ]]{
                "Q|IBM|130.",
                --[[ :: ]]{
                  "Q|FB|80.",
                  --[[ [] ]]0
                }
              }
            }
          }
        }
      }
    }
  }
};

exports.Util = Util;
exports.string_of_rank = string_of_rank;
exports.find_ticker_by_name = find_ticker_by_name;
exports.print_all_composite = print_all_composite;
exports.Ticker_map = Ticker_map;
exports.compute_update_sequences = compute_update_sequences;
exports.process_quote = process_quote;
exports.process_input_line = process_input_line;
exports.lines = lines;
exports.loop = loop;
--[[ No side effect ]]
