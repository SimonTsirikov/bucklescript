--[['use strict';]]

Obj = require "./obj.lua";
Sys = require "./sys.lua";
__Array = require "./array.lua";
Curry = require "./curry.lua";
Random = require "./random.lua";
Hashtbl = require "./hashtbl.lua";
Caml_obj = require "./caml_obj.lua";
Caml_array = require "./caml_array.lua";
Caml_int32 = require "./caml_int32.lua";
Caml_option = require "./caml_option.lua";
Caml_primitive = require "./caml_primitive.lua";
CamlinternalLazy = require "./camlinternalLazy.lua";
Caml_builtin_exceptions = require "./caml_builtin_exceptions.lua";

function create(param) do
  return Obj.Ephemeron.create(1);
end end

function get_key(t) do
  return Obj.Ephemeron.get_key(t, 0);
end end

function get_key_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 0);
end end

function set_key(t, k) do
  return Obj.Ephemeron.set_key(t, 0, k);
end end

function unset_key(t) do
  return Obj.Ephemeron.unset_key(t, 0);
end end

function check_key(t) do
  return Obj.Ephemeron.check_key(t, 0);
end end

function blit_key(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 1);
end end

function get_data(t) do
  return Obj.Ephemeron.get_data(t);
end end

function get_data_copy(t) do
  return Obj.Ephemeron.get_data_copy(t);
end end

