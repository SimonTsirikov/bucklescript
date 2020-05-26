

import * as $$Array from "./array.js";
import * as Curry from "./curry.js";
import * as Random from "./random.js";
import * as Caml_obj from "./caml_obj.js";
import * as Caml_hash from "./caml_hash.js";
import * as Caml_array from "./caml_array.js";
import * as Pervasives from "./pervasives.js";
import * as Caml_option from "./caml_option.js";
import * as Caml_primitive from "./caml_primitive.js";
import * as CamlinternalLazy from "./camlinternalLazy.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function hash(x) do
  return Caml_hash.caml_hash(10, 100, 0, x);
end

function hash_param(n1, n2, x) do
  return Caml_hash.caml_hash(n1, n2, 0, x);
end

function seeded_hash(seed, x) do
  return Caml_hash.caml_hash(10, 100, seed, x);
end

function flip_ongoing_traversal(h) do
  h.initial_size = -h.initial_size | 0;
  return --[ () ]--0;
end

randomized = do
  contents: false
end;

function randomize(param) do
  randomized.contents = true;
  return --[ () ]--0;
end

function is_randomized(param) do
  return randomized.contents;
end

prng = Caml_obj.caml_lazy_make((function (param) do
        return Random.State.make_self_init(--[ () ]--0);
      end));

function power_2_above(_x, n) do
  while(true) do
    x = _x;
    if (x >= n or (x << 1) < x) then do
      return x;
    end else do
      _x = (x << 1);
      continue ;
    end end 
  end;
end

function create(randomOpt, initial_size) do
  random = randomOpt ~= undefined and randomOpt or randomized.contents;
  s = power_2_above(16, initial_size);
  seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
  return do
          size: 0,
          data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
          seed: seed,
          initial_size: s
        end;
end

function clear(h) do
  h.size = 0;
  len = #h.data;
  for i = 0 , len - 1 | 0 , 1 do
    Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
  end
  return --[ () ]--0;
end

function reset(h) do
  len = #h.data;
  if (len == Pervasives.abs(h.initial_size)) then do
    return clear(h);
  end else do
    h.size = 0;
    h.data = Caml_array.caml_make_vect(Pervasives.abs(h.initial_size), --[ Empty ]--0);
    return --[ () ]--0;
  end end 
end

function copy_bucketlist(param) do
  if (param) then do
    key = param[--[ key ]--0];
    data = param[--[ data ]--1];
    next = param[--[ next ]--2];
    loop = function (_prec, _param) do
      while(true) do
        param = _param;
        prec = _prec;
        if (param) then do
          key = param[--[ key ]--0];
          data = param[--[ data ]--1];
          next = param[--[ next ]--2];
          r = --[ Cons ]--[
            --[ key ]--key,
            --[ data ]--data,
            --[ next ]--next
          ];
          if (prec) then do
            prec[--[ next ]--2] = r;
          end else do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "hashtbl.ml",
                    113,
                    23
                  ]
                ];
          end end 
          _param = next;
          _prec = r;
          continue ;
        end else do
          return --[ () ]--0;
        end end 
      end;
    end;
    r = --[ Cons ]--[
      --[ key ]--key,
      --[ data ]--data,
      --[ next ]--next
    ];
    loop(r, next);
    return r;
  end else do
    return --[ Empty ]--0;
  end end 
end

function copy(h) do
  return do
          size: h.size,
          data: $$Array.map(copy_bucketlist, h.data),
          seed: h.seed,
          initial_size: h.initial_size
        end;
end

function length(h) do
  return h.size;
end

function resize(indexfun, h) do
  odata = h.data;
  osize = #odata;
  nsize = (osize << 1);
  if (nsize >= osize) then do
    ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
    ndata_tail = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
    inplace = h.initial_size >= 0;
    h.data = ndata;
    insert_bucket = function (_cell) do
      while(true) do
        cell = _cell;
        if (cell) then do
          key = cell[--[ key ]--0];
          data = cell[--[ data ]--1];
          next = cell[--[ next ]--2];
          cell$1 = inplace and cell or --[ Cons ]--[
              --[ key ]--key,
              --[ data ]--data,
              --[ next : Empty ]--0
            ];
          nidx = Curry._2(indexfun, h, key);
          match = Caml_array.caml_array_get(ndata_tail, nidx);
          if (match) then do
            match[--[ next ]--2] = cell$1;
          end else do
            Caml_array.caml_array_set(ndata, nidx, cell$1);
          end end 
          Caml_array.caml_array_set(ndata_tail, nidx, cell$1);
          _cell = next;
          continue ;
        end else do
          return --[ () ]--0;
        end end 
      end;
    end;
    for i = 0 , osize - 1 | 0 , 1 do
      insert_bucket(Caml_array.caml_array_get(odata, i));
    end
    if (inplace) then do
      for i$1 = 0 , nsize - 1 | 0 , 1 do
        match = Caml_array.caml_array_get(ndata_tail, i$1);
        if (match) then do
          match[--[ next ]--2] = --[ Empty ]--0;
        end
         end 
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end

