console = {log = print};

Mt = require "./mt";
Char = require "../../lib/js/char";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Bytes = require "../../lib/js/bytes";
Curry = require "../../lib/js/curry";
Format = require "../../lib/js/format";
__String = require "../../lib/js/string";
Hashtbl = require "../../lib/js/hashtbl";
Caml_obj = require "../../lib/js/caml_obj";
Caml_array = require "../../lib/js/caml_array";
Caml_bytes = require "../../lib/js/caml_bytes";
Caml_int32 = require "../../lib/js/caml_int32";
Pervasives = require "../../lib/js/pervasives";
Caml_option = require "../../lib/js/caml_option";
Caml_string = require "../../lib/js/caml_string";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function union(_l, _l$prime) do
  while(true) do
    l$prime = _l$prime;
    l = _l;
    if (l$prime) then do
      if (l) then do
        r$prime = l$prime[1];
        match = l$prime[0];
        c2$prime = match[1];
        c1$prime = match[0];
        r = l[1];
        match_1 = l[0];
        c2 = match_1[1];
        c1 = match_1[0];
        if ((c2 + 1 | 0) < c1$prime) then do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    c1,
                    c2
                  },
                  union(r, l$prime)
                };
        end else if ((c2$prime + 1 | 0) < c1) then do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    c1$prime,
                    c2$prime
                  },
                  union(l, r$prime)
                };
        end else if (c2 < c2$prime) then do
          _l$prime = --[[ :: ]]{
            --[[ tuple ]]{
              c1 < c1$prime and c1 or c1$prime,
              c2$prime
            },
            r$prime
          };
          _l = r;
          ::continue:: ;
        end else do
          _l$prime = r$prime;
          _l = --[[ :: ]]{
            --[[ tuple ]]{
              c1 < c1$prime and c1 or c1$prime,
              c2
            },
            r
          };
          ::continue:: ;
        end end  end  end 
      end else do
        return l$prime;
      end end 
    end else do
      return l;
    end end 
  end;
end end

function inter(_l, _l$prime) do
  while(true) do
    l$prime = _l$prime;
    l = _l;
    if (l$prime and l) then do
      r$prime = l$prime[1];
      match = l$prime[0];
      c2$prime = match[1];
      c1$prime = match[0];
      r = l[1];
      match_1 = l[0];
      c2 = match_1[1];
      c1 = match_1[0];
      if (Caml_obj.caml_lessthan(c2, c1$prime)) then do
        _l = r;
        ::continue:: ;
      end else if (Caml_obj.caml_lessthan(c2$prime, c1)) then do
        _l$prime = r$prime;
        ::continue:: ;
      end else if (Caml_obj.caml_lessthan(c2, c2$prime)) then do
        return --[[ :: ]]{
                --[[ tuple ]]{
                  Caml_obj.caml_max(c1, c1$prime),
                  c2
                },
                inter(r, l$prime)
              };
      end else do
        return --[[ :: ]]{
                --[[ tuple ]]{
                  Caml_obj.caml_max(c1, c1$prime),
                  c2$prime
                },
                inter(l, r$prime)
              };
      end end  end  end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function diff(_l, _l$prime) do
  while(true) do
    l$prime = _l$prime;
    l = _l;
    if (l$prime) then do
      if (l) then do
        r$prime = l$prime[1];
        match = l$prime[0];
        c2$prime = match[1];
        c1$prime = match[0];
        r = l[1];
        match_1 = l[0];
        c2 = match_1[1];
        c1 = match_1[0];
        if (c2 < c1$prime) then do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    c1,
                    c2
                  },
                  diff(r, l$prime)
                };
        end else if (c2$prime < c1) then do
          _l$prime = r$prime;
          ::continue:: ;
        end else do
          r$prime$prime = c2$prime < c2 and --[[ :: ]]{
              --[[ tuple ]]{
                c2$prime + 1 | 0,
                c2
              },
              r
            } or r;
          if (c1 < c1$prime) then do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      c1,
                      c1$prime - 1 | 0
                    },
                    diff(r$prime$prime, r$prime)
                  };
          end else do
            _l$prime = r$prime;
            _l = r$prime$prime;
            ::continue:: ;
          end end 
        end end  end 
      end else do
        return --[[ [] ]]0;
      end end 
    end else do
      return l;
    end end 
  end;
end end

function single(c) do
  return --[[ :: ]]{
          --[[ tuple ]]{
            c,
            c
          },
          --[[ [] ]]0
        };
end end

function seq(c, c$prime) do
  if (Caml_obj.caml_lessequal(c, c$prime)) then do
    return --[[ :: ]]{
            --[[ tuple ]]{
              c,
              c$prime
            },
            --[[ [] ]]0
          };
  end else do
    return --[[ :: ]]{
            --[[ tuple ]]{
              c$prime,
              c
            },
            --[[ [] ]]0
          };
  end end 
end end

function offset(o, l) do
  if (l) then do
    match = l[0];
    return --[[ :: ]]{
            --[[ tuple ]]{
              match[0] + o | 0,
              match[1] + o | 0
            },
            offset(o, l[1])
          };
  end else do
    return --[[ [] ]]0;
  end end 
end end

function mem(c, _s) do
  while(true) do
    s = _s;
    if (s) then do
      match = s[0];
      if (c <= match[1]) then do
        return c >= match[0];
      end else do
        _s = s[1];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function hash_rec(param) do
  if (param) then do
    match = param[0];
    return (match[0] + Caml_int32.imul(13, match[1]) | 0) + Caml_int32.imul(257, hash_rec(param[1])) | 0;
  end else do
    return 0;
  end end 
end end

function one_char(param) do
  if (param and not param[1]) then do
    match = param[0];
    i = match[0];
    if (Caml_obj.caml_equal(i, match[1])) then do
      return Caml_option.some(i);
    end else do
      return ;
    end end 
  end
   end 
end end

function compare(param, param_1) do
  c = Caml_obj.caml_compare(param[0], param_1[0]);
  if (c ~= 0) then do
    return c;
  end else do
    return Caml_obj.caml_compare(param[1], param_1[1]);
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

