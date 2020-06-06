

import * as __Array from "./array.lua";
import * as Curry from "./curry.lua";
import * as Random from "./random.lua";
import * as Caml_obj from "./caml_obj.lua";
import * as Caml_hash from "./caml_hash.lua";
import * as Caml_array from "./caml_array.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_option from "./caml_option.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as CamlinternalLazy from "./camlinternalLazy.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function hash(x) do
  return Caml_hash.caml_hash(10, 100, 0, x);
end end

function hash_param(n1, n2, x) do
  return Caml_hash.caml_hash(n1, n2, 0, x);
end end

function seeded_hash(seed, x) do
  return Caml_hash.caml_hash(10, 100, seed, x);
end end

function flip_ongoing_traversal(h) do
  h.initial_size = -h.initial_size | 0;
  return --[[ () ]]0;
end end

randomized = {
  contents = false
};

function randomize(param) do
  randomized.contents = true;
  return --[[ () ]]0;
end end

function is_randomized(param) do
  return randomized.contents;
end end

prng = Caml_obj.caml_lazy_make((function(param) do
        return Random.State.make_self_init(--[[ () ]]0);
      end end));

function power_2_above(_x, n) do
  while(true) do
    x = _x;
    if (x >= n or (x << 1) < x) then do
      return x;
    end else do
      _x = (x << 1);
      ::continue:: ;
    end end 
  end;
end end

function create(randomOpt, initial_size) do
  random = randomOpt ~= nil and randomOpt or randomized.contents;
  s = power_2_above(16, initial_size);
  seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
  return {
          size = 0,
          data = Caml_array.caml_make_vect(s, --[[ Empty ]]0),
          seed = seed,
          initial_size = s
        };
end end

function clear(h) do
  h.size = 0;
  len = #h.data;
  for i = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
  end
  return --[[ () ]]0;
end end

function reset(h) do
  len = #h.data;
  if (len == Pervasives.abs(h.initial_size)) then do
    return clear(h);
  end else do
    h.size = 0;
    h.data = Caml_array.caml_make_vect(Pervasives.abs(h.initial_size), --[[ Empty ]]0);
    return --[[ () ]]0;
  end end 
end end

function copy_bucketlist(param) do
  if (param) then do
    key = param[--[[ key ]]0];
    data = param[--[[ data ]]1];
    next = param[--[[ next ]]2];
    loop = function(_prec, _param) do
      while(true) do
        param = _param;
        prec = _prec;
        if (param) then do
          key = param[--[[ key ]]0];
          data = param[--[[ data ]]1];
          next = param[--[[ next ]]2];
          r = --[[ Cons ]]{
            --[[ key ]]key,
            --[[ data ]]data,
            --[[ next ]]next
          };
          if (prec) then do
            prec[--[[ next ]]2] = r;
          end else do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "hashtbl.ml",
                113,
                23
              }
            })
          end end 
          _param = next;
          _prec = r;
          ::continue:: ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    r = --[[ Cons ]]{
      --[[ key ]]key,
      --[[ data ]]data,
      --[[ next ]]next
    };
    loop(r, next);
    return r;
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function copy(h) do
  return {
          size = h.size,
          data = __Array.map(copy_bucketlist, h.data),
          seed = h.seed,
          initial_size = h.initial_size
        };
end end

function length(h) do
  return h.size;
end end

function resize(indexfun, h) do
  odata = h.data;
  osize = #odata;
  nsize = (osize << 1);
  if (nsize >= osize) then do
    ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
    ndata_tail = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
    inplace = h.initial_size >= 0;
    h.data = ndata;
    insert_bucket = function(_cell) do
      while(true) do
        cell = _cell;
        if (cell) then do
          key = cell[--[[ key ]]0];
          data = cell[--[[ data ]]1];
          next = cell[--[[ next ]]2];
          cell_1 = inplace and cell or --[[ Cons ]]{
              --[[ key ]]key,
              --[[ data ]]data,
              --[[ next : Empty ]]0
            };
          nidx = Curry._2(indexfun, h, key);
          match = Caml_array.caml_array_get(ndata_tail, nidx);
          if (match) then do
            match[--[[ next ]]2] = cell_1;
          end else do
            Caml_array.caml_array_set(ndata, nidx, cell_1);
          end end 
          Caml_array.caml_array_set(ndata_tail, nidx, cell_1);
          _cell = next;
          ::continue:: ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    for i = 0 , osize - 1 | 0 , 1 do
      insert_bucket(Caml_array.caml_array_get(odata, i));
    end
    if (inplace) then do
      for i_1 = 0 , nsize - 1 | 0 , 1 do
        match = Caml_array.caml_array_get(ndata_tail, i_1);
        if (match) then do
          match[--[[ next ]]2] = --[[ Empty ]]0;
        end
         end 
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end end