function key_index(h, key) do
  return Caml_hash.caml_hash(10, 100, h.seed, key) & (#h.data - 1 | 0);
end

function add(h, key, data) do
  i = key_index(h, key);
  bucket = --[ Cons ]--[
    --[ key ]--key,
    --[ data ]--data,
    --[ next ]--Caml_array.caml_array_get(h.data, i)
  ];
  Caml_array.caml_array_set(h.data, i, bucket);
  h.size = h.size + 1 | 0;
  if (h.size > (#h.data << 1)) then do
    return resize(key_index, h);
  end else do
    return 0;
  end end 
end

function remove(h, key) do
  i = key_index(h, key);
  h$1 = h;
  i$1 = i;
  key$1 = key;
  _prec = --[ Empty ]--0;
  _c = Caml_array.caml_array_get(h.data, i);
  while(true) do
    c = _c;
    prec = _prec;
    if (c) then do
      k = c[--[ key ]--0];
      next = c[--[ next ]--2];
      if (Caml_obj.caml_equal(k, key$1)) then do
        h$1.size = h$1.size - 1 | 0;
        if (prec) then do
          prec[--[ next ]--2] = next;
          return --[ () ]--0;
        end else do
          return Caml_array.caml_array_set(h$1.data, i$1, next);
        end end 
      end else do
        _c = next;
        _prec = c;
        continue ;
      end end 
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function find(h, key) do
  match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    k1 = match[--[ key ]--0];
    d1 = match[--[ data ]--1];
    next1 = match[--[ next ]--2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return d1;
    end else if (next1) then do
      k2 = next1[--[ key ]--0];
      d2 = next1[--[ data ]--1];
      next2 = next1[--[ next ]--2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return d2;
      end else if (next2) then do
        k3 = next2[--[ key ]--0];
        d3 = next2[--[ data ]--1];
        next3 = next2[--[ next ]--2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return d3;
        end else do
          key$1 = key;
          _param = next3;
          while(true) do
            param = _param;
            if (param) then do
              k = param[--[ key ]--0];
              data = param[--[ data ]--1];
              next = param[--[ next ]--2];
              if (Caml_obj.caml_equal(key$1, k)) then do
                return data;
              end else do
                _param = next;
                continue ;
              end end 
            end else do
              throw Caml_builtin_exceptions.not_found;
            end end 
          end;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end  end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end  end 
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end

function find_opt(h, key) do
  match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    k1 = match[--[ key ]--0];
    d1 = match[--[ data ]--1];
    next1 = match[--[ next ]--2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return Caml_option.some(d1);
    end else if (next1) then do
      k2 = next1[--[ key ]--0];
      d2 = next1[--[ data ]--1];
      next2 = next1[--[ next ]--2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return Caml_option.some(d2);
      end else if (next2) then do
        k3 = next2[--[ key ]--0];
        d3 = next2[--[ data ]--1];
        next3 = next2[--[ next ]--2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return Caml_option.some(d3);
        end else do
          key$1 = key;
          _param = next3;
          while(true) do
            param = _param;
            if (param) then do
              k = param[--[ key ]--0];
              data = param[--[ data ]--1];
              next = param[--[ next ]--2];
              if (Caml_obj.caml_equal(key$1, k)) then do
                return Caml_option.some(data);
              end else do
                _param = next;
                continue ;
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
end

function find_all(h, key) do
  find_in_bucket = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[ key ]--0];
        data = param[--[ data ]--1];
        next = param[--[ next ]--2];
        if (Caml_obj.caml_equal(k, key)) then do
          return --[ :: ]--[
                  data,
                  find_in_bucket(next)
                ];
        end else do
          _param = next;
          continue ;
        end end 
      end else do
        return --[ [] ]--0;
      end end 
    end;
  end;
  return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
end

function replace_bucket(key, data, _param) do
  while(true) do
    param = _param;
    if (param) then do
      k = param[--[ key ]--0];
      next = param[--[ next ]--2];
      if (Caml_obj.caml_equal(k, key)) then do
        param[--[ key ]--0] = key;
        param[--[ data ]--1] = data;
        return false;
      end else do
        _param = next;
        continue ;
      end end 
    end else do
      return true;
    end end 
  end;
end

function replace(h, key, data) do
  i = key_index(h, key);
  l = Caml_array.caml_array_get(h.data, i);
  if (replace_bucket(key, data, l)) then do
    Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
          --[ key ]--key,
          --[ data ]--data,
          --[ next ]--l
        ]);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end

function mem(h, key) do
  _param = Caml_array.caml_array_get(h.data, key_index(h, key));
  while(true) do
    param = _param;
    if (param) then do
      k = param[--[ key ]--0];
      next = param[--[ next ]--2];
      if (Caml_obj.caml_equal(k, key)) then do
        return true;
      end else do
        _param = next;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function iter(f, h) do
  do_bucket = function (_param) do
    while(true) do
      param = _param;
      if (param) then do
        key = param[--[ key ]--0];
        data = param[--[ data ]--1];
        next = param[--[ next ]--2];
        Curry._2(f, key, data);
        _param = next;
        continue ;
      end else do
        return --[ () ]--0;
      end end 
    end;
  end;
  old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    if (old_trav) then do
      return 0;
    end else do
      return flip_ongoing_traversal(h);
    end end 
  end
  catch (exn)do
    if (old_trav) then do
      throw exn;
    end else do
      flip_ongoing_traversal(h);
      throw exn;
    end end 
  end
end

function filter_map_inplace_bucket(f, h, i, _prec, _slot) do
  while(true) do
    slot = _slot;
    prec = _prec;
    if (slot) then do
      key = slot[--[ key ]--0];
      data = slot[--[ data ]--1];
      next = slot[--[ next ]--2];
      match = Curry._2(f, key, data);
      if (match ~= undefined) then do
        if (prec) then do
          prec[--[ next ]--2] = slot;
        end else do
          Caml_array.caml_array_set(h.data, i, slot);
        end end 
        slot[--[ data ]--1] = Caml_option.valFromOption(match);
        _slot = next;
        _prec = slot;
        continue ;
      end else do
        h.size = h.size - 1 | 0;
        _slot = next;
        continue ;
      end end 
    end else if (prec) then do
      prec[--[ next ]--2] = --[ Empty ]--0;
      return --[ () ]--0;
    end else do
      return Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end end  end 
  end;
end

function filter_map_inplace(f, h) do
  d = h.data;
  old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    for i = 0 , #d - 1 | 0 , 1 do
      filter_map_inplace_bucket(f, h, i, --[ Empty ]--0, Caml_array.caml_array_get(h.data, i));
    end
    return --[ () ]--0;
  end
  catch (exn)do
    if (old_trav) then do
      throw exn;
    end else do
      flip_ongoing_traversal(h);
      throw exn;
    end end 
  end
end

function fold(f, h, init) do
  do_bucket = function (_b, _accu) do
    while(true) do
      accu = _accu;
      b = _b;
      if (b) then do
        key = b[--[ key ]--0];
        data = b[--[ data ]--1];
        next = b[--[ next ]--2];
        _accu = Curry._3(f, key, data, accu);
        _b = next;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    if (!old_trav) then do
      flip_ongoing_traversal(h);
    end
     end 
    return accu;
  end
  catch (exn)do
    if (old_trav) then do
      throw exn;
    end else do
      flip_ongoing_traversal(h);
      throw exn;
    end end 
  end
end

function bucket_length(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      next = param[--[ next ]--2];
      _param = next;
      _accu = accu + 1 | 0;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function stats(h) do
  mbl = $$Array.fold_left((function (m, b) do
          return Caml_primitive.caml_int_max(m, bucket_length(0, b));
        end), 0, h.data);
  histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
  $$Array.iter((function (b) do
          l = bucket_length(0, b);
          return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
        end), h.data);
  return do
          num_bindings: h.size,
          num_buckets: #h.data,
          max_bucket_length: mbl,
          bucket_histogram: histo
        end;
end

function MakeSeeded(H) do
  key_index = function (h, key) do
    return Curry._2(H.hash, h.seed, key) & (#h.data - 1 | 0);
  end;
  add = function (h, key, data) do
    i = key_index(h, key);
    bucket = --[ Cons ]--[
      --[ key ]--key,
      --[ data ]--data,
      --[ next ]--Caml_array.caml_array_get(h.data, i)
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end;
  remove = function (h, key) do
    i = key_index(h, key);
    h$1 = h;
    i$1 = i;
    key$1 = key;
    _prec = --[ Empty ]--0;
    _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      c = _c;
      prec = _prec;
      if (c) then do
        k = c[--[ key ]--0];
        next = c[--[ next ]--2];
        if (Curry._2(H.equal, k, key$1)) then do
          h$1.size = h$1.size - 1 | 0;
          if (prec) then do
            prec[--[ next ]--2] = next;
            return --[ () ]--0;
          end else do
            return Caml_array.caml_array_set(h$1.data, i$1, next);
          end end 
        end else do
          _c = next;
          _prec = c;
          continue ;
        end end 
      end else do
        return --[ () ]--0;
      end end 
    end;
  end;
  find = function (h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[ key ]--0];
      d1 = match[--[ data ]--1];
      next1 = match[--[ next ]--2];
      if (Curry._2(H.equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        k2 = next1[--[ key ]--0];
        d2 = next1[--[ data ]--1];
        next2 = next1[--[ next ]--2];
        if (Curry._2(H.equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          k3 = next2[--[ key ]--0];
          d3 = next2[--[ data ]--1];
          next3 = next2[--[ next ]--2];
          if (Curry._2(H.equal, key, k3)) then do
            return d3;
          end else do
            key$1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[ key ]--0];
                data = param[--[ data ]--1];
                next = param[--[ next ]--2];
                if (Curry._2(H.equal, key$1, k)) then do
                  return data;
                end else do
                  _param = next;
                  continue ;
                end end 
              end else do
                throw Caml_builtin_exceptions.not_found;
              end end 
            end;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end  end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end  end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
  find_opt = function (h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[ key ]--0];
      d1 = match[--[ data ]--1];
      next1 = match[--[ next ]--2];
      if (Curry._2(H.equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        k2 = next1[--[ key ]--0];
        d2 = next1[--[ data ]--1];
        next2 = next1[--[ next ]--2];
        if (Curry._2(H.equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          k3 = next2[--[ key ]--0];
          d3 = next2[--[ data ]--1];
          next3 = next2[--[ next ]--2];
          if (Curry._2(H.equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            key$1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[ key ]--0];
                data = param[--[ data ]--1];
                next = param[--[ next ]--2];
                if (Curry._2(H.equal, key$1, k)) then do
                  return Caml_option.some(data);
                end else do
                  _param = next;
                  continue ;
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
  end;
  find_all = function (h, key) do
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          k = param[--[ key ]--0];
          d = param[--[ data ]--1];
          next = param[--[ next ]--2];
          if (Curry._2(H.equal, k, key)) then do
            return --[ :: ]--[
                    d,
                    find_in_bucket(next)
                  ];
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
  end;
  replace_bucket = function (key, data, _param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[ key ]--0];
        next = param[--[ next ]--2];
        if (Curry._2(H.equal, k, key)) then do
          param[--[ key ]--0] = key;
          param[--[ data ]--1] = data;
          return false;
        end else do
          _param = next;
          continue ;
        end end 
      end else do
        return true;
      end end 
    end;
  end;
  replace = function (h, key, data) do
    i = key_index(h, key);
    l = Caml_array.caml_array_get(h.data, i);
    if (replace_bucket(key, data, l)) then do
      Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
            --[ key ]--key,
            --[ data ]--data,
            --[ next ]--l
          ]);
      h.size = h.size + 1 | 0;
      if (h.size > (#h.data << 1)) then do
        return resize(key_index, h);
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end;
  mem = function (h, key) do
    _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[ key ]--0];
        next = param[--[ next ]--2];
        if (Curry._2(H.equal, k, key)) then do
          return true;
        end else do
          _param = next;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end;
  return do
          create: create,
          clear: clear,
          reset: reset,
          copy: copy,
          add: add,
          remove: remove,
          find: find,
          find_opt: find_opt,
          find_all: find_all,
          replace: replace,
          mem: mem,
          iter: iter,
          filter_map_inplace: filter_map_inplace,
          fold: fold,
          length: length,
          stats: stats
        end;
end

function Make(H) do
  equal = H.equal;
  key_index = function (h, key) do
    return Curry._1(H.hash, key) & (#h.data - 1 | 0);
  end;
  add = function (h, key, data) do
    i = key_index(h, key);
    bucket = --[ Cons ]--[
      --[ key ]--key,
      --[ data ]--data,
      --[ next ]--Caml_array.caml_array_get(h.data, i)
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(key_index, h);
    end else do
      return 0;
    end end 
  end;
  remove = function (h, key) do
    i = key_index(h, key);
    h$1 = h;
    i$1 = i;
    key$1 = key;
    _prec = --[ Empty ]--0;
    _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      c = _c;
      prec = _prec;
      if (c) then do
        k = c[--[ key ]--0];
        next = c[--[ next ]--2];
        if (Curry._2(equal, k, key$1)) then do
          h$1.size = h$1.size - 1 | 0;
          if (prec) then do
            prec[--[ next ]--2] = next;
            return --[ () ]--0;
          end else do
            return Caml_array.caml_array_set(h$1.data, i$1, next);
          end end 
        end else do
          _c = next;
          _prec = c;
          continue ;
        end end 
      end else do
        return --[ () ]--0;
      end end 
    end;
  end;
  find = function (h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[ key ]--0];
      d1 = match[--[ data ]--1];
      next1 = match[--[ next ]--2];
      if (Curry._2(equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        k2 = next1[--[ key ]--0];
        d2 = next1[--[ data ]--1];
        next2 = next1[--[ next ]--2];
        if (Curry._2(equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          k3 = next2[--[ key ]--0];
          d3 = next2[--[ data ]--1];
          next3 = next2[--[ next ]--2];
          if (Curry._2(equal, key, k3)) then do
            return d3;
          end else do
            key$1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[ key ]--0];
                data = param[--[ data ]--1];
                next = param[--[ next ]--2];
                if (Curry._2(equal, key$1, k)) then do
                  return data;
                end else do
                  _param = next;
                  continue ;
                end end 
              end else do
                throw Caml_builtin_exceptions.not_found;
              end end 
            end;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end  end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end  end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
  find_opt = function (h, key) do
    match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      k1 = match[--[ key ]--0];
      d1 = match[--[ data ]--1];
      next1 = match[--[ next ]--2];
      if (Curry._2(equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        k2 = next1[--[ key ]--0];
        d2 = next1[--[ data ]--1];
        next2 = next1[--[ next ]--2];
        if (Curry._2(equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          k3 = next2[--[ key ]--0];
          d3 = next2[--[ data ]--1];
          next3 = next2[--[ next ]--2];
          if (Curry._2(equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            key$1 = key;
            _param = next3;
            while(true) do
              param = _param;
              if (param) then do
                k = param[--[ key ]--0];
                data = param[--[ data ]--1];
                next = param[--[ next ]--2];
                if (Curry._2(equal, key$1, k)) then do
                  return Caml_option.some(data);
                end else do
                  _param = next;
                  continue ;
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
  end;
  find_all = function (h, key) do
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          k = param[--[ key ]--0];
          d = param[--[ data ]--1];
          next = param[--[ next ]--2];
          if (Curry._2(equal, k, key)) then do
            return --[ :: ]--[
                    d,
                    find_in_bucket(next)
                  ];
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, key)));
  end;
  replace_bucket = function (key, data, _param) do
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[ key ]--0];
        next = param[--[ next ]--2];
        if (Curry._2(equal, k, key)) then do
          param[--[ key ]--0] = key;
          param[--[ data ]--1] = data;
          return false;
        end else do
          _param = next;
          continue ;
        end end 
      end else do
        return true;
      end end 
    end;
  end;
  replace = function (h, key, data) do
    i = key_index(h, key);
    l = Caml_array.caml_array_get(h.data, i);
    if (replace_bucket(key, data, l)) then do
      Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
            --[ key ]--key,
            --[ data ]--data,
            --[ next ]--l
          ]);
      h.size = h.size + 1 | 0;
      if (h.size > (#h.data << 1)) then do
        return resize(key_index, h);
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end;
  mem = function (h, key) do
    _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      param = _param;
      if (param) then do
        k = param[--[ key ]--0];
        next = param[--[ next ]--2];
        if (Curry._2(equal, k, key)) then do
          return true;
        end else do
          _param = next;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end;
  create$1 = function (sz) do
    return create(false, sz);
  end;
  return do
          create: create$1,
          clear: clear,
          reset: reset,
          copy: copy,
          add: add,
          remove: remove,
          find: find,
          find_opt: find_opt,
          find_all: find_all,
          replace: replace,
          mem: mem,
          iter: iter,
          filter_map_inplace: filter_map_inplace,
          fold: fold,
          length: length,
          stats: stats
        end;
end

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
--[ No side effect ]--