function add(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
    c = compare(x, v);
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

cany = --[[ :: ]]{
  --[[ tuple ]]{
    0,
    255
  },
  --[[ [] ]]0
};

function intersect(x, y) do
  return (x & y) ~= 0;
end end

function $plus$plus(x, y) do
  return x | y;
end end

function from_char(param) do
  if (param >= 170) then do
    if (param >= 187) then do
      switcher = param - 192 | 0;
      if (switcher > 54 or switcher < 0) then do
        if (switcher >= 56) then do
          return 2;
        end else do
          return 4;
        end end 
      end else if (switcher ~= 23) then do
        return 2;
      end else do
        return 4;
      end end  end 
    end else do
      switcher_1 = param - 171 | 0;
      if (not (switcher_1 > 14 or switcher_1 < 0) and switcher_1 ~= 10) then do
        return 4;
      end else do
        return 2;
      end end 
    end end 
  end else if (param >= 65) then do
    switcher_2 = param - 91 | 0;
    if (switcher_2 > 5 or switcher_2 < 0) then do
      if (switcher_2 >= 32) then do
        return 4;
      end else do
        return 2;
      end end 
    end else if (switcher_2 ~= 4) then do
      return 4;
    end else do
      return 2;
    end end  end 
  end else if (param >= 48) then do
    if (param >= 58) then do
      return 4;
    end else do
      return 2;
    end end 
  end else if (param ~= 10) then do
    return 4;
  end else do
    return 12;
  end end  end  end  end 
end end

function height_1(param) do
  if (param) then do
    return param[--[[ h ]]3];
  end else do
    return 0;
  end end 
end end

function create_1(l, v, r) do
  hl = l and l[--[[ h ]]3] or 0;
  hr = r and r[--[[ h ]]3] or 0;
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]v,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal_1(l, v, r) do
  hl = l and l[--[[ h ]]3] or 0;
  hr = r and r[--[[ h ]]3] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]2];
      lv = l[--[[ v ]]1];
      ll = l[--[[ l ]]0];
      if (height_1(ll) >= height_1(lr)) then do
        return create_1(ll, lv, create_1(lr, v, r));
      end else if (lr) then do
        return create_1(create_1(ll, lv, lr[--[[ l ]]0]), lr[--[[ v ]]1], create_1(lr[--[[ r ]]2], v, r));
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
      rr = r[--[[ r ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height_1(rr) >= height_1(rl)) then do
        return create_1(create_1(l, v, rl), rv, rr);
      end else if (rl) then do
        return create_1(create_1(l, v, rl[--[[ l ]]0]), rl[--[[ v ]]1], create_1(rl[--[[ r ]]2], rv, rr));
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
end end

function add_1(x, t) do
  if (t) then do
    r = t[--[[ r ]]2];
    v = t[--[[ v ]]1];
    l = t[--[[ l ]]0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      ll = add_1(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal_1(ll, v, r);
      end end 
    end else do
      rr = add_1(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal_1(l, v, rr);
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
end end

function hash_combine(h, accu) do
  return Caml_int32.imul(accu, 65599) + h | 0;
end end

empty = do
  marks: --[[ [] ]]0,
  pmarks: --[[ Empty ]]0
end;

function hash(m, accu) do
  _l = m.marks;
  _accu = hash_combine(Hashtbl.hash(m.pmarks), accu);
  while(true) do
    accu_1 = _accu;
    l = _l;
    if (l) then do
      match = l[0];
      _accu = hash_combine(match[0], hash_combine(match[1], accu_1));
      _l = l[1];
      ::continue:: ;
    end else do
      return accu_1;
    end end 
  end;
end end

function marks_set_idx(idx, marks) do
  if (marks) then do
    match = marks[0];
    if (match[1] ~= -1) then do
      return marks;
    end else do
      return --[[ :: ]]{
              --[[ tuple ]]{
                match[0],
                idx
              },
              marks_set_idx(idx, marks[1])
            };
    end end 
  end else do
    return marks;
  end end 
end end

function marks_set_idx_1(marks, idx) do
  return do
          marks: marks_set_idx(idx, marks.marks),
          pmarks: marks.pmarks
        end;
end end

function first(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      res = Curry._1(f, param[0]);
      if (res ~= undefined) then do
        return res;
      end else do
        _param = param[1];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

eps_expr = do
  id: 0,
  def: --[[ Eps ]]0
end;

function mk_expr(ids, def) do
  ids.contents = ids.contents + 1 | 0;
  return do
          id: ids.contents,
          def: def
        end;
end end

function cst(ids, s) do
  if (s and false or true) then do
    return mk_expr(ids, --[[ Alt ]]Block.__(1, {--[[ [] ]]0}));
  end else do
    return mk_expr(ids, --[[ Cst ]]Block.__(0, {s}));
  end end 
end end

function alt(ids, l) do
  if (l) then do
    if (l[1]) then do
      return mk_expr(ids, --[[ Alt ]]Block.__(1, {l}));
    end else do
      return l[0];
    end end 
  end else do
    return mk_expr(ids, --[[ Alt ]]Block.__(1, {--[[ [] ]]0}));
  end end 
end end

function seq_1(ids, kind, x, y) do
  match = x.def;
  match_1 = y.def;
  exit = 0;
  if (typeof match == "number") then do
    return y;
  end else if (match.tag == --[[ Alt ]]1 and not match[0]) then do
    return x;
  end else do
    exit = 2;
  end end  end 
  if (exit == 2) then do
    if (typeof match_1 == "number") then do
      if (kind == --[[ First ]]332064784) then do
        return x;
      end
       end 
    end else if (match_1.tag == --[[ Alt ]]1 and not match_1[0]) then do
      return y;
    end
     end  end 
  end
   end 
  return mk_expr(ids, --[[ Seq ]]Block.__(2, {
                kind,
                x,
                y
              }));
end end

function is_eps(expr) do
  match = expr.def;
  if (typeof match == "number") then do
    return true;
  end else do
    return false;
  end end 
end end

function rep(ids, kind, sem, x) do
  return mk_expr(ids, --[[ Rep ]]Block.__(3, {
                kind,
                sem,
                x
              }));
end end

function erase(ids, m, m$prime) do
  return mk_expr(ids, --[[ Erase ]]Block.__(5, {
                m,
                m$prime
              }));
end end

function rename(ids, x) do
  match = x.def;
  if (typeof match == "number") then do
    return mk_expr(ids, x.def);
  end else do
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 1--[[ Alt ]] then do
          return mk_expr(ids, --[[ Alt ]]Block.__(1, {List.map((function(param) do
                                return rename(ids, param);
                              end end), match[0])})); end end 
       if ___conditional___ == 2--[[ Seq ]] then do
          return mk_expr(ids, --[[ Seq ]]Block.__(2, {
                        match[0],
                        rename(ids, match[1]),
                        rename(ids, match[2])
                      })); end end 
       if ___conditional___ == 3--[[ Rep ]] then do
          return mk_expr(ids, --[[ Rep ]]Block.__(3, {
                        match[0],
                        match[1],
                        rename(ids, match[2])
                      })); end end 
      return mk_expr(ids, x.def);
        
    end
  end end 
end end

function equal(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      match = l1[0];
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ TSeq ]] then do
            if (l2) then do
              match_1 = l2[0];
              local ___conditional___=(match_1.tag | 0);
              do
                 if ___conditional___ == 0--[[ TSeq ]] then do
                    if (match[1].id == match_1[1].id and equal(match[0], match_1[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      ::continue:: ;
                    end else do
                      return false;
                    end end  end end 
                 if ___conditional___ == 1--[[ TExp ]]
                 or ___conditional___ == 2--[[ TMatch ]] then do
                    return false; end end 
                
              end
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 1--[[ TExp ]] then do
            if (l2) then do
              match_2 = l2[0];
              local ___conditional___=(match_2.tag | 0);
              do
                 if ___conditional___ == 1--[[ TExp ]] then do
                    if (match[1].id == match_2[1].id and Caml_obj.caml_equal(match[0], match_2[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      ::continue:: ;
                    end else do
                      return false;
                    end end  end end 
                 if ___conditional___ == 0--[[ TSeq ]]
                 or ___conditional___ == 2--[[ TMatch ]] then do
                    return false; end end 
                
              end
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 2--[[ TMatch ]] then do
            if (l2) then do
              match_3 = l2[0];
              local ___conditional___=(match_3.tag | 0);
              do
                 if ___conditional___ == 0--[[ TSeq ]]
                 or ___conditional___ == 1--[[ TExp ]] then do
                    return false; end end 
                 if ___conditional___ == 2--[[ TMatch ]] then do
                    if (Caml_obj.caml_equal(match[0], match_3[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      ::continue:: ;
                    end else do
                      return false;
                    end end  end end 
                
              end
            end else do
              return false;
            end end  end end 
        
      end
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function hash_1(_l, _accu) do
  while(true) do
    accu = _accu;
    l = _l;
    if (l) then do
      match = l[0];
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ TSeq ]] then do
            _accu = hash_combine(388635598, hash_combine(match[1].id, hash_1(match[0], accu)));
            _l = l[1];
            ::continue:: ; end end 
         if ___conditional___ == 1--[[ TExp ]] then do
            _accu = hash_combine(726404471, hash_combine(match[1].id, hash(match[0], accu)));
            _l = l[1];
            ::continue:: ; end end 
         if ___conditional___ == 2--[[ TMatch ]] then do
            _accu = hash_combine(471882453, hash(match[0], accu));
            _l = l[1];
            ::continue:: ; end end 
        
      end
    end else do
      return accu;
    end end 
  end;
end end

function tseq(kind, x, y, rem) do
  if (x) then do
    match = x[0];
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 1--[[ TExp ]] then do
          if (typeof match[1].def == "number" and not x[1]) then do
            return --[[ :: ]]{
                    --[[ TExp ]]Block.__(1, {
                        match[0],
                        y
                      }),
                    rem
                  };
          end
           end  end else 
       if ___conditional___ == 0--[[ TSeq ]]
       or ___conditional___ == 2--[[ TMatch ]]
       end end end
      
    end
  end else do
    return rem;
  end end 
  return --[[ :: ]]{
          --[[ TSeq ]]Block.__(0, {
              x,
              y,
              kind
            }),
          rem
        };
end end

dummy = do
  idx: -1,
  category: -1,
  desc: --[[ [] ]]0,
  status: undefined,
  hash: -1
end;

function hash_2(idx, cat, desc) do
  return hash_1(desc, hash_combine(idx, hash_combine(cat, 0))) & 1073741823;
end end

function mk(idx, cat, desc) do
  return do
          idx: idx,
          category: cat,
          desc: desc,
          status: undefined,
          hash: hash_2(idx, cat, desc)
        end;
end end

function create_2(cat, e) do
  return mk(0, cat, --[[ :: ]]{
              --[[ TExp ]]Block.__(1, {
                  empty,
                  e
                }),
              --[[ [] ]]0
            });
end end

function equal_1(x, y) do
  if (x.hash == y.hash and x.idx == y.idx and x.category == y.category) then do
    return equal(x.desc, y.desc);
  end else do
    return false;
  end end 
end end

function hash_3(t) do
  return t.hash;
end end

Table = Hashtbl.Make(do
      equal: equal_1,
      hash: hash_3
    end);

function reset_table(a) do
  return __Array.fill(a, 0, #a, false);
end end

function mark_used_indices(tbl) do
  return (function(param) do
      return List.iter((function(param) do
                    local ___conditional___=(param.tag | 0);
                    do
                       if ___conditional___ == 0--[[ TSeq ]] then do
                          return mark_used_indices(tbl)(param[0]); end end 
                       if ___conditional___ == 1--[[ TExp ]]
                       or ___conditional___ == 2--[[ TMatch ]]
                       end
                      
                    end
                    return List.iter((function(param) do
                                  i = param[1];
                                  if (i >= 0) then do
                                    return Caml_array.caml_array_set(tbl, i, true);
                                  end else do
                                    return 0;
                                  end end 
                                end end), param[0].marks);
                  end end), param);
    end end);
end end

function find_free(tbl, _idx, len) do
  while(true) do
    idx = _idx;
    if (idx == len or not Caml_array.caml_array_get(tbl, idx)) then do
      return idx;
    end else do
      _idx = idx + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function free_index(tbl_ref, l) do
  tbl = tbl_ref.contents;
  reset_table(tbl);
  mark_used_indices(tbl)(l);
  len = #tbl;
  idx = find_free(tbl, 0, len);
  if (idx == len) then do
    tbl_ref.contents = Caml_array.caml_make_vect((len << 1), false);
  end
   end 
  return idx;
end end

remove_matches = List.filter((function(param) do
        local ___conditional___=(param.tag | 0);
        do
           if ___conditional___ == 0--[[ TSeq ]]
           or ___conditional___ == 1--[[ TExp ]] then do
              return true; end end 
           if ___conditional___ == 2--[[ TMatch ]] then do
              return false; end end 
          
        end
      end end));

function split_at_match_rec(_l$prime, _param) do
  while(true) do
    param = _param;
    l$prime = _l$prime;
    if (param) then do
      x = param[0];
      local ___conditional___=(x.tag | 0);
      do
         if ___conditional___ == 0--[[ TSeq ]]
         or ___conditional___ == 1--[[ TExp ]] then do
            _param = param[1];
            _l$prime = --[[ :: ]]{
              x,
              l$prime
            };
            ::continue:: ; end end 
         if ___conditional___ == 2--[[ TMatch ]] then do
            return --[[ tuple ]]{
                    List.rev(l$prime),
                    Curry._1(remove_matches, param[1])
                  }; end end 
        
      end
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "re_automata.ml",
          429,
          21
        }
      })
    end end 
  end;
end end

function remove_duplicates(prev, _l, y) do
  while(true) do
    l = _l;
    if (l) then do
      x = l[0];
      local ___conditional___=(x.tag | 0);
      do
         if ___conditional___ == 0--[[ TSeq ]] then do
            x_1 = x[1];
            match = remove_duplicates(prev, x[0], x_1);
            match_1 = remove_duplicates(match[1], l[1], y);
            return --[[ tuple ]]{
                    tseq(x[2], match[0], x_1, match_1[0]),
                    match_1[1]
                  }; end end 
         if ___conditional___ == 1--[[ TExp ]] then do
            x_2 = x[1];
            if (typeof x_2.def == "number") then do
              r = l[1];
              if (List.memq(y.id, prev)) then do
                _l = r;
                ::continue:: ;
              end else do
                match_2 = remove_duplicates(--[[ :: ]]{
                      y.id,
                      prev
                    }, r, y);
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          x,
                          match_2[0]
                        },
                        match_2[1]
                      };
              end end 
            end else do
              r_1 = l[1];
              if (List.memq(x_2.id, prev)) then do
                _l = r_1;
                ::continue:: ;
              end else do
                match_3 = remove_duplicates(--[[ :: ]]{
                      x_2.id,
                      prev
                    }, r_1, y);
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          x,
                          match_3[0]
                        },
                        match_3[1]
                      };
              end end 
            end end  end end 
         if ___conditional___ == 2--[[ TMatch ]] then do
            return --[[ tuple ]]{
                    --[[ :: ]]{
                      x,
                      --[[ [] ]]0
                    },
                    prev
                  }; end end 
        
      end
    end else do
      return --[[ tuple ]]{
              --[[ [] ]]0,
              prev
            };
    end end 
  end;
end end

function set_idx(idx, param) do
  if (param) then do
    match = param[0];
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 0--[[ TSeq ]] then do
          return --[[ :: ]]{
                  --[[ TSeq ]]Block.__(0, {
                      set_idx(idx, match[0]),
                      match[1],
                      match[2]
                    }),
                  set_idx(idx, param[1])
                }; end end 
       if ___conditional___ == 1--[[ TExp ]] then do
          return --[[ :: ]]{
                  --[[ TExp ]]Block.__(1, {
                      marks_set_idx_1(match[0], idx),
                      match[1]
                    }),
                  set_idx(idx, param[1])
                }; end end 
       if ___conditional___ == 2--[[ TMatch ]] then do
          return --[[ :: ]]{
                  --[[ TMatch ]]Block.__(2, {marks_set_idx_1(match[0], idx)}),
                  set_idx(idx, param[1])
                }; end end 
      
    end
  end else do
    return --[[ [] ]]0;
  end end 
end end

function filter_marks(b, e, marks) do
  return do
          marks: List.filter((function(param) do
                    i = param[0];
                    if (i < b) then do
                      return true;
                    end else do
                      return i > e;
                    end end 
                  end end))(marks.marks),
          pmarks: marks.pmarks
        end;
end end

function delta_1(marks, c, next_cat, prev_cat, x, rem) do
  match = x.def;
  if (typeof match == "number") then do
    return --[[ :: ]]{
            --[[ TMatch ]]Block.__(2, {marks}),
            rem
          };
  end else do
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 0--[[ Cst ]] then do
          if (mem(c, match[0])) then do
            return --[[ :: ]]{
                    --[[ TExp ]]Block.__(1, {
                        marks,
                        eps_expr
                      }),
                    rem
                  };
          end else do
            return rem;
          end end  end end 
       if ___conditional___ == 1--[[ Alt ]] then do
          return delta_2(marks, c, next_cat, prev_cat, match[0], rem); end end 
       if ___conditional___ == 2--[[ Seq ]] then do
          y$prime = delta_1(marks, c, next_cat, prev_cat, match[1], --[[ [] ]]0);
          return delta_seq(c, next_cat, prev_cat, match[0], y$prime, match[2], rem); end end 
       if ___conditional___ == 3--[[ Rep ]] then do
          kind = match[1];
          y$prime_1 = delta_1(marks, c, next_cat, prev_cat, match[2], --[[ [] ]]0);
          match_1 = first((function(param) do
                  local ___conditional___=(param.tag | 0);
                  do
                     if ___conditional___ == 0--[[ TSeq ]]
                     or ___conditional___ == 1--[[ TExp ]] then do
                        return ; end end 
                     if ___conditional___ == 2--[[ TMatch ]] then do
                        return param[0]; end end 
                    
                  end
                end end), y$prime_1);
          match_2 = match_1 ~= undefined and --[[ tuple ]]{
              Curry._1(remove_matches, y$prime_1),
              match_1
            } or --[[ tuple ]]{
              y$prime_1,
              marks
            };
          y$prime$prime = match_2[0];
          if (match[0] >= 620821490) then do
            return --[[ :: ]]{
                    --[[ TMatch ]]Block.__(2, {marks}),
                    tseq(kind, y$prime$prime, x, rem)
                  };
          end else do
            return tseq(kind, y$prime$prime, x, --[[ :: ]]{
                        --[[ TMatch ]]Block.__(2, {match_2[1]}),
                        rem
                      });
          end end  end end 
       if ___conditional___ == 4--[[ Mark ]] then do
          i = match[0];
          marks_marks = --[[ :: ]]{
            --[[ tuple ]]{
              i,
              -1
            },
            List.remove_assq(i, marks.marks)
          };
          marks_pmarks = marks.pmarks;
          marks_1 = do
            marks: marks_marks,
            pmarks: marks_pmarks
          end;
          return --[[ :: ]]{
                  --[[ TMatch ]]Block.__(2, {marks_1}),
                  rem
                }; end end 
       if ___conditional___ == 5--[[ Erase ]] then do
          return --[[ :: ]]{
                  --[[ TMatch ]]Block.__(2, {filter_marks(match[0], match[1], marks)}),
                  rem
                }; end end 
       if ___conditional___ == 6--[[ Before ]] then do
          if (intersect(next_cat, match[0])) then do
            return --[[ :: ]]{
                    --[[ TMatch ]]Block.__(2, {marks}),
                    rem
                  };
          end else do
            return rem;
          end end  end end 
       if ___conditional___ == 7--[[ After ]] then do
          if (intersect(prev_cat, match[0])) then do
            return --[[ :: ]]{
                    --[[ TMatch ]]Block.__(2, {marks}),
                    rem
                  };
          end else do
            return rem;
          end end  end end 
       if ___conditional___ == 8--[[ Pmark ]] then do
          marks_marks_1 = marks.marks;
          marks_pmarks_1 = add_1(match[0], marks.pmarks);
          marks_2 = do
            marks: marks_marks_1,
            pmarks: marks_pmarks_1
          end;
          return --[[ :: ]]{
                  --[[ TMatch ]]Block.__(2, {marks_2}),
                  rem
                }; end end 
      
    end
  end end 
end end

function delta_2(marks, c, next_cat, prev_cat, l, rem) do
  if (l) then do
    return delta_1(marks, c, next_cat, prev_cat, l[0], delta_2(marks, c, next_cat, prev_cat, l[1], rem));
  end else do
    return rem;
  end end 
end end

function delta_seq(c, next_cat, prev_cat, kind, y, z, rem) do
  match = first((function(param) do
          local ___conditional___=(param.tag | 0);
          do
             if ___conditional___ == 0--[[ TSeq ]]
             or ___conditional___ == 1--[[ TExp ]] then do
                return ; end end 
             if ___conditional___ == 2--[[ TMatch ]] then do
                return param[0]; end end 
            
          end
        end end), y);
  if (match ~= undefined) then do
    marks = match;
    if (kind ~= -730718166) then do
      if (kind >= 332064784) then do
        match_1 = split_at_match_rec(--[[ [] ]]0, y);
        return tseq(kind, match_1[0], z, delta_1(marks, c, next_cat, prev_cat, z, tseq(kind, match_1[1], z, rem)));
      end else do
        return delta_1(marks, c, next_cat, prev_cat, z, tseq(kind, Curry._1(remove_matches, y), z, rem));
      end end 
    end else do
      return tseq(kind, Curry._1(remove_matches, y), z, delta_1(marks, c, next_cat, prev_cat, z, rem));
    end end 
  end else do
    return tseq(kind, y, z, rem);
  end end 
end end

function delta_4(c, next_cat, prev_cat, l, rem) do
  if (l) then do
    c_1 = c;
    next_cat_1 = next_cat;
    prev_cat_1 = prev_cat;
    x = l[0];
    rem_1 = delta_4(c, next_cat, prev_cat, l[1], rem);
    local ___conditional___=(x.tag | 0);
    do
       if ___conditional___ == 0--[[ TSeq ]] then do
          y$prime = delta_4(c_1, next_cat_1, prev_cat_1, x[0], --[[ [] ]]0);
          return delta_seq(c_1, next_cat_1, prev_cat_1, x[2], y$prime, x[1], rem_1); end end 
       if ___conditional___ == 1--[[ TExp ]] then do
          return delta_1(x[0], c_1, next_cat_1, prev_cat_1, x[1], rem_1); end end 
       if ___conditional___ == 2--[[ TMatch ]] then do
          return --[[ :: ]]{
                  x,
                  rem_1
                }; end end 
      
    end
  end else do
    return rem;
  end end 
end end

function delta(tbl_ref, next_cat, __char, st) do
  prev_cat = st.category;
  match = remove_duplicates(--[[ [] ]]0, delta_4(__char, next_cat, prev_cat, st.desc, --[[ [] ]]0), eps_expr);
  expr$prime = match[0];
  idx = free_index(tbl_ref, expr$prime);
  expr$prime$prime = set_idx(idx, expr$prime);
  return mk(idx, next_cat, expr$prime$prime);
end end

function flatten_match(m) do
  ma = List.fold_left((function(ma, param) do
          return Caml_primitive.caml_int_max(ma, param[0]);
        end end), -1, m);
  res = Caml_array.caml_make_vect(ma + 1 | 0, -1);
  List.iter((function(param) do
          return Caml_array.caml_array_set(res, param[0], param[1]);
        end end), m);
  return res;
end end

function status(s) do
  match = s.status;
  if (match ~= undefined) then do
    return match;
  end else do
    match_1 = s.desc;
    st;
    if (match_1) then do
      match_2 = match_1[0];
      local ___conditional___=(match_2.tag | 0);
      do
         if ___conditional___ == 0--[[ TSeq ]]
         or ___conditional___ == 1--[[ TExp ]] then do
            st = --[[ Running ]]1; end else 
         if ___conditional___ == 2--[[ TMatch ]] then do
            m = match_2[0];
            st = --[[ Match ]]{
              flatten_match(m.marks),
              m.pmarks
            }; end else 
         end end end end
        
      end
    end else do
      st = --[[ Failed ]]0;
    end end 
    s.status = st;
    return st;
  end end 
end end

Re_automata_Category = do
  $plus$plus: $plus$plus,
  from_char: from_char,
  inexistant: 1,
  letter: 2,
  not_letter: 4,
  newline: 8,
  lastnewline: 16,
  search_boundary: 32
end;

Re_automata_State = do
  dummy: dummy,
  create: create_2,
  Table: Table
end;

function iter(_n, f, _v) do
  while(true) do
    v = _v;
    n = _n;
    if (n == 0) then do
      return v;
    end else do
      _v = Curry._1(f, v);
      _n = n - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function category(re, c) do
  if (c == -1) then do
    return Re_automata_Category.inexistant;
  end else if (c == re.lnl) then do
    return Curry._2(Re_automata_Category.$plus$plus, Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.lastnewline, Re_automata_Category.newline), Re_automata_Category.not_letter);
  end else do
    return Curry._1(Re_automata_Category.from_char, Caml_bytes.get(re.col_repr, c));
  end end  end 
end end

dummy_next = {};

unknown_state = do
  idx: -2,
  real_idx: 0,
  next: dummy_next,
  final: --[[ [] ]]0,
  desc: Re_automata_State.dummy
end;

function mk_state(ncol, desc) do
  match = status(desc);
  break_state = typeof match == "number" and match == 0 or true;
  return do
          idx: break_state and -3 or desc.idx,
          real_idx: desc.idx,
          next: break_state and dummy_next or Caml_array.caml_make_vect(ncol, unknown_state),
          final: --[[ [] ]]0,
          desc: desc
        end;
end end

function find_state(re, desc) do
  xpcall(function() do
    return Curry._2(Re_automata_State.Table.find, re.states, desc);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      st = mk_state(re.ncol, desc);
      Curry._3(Re_automata_State.Table.add, re.states, desc, st);
      return st;
    end else do
      error(exn)
    end end 
  end end)
end end

function delta_1(info, cat, c, st) do
  desc = delta(info.re.tbl, cat, c, st.desc);
  len = #info.positions;
  if (desc.idx == len and len > 0) then do
    pos = info.positions;
    info.positions = Caml_array.caml_make_vect((len << 1), 0);
    __Array.blit(pos, 0, info.positions, 0, len);
  end
   end 
  return desc;
end end

function validate(info, s, pos, st) do
  c = Caml_bytes.get(info.i_cols, Caml_string.get(s, pos));
  cat = category(info.re, c);
  desc$prime = delta_1(info, cat, c, st);
  st$prime = find_state(info.re, desc$prime);
  return Caml_array.caml_array_set(st.next, c, st$prime);
end end

function loop(info, s, pos, st) do
  if (pos < info.last) then do
    st$prime = Caml_array.caml_array_get(st.next, Caml_bytes.get(info.i_cols, Caml_string.get(s, pos)));
    info_1 = info;
    s_1 = s;
    _pos = pos;
    _st = st;
    _st$prime = st$prime;
    while(true) do
      st$prime_1 = _st$prime;
      st_1 = _st;
      pos_1 = _pos;
      if (st$prime_1.idx >= 0) then do
        pos_2 = pos_1 + 1 | 0;
        if (pos_2 < info_1.last) then do
          st$prime$prime = Caml_array.caml_array_get(st$prime_1.next, Caml_bytes.get(info_1.i_cols, Caml_string.get(s_1, pos_2)));
          Caml_array.caml_array_set(info_1.positions, st$prime_1.idx, pos_2);
          _st$prime = st$prime$prime;
          _st = st$prime_1;
          _pos = pos_2;
          ::continue:: ;
        end else do
          Caml_array.caml_array_set(info_1.positions, st$prime_1.idx, pos_2);
          return st$prime_1;
        end end 
      end else if (st$prime_1.idx == -3) then do
        Caml_array.caml_array_set(info_1.positions, st$prime_1.real_idx, pos_1 + 1 | 0);
        return st$prime_1;
      end else do
        validate(info_1, s_1, pos_1, st_1);
        return loop(info_1, s_1, pos_1, st_1);
      end end  end 
    end;
  end else do
    return st;
  end end 
end end

function __final(info, st, cat) do
  xpcall(function() do
    return List.assq(cat, st.final);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      st$prime = delta_1(info, cat, -1, st);
      res_000 = st$prime.idx;
      res_001 = status(st$prime);
      res = --[[ tuple ]]{
        res_000,
        res_001
      };
      st.final = --[[ :: ]]{
        --[[ tuple ]]{
          cat,
          res
        },
        st.final
      };
      return res;
    end else do
      error(exn)
    end end 
  end end)
end end

function find_initial_state(re, cat) do
  xpcall(function() do
    return List.assq(cat, re.initial_states);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      st = find_state(re, Curry._2(Re_automata_State.create, cat, re.initial));
      re.initial_states = --[[ :: ]]{
        --[[ tuple ]]{
          cat,
          st
        },
        re.initial_states
      };
      return st;
    end else do
      error(exn)
    end end 
  end end)
end end

function get_color(re, s, pos) do
  if (pos < 0) then do
    return -1;
  end else do
    slen = #s;
    if (pos >= slen) then do
      return -1;
    end else if (pos == (slen - 1 | 0) and re.lnl ~= -1 and Caml_string.get(s, pos) == --[[ "\n" ]]10) then do
      return re.lnl;
    end else do
      return Caml_bytes.get(re.cols, Caml_string.get(s, pos));
    end end  end 
  end end 
end end

function scan_str(info, s, initial_state, groups) do
  pos = info.pos;
  last = info.last;
  if (last == #s and info.re.lnl ~= -1 and last > pos and Caml_string.get(s, last - 1 | 0) == --[[ "\n" ]]10) then do
    info_1 = do
      re: info.re,
      i_cols: info.i_cols,
      positions: info.positions,
      pos: info.pos,
      last: last - 1 | 0
    end;
    st = scan_str(info_1, s, initial_state, groups);
    if (st.idx == -3) then do
      return st;
    end else do
      info_2 = info_1;
      pos_1 = last - 1 | 0;
      st_1 = st;
      groups_1 = groups;
      while(true) do
        st$prime = Caml_array.caml_array_get(st_1.next, info_2.re.lnl);
        if (st$prime.idx >= 0) then do
          if (groups_1) then do
            Caml_array.caml_array_set(info_2.positions, st$prime.idx, pos_1 + 1 | 0);
          end
           end 
          return st$prime;
        end else if (st$prime.idx == -3) then do
          if (groups_1) then do
            Caml_array.caml_array_set(info_2.positions, st$prime.real_idx, pos_1 + 1 | 0);
          end
           end 
          return st$prime;
        end else do
          c = info_2.re.lnl;
          real_c = Caml_bytes.get(info_2.i_cols, --[[ "\n" ]]10);
          cat = category(info_2.re, c);
          desc$prime = delta_1(info_2, cat, real_c, st_1);
          st$prime_1 = find_state(info_2.re, desc$prime);
          Caml_array.caml_array_set(st_1.next, c, st$prime_1);
          ::continue:: ;
        end end  end 
      end;
    end end 
  end else if (groups) then do
    return loop(info, s, pos, initial_state);
  end else do
    info_3 = info;
    s_1 = s;
    _pos = pos;
    last_1 = last;
    _st = initial_state;
    while(true) do
      st_2 = _st;
      pos_2 = _pos;
      if (pos_2 < last_1) then do
        st$prime_2 = Caml_array.caml_array_get(st_2.next, Caml_bytes.get(info_3.i_cols, Caml_string.get(s_1, pos_2)));
        if (st$prime_2.idx >= 0) then do
          _st = st$prime_2;
          _pos = pos_2 + 1 | 0;
          ::continue:: ;
        end else if (st$prime_2.idx == -3) then do
          return st$prime_2;
        end else do
          validate(info_3, s_1, pos_2, st_2);
          ::continue:: ;
        end end  end 
      end else do
        return st_2;
      end end 
    end;
  end end  end 
end end

function cadd(c, s) do
  return union(single(c), s);
end end

function trans_set(cache, cm, s) do
  match = one_char(s);
  if (match ~= undefined) then do
    return single(Caml_bytes.get(cm, match));
  end else do
    v_000 = hash_rec(s);
    v = --[[ tuple ]]{
      v_000,
      s
    };
    xpcall(function() do
      x = v;
      _param = cache.contents;
      while(true) do
        param = _param;
        if (param) then do
          c = compare(x, param[--[[ v ]]1]);
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
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        l = List.fold_right((function(param, l) do
                return union(seq(Caml_bytes.get(cm, param[0]), Caml_bytes.get(cm, param[1])), l);
              end end), s, --[[ [] ]]0);
        cache.contents = add(v, l, cache.contents);
        return l;
      end else do
        error(exn)
      end end 
    end end)
  end end 
end end

function is_charset(_param) do
  while(true) do
    param = _param;
    if (typeof param == "number") then do
      return false;
    end else do
      local ___conditional___=(param.tag | 0);
      do
         if ___conditional___ == 0--[[ Set ]] then do
            return true; end end 
         if ___conditional___ == 4--[[ Sem ]]
         or ___conditional___ == 5--[[ Sem_greedy ]] then do
            _param = param[1];
            ::continue:: ; end end 
         if ___conditional___ == 7--[[ No_group ]]
         or ___conditional___ == 9--[[ Case ]]
         or ___conditional___ == 10--[[ No_case ]] then do
            _param = param[0];
            ::continue:: ; end end 
         if ___conditional___ == 2--[[ Alternative ]]
         or ___conditional___ == 11--[[ Intersection ]]
         or ___conditional___ == 12--[[ Complement ]] then do
            return List.for_all(is_charset, param[0]); end end 
         if ___conditional___ == 13--[[ Difference ]] then do
            if (is_charset(param[0])) then do
              _param = param[1];
              ::continue:: ;
            end else do
              return false;
            end end  end end 
        return false;
          
      end
    end end 
  end;
end end

function split(s, cm) do
  _t = s;
  f = function(i, j) do
    cm[i] = --[[ "\001" ]]1;
    cm[j + 1 | 0] = --[[ "\001" ]]1;
    return --[[ () ]]0;
  end end;
  while(true) do
    t = _t;
    if (t) then do
      match = t[0];
      Curry._2(f, match[0], match[1]);
      _t = t[1];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

cupper = union(seq(--[[ "A" ]]65, --[[ "Z" ]]90), union(seq(--[[ "\192" ]]192, --[[ "\214" ]]214), seq(--[[ "\216" ]]216, --[[ "\222" ]]222)));

clower = offset(32, cupper);

calpha = List.fold_right(cadd, --[[ :: ]]{
      --[[ "\170" ]]170,
      --[[ :: ]]{
        --[[ "\181" ]]181,
        --[[ :: ]]{
          --[[ "\186" ]]186,
          --[[ :: ]]{
            --[[ "\223" ]]223,
            --[[ :: ]]{
              --[[ "\255" ]]255,
              --[[ [] ]]0
            }
          }
        }
      }
    }, union(clower, cupper));

cdigit = seq(--[[ "0" ]]48, --[[ "9" ]]57);

calnum = union(calpha, cdigit);

cword = union(--[[ :: ]]{
      --[[ tuple ]]{
        --[[ "_" ]]95,
        --[[ "_" ]]95
      },
      --[[ [] ]]0
    }, calnum);

function colorize(c, regexp) do
  lnl = do
    contents: false
  end;
  colorize_1 = function(_regexp) do
    while(true) do
      regexp = _regexp;
      if (typeof regexp == "number") then do
        local ___conditional___=(regexp);
        do
           if ___conditional___ == 0--[[ Beg_of_line ]]
           or ___conditional___ == 1--[[ End_of_line ]] then do
              return split(--[[ :: ]]{
                          --[[ tuple ]]{
                            --[[ "\n" ]]10,
                            --[[ "\n" ]]10
                          },
                          --[[ [] ]]0
                        }, c); end end 
           if ___conditional___ == 2--[[ Beg_of_word ]]
           or ___conditional___ == 3--[[ End_of_word ]]
           or ___conditional___ == 4--[[ Not_bound ]] then do
              return split(cword, c); end end 
           if ___conditional___ == 7--[[ Last_end_of_line ]] then do
              lnl.contents = true;
              return --[[ () ]]0; end end 
           if ___conditional___ == 5--[[ Beg_of_str ]]
           or ___conditional___ == 6--[[ End_of_str ]]
           or ___conditional___ == 8--[[ Start ]]
           or ___conditional___ == 9--[[ Stop ]] then do
              return --[[ () ]]0; end end 
          
        end
      end else do
        local ___conditional___=(regexp.tag | 0);
        do
           if ___conditional___ == 0--[[ Set ]] then do
              return split(regexp[0], c); end end 
           if ___conditional___ == 1--[[ Sequence ]]
           or ___conditional___ == 2--[[ Alternative ]] then do
              return List.iter(colorize_1, regexp[0]); end end 
           if ___conditional___ == 3--[[ Repeat ]]
           or ___conditional___ == 6--[[ Group ]]
           or ___conditional___ == 7--[[ No_group ]]
           or ___conditional___ == 8--[[ Nest ]] then do
              _regexp = regexp[0];
              ::continue:: ; end end 
           if ___conditional___ == 4--[[ Sem ]]
           or ___conditional___ == 5--[[ Sem_greedy ]]
           or ___conditional___ == 14--[[ Pmark ]] then do
              _regexp = regexp[1];
              ::continue:: ; end end 
          error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "re.ml",
                502,
                35
              }
            })
            
        end
      end end 
    end;
  end end;
  colorize_1(regexp);
  return lnl.contents;
end end

function flatten_cmap(cm) do
  c = Caml_bytes.caml_create_bytes(256);
  col_repr = Caml_bytes.caml_create_bytes(256);
  v = 0;
  c[0] = --[[ "\000" ]]0;
  col_repr[0] = --[[ "\000" ]]0;
  for i = 1 , 255 , 1 do
    if (Caml_bytes.get(cm, i) ~= --[[ "\000" ]]0) then do
      v = v + 1 | 0;
    end
     end 
    c[i] = Char.chr(v);
    col_repr[v] = Char.chr(i);
  end
  return --[[ tuple ]]{
          c,
          Bytes.sub(col_repr, 0, v + 1 | 0),
          v + 1 | 0
        };
end end

function equal_2(_x1, _x2) do
  while(true) do
    x2 = _x2;
    x1 = _x1;
    if (typeof x1 == "number") then do
      local ___conditional___=(x1);
      do
         if ___conditional___ == 0--[[ Beg_of_line ]] then do
            if (typeof x2 == "number") then do
              return x2 == 0;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 1--[[ End_of_line ]] then do
            if (typeof x2 == "number") then do
              return x2 == 1;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 2--[[ Beg_of_word ]] then do
            if (typeof x2 == "number") then do
              return x2 == 2;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 3--[[ End_of_word ]] then do
            if (typeof x2 == "number") then do
              return x2 == 3;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 4--[[ Not_bound ]] then do
            if (typeof x2 == "number") then do
              return x2 == 4;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 5--[[ Beg_of_str ]] then do
            if (typeof x2 == "number") then do
              return x2 == 5;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 6--[[ End_of_str ]] then do
            if (typeof x2 == "number") then do
              return x2 == 6;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 7--[[ Last_end_of_line ]] then do
            if (typeof x2 == "number") then do
              return x2 == 7;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 8--[[ Start ]] then do
            if (typeof x2 == "number") then do
              return x2 == 8;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 9--[[ Stop ]] then do
            if (typeof x2 == "number") then do
              return x2 >= 9;
            end else do
              return false;
            end end  end end 
        
      end
    end else do
      local ___conditional___=(x1.tag | 0);
      do
         if ___conditional___ == 0--[[ Set ]] then do
            if (typeof x2 == "number" or x2.tag) then do
              return false;
            end else do
              return Caml_obj.caml_equal(x1[0], x2[0]);
            end end  end end 
         if ___conditional___ == 1--[[ Sequence ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Sequence ]]1) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end  end end 
         if ___conditional___ == 2--[[ Alternative ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Alternative ]]2) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end  end end 
         if ___conditional___ == 3--[[ Repeat ]] then do
            if (typeof x2 == "number" or not (x2.tag == --[[ Repeat ]]3 and x1[1] == x2[1] and Caml_obj.caml_equal(x1[2], x2[2]))) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 4--[[ Sem ]] then do
            if (typeof x2 == "number" or not (x2.tag == --[[ Sem ]]4 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 5--[[ Sem_greedy ]] then do
            if (typeof x2 == "number" or not (x2.tag == --[[ Sem_greedy ]]5 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 6--[[ Group ]] then do
            return false; end end 
         if ___conditional___ == 7--[[ No_group ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ No_group ]]7) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 8--[[ Nest ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Nest ]]8) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 9--[[ Case ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Case ]]9) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 10--[[ No_case ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ No_case ]]10) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 11--[[ Intersection ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Intersection ]]11) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end  end end 
         if ___conditional___ == 12--[[ Complement ]] then do
            if (typeof x2 == "number" or x2.tag ~= --[[ Complement ]]12) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end  end end 
         if ___conditional___ == 13--[[ Difference ]] then do
            if (typeof x2 == "number" or not (x2.tag == --[[ Difference ]]13 and equal_2(x1[0], x2[0]))) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 14--[[ Pmark ]] then do
            if (typeof x2 == "number" or not (x2.tag == --[[ Pmark ]]14 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              ::continue:: ;
            end end  end end 
        
      end
    end end 
  end;
end end

function eq_list(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2 and equal_2(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function sequence(l) do
  if (l and not l[1]) then do
    return l[0];
  end else do
    return --[[ Sequence ]]Block.__(1, {l});
  end end 
end end

function merge_sequences(_param) do
  while(true) do
    param = _param;
    if (param) then do
      x = param[0];
      if (typeof x ~= "number") then do
        local ___conditional___=(x.tag | 0);
        do
           if ___conditional___ == 1--[[ Sequence ]] then do
              match = x[0];
              if (match) then do
                y = match[1];
                x_1 = match[0];
                r$prime = merge_sequences(param[1]);
                exit = 0;
                if (r$prime) then do
                  match_1 = r$prime[0];
                  if (typeof match_1 == "number" or match_1.tag ~= --[[ Sequence ]]1) then do
                    exit = 2;
                  end else do
                    match_2 = match_1[0];
                    if (match_2 and equal_2(x_1, match_2[0])) then do
                      return --[[ :: ]]{
                              --[[ Sequence ]]Block.__(1, {--[[ :: ]]{
                                    x_1,
                                    --[[ :: ]]{
                                      --[[ Alternative ]]Block.__(2, {--[[ :: ]]{
                                            sequence(y),
                                            --[[ :: ]]{
                                              sequence(match_2[1]),
                                              --[[ [] ]]0
                                            }
                                          }}),
                                      --[[ [] ]]0
                                    }
                                  }}),
                              r$prime[1]
                            };
                    end else do
                      exit = 2;
                    end end 
                  end end 
                end else do
                  exit = 2;
                end end 
                if (exit == 2) then do
                  return --[[ :: ]]{
                          --[[ Sequence ]]Block.__(1, {--[[ :: ]]{
                                x_1,
                                y
                              }}),
                          r$prime
                        };
                end
                 end 
              end
               end  end else 
           if ___conditional___ == 2--[[ Alternative ]] then do
              _param = Pervasives.$at(x[0], param[1]);
              ::continue:: ; end end end end 
          
        end
      end
       end 
      return --[[ :: ]]{
              x,
              merge_sequences(param[1])
            };
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function enforce_kind(ids, kind, kind$prime, cr) do
  if (kind ~= 332064784 or kind$prime == 332064784) then do
    return cr;
  end else do
    return seq_1(ids, kind$prime, cr, mk_expr(ids, --[[ Eps ]]0));
  end end 
end end

function translate(ids, kind, _ign_group, ign_case, _greedy, pos, cache, c, _param) do
  while(true) do
    param = _param;
    greedy = _greedy;
    ign_group = _ign_group;
    if (typeof param == "number") then do
      local ___conditional___=(param);
      do
         if ___conditional___ == 0--[[ Beg_of_line ]] then do
            c_1 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.newline);
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ After ]]Block.__(7, {c_1})),
                    kind
                  }; end end 
         if ___conditional___ == 1--[[ End_of_line ]] then do
            c_2 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.newline);
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ Before ]]Block.__(6, {c_2})),
                    kind
                  }; end end 
         if ___conditional___ == 2--[[ Beg_of_word ]] then do
            c_3 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.not_letter);
            c_4 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.letter);
            return --[[ tuple ]]{
                    seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ After ]]Block.__(7, {c_3})), mk_expr(ids, --[[ Before ]]Block.__(6, {c_4}))),
                    kind
                  }; end end 
         if ___conditional___ == 3--[[ End_of_word ]] then do
            c_5 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.letter);
            c_6 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.not_letter);
            return --[[ tuple ]]{
                    seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ After ]]Block.__(7, {c_5})), mk_expr(ids, --[[ Before ]]Block.__(6, {c_6}))),
                    kind
                  }; end end 
         if ___conditional___ == 4--[[ Not_bound ]] then do
            return --[[ tuple ]]{
                    alt(ids, --[[ :: ]]{
                          seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ After ]]Block.__(7, {Re_automata_Category.letter})), mk_expr(ids, --[[ Before ]]Block.__(6, {Re_automata_Category.letter}))),
                          --[[ :: ]]{
                            seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ After ]]Block.__(7, {Re_automata_Category.letter})), mk_expr(ids, --[[ Before ]]Block.__(6, {Re_automata_Category.letter}))),
                            --[[ [] ]]0
                          }
                        }),
                    kind
                  }; end end 
         if ___conditional___ == 5--[[ Beg_of_str ]] then do
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ After ]]Block.__(7, {Re_automata_Category.inexistant})),
                    kind
                  }; end end 
         if ___conditional___ == 6--[[ End_of_str ]] then do
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ Before ]]Block.__(6, {Re_automata_Category.inexistant})),
                    kind
                  }; end end 
         if ___conditional___ == 7--[[ Last_end_of_line ]] then do
            c_7 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.lastnewline);
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ Before ]]Block.__(6, {c_7})),
                    kind
                  }; end end 
         if ___conditional___ == 8--[[ Start ]] then do
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ After ]]Block.__(7, {Re_automata_Category.search_boundary})),
                    kind
                  }; end end 
         if ___conditional___ == 9--[[ Stop ]] then do
            return --[[ tuple ]]{
                    mk_expr(ids, --[[ Before ]]Block.__(6, {Re_automata_Category.search_boundary})),
                    kind
                  }; end end 
        
      end
    end else do
      local ___conditional___=(param.tag | 0);
      do
         if ___conditional___ == 0--[[ Set ]] then do
            return --[[ tuple ]]{
                    cst(ids, trans_set(cache, c, param[0])),
                    kind
                  }; end end 
         if ___conditional___ == 1--[[ Sequence ]] then do
            return --[[ tuple ]]{
                    trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]),
                    kind
                  }; end end 
         if ___conditional___ == 2--[[ Alternative ]] then do
            merged_sequences = merge_sequences(param[0]);
            if (merged_sequences and not merged_sequences[1]) then do
              match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, merged_sequences[0]);
              return --[[ tuple ]]{
                      enforce_kind(ids, kind, match[1], match[0]),
                      kind
                    };
            end
             end 
            return --[[ tuple ]]{
                    alt(ids, List.map((function(ign_group,greedy)do
                            return function (r$prime) do
                              match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r$prime);
                              return enforce_kind(ids, kind, match[1], match[0]);
                            end end
                            end end)(ign_group,greedy), merged_sequences)),
                    kind
                  }; end end 
         if ___conditional___ == 3--[[ Repeat ]] then do
            j = param[2];
            i = param[1];
            match_1 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]);
            kind$prime = match_1[1];
            cr = match_1[0];
            rem;
            if (j ~= undefined) then do
              f = greedy >= 620821490 and (function(cr,kind$prime)do
                return function (rem) do
                  return alt(ids, --[[ :: ]]{
                              mk_expr(ids, --[[ Eps ]]0),
                              --[[ :: ]]{
                                seq_1(ids, kind$prime, rename(ids, cr), rem),
                                --[[ [] ]]0
                              }
                            });
                end end
                end end)(cr,kind$prime) or (function(cr,kind$prime)do
                return function (rem) do
                  return alt(ids, --[[ :: ]]{
                              seq_1(ids, kind$prime, rename(ids, cr), rem),
                              --[[ :: ]]{
                                mk_expr(ids, --[[ Eps ]]0),
                                --[[ [] ]]0
                              }
                            });
                end end
                end end)(cr,kind$prime);
              rem = iter(j - i | 0, f, mk_expr(ids, --[[ Eps ]]0));
            end else do
              rem = rep(ids, greedy, kind$prime, cr);
            end end 
            return --[[ tuple ]]{
                    iter(i, (function(cr,kind$prime)do
                        return function (rem) do
                          return seq_1(ids, kind$prime, rename(ids, cr), rem);
                        end end
                        end end)(cr,kind$prime), rem),
                    kind
                  }; end end 
         if ___conditional___ == 4--[[ Sem ]] then do
            kind$prime_1 = param[0];
            match_2 = translate(ids, kind$prime_1, ign_group, ign_case, greedy, pos, cache, c, param[1]);
            return --[[ tuple ]]{
                    enforce_kind(ids, kind$prime_1, match_2[1], match_2[0]),
                    kind$prime_1
                  }; end end 
         if ___conditional___ == 5--[[ Sem_greedy ]] then do
            _param = param[1];
            _greedy = param[0];
            ::continue:: ; end end 
         if ___conditional___ == 6--[[ Group ]] then do
            r$prime = param[0];
            if (ign_group) then do
              _param = r$prime;
              ::continue:: ;
            end else do
              p = pos.contents;
              pos.contents = pos.contents + 2 | 0;
              match_3 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r$prime);
              return --[[ tuple ]]{
                      seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ Mark ]]Block.__(4, {p})), seq_1(ids, --[[ First ]]332064784, match_3[0], mk_expr(ids, --[[ Mark ]]Block.__(4, {p + 1 | 0})))),
                      match_3[1]
                    };
            end end  end end 
         if ___conditional___ == 7--[[ No_group ]] then do
            _param = param[0];
            _ign_group = true;
            ::continue:: ; end end 
         if ___conditional___ == 8--[[ Nest ]] then do
            b = pos.contents;
            match_4 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]);
            kind$prime_2 = match_4[1];
            cr_1 = match_4[0];
            e = pos.contents - 1 | 0;
            if (e < b) then do
              return --[[ tuple ]]{
                      cr_1,
                      kind$prime_2
                    };
            end else do
              return --[[ tuple ]]{
                      seq_1(ids, --[[ First ]]332064784, erase(ids, b, e), cr_1),
                      kind$prime_2
                    };
            end end  end end 
         if ___conditional___ == 14--[[ Pmark ]] then do
            match_5 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[1]);
            return --[[ tuple ]]{
                    seq_1(ids, --[[ First ]]332064784, mk_expr(ids, --[[ Pmark ]]Block.__(8, {param[0]})), match_5[0]),
                    match_5[1]
                  }; end end 
        error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "re.ml",
              714,
              4
            }
          })
          
      end
    end end 
  end;