function key_index(h, key) do
  return Caml_hash.caml_hash(10, 100, h.seed, key) & (#h.data - 1 | 0);
end end

function add(h, key, data) do
  i = key_index(h, key);
  bucket = --[[ Cons ]]{
    --[[ key ]]key,
    --[[ data ]]data,
    --[[ next ]]Caml_array.caml_array_get(h.data, i)
  };
  Caml_array.caml_array_set(h.data, i, bucket);
  h.size = h.size + 1 | 0;
  if (h.size > (#h.data << 1)) then do
    return resize(key_index, h);
  end else do
    return 0;
  end end 
end end

function remove(h, key) do
  i = key_index(h, key);
  h_1 = h;
  i_1 = i;
  key_1 = key;
  _prec = --[[ Empty ]]0;
  _c = Caml_array.caml_array_get(h.data, i);
  while(true) do
    c = _c;
    prec = _prec;
    if (c) then do
      k = c[--[[ key ]]0];
      next = c[--[[ next ]]2];
      if (Caml_obj.caml_equal(k, key_1)) then do
        h_1.size = h_1.size - 1 | 0;
        if (prec) then do
          prec[--[[ next ]]2] = next;
          return --[[ () ]]0;
        end else do
          return Caml_array.caml_array_set(h_1.data, i_1, next);
        end end 
      end else do
        _c = next;
        _prec = c;
        ::continue:: ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function find(h, key) do
  match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    k1 = match[--[[ key ]]0];
    d1 = match[--[[ data ]]1];
    next1 = match[--[[ next ]]2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return d1;
    end else if (next1) then do
      k2 = next1[--[[ key ]]0];
      d2 = next1[--[[ data ]]1];
      next2 = next1[--[[ next ]]2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return d2;
      end else if (next2) then do
        k3 = next2[--[[ key ]]0];
        d3 = next2[--[[ data ]]1];
        next3 = next2[--[[ next ]]2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return d3;
        end else do
          key_1 = key;
          _param = next3;
          while(true) do
            param = _param;
            if (param) then do
              k = param[--[[ key ]]0];
              data = param[--[[ data ]]1];
              next = param[--[[ next ]]2];
              if (Caml_obj.caml_equal(key_1, k)) then do
                return data;
              end else do
                _param = next;
                ::continue:: ;
              end end 
            end else do
              error(Caml_builtin_exceptions.not_found)
            end end 
          end;
        end end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end  end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end  end 
  end else do
    error(Caml_builtin_exceptions.not_found)
  end end 
end end

function find_opt(h, key) do
  match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    k1 = match[--[[ key ]]0];
    d1 = match[--[[ data ]]1];
    next1 = match[--[[ next ]]2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return Caml_option.some(d1);
    end else if (next1) then do
      k2 = next1[--[[ key ]]0];
      d2 = next1[--[[ data ]]1];
      next2 = next1[--[[ next ]]2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return Caml_option.some(d2);
      end else if (next2) then do
        k3 = next2[--[[ key ]]0];
        d3 = next2[--[[ data ]]1];
        next3 = next2[--[[ next ]]2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return Caml_option.some(d3);
        end else do
          key_1 = key;
          _param = next3;
          while(true) do
            param = _param;
            if (param) then do
              k = param[--[[ key ]]0];
              data = param[--[[ data ]]1];
              next = param[--[[ next ]]2];
              if (Caml_obj.caml_equal(key_1, k)) then do
                return Caml_option.some(data);
              end else do
                _param = next;
                ::continue:: ;
              end end 
            end else do
              return ;
            end end 
          end;
        end end 
      end else do
        return ;
      end end  end 
    end else do
      return ;
    end end  end 
  end
   end 
end end

function find_all(h, key) do
  find_in_bucket = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[[ key ]]0];
        data = param[--[[ data ]]1];
        next = param[--[[ next ]]2];
        if (Caml_obj.caml_equal(k, key)) then do
          return --[[ :: ]]{
                  data,
                  find_in_bucket(next)
                };
        end else do
          _param = next;
          ::continue:: ;
        end end 
      end else do
        return --[[ [] ]]0;
      end end 
    end;
  end end;
  return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
end end

function replace_bucket(key, data, _param) do
  while(true) do
    param = _param;
    if (param) then do
      k = param[--[[ key ]]0];
      next = param[--[[ next ]]2];
      if (Caml_obj.caml_equal(k, key)) then do
        param[--[[ key ]]0] = key;
        param[--[[ data ]]1] = data;
        return false;
      end else do
        _param = next;
        ::continue:: ;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function replace(h, key, data) do
  i = key_index(h, key);
  l = Caml_array.caml_array_get(h.data, i);
  if (replace_bucket(key, data, l)) then do
    Caml_array.caml_array_set(h.data, i, --[[ Cons ]]{
          --[[ key ]]key,
          --[[ data ]]data,
          --[[ next ]]l
        });
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end end

function mem(h, key) do
  _param = Caml_array.caml_array_get(h.data, key_index(h, key));
  while(true) do
    param = _param;
    if (param) then do
      k = param[--[[ key ]]0];
      next = param[--[[ next ]]2];
      if (Caml_obj.caml_equal(k, key)) then do
        return true;
      end else do
        _param = next;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function iter(f, h) do
  do_bucket = function(_param) do
    while(true) do
      param = _param;
      if (param) then do
        key = param[--[[ key ]]0];
        data = param[--[[ data ]]1];
        next = param[--[[ next ]]2];
        Curry._2(f, key, data);
        _param = next;
        ::continue:: ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  old_trav = h.initial_size < 0;
  if (not old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  xpcall(function() do
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    if (old_trav) then do
      return 0;
    end else do
      return flip_ongoing_traversal(h);
    end end 
  end end,function(exn) do
    if (old_trav) then do
      error(exn)
    end else do
      flip_ongoing_traversal(h);
      error(exn)
    end end 
  end end)
end end

function filter_map_inplace_bucket(f, h, i, _prec, _slot) do
  while(true) do
    slot = _slot;
    prec = _prec;
    if (slot) then do
      key = slot[--[[ key ]]0];
      data = slot[--[[ data ]]1];
      next = slot[--[[ next ]]2];
      match = Curry._2(f, key, data);
      if (match ~= nil) then do
        if (prec) then do
          prec[--[[ next ]]2] = slot;
        end else do
          Caml_array.caml_array_set(h.data, i, slot);
        end end 
        slot[--[[ data ]]1] = Caml_option.valFromOption(match);
        _slot = next;
        _prec = slot;
        ::continue:: ;
      end else do
        h.size = h.size - 1 | 0;
        _slot = next;
        ::continue:: ;
      end end 
    end else if (prec) then do
      prec[--[[ next ]]2] = --[[ Empty ]]0;
      return --[[ () ]]0;
    end else do
      return Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end end  end 
  end;
end end

function filter_map_inplace(f, h) do
  d = h.data;
  old_trav = h.initial_size < 0;
  if (not old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  xpcall(function() do
    for i = 0 , #d - 1 | 0 , 1 do
      filter_map_inplace_bucket(f, h, i, --[[ Empty ]]0, Caml_array.caml_array_get(h.data, i));
    end
    return --[[ () ]]0;
  end end,function(exn) do
    if (old_trav) then do
      error(exn)
    end else do
      flip_ongoing_traversal(h);
      error(exn)
    end end 
  end end)
end end

function fold(f, h, init) do
  do_bucket = function(_b, _accu) do
    while(true) do
      accu = _accu;
      b = _b;
      if (b) then do
        key = b[--[[ key ]]0];
        data = b[--[[ data ]]1];
        next = b[--[[ next ]]2];
        _accu = Curry._3(f, key, data, accu);
        _b = next;
        ::continue:: ;
      end else do
        return accu;
      end end 
    end;
  end end;
  old_trav = h.initial_size < 0;
  if (not old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  xpcall(function() do
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    if (not old_trav) then do
      flip_ongoing_traversal(h);
    end
     end 
    return accu;
  end end,function(exn) do
    if (old_trav) then do
      error(exn)
    end else do
      flip_ongoing_traversal(h);
      error(exn)
    end end 
  end end)
end end

function bucket_length(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      next = param[--[[ next ]]2];
      _param = next;
      _accu = accu + 1 | 0;
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function stats(h) do
  mbl = __Array.fold_left((function(m, b) do
          return Caml_primitive.caml_int_max(m, bucket_length(0, b));
        end end), 0, h.data);
  histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
  __Array.iter((function(b) do
          l = bucket_length(0, b);
          return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
        end end), h.data);
  return {
          num_bindings = h.size,
          num_buckets = #h.data,
          max_bucket_length = mbl,
          bucket_histogram = histo
        };
end end

function MakeSeeded(H) do
  key_index = function(h, key) do
    return Curry._2(H.hash, h.seed, key) & (#h.data - 1 | 0);
  end end;
  add = function(h, key, data) do
    i = key_index(h, key);
    bucket = --[[ Cons ]]{
      --[[ key ]]key,
      --[[ data ]]data,
      --[[ next ]]Caml_array.caml_array_get(h.data, i)
    };
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end end;
  remove = function(h, key) do
    i = key_index(h, key);
    h_1 = h;
    i_1 = i;
    key_1 = key;
    _prec = --[[ Empty ]]0;
    _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      c = _c;
      prec = _prec;
      if (c) then do
        k = c[--[[ key ]]0];
        next = c[--[[ next ]]2];
        if (Curry._2(H.equal, k, key_1)) then do
          h_1.size = h_1.size - 1 | 0;
          if (prec) then do
            prec[--[[ next ]]2] = next;
            return --[[ () ]]0;
          end else do
            return Caml_array.caml_array_set(h_1.data, i_1, next);
          end end 
        end else do
          _c = next;
          _prec = c;
          ::continue:: ;
        end end 
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  find = function(h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[[ key ]]0];
      d1 = match[--[[ data ]]1];
      next1 = match[--[[ next ]]2];
      if (Curry._2(H.equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        k2 = next1[--[[ key ]]0];
        d2 = next1[--[[ data ]]1];
        next2 = next1[--[[ next ]]2];
        if (Curry._2(H.equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          k3 = next2[--[[ key ]]0];
          d3 = next2[--[[ data ]]1];
          next3 = next2[--[[ next ]]2];
          if (Curry._2(H.equal, key, k3)) then do
            return d3;
          end else do
            key_1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[[ key ]]0];
                data = param[--[[ data ]]1];
                next = param[--[[ next ]]2];
                if (Curry._2(H.equal, key_1, k)) then do
                  return data;
                end else do
                  _param = next;
                  ::continue:: ;
                end end 
              end else do
                error(Caml_builtin_exceptions.not_found)
              end end 
            end;
          end end 
        end else do
          error(Caml_builtin_exceptions.not_found)
        end end  end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end  end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end end;
  find_opt = function(h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[[ key ]]0];
      d1 = match[--[[ data ]]1];
      next1 = match[--[[ next ]]2];
      if (Curry._2(H.equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        k2 = next1[--[[ key ]]0];
        d2 = next1[--[[ data ]]1];
        next2 = next1[--[[ next ]]2];
        if (Curry._2(H.equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          k3 = next2[--[[ key ]]0];
          d3 = next2[--[[ data ]]1];
          next3 = next2[--[[ next ]]2];
          if (Curry._2(H.equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            key_1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[[ key ]]0];
                data = param[--[[ data ]]1];
                next = param[--[[ next ]]2];
                if (Curry._2(H.equal, key_1, k)) then do
                  return Caml_option.some(data);
                end else do
                  _param = next;
                  ::continue:: ;
                end end 
              end else do
                return ;
              end end 
            end;
          end end 
        end else do
          return ;
        end end  end 
      end else do
        return ;
      end end  end 
    end
     end 
  end end;
  find_all = function(h, key) do
    find_in_bucket = function(_param) do
      while(true) do
        param = _param;
        if (param) then do
          k = param[--[[ key ]]0];
          d = param[--[[ data ]]1];
          next = param[--[[ next ]]2];
          if (Curry._2(H.equal, k, key)) then do
            return --[[ :: ]]{
                    d,
                    find_in_bucket(next)
                  };
          end else do
            _param = next;
            ::continue:: ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
  end end;
  replace_bucket = function(key, data, _param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[[ key ]]0];
        next = param[--[[ next ]]2];
        if (Curry._2(H.equal, k, key)) then do
          param[--[[ key ]]0] = key;
          param[--[[ data ]]1] = data;
          return false;
        end else do
          _param = next;
          ::continue:: ;
        end end 
      end else do
        return true;
      end end 
    end;
  end end;
  replace = function(h, key, data) do
    i = key_index(h, key);
    l = Caml_array.caml_array_get(h.data, i);
    if (replace_bucket(key, data, l)) then do
      Caml_array.caml_array_set(h.data, i, --[[ Cons ]]{
            --[[ key ]]key,
            --[[ data ]]data,
            --[[ next ]]l
          });
      h.size = h.size + 1 | 0;
      if (h.size > (#h.data << 1)) then do
        return resize(key_index, h);
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end end;
  mem = function(h, key) do
    _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[[ key ]]0];
        next = param[--[[ next ]]2];
        if (Curry._2(H.equal, k, key)) then do
          return true;
        end else do
          _param = next;
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  return {
          create = create,
          clear = clear,
          reset = reset,
          copy = copy,
          add = add,
          remove = remove,
          find = find,
          find_opt = find_opt,
          find_all = find_all,
          replace = replace,
          mem = mem,
          iter = iter,
          filter_map_inplace = filter_map_inplace,
          fold = fold,
          length = length,
          stats = stats
        };
end end

function Make(H) do
  equal = H.equal;
  key_index = function(h, key) do
    return Curry._1(H.hash, key) & (#h.data - 1 | 0);
  end end;
  add = function(h, key, data) do
    i = key_index(h, key);
    bucket = --[[ Cons ]]{
      --[[ key ]]key,
      --[[ data ]]data,
      --[[ next ]]Caml_array.caml_array_get(h.data, i)
    };
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end end;
  remove = function(h, key) do
    i = key_index(h, key);
    h_1 = h;
    i_1 = i;
    key_1 = key;
    _prec = --[[ Empty ]]0;
    _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      c = _c;
      prec = _prec;
      if (c) then do
        k = c[--[[ key ]]0];
        next = c[--[[ next ]]2];
        if (Curry._2(equal, k, key_1)) then do
          h_1.size = h_1.size - 1 | 0;
          if (prec) then do
            prec[--[[ next ]]2] = next;
            return --[[ () ]]0;
          end else do
            return Caml_array.caml_array_set(h_1.data, i_1, next);
          end end 
        end else do
          _c = next;
          _prec = c;
          ::continue:: ;
        end end 
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  find = function(h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[[ key ]]0];
      d1 = match[--[[ data ]]1];
      next1 = match[--[[ next ]]2];
      if (Curry._2(equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        k2 = next1[--[[ key ]]0];
        d2 = next1[--[[ data ]]1];
        next2 = next1[--[[ next ]]2];
        if (Curry._2(equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          k3 = next2[--[[ key ]]0];
          d3 = next2[--[[ data ]]1];
          next3 = next2[--[[ next ]]2];
          if (Curry._2(equal, key, k3)) then do
            return d3;
          end else do
            key_1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[[ key ]]0];
                data = param[--[[ data ]]1];
                next = param[--[[ next ]]2];
                if (Curry._2(equal, key_1, k)) then do
                  return data;
                end else do
                  _param = next;
                  ::continue:: ;
                end end 
              end else do
                error(Caml_builtin_exceptions.not_found)
              end end 
            end;
          end end 
        end else do
          error(Caml_builtin_exceptions.not_found)
        end end  end 
      end else do
        error(Caml_builtin_exceptions.not_found)
      end end  end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end end;
  find_opt = function(h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[[ key ]]0];
      d1 = match[--[[ data ]]1];
      next1 = match[--[[ next ]]2];
      if (Curry._2(equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        k2 = next1[--[[ key ]]0];
        d2 = next1[--[[ data ]]1];
        next2 = next1[--[[ next ]]2];
        if (Curry._2(equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          k3 = next2[--[[ key ]]0];
          d3 = next2[--[[ data ]]1];
          next3 = next2[--[[ next ]]2];
          if (Curry._2(equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            key_1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[[ key ]]0];
                data = param[--[[ data ]]1];
                next = param[--[[ next ]]2];
                if (Curry._2(equal, key_1, k)) then do
                  return Caml_option.some(data);
                end else do
                  _param = next;
                  ::continue:: ;
                end end 
              end else do
                return ;
              end end 
            end;
          end end 
        end else do
          return ;
        end end  end 
      end else do
        return ;
      end end  end 
    end
     end 
  end end;
  find_all = function(h, key) do
    find_in_bucket = function(_param) do
      while(true) do
        param = _param;
        if (param) then do
          k = param[--[[ key ]]0];
          d = param[--[[ data ]]1];
          next = param[--[[ next ]]2];
          if (Curry._2(equal, k, key)) then do
            return --[[ :: ]]{
                    d,
                    find_in_bucket(next)
                  };
          end else do
            _param = next;
            ::continue:: ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
  end end;
  replace_bucket = function(key, data, _param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[[ key ]]0];
        next = param[--[[ next ]]2];
        if (Curry._2(equal, k, key)) then do
          param[--[[ key ]]0] = key;
          param[--[[ data ]]1] = data;
          return false;
        end else do
          _param = next;
          ::continue:: ;
        end end 
      end else do
        return true;
      end end 
    end;
  end end;
  replace = function(h, key, data) do
    i = key_index(h, key);
    l = Caml_array.caml_array_get(h.data, i);
    if (replace_bucket(key, data, l)) then do
      Caml_array.caml_array_set(h.data, i, --[[ Cons ]]{
            --[[ key ]]key,
            --[[ data ]]data,
            --[[ next ]]l
          });
      h.size = h.size + 1 | 0;
      if (h.size > (#h.data << 1)) then do
        return resize(key_index, h);
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end end;
  mem = function(h, key) do
    _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[[ key ]]0];
        next = param[--[[ next ]]2];
        if (Curry._2(equal, k, key)) then do
          return true;
        end else do
          _param = next;
          ::continue:: ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  create_1 = function(sz) do
    return create(false, sz);
  end end;
  return {
          create = create_1,
          clear = clear,
          reset = reset,
          copy = copy,
          add = add,
          remove = remove,
          find = find,
          find_opt = find_opt,
          find_all = find_all,
          replace = replace,
          mem = mem,
          iter = iter,
          filter_map_inplace = filter_map_inplace,
          fold = fold,
          length = length,
          stats = stats
        };
end end

seeded_hash_param = Caml_hash.caml_hash;

export do
  create ,
  clear ,
  reset ,
  copy ,
  add ,
  find ,
  find_opt ,
  find_all ,
  mem ,
  remove ,
  replace ,
  iter ,
  filter_map_inplace ,
  fold ,
  length ,
  randomize ,
  is_randomized ,
  stats ,
  Make ,
  MakeSeeded ,
  hash ,
  seeded_hash ,
  hash_param ,
  seeded_hash_param ,
  
end
--[[ No side effect ]]