function set_data(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end end

function unset_data(t) do
  return Obj.Ephemeron.unset_data(t);
end end

function check_data(t) do
  return Obj.Ephemeron.check_data(t);
end end

function blit_data(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end end

function MakeSeeded(H) do
  create = function (k, d) do
    c = Obj.Ephemeron.create(1);
    Obj.Ephemeron.set_data(c, d);
    set_key(c, k);
    return c;
  end end;
  hash = H.hash;
  equal = function (c, k) do
    match = Obj.Ephemeron.get_key(c, 0);
    if (match ~= undefined) then do
      if (Curry._2(H.equal, k, Caml_option.valFromOption(match))) then do
        return --[[ ETrue ]]0;
      end else do
        return --[[ EFalse ]]1;
      end end 
    end else do
      return --[[ EDead ]]2;
    end end 
  end end;
  set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    set_key(c, k);
    return Obj.Ephemeron.set_data(c, d);
  end end;
  power_2_above = function (_x, n) do
    while(true) do
      x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end end;
  prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[[ () ]]0);
        end end));
  create$1 = function (randomOpt, initial_size) do
    random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
    s = power_2_above(16, initial_size);
    seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
            seed: seed,
            initial_size: s
          end;
  end end;
  clear = function (h) do
    h.size = 0;
    len = #h.data;
    for i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end
    return --[[ () ]]0;
  end end;
  reset = function (h) do
    len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
      return --[[ () ]]0;
    end end 
  end end;
  copy = function (h) do
    return do
            size: h.size,
            data: __Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end end;
  key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end end;
  clean = function (h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (check_key(c)) then do
            return --[[ Cons ]][
                    param[0],
                    c,
                    do_bucket(rest)
                  ];
          end else do
            h.size = h.size - 1 | 0;
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  resize = function (h) do
    odata = h.data;
    osize = #odata;
    nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
      h.data = ndata;
      insert_bucket = function (param) do
        if (param) then do
          hkey = param[0];
          insert_bucket(param[2]);
          nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[[ () ]]0;
        end end 
      end end;
      for i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end end;
  add = function (h, key, info) do
    hkey = Curry._2(hash, h.seed, key);
    i = key_index(h, hkey);
    container = create(key, info);
    bucket_002 = Caml_array.caml_array_get(h.data, i);
    bucket = --[[ Cons ]][
      hkey,
      container,
      bucket_002
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(h);
    end else do
      return 0;
    end end 
  end end;
  remove = function (h, key) do
    hkey = Curry._2(hash, h.seed, key);
    remove_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          hk = param[0];
          if (hkey == hk) then do
            match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[[ ETrue ]] then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[[ EFalse ]] then do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[[ EDead ]] then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[[ Cons ]][
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end end;
  find = function (h, key) do
    hkey = Curry._2(hash, h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            match$1 = get_data(c);
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_opt = function (h, key) do
    hkey = Curry._2(hash, h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            d = get_data(c);
            if (d ~= undefined) then do
              return d;
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_all = function (h, key) do
    hkey = Curry._2(hash, h.seed, key);
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              match$1 = get_data(c);
              if (match$1 ~= undefined) then do
                return --[[ :: ]][
                        Caml_option.valFromOption(match$1),
                        find_in_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end end;
  replace = function (h, key, info) do
    hkey = Curry._2(hash, h.seed, key);
    i = key_index(h, hkey);
    l = Caml_array.caml_array_get(h.data, i);
    try do
      _param = l;
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = next;
              continue ;
            end else do
              return set_key_data(c, key, info);
            end end 
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
              hkey,
              container,
              l
            ]);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end else do
        throw exn;
      end end 
    end
  end end;
  mem = function (h, key) do
    hkey = Curry._2(hash, h.seed, key);
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        if (param[0] == hkey) then do
          match = equal(param[1], key);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            return true;
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  iter = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          c = param[1];
          match = get_key(c);
          match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
            end
             end 
          end
           end 
          _param = param[2];
          continue ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[[ () ]]0;
  end end;
  fold = function (f, h, init) do
    do_bucket = function (_b, _accu) do
      while(true) do
        accu = _accu;
        b = _b;
        if (b) then do
          c = b[1];
          match = get_key(c);
          match$1 = get_data(c);
          accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end end;
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end end;
  filter_map_inplace = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          match = get_key(c);
          match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              k = Caml_option.valFromOption(match);
              match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  length = function (h) do
    return h.size;
  end end;
  bucket_length = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  stats = function (h) do
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  bucket_length_alive = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        rest = param[2];
        if (check_key(param[1])) then do
          _param = rest;
          _accu = accu + 1 | 0;
          continue ;
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return accu;
      end end 
    end;
  end end;
  stats_alive = function (h) do
    size = do
      contents: 0
    end;
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end end

function Make(H) do
  equal = H.equal;
  hash = function (_seed, x) do
    return Curry._1(H.hash, x);
  end end;
  create = function (k, d) do
    c = Obj.Ephemeron.create(1);
    Obj.Ephemeron.set_data(c, d);
    set_key(c, k);
    return c;
  end end;
  equal$1 = function (c, k) do
    match = Obj.Ephemeron.get_key(c, 0);
    if (match ~= undefined) then do
      if (Curry._2(equal, k, Caml_option.valFromOption(match))) then do
        return --[[ ETrue ]]0;
      end else do
        return --[[ EFalse ]]1;
      end end 
    end else do
      return --[[ EDead ]]2;
    end end 
  end end;
  set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    set_key(c, k);
    return Obj.Ephemeron.set_data(c, d);
  end end;
  power_2_above = function (_x, n) do
    while(true) do
      x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end end;
  prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[[ () ]]0);
        end end));
  clear = function (h) do
    h.size = 0;
    len = #h.data;
    for i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end
    return --[[ () ]]0;
  end end;
  reset = function (h) do
    len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
      return --[[ () ]]0;
    end end 
  end end;
  copy = function (h) do
    return do
            size: h.size,
            data: __Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end end;
  key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end end;
  clean = function (h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (check_key(c)) then do
            return --[[ Cons ]][
                    param[0],
                    c,
                    do_bucket(rest)
                  ];
          end else do
            h.size = h.size - 1 | 0;
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  resize = function (h) do
    odata = h.data;
    osize = #odata;
    nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
      h.data = ndata;
      insert_bucket = function (param) do
        if (param) then do
          hkey = param[0];
          insert_bucket(param[2]);
          nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[[ () ]]0;
        end end 
      end end;
      for i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end end;
  add = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    container = create(key, info);
    bucket_002 = Caml_array.caml_array_get(h.data, i);
    bucket = --[[ Cons ]][
      hkey,
      container,
      bucket_002
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(h);
    end else do
      return 0;
    end end 
  end end;
  remove = function (h, key) do
    hkey = hash(h.seed, key);
    remove_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          hk = param[0];
          if (hkey == hk) then do
            match = equal$1(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[[ ETrue ]] then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[[ EFalse ]] then do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[[ EDead ]] then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[[ Cons ]][
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end end;
  find = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            match$1 = get_data(c);
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_opt = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            d = get_data(c);
            if (d ~= undefined) then do
              return d;
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_all = function (h, key) do
    hkey = hash(h.seed, key);
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal$1(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              match$1 = get_data(c);
              if (match$1 ~= undefined) then do
                return --[[ :: ]][
                        Caml_option.valFromOption(match$1),
                        find_in_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end end;
  replace = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    l = Caml_array.caml_array_get(h.data, i);
    try do
      _param = l;
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal$1(c, key);
            if (match ~= 0) then do
              _param = next;
              continue ;
            end else do
              return set_key_data(c, key, info);
            end end 
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
              hkey,
              container,
              l
            ]);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end else do
        throw exn;
      end end 
    end
  end end;
  mem = function (h, key) do
    hkey = hash(h.seed, key);
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        if (param[0] == hkey) then do
          match = equal$1(param[1], key);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            return true;
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  iter = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          c = param[1];
          match = get_key(c);
          match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
            end
             end 
          end
           end 
          _param = param[2];
          continue ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[[ () ]]0;
  end end;
  fold = function (f, h, init) do
    do_bucket = function (_b, _accu) do
      while(true) do
        accu = _accu;
        b = _b;
        if (b) then do
          c = b[1];
          match = get_key(c);
          match$1 = get_data(c);
          accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end end;
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end end;
  filter_map_inplace = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          match = get_key(c);
          match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              k = Caml_option.valFromOption(match);
              match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  length = function (h) do
    return h.size;
  end end;
  bucket_length = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  stats = function (h) do
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  bucket_length_alive = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        rest = param[2];
        if (check_key(param[1])) then do
          _param = rest;
          _accu = accu + 1 | 0;
          continue ;
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return accu;
      end end 
    end;
  end end;
  stats_alive = function (h) do
    size = do
      contents: 0
    end;
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  create$1 = function (sz) do
    randomOpt = false;
    initial_size = sz;
    random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
    s = power_2_above(16, initial_size);
    seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
            seed: seed,
            initial_size: s
          end;
  end end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end end

function create$1(param) do
  return Obj.Ephemeron.create(2);
end end

function get_key1(t) do
  return Obj.Ephemeron.get_key(t, 0);
end end

function get_key1_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 0);
end end

function set_key1(t, k) do
  return Obj.Ephemeron.set_key(t, 0, k);
end end

function unset_key1(t) do
  return Obj.Ephemeron.unset_key(t, 0);
end end

function check_key1(t) do
  return Obj.Ephemeron.check_key(t, 0);
end end

function get_key2(t) do
  return Obj.Ephemeron.get_key(t, 1);
end end

function get_key2_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 1);
end end

function set_key2(t, k) do
  return Obj.Ephemeron.set_key(t, 1, k);
end end

function unset_key2(t) do
  return Obj.Ephemeron.unset_key(t, 1);
end end

function check_key2(t) do
  return Obj.Ephemeron.check_key(t, 1);
end end

function blit_key1(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 1);
end end

function blit_key2(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 1, t2, 1, 1);
end end

function blit_key12(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 2);
end end

function get_data$1(t) do
  return Obj.Ephemeron.get_data(t);
end end

function get_data_copy$1(t) do
  return Obj.Ephemeron.get_data_copy(t);
end end

function set_data$1(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end end

function unset_data$1(t) do
  return Obj.Ephemeron.unset_data(t);
end end

function check_data$1(t) do
  return Obj.Ephemeron.check_data(t);
end end

function blit_data$1(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end end

function MakeSeeded$1(H1, H2) do
  create = function (param, d) do
    c = Obj.Ephemeron.create(2);
    Obj.Ephemeron.set_data(c, d);
    set_key1(c, param[0]);
    set_key2(c, param[1]);
    return c;
  end end;
  hash = function (seed, param) do
    return Curry._2(H1.hash, seed, param[0]) + Caml_int32.imul(Curry._2(H2.hash, seed, param[1]), 65599) | 0;
  end end;
  equal = function (c, param) do
    match = Obj.Ephemeron.get_key(c, 0);
    match$1 = Obj.Ephemeron.get_key(c, 1);
    if (match ~= undefined and match$1 ~= undefined) then do
      if (Curry._2(H1.equal, param[0], Caml_option.valFromOption(match)) and Curry._2(H2.equal, param[1], Caml_option.valFromOption(match$1))) then do
        return --[[ ETrue ]]0;
      end else do
        return --[[ EFalse ]]1;
      end end 
    end else do
      return --[[ EDead ]]2;
    end end 
  end end;
  get_key = function (c) do
    match = Obj.Ephemeron.get_key(c, 0);
    match$1 = Obj.Ephemeron.get_key(c, 1);
    if (match ~= undefined and match$1 ~= undefined) then do
      return --[[ tuple ]][
              Caml_option.valFromOption(match),
              Caml_option.valFromOption(match$1)
            ];
    end
     end 
  end end;
  set_key_data = function (c, param, d) do
    Obj.Ephemeron.unset_data(c);
    set_key1(c, param[0]);
    set_key2(c, param[1]);
    return Obj.Ephemeron.set_data(c, d);
  end end;
  check_key = function (c) do
    if (Obj.Ephemeron.check_key(c, 0)) then do
      return Obj.Ephemeron.check_key(c, 1);
    end else do
      return false;
    end end 
  end end;
  power_2_above = function (_x, n) do
    while(true) do
      x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end end;
  prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[[ () ]]0);
        end end));
  create$1 = function (randomOpt, initial_size) do
    random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
    s = power_2_above(16, initial_size);
    seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
            seed: seed,
            initial_size: s
          end;
  end end;
  clear = function (h) do
    h.size = 0;
    len = #h.data;
    for i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end
    return --[[ () ]]0;
  end end;
  reset = function (h) do
    len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
      return --[[ () ]]0;
    end end 
  end end;
  copy = function (h) do
    return do
            size: h.size,
            data: __Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end end;
  key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end end;
  clean = function (h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (check_key(c)) then do
            return --[[ Cons ]][
                    param[0],
                    c,
                    do_bucket(rest)
                  ];
          end else do
            h.size = h.size - 1 | 0;
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  resize = function (h) do
    odata = h.data;
    osize = #odata;
    nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
      h.data = ndata;
      insert_bucket = function (param) do
        if (param) then do
          hkey = param[0];
          insert_bucket(param[2]);
          nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[[ () ]]0;
        end end 
      end end;
      for i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end end;
  add = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    container = create(key, info);
    bucket_002 = Caml_array.caml_array_get(h.data, i);
    bucket = --[[ Cons ]][
      hkey,
      container,
      bucket_002
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(h);
    end else do
      return 0;
    end end 
  end end;
  remove = function (h, key) do
    hkey = hash(h.seed, key);
    remove_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          hk = param[0];
          if (hkey == hk) then do
            match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[[ ETrue ]] then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[[ EFalse ]] then do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[[ EDead ]] then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[[ Cons ]][
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end end;
  find = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            match$1 = get_data$1(c);
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_opt = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            d = get_data$1(c);
            if (d ~= undefined) then do
              return d;
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_all = function (h, key) do
    hkey = hash(h.seed, key);
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              match$1 = get_data$1(c);
              if (match$1 ~= undefined) then do
                return --[[ :: ]][
                        Caml_option.valFromOption(match$1),
                        find_in_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end end;
  replace = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    l = Caml_array.caml_array_get(h.data, i);
    try do
      _param = l;
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = next;
              continue ;
            end else do
              return set_key_data(c, key, info);
            end end 
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
              hkey,
              container,
              l
            ]);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end else do
        throw exn;
      end end 
    end
  end end;
  mem = function (h, key) do
    hkey = hash(h.seed, key);
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        if (param[0] == hkey) then do
          match = equal(param[1], key);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            return true;
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  iter = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          c = param[1];
          match = get_key(c);
          match$1 = get_data$1(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
            end
             end 
          end
           end 
          _param = param[2];
          continue ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[[ () ]]0;
  end end;
  fold = function (f, h, init) do
    do_bucket = function (_b, _accu) do
      while(true) do
        accu = _accu;
        b = _b;
        if (b) then do
          c = b[1];
          match = get_key(c);
          match$1 = get_data$1(c);
          accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end end;
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end end;
  filter_map_inplace = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          match = get_key(c);
          match$1 = get_data$1(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              k = Caml_option.valFromOption(match);
              match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  length = function (h) do
    return h.size;
  end end;
  bucket_length = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  stats = function (h) do
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  bucket_length_alive = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        rest = param[2];
        if (check_key(param[1])) then do
          _param = rest;
          _accu = accu + 1 | 0;
          continue ;
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return accu;
      end end 
    end;
  end end;
  stats_alive = function (h) do
    size = do
      contents: 0
    end;
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end end

function Make$1(H1, H2) do
  hash = function (_seed, x) do
    return Curry._1(H1.hash, x);
  end end;
  partial_arg_equal = H1.equal;
  hash$1 = function (_seed, x) do
    return Curry._1(H2.hash, x);
  end end;
  include = (function (param) do
        create = function (param, d) do
          c = Obj.Ephemeron.create(2);
          Obj.Ephemeron.set_data(c, d);
          set_key1(c, param[0]);
          set_key2(c, param[1]);
          return c;
        end end;
        hash$2 = function (seed, param$1) do
          return Curry._2(hash, seed, param$1[0]) + Caml_int32.imul(Curry._2(param.hash, seed, param$1[1]), 65599) | 0;
        end end;
        equal = function (c, param$1) do
          match = Obj.Ephemeron.get_key(c, 0);
          match$1 = Obj.Ephemeron.get_key(c, 1);
          if (match ~= undefined and match$1 ~= undefined) then do
            if (Curry._2(partial_arg_equal, param$1[0], Caml_option.valFromOption(match)) and Curry._2(param.equal, param$1[1], Caml_option.valFromOption(match$1))) then do
              return --[[ ETrue ]]0;
            end else do
              return --[[ EFalse ]]1;
            end end 
          end else do
            return --[[ EDead ]]2;
          end end 
        end end;
        get_key = function (c) do
          match = Obj.Ephemeron.get_key(c, 0);
          match$1 = Obj.Ephemeron.get_key(c, 1);
          if (match ~= undefined and match$1 ~= undefined) then do
            return --[[ tuple ]][
                    Caml_option.valFromOption(match),
                    Caml_option.valFromOption(match$1)
                  ];
          end
           end 
        end end;
        set_key_data = function (c, param, d) do
          Obj.Ephemeron.unset_data(c);
          set_key1(c, param[0]);
          set_key2(c, param[1]);
          return Obj.Ephemeron.set_data(c, d);
        end end;
        check_key = function (c) do
          if (Obj.Ephemeron.check_key(c, 0)) then do
            return Obj.Ephemeron.check_key(c, 1);
          end else do
            return false;
          end end 
        end end;
        power_2_above = function (_x, n) do
          while(true) do
            x = _x;
            if (x >= n or (x << 1) > Sys.max_array_length) then do
              return x;
            end else do
              _x = (x << 1);
              continue ;
            end end 
          end;
        end end;
        prng = Caml_obj.caml_lazy_make((function (param) do
                return Random.State.make_self_init(--[[ () ]]0);
              end end));
        create$1 = function (randomOpt, initial_size) do
          random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
          s = power_2_above(16, initial_size);
          seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
          return do
                  size: 0,
                  data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
                  seed: seed,
                  initial_size: s
                end;
        end end;
        clear = function (h) do
          h.size = 0;
          len = #h.data;
          for i = 0 , len - 1 | 0 , 1 do
            Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
          end
          return --[[ () ]]0;
        end end;
        reset = function (h) do
          len = #h.data;
          if (len == h.initial_size) then do
            return clear(h);
          end else do
            h.size = 0;
            h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
            return --[[ () ]]0;
          end end 
        end end;
        copy = function (h) do
          return do
                  size: h.size,
                  data: __Array.copy(h.data),
                  seed: h.seed,
                  initial_size: h.initial_size
                end;
        end end;
        key_index = function (h, hkey) do
          return hkey & (#h.data - 1 | 0);
        end end;
        clean = function (h) do
          do_bucket = function (_param) do
            while(true) do
              param = _param;
              if (param) then do
                rest = param[2];
                c = param[1];
                if (Curry._1(check_key, c)) then do
                  return --[[ Cons ]][
                          param[0],
                          c,
                          do_bucket(rest)
                        ];
                end else do
                  h.size = h.size - 1 | 0;
                  _param = rest;
                  continue ;
                end end 
              end else do
                return --[[ Empty ]]0;
              end end 
            end;
          end end;
          d = h.data;
          for i = 0 , #d - 1 | 0 , 1 do
            Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
          end
          return --[[ () ]]0;
        end end;
        resize = function (h) do
          odata = h.data;
          osize = #odata;
          nsize = (osize << 1);
          clean(h);
          if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
            ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
            h.data = ndata;
            insert_bucket = function (param) do
              if (param) then do
                hkey = param[0];
                insert_bucket(param[2]);
                nidx = key_index(h, hkey);
                return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                            hkey,
                            param[1],
                            Caml_array.caml_array_get(ndata, nidx)
                          ]);
              end else do
                return --[[ () ]]0;
              end end 
            end end;
            for i = 0 , osize - 1 | 0 , 1 do
              insert_bucket(Caml_array.caml_array_get(odata, i));
            end
            return --[[ () ]]0;
          end else do
            return 0;
          end end 
        end end;
        add = function (h, key, info) do
          hkey = Curry._2(hash$2, h.seed, key);
          i = key_index(h, hkey);
          container = Curry._2(create, key, info);
          bucket_002 = Caml_array.caml_array_get(h.data, i);
          bucket = --[[ Cons ]][
            hkey,
            container,
            bucket_002
          ];
          Caml_array.caml_array_set(h.data, i, bucket);
          h.size = h.size + 1 | 0;
          if (h.size > (#h.data << 1)) then do
            return resize(h);
          end else do
            return 0;
          end end 
        end end;
        remove = function (h, key) do
          hkey = Curry._2(hash$2, h.seed, key);
          remove_bucket = function (_param) do
            while(true) do
              param = _param;
              if (param) then do
                next = param[2];
                c = param[1];
                hk = param[0];
                if (hkey == hk) then do
                  match = Curry._2(equal, c, key);
                  local ___conditional___=(match);
                  do
                     if ___conditional___ = 0--[[ ETrue ]] then do
                        h.size = h.size - 1 | 0;
                        return next;end end end 
                     if ___conditional___ = 1--[[ EFalse ]] then do
                        return --[[ Cons ]][
                                hk,
                                c,
                                remove_bucket(next)
                              ];end end end 
                     if ___conditional___ = 2--[[ EDead ]] then do
                        h.size = h.size - 1 | 0;
                        _param = next;
                        continue ;end end end 
                     do
                    
                  end
                end else do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];
                end end 
              end else do
                return --[[ Empty ]]0;
              end end 
            end;
          end end;
          i = key_index(h, hkey);
          return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
        end end;
        find = function (h, key) do
          hkey = Curry._2(hash$2, h.seed, key);
          key$1 = key;
          hkey$1 = hkey;
          _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              c = param[1];
              if (hkey$1 == param[0]) then do
                match = Curry._2(equal, c, key$1);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  match$1 = Curry._1(get_data$1, c);
                  if (match$1 ~= undefined) then do
                    return Caml_option.valFromOption(match$1);
                  end else do
                    _param = rest;
                    continue ;
                  end end 
                end end 
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              throw Caml_builtin_exceptions.not_found;
            end end 
          end;
        end end;
        find_opt = function (h, key) do
          hkey = Curry._2(hash$2, h.seed, key);
          key$1 = key;
          hkey$1 = hkey;
          _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              c = param[1];
              if (hkey$1 == param[0]) then do
                match = Curry._2(equal, c, key$1);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  d = Curry._1(get_data$1, c);
                  if (d ~= undefined) then do
                    return d;
                  end else do
                    _param = rest;
                    continue ;
                  end end 
                end end 
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              return ;
            end end 
          end;
        end end;
        find_all = function (h, key) do
          hkey = Curry._2(hash$2, h.seed, key);
          find_in_bucket = function (_param) do
            while(true) do
              param = _param;
              if (param) then do
                rest = param[2];
                c = param[1];
                if (hkey == param[0]) then do
                  match = Curry._2(equal, c, key);
                  if (match ~= 0) then do
                    _param = rest;
                    continue ;
                  end else do
                    match$1 = Curry._1(get_data$1, c);
                    if (match$1 ~= undefined) then do
                      return --[[ :: ]][
                              Caml_option.valFromOption(match$1),
                              find_in_bucket(rest)
                            ];
                    end else do
                      _param = rest;
                      continue ;
                    end end 
                  end end 
                end else do
                  _param = rest;
                  continue ;
                end end 
              end else do
                return --[[ [] ]]0;
              end end 
            end;
          end end;
          return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
        end end;
        replace = function (h, key, info) do
          hkey = Curry._2(hash$2, h.seed, key);
          i = key_index(h, hkey);
          l = Caml_array.caml_array_get(h.data, i);
          try do
            _param = l;
            while(true) do
              param = _param;
              if (param) then do
                next = param[2];
                c = param[1];
                if (hkey == param[0]) then do
                  match = Curry._2(equal, c, key);
                  if (match ~= 0) then do
                    _param = next;
                    continue ;
                  end else do
                    return Curry._3(set_key_data, c, key, info);
                  end end 
                end else do
                  _param = next;
                  continue ;
                end end 
              end else do
                throw Caml_builtin_exceptions.not_found;
              end end 
            end;
          end
          catch (exn)do
            if (exn == Caml_builtin_exceptions.not_found) then do
              container = Curry._2(create, key, info);
              Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
                    hkey,
                    container,
                    l
                  ]);
              h.size = h.size + 1 | 0;
              if (h.size > (#h.data << 1)) then do
                return resize(h);
              end else do
                return 0;
              end end 
            end else do
              throw exn;
            end end 
          end
        end end;
        mem = function (h, key) do
          hkey = Curry._2(hash$2, h.seed, key);
          _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              if (param[0] == hkey) then do
                match = Curry._2(equal, param[1], key);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  return true;
                end end 
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              return false;
            end end 
          end;
        end end;
        iter = function (f, h) do
          do_bucket = function (_param) do
            while(true) do
              param = _param;
              if (param) then do
                c = param[1];
                match = Curry._1(get_key, c);
                match$1 = Curry._1(get_data$1, c);
                if (match ~= undefined) then do
                  if (match$1 ~= undefined) then do
                    Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
                  end
                   end 
                end
                 end 
                _param = param[2];
                continue ;
              end else do
                return --[[ () ]]0;
              end end 
            end;
          end end;
          d = h.data;
          for i = 0 , #d - 1 | 0 , 1 do
            do_bucket(Caml_array.caml_array_get(d, i));
          end
          return --[[ () ]]0;
        end end;
        fold = function (f, h, init) do
          do_bucket = function (_b, _accu) do
            while(true) do
              accu = _accu;
              b = _b;
              if (b) then do
                c = b[1];
                match = Curry._1(get_key, c);
                match$1 = Curry._1(get_data$1, c);
                accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
                _accu = accu$1;
                _b = b[2];
                continue ;
              end else do
                return accu;
              end end 
            end;
          end end;
          d = h.data;
          accu = init;
          for i = 0 , #d - 1 | 0 , 1 do
            accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
          end
          return accu;
        end end;
        filter_map_inplace = function (f, h) do
          do_bucket = function (_param) do
            while(true) do
              param = _param;
              if (param) then do
                rest = param[2];
                c = param[1];
                match = Curry._1(get_key, c);
                match$1 = Curry._1(get_data$1, c);
                if (match ~= undefined) then do
                  if (match$1 ~= undefined) then do
                    k = Caml_option.valFromOption(match);
                    match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
                    if (match$2 ~= undefined) then do
                      Curry._3(set_key_data, c, k, Caml_option.valFromOption(match$2));
                      return --[[ Cons ]][
                              param[0],
                              c,
                              do_bucket(rest)
                            ];
                    end else do
                      _param = rest;
                      continue ;
                    end end 
                  end else do
                    _param = rest;
                    continue ;
                  end end 
                end else do
                  _param = rest;
                  continue ;
                end end 
              end else do
                return --[[ Empty ]]0;
              end end 
            end;
          end end;
          d = h.data;
          for i = 0 , #d - 1 | 0 , 1 do
            Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
          end
          return --[[ () ]]0;
        end end;
        length = function (h) do
          return h.size;
        end end;
        bucket_length = function (_accu, _param) do
          while(true) do
            param = _param;
            accu = _accu;
            if (param) then do
              _param = param[2];
              _accu = accu + 1 | 0;
              continue ;
            end else do
              return accu;
            end end 
          end;
        end end;
        stats = function (h) do
          mbl = __Array.fold_left((function (m, b) do
                  return Caml_primitive.caml_int_max(m, bucket_length(0, b));
                end end), 0, h.data);
          histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
          __Array.iter((function (b) do
                  l = bucket_length(0, b);
                  return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
                end end), h.data);
          return do
                  num_bindings: h.size,
                  num_buckets: #h.data,
                  max_bucket_length: mbl,
                  bucket_histogram: histo
                end;
        end end;
        bucket_length_alive = function (_accu, _param) do
          while(true) do
            param = _param;
            accu = _accu;
            if (param) then do
              rest = param[2];
              if (Curry._1(check_key, param[1])) then do
                _param = rest;
                _accu = accu + 1 | 0;
                continue ;
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              return accu;
            end end 
          end;
        end end;
        stats_alive = function (h) do
          size = do
            contents: 0
          end;
          mbl = __Array.fold_left((function (m, b) do
                  return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
                end end), 0, h.data);
          histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
          __Array.iter((function (b) do
                  l = bucket_length_alive(0, b);
                  size.contents = size.contents + l | 0;
                  return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
                end end), h.data);
          return do
                  num_bindings: size.contents,
                  num_buckets: #h.data,
                  max_bucket_length: mbl,
                  bucket_histogram: histo
                end;
        end end;
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
                stats: stats,
                clean: clean,
                stats_alive: stats_alive
              end;
      end end)(do
        equal: H2.equal,
        hash: hash$1
      end);
  create = include.create;
  create$1 = function (sz) do
    return Curry._2(create, false, sz);
  end end;
  return do
          create: create$1,
          clear: include.clear,
          reset: include.reset,
          copy: include.copy,
          add: include.add,
          remove: include.remove,
          find: include.find,
          find_opt: include.find_opt,
          find_all: include.find_all,
          replace: include.replace,
          mem: include.mem,
          iter: include.iter,
          filter_map_inplace: include.filter_map_inplace,
          fold: include.fold,
          length: include.length,
          stats: include.stats,
          clean: include.clean,
          stats_alive: include.stats_alive
        end;
end end

function create$2(n) do
  return Obj.Ephemeron.create(n);
end end

function get_key$1(t, n) do
  return Obj.Ephemeron.get_key(t, n);
end end

function get_key_copy$1(t, n) do
  return Obj.Ephemeron.get_key_copy(t, n);
end end

function set_key$1(t, n, k) do
  return Obj.Ephemeron.set_key(t, n, k);
end end

function unset_key$1(t, n) do
  return Obj.Ephemeron.unset_key(t, n);
end end

function check_key$1(t, n) do
  return Obj.Ephemeron.check_key(t, n);
end end

function blit_key$1(t1, o1, t2, o2, l) do
  return Obj.Ephemeron.blit_key(t1, o1, t2, o2, l);
end end

function get_data$2(t) do
  return Obj.Ephemeron.get_data(t);
end end

function get_data_copy$2(t) do
  return Obj.Ephemeron.get_data_copy(t);
end end

function set_data$2(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end end

function unset_data$2(t) do
  return Obj.Ephemeron.unset_data(t);
end end

function check_data$2(t) do
  return Obj.Ephemeron.check_data(t);
end end

function blit_data$2(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end end

function MakeSeeded$2(H) do
  create = function (k, d) do
    c = Obj.Ephemeron.create(#k);
    Obj.Ephemeron.set_data(c, d);
    for i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return c;
  end end;
  hash = function (seed, k) do
    h = 0;
    for i = 0 , #k - 1 | 0 , 1 do
      h = Caml_int32.imul(Curry._2(H.hash, seed, Caml_array.caml_array_get(k, i)), 65599) + h | 0;
    end
    return h;
  end end;
  equal = function (c, k) do
    len = #k;
    len$prime = Obj.Ephemeron.length(c);
    if (len ~= len$prime) then do
      return --[[ EFalse ]]1;
    end else do
      k$1 = k;
      c$1 = c;
      _i = len - 1 | 0;
      while(true) do
        i = _i;
        if (i < 0) then do
          return --[[ ETrue ]]0;
        end else do
          match = Obj.Ephemeron.get_key(c$1, i);
          if (match ~= undefined) then do
            if (Curry._2(H.equal, Caml_array.caml_array_get(k$1, i), Caml_option.valFromOption(match))) then do
              _i = i - 1 | 0;
              continue ;
            end else do
              return --[[ EFalse ]]1;
            end end 
          end else do
            return --[[ EDead ]]2;
          end end 
        end end 
      end;
    end end 
  end end;
  get_key = function (c) do
    len = Obj.Ephemeron.length(c);
    if (len == 0) then do
      return [];
    end else do
      match = Obj.Ephemeron.get_key(c, 0);
      if (match ~= undefined) then do
        a = Caml_array.caml_make_vect(len, Caml_option.valFromOption(match));
        a$1 = a;
        _i = len - 1 | 0;
        while(true) do
          i = _i;
          if (i < 1) then do
            return a$1;
          end else do
            match$1 = Obj.Ephemeron.get_key(c, i);
            if (match$1 ~= undefined) then do
              Caml_array.caml_array_set(a$1, i, Caml_option.valFromOption(match$1));
              _i = i - 1 | 0;
              continue ;
            end else do
              return ;
            end end 
          end end 
        end;
      end else do
        return ;
      end end 
    end end 
  end end;
  set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    for i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return Obj.Ephemeron.set_data(c, d);
  end end;
  check_key = function (c) do
    c$1 = c;
    _i = Obj.Ephemeron.length(c) - 1 | 0;
    while(true) do
      i = _i;
      if (i < 0) then do
        return true;
      end else if (Obj.Ephemeron.check_key(c$1, i)) then do
        _i = i - 1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end end;
  power_2_above = function (_x, n) do
    while(true) do
      x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end end;
  prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[[ () ]]0);
        end end));
  create$1 = function (randomOpt, initial_size) do
    random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
    s = power_2_above(16, initial_size);
    seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
            seed: seed,
            initial_size: s
          end;
  end end;
  clear = function (h) do
    h.size = 0;
    len = #h.data;
    for i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end
    return --[[ () ]]0;
  end end;
  reset = function (h) do
    len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
      return --[[ () ]]0;
    end end 
  end end;
  copy = function (h) do
    return do
            size: h.size,
            data: __Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end end;
  key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end end;
  clean = function (h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (check_key(c)) then do
            return --[[ Cons ]][
                    param[0],
                    c,
                    do_bucket(rest)
                  ];
          end else do
            h.size = h.size - 1 | 0;
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  resize = function (h) do
    odata = h.data;
    osize = #odata;
    nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
      h.data = ndata;
      insert_bucket = function (param) do
        if (param) then do
          hkey = param[0];
          insert_bucket(param[2]);
          nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[[ () ]]0;
        end end 
      end end;
      for i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end end;
  add = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    container = create(key, info);
    bucket_002 = Caml_array.caml_array_get(h.data, i);
    bucket = --[[ Cons ]][
      hkey,
      container,
      bucket_002
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(h);
    end else do
      return 0;
    end end 
  end end;
  remove = function (h, key) do
    hkey = hash(h.seed, key);
    remove_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          hk = param[0];
          if (hkey == hk) then do
            match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[[ ETrue ]] then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[[ EFalse ]] then do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[[ EDead ]] then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[[ Cons ]][
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end end;
  find = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            match$1 = get_data$2(c);
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_opt = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            d = get_data$2(c);
            if (d ~= undefined) then do
              return d;
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_all = function (h, key) do
    hkey = hash(h.seed, key);
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              match$1 = get_data$2(c);
              if (match$1 ~= undefined) then do
                return --[[ :: ]][
                        Caml_option.valFromOption(match$1),
                        find_in_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end end;
  replace = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    l = Caml_array.caml_array_get(h.data, i);
    try do
      _param = l;
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal(c, key);
            if (match ~= 0) then do
              _param = next;
              continue ;
            end else do
              return set_key_data(c, key, info);
            end end 
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
              hkey,
              container,
              l
            ]);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end else do
        throw exn;
      end end 
    end
  end end;
  mem = function (h, key) do
    hkey = hash(h.seed, key);
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        if (param[0] == hkey) then do
          match = equal(param[1], key);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            return true;
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  iter = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          c = param[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
            end
             end 
          end
           end 
          _param = param[2];
          continue ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[[ () ]]0;
  end end;
  fold = function (f, h, init) do
    do_bucket = function (_b, _accu) do
      while(true) do
        accu = _accu;
        b = _b;
        if (b) then do
          c = b[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end end;
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end end;
  filter_map_inplace = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              k = Caml_option.valFromOption(match);
              match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  length = function (h) do
    return h.size;
  end end;
  bucket_length = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  stats = function (h) do
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  bucket_length_alive = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        rest = param[2];
        if (check_key(param[1])) then do
          _param = rest;
          _accu = accu + 1 | 0;
          continue ;
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return accu;
      end end 
    end;
  end end;
  stats_alive = function (h) do
    size = do
      contents: 0
    end;
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end end

function Make$2(H) do
  equal = H.equal;
  create = function (k, d) do
    c = Obj.Ephemeron.create(#k);
    Obj.Ephemeron.set_data(c, d);
    for i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return c;
  end end;
  hash = function (seed, k) do
    h = 0;
    for i = 0 , #k - 1 | 0 , 1 do
      h = Caml_int32.imul(Curry._1(H.hash, Caml_array.caml_array_get(k, i)), 65599) + h | 0;
    end
    return h;
  end end;
  equal$1 = function (c, k) do
    len = #k;
    len$prime = Obj.Ephemeron.length(c);
    if (len ~= len$prime) then do
      return --[[ EFalse ]]1;
    end else do
      k$1 = k;
      c$1 = c;
      _i = len - 1 | 0;
      while(true) do
        i = _i;
        if (i < 0) then do
          return --[[ ETrue ]]0;
        end else do
          match = Obj.Ephemeron.get_key(c$1, i);
          if (match ~= undefined) then do
            if (Curry._2(equal, Caml_array.caml_array_get(k$1, i), Caml_option.valFromOption(match))) then do
              _i = i - 1 | 0;
              continue ;
            end else do
              return --[[ EFalse ]]1;
            end end 
          end else do
            return --[[ EDead ]]2;
          end end 
        end end 
      end;
    end end 
  end end;
  get_key = function (c) do
    len = Obj.Ephemeron.length(c);
    if (len == 0) then do
      return [];
    end else do
      match = Obj.Ephemeron.get_key(c, 0);
      if (match ~= undefined) then do
        a = Caml_array.caml_make_vect(len, Caml_option.valFromOption(match));
        a$1 = a;
        _i = len - 1 | 0;
        while(true) do
          i = _i;
          if (i < 1) then do
            return a$1;
          end else do
            match$1 = Obj.Ephemeron.get_key(c, i);
            if (match$1 ~= undefined) then do
              Caml_array.caml_array_set(a$1, i, Caml_option.valFromOption(match$1));
              _i = i - 1 | 0;
              continue ;
            end else do
              return ;
            end end 
          end end 
        end;
      end else do
        return ;
      end end 
    end end 
  end end;
  set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    for i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return Obj.Ephemeron.set_data(c, d);
  end end;
  check_key = function (c) do
    c$1 = c;
    _i = Obj.Ephemeron.length(c) - 1 | 0;
    while(true) do
      i = _i;
      if (i < 0) then do
        return true;
      end else if (Obj.Ephemeron.check_key(c$1, i)) then do
        _i = i - 1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end end;
  power_2_above = function (_x, n) do
    while(true) do
      x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end end;
  prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[[ () ]]0);
        end end));
  clear = function (h) do
    h.size = 0;
    len = #h.data;
    for i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
    end
    return --[[ () ]]0;
  end end;
  reset = function (h) do
    len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
      return --[[ () ]]0;
    end end 
  end end;
  copy = function (h) do
    return do
            size: h.size,
            data: __Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end end;
  key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end end;
  clean = function (h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (check_key(c)) then do
            return --[[ Cons ]][
                    param[0],
                    c,
                    do_bucket(rest)
                  ];
          end else do
            h.size = h.size - 1 | 0;
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  resize = function (h) do
    odata = h.data;
    osize = #odata;
    nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
      h.data = ndata;
      insert_bucket = function (param) do
        if (param) then do
          hkey = param[0];
          insert_bucket(param[2]);
          nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[[ () ]]0;
        end end 
      end end;
      for i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end end;
  add = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    container = create(key, info);
    bucket_002 = Caml_array.caml_array_get(h.data, i);
    bucket = --[[ Cons ]][
      hkey,
      container,
      bucket_002
    ];
    Caml_array.caml_array_set(h.data, i, bucket);
    h.size = h.size + 1 | 0;
    if (h.size > (#h.data << 1)) then do
      return resize(h);
    end else do
      return 0;
    end end 
  end end;
  remove = function (h, key) do
    hkey = hash(h.seed, key);
    remove_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          hk = param[0];
          if (hkey == hk) then do
            match = equal$1(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[[ ETrue ]] then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[[ EFalse ]] then do
                  return --[[ Cons ]][
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[[ EDead ]] then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[[ Cons ]][
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end end;
  find = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            match$1 = get_data$2(c);
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end end;
  find_opt = function (h, key) do
    hkey = hash(h.seed, key);
    key$1 = key;
    hkey$1 = hkey;
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        c = param[1];
        if (hkey$1 == param[0]) then do
          match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            d = get_data$2(c);
            if (d ~= undefined) then do
              return d;
            end else do
              _param = rest;
              continue ;
            end end 
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end;
  find_all = function (h, key) do
    hkey = hash(h.seed, key);
    find_in_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal$1(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              match$1 = get_data$2(c);
              if (match$1 ~= undefined) then do
                return --[[ :: ]][
                        Caml_option.valFromOption(match$1),
                        find_in_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ [] ]]0;
        end end 
      end;
    end end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end end;
  replace = function (h, key, info) do
    hkey = hash(h.seed, key);
    i = key_index(h, hkey);
    l = Caml_array.caml_array_get(h.data, i);
    try do
      _param = l;
      while(true) do
        param = _param;
        if (param) then do
          next = param[2];
          c = param[1];
          if (hkey == param[0]) then do
            match = equal$1(c, key);
            if (match ~= 0) then do
              _param = next;
              continue ;
            end else do
              return set_key_data(c, key, info);
            end end 
          end else do
            _param = next;
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
              hkey,
              container,
              l
            ]);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end else do
        throw exn;
      end end 
    end
  end end;
  mem = function (h, key) do
    hkey = hash(h.seed, key);
    _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      param = _param;
      if (param) then do
        rest = param[2];
        if (param[0] == hkey) then do
          match = equal$1(param[1], key);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            return true;
          end end 
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end end;
  iter = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          c = param[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
            end
             end 
          end
           end 
          _param = param[2];
          continue ;
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[[ () ]]0;
  end end;
  fold = function (f, h, init) do
    do_bucket = function (_b, _accu) do
      while(true) do
        accu = _accu;
        b = _b;
        if (b) then do
          c = b[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end end;
    d = h.data;
    accu = init;
    for i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end end;
  filter_map_inplace = function (f, h) do
    do_bucket = function (_param) do
      while(true) do
        param = _param;
        if (param) then do
          rest = param[2];
          c = param[1];
          match = get_key(c);
          match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              k = Caml_option.valFromOption(match);
              match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            _param = rest;
            continue ;
          end end 
        end else do
          return --[[ Empty ]]0;
        end end 
      end;
    end end;
    d = h.data;
    for i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[[ () ]]0;
  end end;
  length = function (h) do
    return h.size;
  end end;
  bucket_length = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end end;
  stats = function (h) do
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  bucket_length_alive = function (_accu, _param) do
    while(true) do
      param = _param;
      accu = _accu;
      if (param) then do
        rest = param[2];
        if (check_key(param[1])) then do
          _param = rest;
          _accu = accu + 1 | 0;
          continue ;
        end else do
          _param = rest;
          continue ;
        end end 
      end else do
        return accu;
      end end 
    end;
  end end;
  stats_alive = function (h) do
    size = do
      contents: 0
    end;
    mbl = __Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end end), 0, h.data);
    histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    __Array.iter((function (b) do
            l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end end;
  create$1 = function (sz) do
    randomOpt = false;
    initial_size = sz;
    random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
    s = power_2_above(16, initial_size);
    seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
            seed: seed,
            initial_size: s
          end;
  end end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end end

K1 = do
  create: create,
  get_key: get_key,
  get_key_copy: get_key_copy,
  set_key: set_key,
  unset_key: unset_key,
  check_key: check_key,
  blit_key: blit_key,
  get_data: get_data,
  get_data_copy: get_data_copy,
  set_data: set_data,
  unset_data: unset_data,
  check_data: check_data,
  blit_data: blit_data,
  Make: Make,
  MakeSeeded: MakeSeeded
end;

K2 = do
  create: create$1,
  get_key1: get_key1,
  get_key1_copy: get_key1_copy,
  set_key1: set_key1,
  unset_key1: unset_key1,
  check_key1: check_key1,
  get_key2: get_key2,
  get_key2_copy: get_key2_copy,
  set_key2: set_key2,
  unset_key2: unset_key2,
  check_key2: check_key2,
  blit_key1: blit_key1,
  blit_key2: blit_key2,
  blit_key12: blit_key12,
  get_data: get_data$1,
  get_data_copy: get_data_copy$1,
  set_data: set_data$1,
  unset_data: unset_data$1,
  check_data: check_data$1,
  blit_data: blit_data$1,
  Make: Make$1,
  MakeSeeded: MakeSeeded$1
end;

Kn = do
  create: create$2,
  get_key: get_key$1,
  get_key_copy: get_key_copy$1,
  set_key: set_key$1,
  unset_key: unset_key$1,
  check_key: check_key$1,
  blit_key: blit_key$1,
  get_data: get_data$2,
  get_data_copy: get_data_copy$2,
  set_data: set_data$2,
  unset_data: unset_data$2,
  check_data: check_data$2,
  blit_data: blit_data$2,
  Make: Make$2,
  MakeSeeded: MakeSeeded$2
end;

GenHashTable = do
  MakeSeeded: (function (funarg) do
      H = do
        create: funarg.create,
        hash: funarg.hash,
        equal: funarg.equal,
        get_data: funarg.get_data,
        get_key: funarg.get_key,
        set_key_data: funarg.set_key_data,
        check_key: funarg.check_key
      end;
      power_2_above = function (_x, n) do
        while(true) do
          x = _x;
          if (x >= n or (x << 1) > Sys.max_array_length) then do
            return x;
          end else do
            _x = (x << 1);
            continue ;
          end end 
        end;
      end end;
      prng = Caml_obj.caml_lazy_make((function (param) do
              return Random.State.make_self_init(--[[ () ]]0);
            end end));
      create = function (randomOpt, initial_size) do
        random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[[ () ]]0);
        s = power_2_above(16, initial_size);
        seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
        return do
                size: 0,
                data: Caml_array.caml_make_vect(s, --[[ Empty ]]0),
                seed: seed,
                initial_size: s
              end;
      end end;
      clear = function (h) do
        h.size = 0;
        len = #h.data;
        for i = 0 , len - 1 | 0 , 1 do
          Caml_array.caml_array_set(h.data, i, --[[ Empty ]]0);
        end
        return --[[ () ]]0;
      end end;
      reset = function (h) do
        len = #h.data;
        if (len == h.initial_size) then do
          return clear(h);
        end else do
          h.size = 0;
          h.data = Caml_array.caml_make_vect(h.initial_size, --[[ Empty ]]0);
          return --[[ () ]]0;
        end end 
      end end;
      copy = function (h) do
        return do
                size: h.size,
                data: __Array.copy(h.data),
                seed: h.seed,
                initial_size: h.initial_size
              end;
      end end;
      key_index = function (h, hkey) do
        return hkey & (#h.data - 1 | 0);
      end end;
      clean = function (h) do
        do_bucket = function (_param) do
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              c = param[1];
              if (Curry._1(H.check_key, c)) then do
                return --[[ Cons ]][
                        param[0],
                        c,
                        do_bucket(rest)
                      ];
              end else do
                h.size = h.size - 1 | 0;
                _param = rest;
                continue ;
              end end 
            end else do
              return --[[ Empty ]]0;
            end end 
          end;
        end end;
        d = h.data;
        for i = 0 , #d - 1 | 0 , 1 do
          Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
        end
        return --[[ () ]]0;
      end end;
      resize = function (h) do
        odata = h.data;
        osize = #odata;
        nsize = (osize << 1);
        clean(h);
        if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
          ndata = Caml_array.caml_make_vect(nsize, --[[ Empty ]]0);
          h.data = ndata;
          insert_bucket = function (param) do
            if (param) then do
              hkey = param[0];
              insert_bucket(param[2]);
              nidx = key_index(h, hkey);
              return Caml_array.caml_array_set(ndata, nidx, --[[ Cons ]][
                          hkey,
                          param[1],
                          Caml_array.caml_array_get(ndata, nidx)
                        ]);
            end else do
              return --[[ () ]]0;
            end end 
          end end;
          for i = 0 , osize - 1 | 0 , 1 do
            insert_bucket(Caml_array.caml_array_get(odata, i));
          end
          return --[[ () ]]0;
        end else do
          return 0;
        end end 
      end end;
      add = function (h, key, info) do
        hkey = Curry._2(H.hash, h.seed, key);
        i = key_index(h, hkey);
        container = Curry._2(H.create, key, info);
        bucket_002 = Caml_array.caml_array_get(h.data, i);
        bucket = --[[ Cons ]][
          hkey,
          container,
          bucket_002
        ];
        Caml_array.caml_array_set(h.data, i, bucket);
        h.size = h.size + 1 | 0;
        if (h.size > (#h.data << 1)) then do
          return resize(h);
        end else do
          return 0;
        end end 
      end end;
      remove = function (h, key) do
        hkey = Curry._2(H.hash, h.seed, key);
        remove_bucket = function (_param) do
          while(true) do
            param = _param;
            if (param) then do
              next = param[2];
              c = param[1];
              hk = param[0];
              if (hkey == hk) then do
                match = Curry._2(H.equal, c, key);
                local ___conditional___=(match);
                do
                   if ___conditional___ = 0--[[ ETrue ]] then do
                      h.size = h.size - 1 | 0;
                      return next;end end end 
                   if ___conditional___ = 1--[[ EFalse ]] then do
                      return --[[ Cons ]][
                              hk,
                              c,
                              remove_bucket(next)
                            ];end end end 
                   if ___conditional___ = 2--[[ EDead ]] then do
                      h.size = h.size - 1 | 0;
                      _param = next;
                      continue ;end end end 
                   do
                  
                end
              end else do
                return --[[ Cons ]][
                        hk,
                        c,
                        remove_bucket(next)
                      ];
              end end 
            end else do
              return --[[ Empty ]]0;
            end end 
          end;
        end end;
        i = key_index(h, hkey);
        return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
      end end;
      find = function (h, key) do
        hkey = Curry._2(H.hash, h.seed, key);
        key$1 = key;
        hkey$1 = hkey;
        _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          param = _param;
          if (param) then do
            rest = param[2];
            c = param[1];
            if (hkey$1 == param[0]) then do
              match = Curry._2(H.equal, c, key$1);
              if (match ~= 0) then do
                _param = rest;
                continue ;
              end else do
                match$1 = Curry._1(H.get_data, c);
                if (match$1 ~= undefined) then do
                  return Caml_option.valFromOption(match$1);
                end else do
                  _param = rest;
                  continue ;
                end end 
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            throw Caml_builtin_exceptions.not_found;
          end end 
        end;
      end end;
      find_opt = function (h, key) do
        hkey = Curry._2(H.hash, h.seed, key);
        key$1 = key;
        hkey$1 = hkey;
        _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          param = _param;
          if (param) then do
            rest = param[2];
            c = param[1];
            if (hkey$1 == param[0]) then do
              match = Curry._2(H.equal, c, key$1);
              if (match ~= 0) then do
                _param = rest;
                continue ;
              end else do
                d = Curry._1(H.get_data, c);
                if (d ~= undefined) then do
                  return d;
                end else do
                  _param = rest;
                  continue ;
                end end 
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            return ;
          end end 
        end;
      end end;
      find_all = function (h, key) do
        hkey = Curry._2(H.hash, h.seed, key);
        find_in_bucket = function (_param) do
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              c = param[1];
              if (hkey == param[0]) then do
                match = Curry._2(H.equal, c, key);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  match$1 = Curry._1(H.get_data, c);
                  if (match$1 ~= undefined) then do
                    return --[[ :: ]][
                            Caml_option.valFromOption(match$1),
                            find_in_bucket(rest)
                          ];
                  end else do
                    _param = rest;
                    continue ;
                  end end 
                end end 
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              return --[[ [] ]]0;
            end end 
          end;
        end end;
        return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
      end end;
      replace = function (h, key, info) do
        hkey = Curry._2(H.hash, h.seed, key);
        i = key_index(h, hkey);
        l = Caml_array.caml_array_get(h.data, i);
        try do
          _param = l;
          while(true) do
            param = _param;
            if (param) then do
              next = param[2];
              c = param[1];
              if (hkey == param[0]) then do
                match = Curry._2(H.equal, c, key);
                if (match ~= 0) then do
                  _param = next;
                  continue ;
                end else do
                  return Curry._3(H.set_key_data, c, key, info);
                end end 
              end else do
                _param = next;
                continue ;
              end end 
            end else do
              throw Caml_builtin_exceptions.not_found;
            end end 
          end;
        end
        catch (exn)do
          if (exn == Caml_builtin_exceptions.not_found) then do
            container = Curry._2(H.create, key, info);
            Caml_array.caml_array_set(h.data, i, --[[ Cons ]][
                  hkey,
                  container,
                  l
                ]);
            h.size = h.size + 1 | 0;
            if (h.size > (#h.data << 1)) then do
              return resize(h);
            end else do
              return 0;
            end end 
          end else do
            throw exn;
          end end 
        end
      end end;
      mem = function (h, key) do
        hkey = Curry._2(H.hash, h.seed, key);
        _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          param = _param;
          if (param) then do
            rest = param[2];
            if (param[0] == hkey) then do
              match = Curry._2(H.equal, param[1], key);
              if (match ~= 0) then do
                _param = rest;
                continue ;
              end else do
                return true;
              end end 
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            return false;
          end end 
        end;
      end end;
      iter = function (f, h) do
        do_bucket = function (_param) do
          while(true) do
            param = _param;
            if (param) then do
              c = param[1];
              match = Curry._1(H.get_key, c);
              match$1 = Curry._1(H.get_data, c);
              if (match ~= undefined) then do
                if (match$1 ~= undefined) then do
                  Curry._2(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
                end
                 end 
              end
               end 
              _param = param[2];
              continue ;
            end else do
              return --[[ () ]]0;
            end end 
          end;
        end end;
        d = h.data;
        for i = 0 , #d - 1 | 0 , 1 do
          do_bucket(Caml_array.caml_array_get(d, i));
        end
        return --[[ () ]]0;
      end end;
      fold = function (f, h, init) do
        do_bucket = function (_b, _accu) do
          while(true) do
            accu = _accu;
            b = _b;
            if (b) then do
              c = b[1];
              match = Curry._1(H.get_key, c);
              match$1 = Curry._1(H.get_data, c);
              accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
              _accu = accu$1;
              _b = b[2];
              continue ;
            end else do
              return accu;
            end end 
          end;
        end end;
        d = h.data;
        accu = init;
        for i = 0 , #d - 1 | 0 , 1 do
          accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
        end
        return accu;
      end end;
      filter_map_inplace = function (f, h) do
        do_bucket = function (_param) do
          while(true) do
            param = _param;
            if (param) then do
              rest = param[2];
              c = param[1];
              match = Curry._1(H.get_key, c);
              match$1 = Curry._1(H.get_data, c);
              if (match ~= undefined) then do
                if (match$1 ~= undefined) then do
                  k = Caml_option.valFromOption(match);
                  match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
                  if (match$2 ~= undefined) then do
                    Curry._3(H.set_key_data, c, k, Caml_option.valFromOption(match$2));
                    return --[[ Cons ]][
                            param[0],
                            c,
                            do_bucket(rest)
                          ];
                  end else do
                    _param = rest;
                    continue ;
                  end end 
                end else do
                  _param = rest;
                  continue ;
                end end 
              end else do
                _param = rest;
                continue ;
              end end 
            end else do
              return --[[ Empty ]]0;
            end end 
          end;
        end end;
        d = h.data;
        for i = 0 , #d - 1 | 0 , 1 do
          Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
        end
        return --[[ () ]]0;
      end end;
      length = function (h) do
        return h.size;
      end end;
      bucket_length = function (_accu, _param) do
        while(true) do
          param = _param;
          accu = _accu;
          if (param) then do
            _param = param[2];
            _accu = accu + 1 | 0;
            continue ;
          end else do
            return accu;
          end end 
        end;
      end end;
      stats = function (h) do
        mbl = __Array.fold_left((function (m, b) do
                return Caml_primitive.caml_int_max(m, bucket_length(0, b));
              end end), 0, h.data);
        histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
        __Array.iter((function (b) do
                l = bucket_length(0, b);
                return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
              end end), h.data);
        return do
                num_bindings: h.size,
                num_buckets: #h.data,
                max_bucket_length: mbl,
                bucket_histogram: histo
              end;
      end end;
      bucket_length_alive = function (_accu, _param) do
        while(true) do
          param = _param;
          accu = _accu;
          if (param) then do
            rest = param[2];
            if (Curry._1(H.check_key, param[1])) then do
              _param = rest;
              _accu = accu + 1 | 0;
              continue ;
            end else do
              _param = rest;
              continue ;
            end end 
          end else do
            return accu;
          end end 
        end;
      end end;
      stats_alive = function (h) do
        size = do
          contents: 0
        end;
        mbl = __Array.fold_left((function (m, b) do
                return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
              end end), 0, h.data);
        histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
        __Array.iter((function (b) do
                l = bucket_length_alive(0, b);
                size.contents = size.contents + l | 0;
                return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
              end end), h.data);
        return do
                num_bindings: size.contents,
                num_buckets: #h.data,
                max_bucket_length: mbl,
                bucket_histogram: histo
              end;
      end end;
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
              stats: stats,
              clean: clean,
              stats_alive: stats_alive
            end;
    end end)
end;

exports.K1 = K1;
exports.K2 = K2;
exports.Kn = Kn;
exports.GenHashTable = GenHashTable;
--[[ No side effect ]]