end end

function trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param) do
  if (param) then do
    rem = param[1];
    r = param[0];
    if (rem) then do
      match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r);
      cr$prime = match[0];
      cr$prime$prime = trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, rem);
      if (is_eps(cr$prime$prime)) then do
        return cr$prime;
      end else if (is_eps(cr$prime)) then do
        return cr$prime$prime;
      end else do
        return seq_1(ids, match[1], cr$prime, cr$prime$prime);
      end end  end 
    end else do
      match_1 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r);
      return enforce_kind(ids, kind, match_1[1], match_1[0]);
    end end 
  end else do
    return mk_expr(ids, --[[ Eps ]]0);
  end end 
end end

function case_insens(s) do
  return union(s, union(offset(32, inter(s, cupper)), offset(-32, inter(s, clower))));
end end

function as_set(param) do
  if (typeof param == "number") then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "re.ml",
        747,
        13
      }
    })
  end else if (param.tag) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "re.ml",
        747,
        13
      }
    })
  end else do
    return param[0];
  end end  end 
end end

function handle_case(_ign_case, _r) do
  while(true) do
    r = _r;
    ign_case = _ign_case;
    if (typeof r == "number") then do
      return r;
    end else do
      local ___conditional___=(r.tag | 0);
      do
         if ___conditional___ == 0--[[ Set ]] then do
            s = r[0];
            return --[[ Set ]]Block.__(0, {ign_case and case_insens(s) or s}); end end 
         if ___conditional___ == 1--[[ Sequence ]] then do
            return --[[ Sequence ]]Block.__(1, {List.map((function(ign_case)do
                          return function (param) do
                            return handle_case(ign_case, param);
                          end end
                          end end)(ign_case), r[0])}); end end 
         if ___conditional___ == 2--[[ Alternative ]] then do
            l$prime = List.map((function(ign_case)do
                return function (param) do
                  return handle_case(ign_case, param);
                end end
                end end)(ign_case), r[0]);
            if (is_charset(--[[ Alternative ]]Block.__(2, {l$prime}))) then do
              return --[[ Set ]]Block.__(0, {List.fold_left((function(s, r) do
                                return union(s, as_set(r));
                              end end), --[[ [] ]]0, l$prime)});
            end else do
              return --[[ Alternative ]]Block.__(2, {l$prime});
            end end  end end 
         if ___conditional___ == 3--[[ Repeat ]] then do
            return --[[ Repeat ]]Block.__(3, {
                      handle_case(ign_case, r[0]),
                      r[1],
                      r[2]
                    }); end end 
         if ___conditional___ == 4--[[ Sem ]] then do
            r$prime = handle_case(ign_case, r[1]);
            if (is_charset(r$prime)) then do
              return r$prime;
            end else do
              return --[[ Sem ]]Block.__(4, {
                        r[0],
                        r$prime
                      });
            end end  end end 
         if ___conditional___ == 5--[[ Sem_greedy ]] then do
            r$prime_1 = handle_case(ign_case, r[1]);
            if (is_charset(r$prime_1)) then do
              return r$prime_1;
            end else do
              return --[[ Sem_greedy ]]Block.__(5, {
                        r[0],
                        r$prime_1
                      });
            end end  end end 
         if ___conditional___ == 6--[[ Group ]] then do
            return --[[ Group ]]Block.__(6, {handle_case(ign_case, r[0])}); end end 
         if ___conditional___ == 7--[[ No_group ]] then do
            r$prime_2 = handle_case(ign_case, r[0]);
            if (is_charset(r$prime_2)) then do
              return r$prime_2;
            end else do
              return --[[ No_group ]]Block.__(7, {r$prime_2});
            end end  end end 
         if ___conditional___ == 8--[[ Nest ]] then do
            r$prime_3 = handle_case(ign_case, r[0]);
            if (is_charset(r$prime_3)) then do
              return r$prime_3;
            end else do
              return --[[ Nest ]]Block.__(8, {r$prime_3});
            end end  end end 
         if ___conditional___ == 9--[[ Case ]] then do
            _r = r[0];
            _ign_case = false;
            ::continue:: ; end end 
         if ___conditional___ == 10--[[ No_case ]] then do
            _r = r[0];
            _ign_case = true;
            ::continue:: ; end end 
         if ___conditional___ == 11--[[ Intersection ]] then do
            l$prime_1 = List.map((function(ign_case)do
                return function (r) do
                  return handle_case(ign_case, r);
                end end
                end end)(ign_case), r[0]);
            return --[[ Set ]]Block.__(0, {List.fold_left((function(s, r) do
                              return inter(s, as_set(r));
                            end end), cany, l$prime_1)}); end end 
         if ___conditional___ == 12--[[ Complement ]] then do
            l$prime_2 = List.map((function(ign_case)do
                return function (r) do
                  return handle_case(ign_case, r);
                end end
                end end)(ign_case), r[0]);
            return --[[ Set ]]Block.__(0, {diff(cany, List.fold_left((function(s, r) do
                                  return union(s, as_set(r));
                                end end), --[[ [] ]]0, l$prime_2))}); end end 
         if ___conditional___ == 13--[[ Difference ]] then do
            return --[[ Set ]]Block.__(0, {inter(as_set(handle_case(ign_case, r[0])), diff(cany, as_set(handle_case(ign_case, r[1]))))}); end end 
         if ___conditional___ == 14--[[ Pmark ]] then do
            return --[[ Pmark ]]Block.__(14, {
                      r[0],
                      handle_case(ign_case, r[1])
                    }); end end 
        
      end
    end end 
  end;
