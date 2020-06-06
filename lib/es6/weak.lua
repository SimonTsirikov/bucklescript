

import * as Sys from "./sys.lua";
import * as __Array from "./array.lua";
import * as Curry from "./curry.lua";
import * as Caml_obj from "./caml_obj.lua";
import * as Caml_weak from "./caml_weak.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_int32 from "./caml_int32.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_option from "./caml_option.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function fill(ar, ofs, len, x) do
  if (ofs < 0 or len < 0 or (ofs + len | 0) > #ar) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Weak.fill"
    })
  end
   end 
  for i = ofs , (ofs + len | 0) - 1 | 0 , 1 do
    Caml_weak.caml_weak_set(ar, i, x);
  end
  return --[[ () ]]0;
end end

function Make(H) do
  emptybucket = Caml_weak.caml_weak_create(0);
  get_index = function(t, h) do
    return (h & Pervasives.max_int) % #t.table;
  end end;
  create = function(sz) do
    sz_1 = sz < 7 and 7 or sz;
    sz_2 = sz_1 > Sys.max_array_length and Sys.max_array_length or sz_1;
    return {
            table = Caml_array.caml_make_vect(sz_2, emptybucket),
            hashes = Caml_array.caml_make_vect(sz_2, {}),
            limit = 7,
            oversize = 0,
            rover = 0
          };
  end end;
  clear = function(t) do
    for i = 0 , #t.table - 1 | 0 , 1 do
      Caml_array.caml_array_set(t.table, i, emptybucket);
      Caml_array.caml_array_set(t.hashes, i, {});
    end
    t.limit = 7;
    t.oversize = 0;
    return --[[ () ]]0;
  end end;
  fold = function(f, t, init) do
    return __Array.fold_right((function(param, param_1) do
                  _i = 0;
                  b = param;
                  _accu = param_1;
                  while(true) do
                    accu = _accu;
                    i = _i;
                    if (i >= #b) then do
                      return accu;
                    end else do
                      match = Caml_weak.caml_weak_get(b, i);
                      if (match ~= nil) then do
                        _accu = Curry._2(f, Caml_option.valFromOption(match), accu);
                        _i = i + 1 | 0;
                        ::continue:: ;
                      end else do
                        _i = i + 1 | 0;
                        ::continue:: ;
                      end end 
                    end end 
                  end;
                end end), t.table, init);
  end end;
  iter = function(f, t) do
    return __Array.iter((function(param) do
                  _i = 0;
                  b = param;
                  while(true) do
                    i = _i;
                    if (i >= #b) then do
                      return --[[ () ]]0;
                    end else do
                      match = Caml_weak.caml_weak_get(b, i);
                      if (match ~= nil) then do
                        Curry._1(f, Caml_option.valFromOption(match));
                        _i = i + 1 | 0;
                        ::continue:: ;
                      end else do
                        _i = i + 1 | 0;
                        ::continue:: ;
                      end end 
                    end end 
                  end;
                end end), t.table);
  end end;
  iter_weak = function(f, t) do
    return __Array.iteri((function(param, param_1) do
                  _i = 0;
                  j = param;
                  b = param_1;
                  while(true) do
                    i = _i;
                    if (i >= #b) then do
                      return --[[ () ]]0;
                    end else if (Caml_weak.caml_weak_check(b, i)) then do
                      Curry._3(f, b, Caml_array.caml_array_get(t.hashes, j), i);
                      _i = i + 1 | 0;
                      ::continue:: ;
                    end else do
                      _i = i + 1 | 0;
                      ::continue:: ;
                    end end  end 
                  end;
                end end), t.table);
  end end;
  count_bucket = function(_i, b, _accu) do
    while(true) do
      accu = _accu;
      i = _i;
      if (i >= #b) then do
        return accu;
      end else do
        _accu = accu + (
          Caml_weak.caml_weak_check(b, i) and 1 or 0
        ) | 0;
        _i = i + 1 | 0;
        ::continue:: ;
      end end 
    end;
  end end;
  count = function(t) do
    return __Array.fold_right((function(param, param_1) do
                  return count_bucket(0, param, param_1);
                end end), t.table, 0);
  end end;
  next_sz = function(n) do
    return Caml_primitive.caml_int_min((Caml_int32.imul(3, n) / 2 | 0) + 3 | 0, Sys.max_array_length);
  end end;
  prev_sz = function(n) do
    return (((n - 3 | 0) << 1) + 2 | 0) / 3 | 0;
  end end;
  test_shrink_bucket = function(t) do
    bucket = Caml_array.caml_array_get(t.table, t.rover);
    hbucket = Caml_array.caml_array_get(t.hashes, t.rover);
    len = #bucket;
    prev_len = prev_sz(len);
    live = count_bucket(0, bucket, 0);
    if (live <= prev_len) then do
      loop = function(_i, _j) do
        while(true) do
          j = _j;
          i = _i;
          if (j >= prev_len) then do
            if (Caml_weak.caml_weak_check(bucket, i)) then do
              _i = i + 1 | 0;
              ::continue:: ;
            end else if (Caml_weak.caml_weak_check(bucket, j)) then do
              Caml_weak.caml_weak_blit(bucket, j, bucket, i, 1);
              Caml_array.caml_array_set(hbucket, i, Caml_array.caml_array_get(hbucket, j));
              _j = j - 1 | 0;
              _i = i + 1 | 0;
              ::continue:: ;
            end else do
              _j = j - 1 | 0;
              ::continue:: ;
            end end  end 
          end else do
            return 0;
          end end 
        end;
      end end;
      loop(0, #bucket - 1 | 0);
      if (prev_len == 0) then do
        Caml_array.caml_array_set(t.table, t.rover, emptybucket);
        Caml_array.caml_array_set(t.hashes, t.rover, {});
      end else do
        Caml_obj.caml_obj_truncate(bucket, prev_len + 0 | 0);
        Caml_obj.caml_obj_truncate(hbucket, prev_len);
      end end 
      if (len > t.limit and prev_len <= t.limit) then do
        t.oversize = t.oversize - 1 | 0;
      end
       end 
    end
     end 
    t.rover = (t.rover + 1 | 0) % #t.table;
    return --[[ () ]]0;
  end end;
  add_aux = function(t, setter, d, h, index) do
    bucket = Caml_array.caml_array_get(t.table, index);
    hashes = Caml_array.caml_array_get(t.hashes, index);
    sz = #bucket;
    _i = 0;
    while(true) do
      i = _i;
      if (i >= sz) then do
        newsz = Caml_primitive.caml_int_min((Caml_int32.imul(3, sz) / 2 | 0) + 3 | 0, Sys.max_array_length - 0 | 0);
        if (newsz <= sz) then do
          error({
            Caml_builtin_exceptions.failure,
            "Weak.Make: hash bucket cannot grow more"
          })
        end
         end 
        newbucket = Caml_weak.caml_weak_create(newsz);
        newhashes = Caml_array.caml_make_vect(newsz, 0);
        Caml_weak.caml_weak_blit(bucket, 0, newbucket, 0, sz);
        __Array.blit(hashes, 0, newhashes, 0, sz);
        Curry._3(setter, newbucket, sz, d);
        Caml_array.caml_array_set(newhashes, sz, h);
        Caml_array.caml_array_set(t.table, index, newbucket);
        Caml_array.caml_array_set(t.hashes, index, newhashes);
        if (sz <= t.limit and newsz > t.limit) then do
          t.oversize = t.oversize + 1 | 0;
          for _i_1 = 0 , 2 , 1 do
            test_shrink_bucket(t);
          end
        end
         end 
        if (t.oversize > (#t.table >> 1)) then do
          t_1 = t;
          oldlen = #t_1.table;
          newlen = next_sz(oldlen);
          if (newlen > oldlen) then do
            newt = create(newlen);
            add_weak = (function(newt)do
            return function add_weak(ob, oh, oi) do
              setter = function(nb, ni, param) do
                return Caml_weak.caml_weak_blit(ob, oi, nb, ni, 1);
              end end;
              h = Caml_array.caml_array_get(oh, oi);
              return add_aux(newt, setter, nil, h, get_index(newt, h));
            end end
            end end)(newt);
            iter_weak(add_weak, t_1);
            t_1.table = newt.table;
            t_1.hashes = newt.hashes;
            t_1.limit = newt.limit;
            t_1.oversize = newt.oversize;
            t_1.rover = t_1.rover % #newt.table;
            return --[[ () ]]0;
          end else do
            t_1.limit = Pervasives.max_int;
            t_1.oversize = 0;
            return --[[ () ]]0;
          end end 
        end else do
          return 0;
        end end 
      end else if (Caml_weak.caml_weak_check(bucket, i)) then do
        _i = i + 1 | 0;
        ::continue:: ;
      end else do
        Curry._3(setter, bucket, i, d);
        return Caml_array.caml_array_set(hashes, i, h);
      end end  end 
    end;
  end end;
  add = function(t, d) do
    h = Curry._1(H.hash, d);
    return add_aux(t, Caml_weak.caml_weak_set, Caml_option.some(d), h, get_index(t, h));
  end end;
  find_or = function(t, d, ifnotfound) do
    h = Curry._1(H.hash, d);
    index = get_index(t, h);
    bucket = Caml_array.caml_array_get(t.table, index);
    hashes = Caml_array.caml_array_get(t.hashes, index);
    sz = #bucket;
    _i = 0;
    while(true) do
      i = _i;
      if (i >= sz) then do
        return Curry._2(ifnotfound, h, index);
      end else if (h == Caml_array.caml_array_get(hashes, i)) then do
        match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= nil) then do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) then do
            match_1 = Caml_weak.caml_weak_get(bucket, i);
            if (match_1 ~= nil) then do
              return Caml_option.valFromOption(match_1);
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end 
        end else do
          _i = i + 1 | 0;
          ::continue:: ;
        end end 
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end  end 
    end;
  end end;
  merge = function(t, d) do
    return find_or(t, d, (function(h, index) do
                  add_aux(t, Caml_weak.caml_weak_set, Caml_option.some(d), h, index);
                  return d;
                end end));
  end end;
  find = function(t, d) do
    return find_or(t, d, (function(_h, _index) do
                  error(Caml_builtin_exceptions.not_found)
                end end));
  end end;
  find_opt = function(t, d) do
    h = Curry._1(H.hash, d);
    index = get_index(t, h);
    bucket = Caml_array.caml_array_get(t.table, index);
    hashes = Caml_array.caml_array_get(t.hashes, index);
    sz = #bucket;
    _i = 0;
    while(true) do
      i = _i;
      if (i >= sz) then do
        return ;
      end else if (h == Caml_array.caml_array_get(hashes, i)) then do
        match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= nil) then do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) then do
            v = Caml_weak.caml_weak_get(bucket, i);
            if (v ~= nil) then do
              return v;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end 
        end else do
          _i = i + 1 | 0;
          ::continue:: ;
        end end 
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end  end 
    end;
  end end;
  find_shadow = function(t, d, iffound, ifnotfound) do
    h = Curry._1(H.hash, d);
    index = get_index(t, h);
    bucket = Caml_array.caml_array_get(t.table, index);
    hashes = Caml_array.caml_array_get(t.hashes, index);
    sz = #bucket;
    _i = 0;
    while(true) do
      i = _i;
      if (i >= sz) then do
        return ifnotfound;
      end else if (h == Caml_array.caml_array_get(hashes, i)) then do
        match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= nil) then do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) then do
            return Curry._2(iffound, bucket, i);
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end 
        end else do
          _i = i + 1 | 0;
          ::continue:: ;
        end end 
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end  end 
    end;
  end end;
  remove = function(t, d) do
    return find_shadow(t, d, (function(w, i) do
                  return Caml_weak.caml_weak_set(w, i, nil);
                end end), --[[ () ]]0);
  end end;
  mem = function(t, d) do
    return find_shadow(t, d, (function(_w, _i) do
                  return true;
                end end), false);
  end end;
  find_all = function(t, d) do
    h = Curry._1(H.hash, d);
    index = get_index(t, h);
    bucket = Caml_array.caml_array_get(t.table, index);
    hashes = Caml_array.caml_array_get(t.hashes, index);
    sz = #bucket;
    _i = 0;
    _accu = --[[ [] ]]0;
    while(true) do
      accu = _accu;
      i = _i;
      if (i >= sz) then do
        return accu;
      end else if (h == Caml_array.caml_array_get(hashes, i)) then do
        match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= nil) then do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) then do
            match_1 = Caml_weak.caml_weak_get(bucket, i);
            if (match_1 ~= nil) then do
              _accu = --[[ :: ]]{
                Caml_option.valFromOption(match_1),
                accu
              };
              _i = i + 1 | 0;
              ::continue:: ;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end 
        end else do
          _i = i + 1 | 0;
          ::continue:: ;
        end end 
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end  end 
    end;
  end end;
  stats = function(t) do
    len = #t.table;
    lens = __Array.map((function(prim) do
            return #prim;
          end end), t.table);
    __Array.sort(Caml_primitive.caml_int_compare, lens);
    totlen = __Array.fold_left((function(prim, prim_1) do
            return prim + prim_1 | 0;
          end end), 0, lens);
    return --[[ tuple ]]{
            len,
            count(t),
            totlen,
            Caml_array.caml_array_get(lens, 0),
            Caml_array.caml_array_get(lens, len / 2 | 0),
            Caml_array.caml_array_get(lens, len - 1 | 0)
          };
  end end;
  return {
          create = create,
          clear = clear,
          merge = merge,
          add = add,
          remove = remove,
          find = find,
          find_opt = find_opt,
          find_all = find_all,
          mem = mem,
          iter = iter,
          fold = fold,
          count = count,
          stats = stats
        };
end end

create = Caml_weak.caml_weak_create;

function length(prim) do
  return #prim;
end end

set = Caml_weak.caml_weak_set;

get = Caml_weak.caml_weak_get;

get_copy = Caml_weak.caml_weak_get_copy;

check = Caml_weak.caml_weak_check;

blit = Caml_weak.caml_weak_blit;

export do
  create ,
  length ,
  set ,
  get ,
  get_copy ,
  check ,
  fill ,
  blit ,
  Make ,
  
end
--[[ No side effect ]]