end end

function anchored(_param) do
  while(true) do
    param = _param;
    if (typeof param == "number") then do
      local ___conditional___=(param);
      do
         if ___conditional___ == 5--[[ Beg_of_str ]]
         or ___conditional___ == 8--[[ Start ]] then do
            return true; end end 
        return false;
          
      end
    end else do
      local ___conditional___=(param.tag | 0);
      do
         if ___conditional___ == 1--[[ Sequence ]] then do
            return List.exists(anchored, param[0]); end end 
         if ___conditional___ == 2--[[ Alternative ]] then do
            return List.for_all(anchored, param[0]); end end 
         if ___conditional___ == 3--[[ Repeat ]] then do
            if (param[1] > 0) then do
              _param = param[0];
              ::continue:: ;
            end else do
              return false;
            end end  end end 
         if ___conditional___ == 6--[[ Group ]]
         or ___conditional___ == 7--[[ No_group ]]
         or ___conditional___ == 8--[[ Nest ]]
         or ___conditional___ == 9--[[ Case ]]
         or ___conditional___ == 10--[[ No_case ]] then do
            _param = param[0];
            ::continue:: ; end end 
         if ___conditional___ == 4--[[ Sem ]]
         or ___conditional___ == 5--[[ Sem_greedy ]]
         or ___conditional___ == 14--[[ Pmark ]] then do
            _param = param[1];
            ::continue:: ; end end 
        return false;
          
      end
    end end 
  end;
end end

function alt_1(l) do
  if (l and not l[1]) then do
    return l[0];
  end else do
    return --[[ Alternative ]]Block.__(2, {l});
  end end 
end end

function seq_2(l) do
  if (l and not l[1]) then do
    return l[0];
  end else do
    return --[[ Sequence ]]Block.__(1, {l});
  end end 
end end

epsilon = --[[ Sequence ]]Block.__(1, {--[[ [] ]]0});

function repn(r, i, j) do
  if (i < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Re.repn"
    })
  end
   end 
  if (j ~= undefined and j < i) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Re.repn"
    })
  end
   end 
  return --[[ Repeat ]]Block.__(3, {
            r,
            i,
            j
          });
end end

function set(str) do
  s = --[[ [] ]]0;
  for i = 0 , #str - 1 | 0 , 1 do
    s = union(single(Caml_string.get(str, i)), s);
  end
  return --[[ Set ]]Block.__(0, {s});
end end

function compl(l) do
  r = --[[ Complement ]]Block.__(12, {l});
  if (is_charset(r)) then do
    return r;
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Re.compl"
    })
  end end 
end end

any = --[[ Set ]]Block.__(0, {cany});

notnl = --[[ Set ]]Block.__(0, {diff(cany, --[[ :: ]]{
          --[[ tuple ]]{
            --[[ "\n" ]]10,
            --[[ "\n" ]]10
          },
          --[[ [] ]]0
        })});

lower = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ "a" ]]97, --[[ "z" ]]122)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {--[[ :: ]]{
              --[[ tuple ]]{
                --[[ "\181" ]]181,
                --[[ "\181" ]]181
              },
              --[[ [] ]]0
            }}),
        --[[ :: ]]{
          --[[ Set ]]Block.__(0, {seq(--[[ "\223" ]]223, --[[ "\246" ]]246)}),
          --[[ :: ]]{
            --[[ Set ]]Block.__(0, {seq(--[[ "\248" ]]248, --[[ "\255" ]]255)}),
            --[[ [] ]]0
          }
        }
      }
    });

upper = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ "A" ]]65, --[[ "Z" ]]90)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "\192" ]]192, --[[ "\214" ]]214)}),
        --[[ :: ]]{
          --[[ Set ]]Block.__(0, {seq(--[[ "\216" ]]216, --[[ "\222" ]]222)}),
          --[[ [] ]]0
        }
      }
    });

alpha = alt_1(--[[ :: ]]{
      lower,
      --[[ :: ]]{
        upper,
        --[[ :: ]]{
          --[[ Set ]]Block.__(0, {--[[ :: ]]{
                --[[ tuple ]]{
                  --[[ "\170" ]]170,
                  --[[ "\170" ]]170
                },
                --[[ [] ]]0
              }}),
          --[[ :: ]]{
            --[[ Set ]]Block.__(0, {--[[ :: ]]{
                  --[[ tuple ]]{
                    --[[ "\186" ]]186,
                    --[[ "\186" ]]186
                  },
                  --[[ [] ]]0
                }}),
            --[[ [] ]]0
          }
        }
      }
    });

digit = --[[ Set ]]Block.__(0, {seq(--[[ "0" ]]48, --[[ "9" ]]57)});

alnum = alt_1(--[[ :: ]]{
      alpha,
      --[[ :: ]]{
        digit,
        --[[ [] ]]0
      }
    });

wordc = alt_1(--[[ :: ]]{
      alnum,
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {--[[ :: ]]{
              --[[ tuple ]]{
                --[[ "_" ]]95,
                --[[ "_" ]]95
              },
              --[[ [] ]]0
            }}),
        --[[ [] ]]0
      }
    });

ascii = --[[ Set ]]Block.__(0, {seq(--[[ "\000" ]]0, --[[ "\127" ]]127)});

blank = set("\t ");

cntrl = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ "\000" ]]0, --[[ "\031" ]]31)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "\127" ]]127, --[[ "\159" ]]159)}),
        --[[ [] ]]0
      }
    });

graph = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ "!" ]]33, --[[ "~" ]]126)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "\160" ]]160, --[[ "\255" ]]255)}),
        --[[ [] ]]0
      }
    });

print = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ " " ]]32, --[[ "~" ]]126)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "\160" ]]160, --[[ "\255" ]]255)}),
        --[[ [] ]]0
      }
    });

punct = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {seq(--[[ "!" ]]33, --[[ "/" ]]47)}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ ":" ]]58, --[[ "@" ]]64)}),
        --[[ :: ]]{
          --[[ Set ]]Block.__(0, {seq(--[[ "[" ]]91, --[[ "`" ]]96)}),
          --[[ :: ]]{
            --[[ Set ]]Block.__(0, {seq(--[[ "{" ]]123, --[[ "~" ]]126)}),
            --[[ :: ]]{
              --[[ Set ]]Block.__(0, {seq(--[[ "\160" ]]160, --[[ "\169" ]]169)}),
              --[[ :: ]]{
                --[[ Set ]]Block.__(0, {seq(--[[ "\171" ]]171, --[[ "\180" ]]180)}),
                --[[ :: ]]{
                  --[[ Set ]]Block.__(0, {seq(--[[ "\182" ]]182, --[[ "\185" ]]185)}),
                  --[[ :: ]]{
                    --[[ Set ]]Block.__(0, {seq(--[[ "\187" ]]187, --[[ "\191" ]]191)}),
                    --[[ :: ]]{
                      --[[ Set ]]Block.__(0, {--[[ :: ]]{
                            --[[ tuple ]]{
                              --[[ "\215" ]]215,
                              --[[ "\215" ]]215
                            },
                            --[[ [] ]]0
                          }}),
                      --[[ :: ]]{
                        --[[ Set ]]Block.__(0, {--[[ :: ]]{
                              --[[ tuple ]]{
                                --[[ "\247" ]]247,
                                --[[ "\247" ]]247
                              },
                              --[[ [] ]]0
                            }}),
                        --[[ [] ]]0
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });

space = alt_1(--[[ :: ]]{
      --[[ Set ]]Block.__(0, {--[[ :: ]]{
            --[[ tuple ]]{
              --[[ " " ]]32,
              --[[ " " ]]32
            },
            --[[ [] ]]0
          }}),
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "\t" ]]9, --[[ "\r" ]]13)}),
        --[[ [] ]]0
      }
    });

xdigit = alt_1(--[[ :: ]]{
      digit,
      --[[ :: ]]{
        --[[ Set ]]Block.__(0, {seq(--[[ "a" ]]97, --[[ "f" ]]102)}),
        --[[ :: ]]{
          --[[ Set ]]Block.__(0, {seq(--[[ "A" ]]65, --[[ "F" ]]70)}),
          --[[ [] ]]0
        }
      }
    });

function compile(r) do
  regexp = anchored(r) and --[[ Group ]]Block.__(6, {r}) or seq_2(--[[ :: ]]{
          --[[ Sem ]]Block.__(4, {
              --[[ Shortest ]]-1034406550,
              repn(any, 0, undefined)
            }),
          --[[ :: ]]{
            --[[ Group ]]Block.__(6, {r}),
            --[[ [] ]]0
          }
        });
  regexp_1 = handle_case(false, regexp);
  c = Bytes.make(257, --[[ "\000" ]]0);
  need_lnl = colorize(c, regexp_1);
  match = flatten_cmap(c);
  ncol = match[2];
  col = match[0];
  lnl = need_lnl and ncol or -1;
  ncol_1 = need_lnl and ncol + 1 | 0 or ncol;
  ids = do
    contents: 0
  end;
  pos = do
    contents: 0
  end;
  match_1 = translate(ids, --[[ First ]]332064784, false, false, --[[ Greedy ]]-904640576, pos, do
        contents: --[[ Empty ]]0
      end, col, regexp_1);
  r_1 = enforce_kind(ids, --[[ First ]]332064784, match_1[1], match_1[0]);
  init = r_1;
  cols = col;
  col_repr = match[1];
  ncol_2 = ncol_1;
  lnl_1 = lnl;
  group_count = pos.contents / 2 | 0;
  return do
          initial: init,
          initial_states: --[[ [] ]]0,
          cols: cols,
          col_repr: col_repr,
          ncol: ncol_2,
          lnl: lnl_1,
          tbl: do
            contents: {false}
          end,
          states: Curry._1(Re_automata_State.Table.create, 97),
          group_count: group_count
        end;
end end

function exec_internal(name, posOpt, lenOpt, groups, re, s) do
  pos = posOpt ~= undefined and posOpt or 0;
  len = lenOpt ~= undefined and lenOpt or -1;
  if (pos < 0 or len < -1 or (pos + len | 0) > #s) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      name
    })
  end
   end 
  groups_1 = groups;
  partial = false;
  re_1 = re;
  s_1 = s;
  pos_1 = pos;
  len_1 = len;
  slen = #s_1;
  last = len_1 == -1 and slen or pos_1 + len_1 | 0;
  tmp;
  if (groups_1) then do
    n = #re_1.tbl.contents + 1 | 0;
    tmp = n <= 10 and {
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      } or Caml_array.caml_make_vect(n, 0);
  end else do
    tmp = {};
  end end 
  info = do
    re: re_1,
    i_cols: re_1.cols,
    positions: tmp,
    pos: pos_1,
    last: last
  end;
  initial_cat = pos_1 == 0 and Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, Re_automata_Category.inexistant) or Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, category(re_1, get_color(re_1, s_1, pos_1 - 1 | 0)));
  initial_state = find_initial_state(re_1, initial_cat);
  st = scan_str(info, s_1, initial_state, groups_1);
  res;
  if (st.idx == -3 or partial) then do
    res = status(st.desc);
  end else do
    final_cat = last == slen and Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, Re_automata_Category.inexistant) or Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, category(re_1, get_color(re_1, s_1, last)));
    match = __final(info, st, final_cat);
    if (groups_1) then do
      Caml_array.caml_array_set(info.positions, match[0], last + 1 | 0);
    end
     end 
    res = match[1];
  end end 
  if (typeof res == "number") then do
    if (res ~= 0) then do
      return --[[ Running ]]1;
    end else do
      return --[[ Failed ]]0;
    end end 
  end else do
    return --[[ Match ]]{do
              s: s_1,
              marks: res[0],
              pmarks: res[1],
              gpos: info.positions,
              gcount: re_1.group_count
            end};
  end end 
end end

function offset_1(t, i) do
  if (((i << 1) + 1 | 0) >= #t.marks) then do
    error(Caml_builtin_exceptions.not_found)
  end
   end 
  m1 = Caml_array.caml_array_get(t.marks, (i << 1));
  if (m1 == -1) then do
    error(Caml_builtin_exceptions.not_found)
  end
   end 
  p1 = Caml_array.caml_array_get(t.gpos, m1) - 1 | 0;
  p2 = Caml_array.caml_array_get(t.gpos, Caml_array.caml_array_get(t.marks, (i << 1) + 1 | 0)) - 1 | 0;
  return --[[ tuple ]]{
          p1,
          p2
        };
end end

function get(t, i) do
  match = offset_1(t, i);
  p1 = match[0];
  return __String.sub(t.s, p1, match[1] - p1 | 0);
end end

Parse_error = Caml_exceptions.create("Parse_error");

Not_supported = Caml_exceptions.create("Not_supported");

function posix_class_of_string(class_) do
  local ___conditional___=(class_);
  do
     if ___conditional___ == "alnum" then do
        return alnum; end end 
     if ___conditional___ == "ascii" then do
        return ascii; end end 
     if ___conditional___ == "blank" then do
        return blank; end end 
     if ___conditional___ == "cntrl" then do
        return cntrl; end end 
     if ___conditional___ == "digit" then do
        return digit; end end 
     if ___conditional___ == "graph" then do
        return graph; end end 
     if ___conditional___ == "lower" then do
        return lower; end end 
     if ___conditional___ == "print" then do
        return print; end end 
     if ___conditional___ == "punct" then do
        return punct; end end 
     if ___conditional___ == "space" then do
        return space; end end 
     if ___conditional___ == "upper" then do
        return upper; end end 
     if ___conditional___ == "word" then do
        return wordc; end end 
     if ___conditional___ == "xdigit" then do
        return xdigit; end end 
    s = "Invalid pcre class: " .. class_;
      error({
        Caml_builtin_exceptions.invalid_argument,
        s
      })
      
  end
end end

function parse(multiline, dollar_endonly, dotall, ungreedy, s) do
  i = do
    contents: 0
  end;
  l = #s;
  test = function(c) do
    if (i.contents ~= l) then do
      return Caml_string.get(s, i.contents) == c;
    end else do
      return false;
    end end 
  end end;
  accept = function(c) do
    r = test(c);
    if (r) then do
      i.contents = i.contents + 1 | 0;
    end
     end 
    return r;
  end end;
  accept_s = function(s$prime) do
    len = #s$prime;
    xpcall(function() do
      for j = 0 , len - 1 | 0 , 1 do
        xpcall(function() do
          if (Caml_string.get(s$prime, j) ~= Caml_string.get(s, i.contents + j | 0)) then do
            error(Pervasives.Exit)
          end
           end 
        end end,function(exn) do
          error(Pervasives.Exit)
        end end)
      end
      i.contents = i.contents + len | 0;
      return true;
    end end,function(exn_1) do
      if (exn_1 == Pervasives.Exit) then do
        return false;
      end else do
        error(exn_1)
      end end 
    end end)
  end end;
  get = function(param) do
    r = Caml_string.get(s, i.contents);
    i.contents = i.contents + 1 | 0;
    return r;
  end end;
  greedy_mod = function(r) do
    gr = accept(--[[ "?" ]]63);
    gr_1 = ungreedy and not gr or gr;
    if (gr_1) then do
      return --[[ Sem_greedy ]]Block.__(5, {
                --[[ Non_greedy ]]620821490,
                r
              });
    end else do
      return --[[ Sem_greedy ]]Block.__(5, {
                --[[ Greedy ]]-904640576,
                r
              });
    end end 
  end end;
  atom = function(param) do
    if (accept(--[[ "." ]]46)) then do
      if (dotall) then do
        return any;
      end else do
        return notnl;
      end end 
    end else if (accept(--[[ "(" ]]40)) then do
      if (accept(--[[ "?" ]]63)) then do
        if (accept(--[[ ":" ]]58)) then do
          r = regexp$prime(branch$prime(--[[ [] ]]0));
          if (not accept(--[[ ")" ]]41)) then do
            error(Parse_error)
          end
           end 
          return r;
        end else if (accept(--[[ "#" ]]35)) then do
          _param = --[[ () ]]0;
          while(true) do
            if (accept(--[[ ")" ]]41)) then do
              return epsilon;
            end else do
              i.contents = i.contents + 1 | 0;
              _param = --[[ () ]]0;
              ::continue:: ;
            end end 
          end;
        end else do
          error(Parse_error)
        end end  end 
      end else do
        r_1 = regexp$prime(branch$prime(--[[ [] ]]0));
        if (not accept(--[[ ")" ]]41)) then do
          error(Parse_error)
        end
         end 
        return --[[ Group ]]Block.__(6, {r_1});
      end end 
    end else if (accept(--[[ "^" ]]94)) then do
      if (multiline) then do
        return --[[ Beg_of_line ]]0;
      end else do
        return --[[ Beg_of_str ]]5;
      end end 
    end else if (accept(--[[ "$" ]]36)) then do
      if (multiline) then do
        return --[[ End_of_line ]]1;
      end else if (dollar_endonly) then do
        return --[[ Last_end_of_line ]]7;
      end else do
        return --[[ End_of_str ]]6;
      end end  end 
    end else if (accept(--[[ "[" ]]91)) then do
      if (accept(--[[ "^" ]]94)) then do
        return compl(bracket(--[[ [] ]]0));
      end else do
        return alt_1(bracket(--[[ [] ]]0));
      end end 
    end else if (accept(--[[ "\\" ]]92)) then do
      if (i.contents == l) then do
        error(Parse_error)
      end
       end 
      c = get(--[[ () ]]0);
      local ___conditional___=(c);
      do
         if ___conditional___ == 48
         or ___conditional___ == 49
         or ___conditional___ == 50
         or ___conditional___ == 51
         or ___conditional___ == 52
         or ___conditional___ == 53
         or ___conditional___ == 54
         or ___conditional___ == 55
         or ___conditional___ == 56
         or ___conditional___ == 57 then do
            error(Not_supported) end end 
         if ___conditional___ == 65 then do
            return --[[ Beg_of_str ]]5; end end 
         if ___conditional___ == 66 then do
            return --[[ Not_bound ]]4; end end 
         if ___conditional___ == 68 then do
            return compl(--[[ :: ]]{
                        digit,
                        --[[ [] ]]0
                      }); end end 
         if ___conditional___ == 71 then do
            return --[[ Start ]]8; end end 
         if ___conditional___ == 83 then do
            return compl(--[[ :: ]]{
                        space,
                        --[[ [] ]]0
                      }); end end 
         if ___conditional___ == 87 then do
            return compl(--[[ :: ]]{
                        alnum,
                        --[[ :: ]]{
                          --[[ Set ]]Block.__(0, {--[[ :: ]]{
                                --[[ tuple ]]{
                                  --[[ "_" ]]95,
                                  --[[ "_" ]]95
                                },
                                --[[ [] ]]0
                              }}),
                          --[[ [] ]]0
                        }
                      }); end end 
         if ___conditional___ == 90 then do
            return --[[ Last_end_of_line ]]7; end end 
         if ___conditional___ == 58
         or ___conditional___ == 59
         or ___conditional___ == 60
         or ___conditional___ == 61
         or ___conditional___ == 62
         or ___conditional___ == 63
         or ___conditional___ == 64
         or ___conditional___ == 91
         or ___conditional___ == 92
         or ___conditional___ == 93
         or ___conditional___ == 94
         or ___conditional___ == 95
         or ___conditional___ == 96 then do
            return --[[ Set ]]Block.__(0, {single(c)}); end end 
         if ___conditional___ == 98 then do
            return alt_1(--[[ :: ]]{
                        --[[ Beg_of_word ]]2,
                        --[[ :: ]]{
                          --[[ End_of_word ]]3,
                          --[[ [] ]]0
                        }
                      }); end end 
         if ___conditional___ == 100 then do
            return digit; end end 
         if ___conditional___ == 115 then do
            return space; end end 
         if ___conditional___ == 119 then do
            return alt_1(--[[ :: ]]{
                        alnum,
                        --[[ :: ]]{
                          --[[ Set ]]Block.__(0, {--[[ :: ]]{
                                --[[ tuple ]]{
                                  --[[ "_" ]]95,
                                  --[[ "_" ]]95
                                },
                                --[[ [] ]]0
                              }}),
                          --[[ [] ]]0
                        }
                      }); end end 
         if ___conditional___ == 67
         or ___conditional___ == 69
         or ___conditional___ == 70
         or ___conditional___ == 72
         or ___conditional___ == 73
         or ___conditional___ == 74
         or ___conditional___ == 75
         or ___conditional___ == 76
         or ___conditional___ == 77
         or ___conditional___ == 78
         or ___conditional___ == 79
         or ___conditional___ == 80
         or ___conditional___ == 81
         or ___conditional___ == 82
         or ___conditional___ == 84
         or ___conditional___ == 85
         or ___conditional___ == 86
         or ___conditional___ == 88
         or ___conditional___ == 89
         or ___conditional___ == 97
         or ___conditional___ == 99
         or ___conditional___ == 101
         or ___conditional___ == 102
         or ___conditional___ == 103
         or ___conditional___ == 104
         or ___conditional___ == 105
         or ___conditional___ == 106
         or ___conditional___ == 107
         or ___conditional___ == 108
         or ___conditional___ == 109
         or ___conditional___ == 110
         or ___conditional___ == 111
         or ___conditional___ == 112
         or ___conditional___ == 113
         or ___conditional___ == 114
         or ___conditional___ == 116
         or ___conditional___ == 117
         or ___conditional___ == 118
         or ___conditional___ == 120
         or ___conditional___ == 121 then do
            error(Parse_error) end end 
         if ___conditional___ == 122 then do
            return --[[ End_of_str ]]6; end end 
        return --[[ Set ]]Block.__(0, {single(c)});
          
      end
    end else do
      if (i.contents == l) then do
        error(Parse_error)
      end
       end 
      c_1 = get(--[[ () ]]0);
      if (c_1 >= 64) then do
        if (c_1 ~= 92) then do
          if (c_1 ~= 123) then do
            return --[[ Set ]]Block.__(0, {single(c_1)});
          end else do
            error(Parse_error)
          end end 
        end else do
          error(Parse_error)
        end end 
      end else if (c_1 >= 44) then do
        if (c_1 >= 63) then do
          error(Parse_error)
        end
         end 
        return --[[ Set ]]Block.__(0, {single(c_1)});
      end else do
        if (c_1 >= 42) then do
          error(Parse_error)
        end
         end 
        return --[[ Set ]]Block.__(0, {single(c_1)});
      end end  end 
    end end  end  end  end  end  end 
  end end;
  integer = function(param) do
    if (i.contents == l) then do
      return ;
    end else do
      d = get(--[[ () ]]0);
      if (d > 57 or d < 48) then do
        i.contents = i.contents - 1 | 0;
        return ;
      end else do
        _i = d - --[[ "0" ]]48 | 0;
        while(true) do
          i_1 = _i;
          if (i.contents == l) then do
            return i_1;
          end else do
            d_1 = get(--[[ () ]]0);
            if (d_1 > 57 or d_1 < 48) then do
              i.contents = i.contents - 1 | 0;
              return i_1;
            end else do
              i$prime = Caml_int32.imul(10, i_1) + (d_1 - --[[ "0" ]]48 | 0) | 0;
              if (i$prime < i_1) then do
                error(Parse_error)
              end
               end 
              _i = i$prime;
              ::continue:: ;
            end end 
          end end 
        end;
      end end 
    end end 
  end end;
  branch$prime = function(_left) do
    while(true) do
      left = _left;
      if (i.contents == l or test(--[[ "|" ]]124) or test(--[[ ")" ]]41)) then do
        return seq_2(List.rev(left));
      end else do
        _left = --[[ :: ]]{
          piece(--[[ () ]]0),
          left
        };
        ::continue:: ;
      end end 
    end;
  end end;
  regexp$prime = function(_left) do
    while(true) do
      left = _left;
      if (accept(--[[ "|" ]]124)) then do
        _left = alt_1(--[[ :: ]]{
              left,
              --[[ :: ]]{
                branch$prime(--[[ [] ]]0),
                --[[ [] ]]0
              }
            });
        ::continue:: ;
      end else do
        return left;
      end end 
    end;
  end end;
  bracket = function(_s) do
    while(true) do
      s = _s;
      if (s ~= --[[ [] ]]0 and accept(--[[ "]" ]]93)) then do
        return s;
      end else do
        match = __char(--[[ () ]]0);
        if (match[0] >= 748194550) then do
          c = match[1];
          if (accept(--[[ "-" ]]45)) then do
            if (accept(--[[ "]" ]]93)) then do
              return --[[ :: ]]{
                      --[[ Set ]]Block.__(0, {single(c)}),
                      --[[ :: ]]{
                        --[[ Set ]]Block.__(0, {--[[ :: ]]{
                              --[[ tuple ]]{
                                --[[ "-" ]]45,
                                --[[ "-" ]]45
                              },
                              --[[ [] ]]0
                            }}),
                        s
                      }
                    };
            end else do
              match_1 = __char(--[[ () ]]0);
              if (match_1[0] >= 748194550) then do
                _s = --[[ :: ]]{
                  --[[ Set ]]Block.__(0, {seq(c, match_1[1])}),
                  s
                };
                ::continue:: ;
              end else do
                return --[[ :: ]]{
                        --[[ Set ]]Block.__(0, {single(c)}),
                        --[[ :: ]]{
                          --[[ Set ]]Block.__(0, {--[[ :: ]]{
                                --[[ tuple ]]{
                                  --[[ "-" ]]45,
                                  --[[ "-" ]]45
                                },
                                --[[ [] ]]0
                              }}),
                          --[[ :: ]]{
                            match_1[1],
                            s
                          }
                        }
                      };
              end end 
            end end 
          end else do
            _s = --[[ :: ]]{
              --[[ Set ]]Block.__(0, {single(c)}),
              s
            };
            ::continue:: ;
          end end 
        end else do
          _s = --[[ :: ]]{
            match[1],
            s
          };
          ::continue:: ;
        end end 
      end end 
    end;
  end end;
  __char = function(param) do
    if (i.contents == l) then do
      error(Parse_error)
    end
     end 
    c = get(--[[ () ]]0);
    if (c == --[[ "[" ]]91) then do
      if (accept(--[[ "=" ]]61)) then do
        error(Not_supported)
      end
       end 
      if (accept(--[[ ":" ]]58)) then do
        compl_1 = accept(--[[ "^" ]]94);
        cls;
        xpcall(function() do
          cls = List.find(accept_s, --[[ :: ]]{
                "alnum",
                --[[ :: ]]{
                  "ascii",
                  --[[ :: ]]{
                    "blank",
                    --[[ :: ]]{
                      "cntrl",
                      --[[ :: ]]{
                        "digit",
                        --[[ :: ]]{
                          "lower",
                          --[[ :: ]]{
                            "print",
                            --[[ :: ]]{
                              "space",
                              --[[ :: ]]{
                                "upper",
                                --[[ :: ]]{
                                  "word",
                                  --[[ :: ]]{
                                    "punct",
                                    --[[ :: ]]{
                                      "graph",
                                      --[[ :: ]]{
                                        "xdigit",
                                        --[[ [] ]]0
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              });
        end end,function(exn) do
          if (exn == Caml_builtin_exceptions.not_found) then do
            error(Parse_error)
          end
           end 
          error(exn)
        end end)
        if (not accept_s(":]")) then do
          error(Parse_error)
        end
         end 
        posix_class = posix_class_of_string(cls);
        re = compl_1 and compl(--[[ :: ]]{
                posix_class,
                --[[ [] ]]0
              }) or posix_class;
        return --[[ `Set ]]{
                4150146,
                re
              };
      end else if (accept(--[[ "." ]]46)) then do
        if (i.contents == l) then do
          error(Parse_error)
        end
         end 
        c_1 = get(--[[ () ]]0);
        if (not accept(--[[ "." ]]46)) then do
          error(Not_supported)
        end
         end 
        if (not accept(--[[ "]" ]]93)) then do
          error(Parse_error)
        end
         end 
        return --[[ `Char ]]{
                748194550,
                c_1
              };
      end else do
        return --[[ `Char ]]{
                748194550,
                c
              };
      end end  end 
    end else if (c == --[[ "\\" ]]92) then do
      c_2 = get(--[[ () ]]0);
      if (c_2 >= 58) then do
        if (c_2 >= 123) then do
          return --[[ `Char ]]{
                  748194550,
                  c_2
                };
        end else do
          local ___conditional___=(c_2 - 58 | 0);
          do
             if ___conditional___ == 10 then do
                return --[[ `Set ]]{
                        4150146,
                        compl(--[[ :: ]]{
                              digit,
                              --[[ [] ]]0
                            })
                      }; end end 
             if ___conditional___ == 25 then do
                return --[[ `Set ]]{
                        4150146,
                        compl(--[[ :: ]]{
                              space,
                              --[[ [] ]]0
                            })
                      }; end end 
             if ___conditional___ == 29 then do
                return --[[ `Set ]]{
                        4150146,
                        compl(--[[ :: ]]{
                              alnum,
                              --[[ :: ]]{
                                --[[ Set ]]Block.__(0, {--[[ :: ]]{
                                      --[[ tuple ]]{
                                        --[[ "_" ]]95,
                                        --[[ "_" ]]95
                                      },
                                      --[[ [] ]]0
                                    }}),
                                --[[ [] ]]0
                              }
                            })
                      }; end end 
             if ___conditional___ == 0
             or ___conditional___ == 1
             or ___conditional___ == 2
             or ___conditional___ == 3
             or ___conditional___ == 4
             or ___conditional___ == 5
             or ___conditional___ == 6
             or ___conditional___ == 33
             or ___conditional___ == 34
             or ___conditional___ == 35
             or ___conditional___ == 36
             or ___conditional___ == 37
             or ___conditional___ == 38 then do
                return --[[ `Char ]]{
                        748194550,
                        c_2
                      }; end end 
             if ___conditional___ == 40 then do
                return --[[ `Char ]]{
                        748194550,
                        --[[ "\b" ]]8
                      }; end end 
             if ___conditional___ == 42 then do
                return --[[ `Set ]]{
                        4150146,
                        digit
                      }; end end 
             if ___conditional___ == 52 then do
                return --[[ `Char ]]{
                        748194550,
                        --[[ "\n" ]]10
                      }; end end 
             if ___conditional___ == 56 then do
                return --[[ `Char ]]{
                        748194550,
                        --[[ "\r" ]]13
                      }; end end 
             if ___conditional___ == 57 then do
                return --[[ `Set ]]{
                        4150146,
                        space
                      }; end end 
             if ___conditional___ == 58 then do
                return --[[ `Char ]]{
                        748194550,
                        --[[ "\t" ]]9
                      }; end end 
             if ___conditional___ == 61 then do
                return --[[ `Set ]]{
                        4150146,
                        alt_1(--[[ :: ]]{
                              alnum,
                              --[[ :: ]]{
                                --[[ Set ]]Block.__(0, {--[[ :: ]]{
                                      --[[ tuple ]]{
                                        --[[ "_" ]]95,
                                        --[[ "_" ]]95
                                      },
                                      --[[ [] ]]0
                                    }}),
                                --[[ [] ]]0
                              }
                            })
                      }; end end 
             if ___conditional___ == 7
             or ___conditional___ == 8
             or ___conditional___ == 9
             or ___conditional___ == 11
             or ___conditional___ == 12
             or ___conditional___ == 13
             or ___conditional___ == 14
             or ___conditional___ == 15
             or ___conditional___ == 16
             or ___conditional___ == 17
             or ___conditional___ == 18
             or ___conditional___ == 19
             or ___conditional___ == 20
             or ___conditional___ == 21
             or ___conditional___ == 22
             or ___conditional___ == 23
             or ___conditional___ == 24
             or ___conditional___ == 26
             or ___conditional___ == 27
             or ___conditional___ == 28
             or ___conditional___ == 30
             or ___conditional___ == 31
             or ___conditional___ == 32
             or ___conditional___ == 39
             or ___conditional___ == 41
             or ___conditional___ == 43
             or ___conditional___ == 44
             or ___conditional___ == 45
             or ___conditional___ == 46
             or ___conditional___ == 47
             or ___conditional___ == 48
             or ___conditional___ == 49
             or ___conditional___ == 50
             or ___conditional___ == 51
             or ___conditional___ == 53
             or ___conditional___ == 54
             or ___conditional___ == 55
             or ___conditional___ == 59
             or ___conditional___ == 60
             or ___conditional___ == 62
             or ___conditional___ == 63
             or ___conditional___ == 64 then do
                error(Parse_error) end end 
            
          end
        end end 
      end else do
        if (c_2 >= 48) then do
          error(Not_supported)
        end
         end 
        return --[[ `Char ]]{
                748194550,
                c_2
              };
      end end 
    end else do
      return --[[ `Char ]]{
              748194550,
              c
            };
    end end  end 
  end end;
  piece = function(param) do
    r = atom(--[[ () ]]0);
    if (accept(--[[ "*" ]]42)) then do
      return greedy_mod(repn(r, 0, undefined));
    end else if (accept(--[[ "+" ]]43)) then do
      return greedy_mod(repn(r, 1, undefined));
    end else if (accept(--[[ "?" ]]63)) then do
      return greedy_mod(repn(r, 0, 1));
    end else if (accept(--[[ "{" ]]123)) then do
      match = integer(--[[ () ]]0);
      if (match ~= undefined) then do
        i_1 = match;
        j = accept(--[[ "," ]]44) and integer(--[[ () ]]0) or i_1;
        if (not accept(--[[ "}" ]]125)) then do
          error(Parse_error)
        end
         end 
        if (j ~= undefined and j < i_1) then do
          error(Parse_error)
        end
         end 
        return greedy_mod(repn(r, i_1, j));
      end else do
        i.contents = i.contents - 1 | 0;
        return r;
      end end 
    end else do
      return r;
    end end  end  end  end 
  end end;
  res = regexp$prime(branch$prime(--[[ [] ]]0));
  if (i.contents ~= l) then do
    error(Parse_error)
  end
   end 
  return res;
end end

function re(flagsOpt, pat) do
  flags = flagsOpt ~= undefined and flagsOpt or --[[ [] ]]0;
  opts = List.map((function(param) do
          if (param ~= 601676297) then do
            if (param >= 613575188) then do
              return --[[ Anchored ]]616470068;
            end else do
              return --[[ Multiline ]]1071952589;
            end end 
          end else do
            return --[[ Caseless ]]604571177;
          end end 
        end end), flags);
  optsOpt = opts;
  s = pat;
  opts_1 = optsOpt ~= undefined and optsOpt or --[[ [] ]]0;
  r = parse(List.memq(--[[ Multiline ]]1071952589, opts_1), List.memq(--[[ Dollar_endonly ]]-712595228, opts_1), List.memq(--[[ Dotall ]]-424303016, opts_1), List.memq(--[[ Ungreedy ]]-243745063, opts_1), s);
  r_1 = List.memq(--[[ Anchored ]]616470068, opts_1) and seq_2(--[[ :: ]]{
          --[[ Start ]]8,
          --[[ :: ]]{
            r,
            --[[ [] ]]0
          }
        }) or r;
  if (List.memq(--[[ Caseless ]]604571177, opts_1)) then do
    return --[[ No_case ]]Block.__(10, {r_1});
  end else do
    return r_1;
  end end 
end end

function exec(rex, pos, s) do
  pos_1 = pos;
  len = undefined;
  re = rex;
  s_1 = s;
  match = exec_internal("Re.exec", pos_1, len, true, re, s_1);
  if (typeof match == "number") then do
    error(Caml_builtin_exceptions.not_found)
  end
   end 
  return match[0];
end end

s = Caml_bytes.bytes_to_string(Bytes.make(1048575, --[[ "a" ]]97)) .. "b";

eq("File \"xx.ml\", line 7, characters 3-10", get(exec(compile(re(undefined, "aa?b")), undefined, s), 0), "aab");

Mt.from_pair_suites("Ocaml_re_test", suites.contents);

exports = {}
--[[ Table Not a pure module ]]
