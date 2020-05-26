'use strict';

var Obj = require("./obj.js");
var Sys = require("./sys.js");
var $$Array = require("./array.js");
var Curry = require("./curry.js");
var Random = require("./random.js");
var Hashtbl = require("./hashtbl.js");
var Caml_obj = require("./caml_obj.js");
var Caml_array = require("./caml_array.js");
var Caml_int32 = require("./caml_int32.js");
var Caml_option = require("./caml_option.js");
var Caml_primitive = require("./caml_primitive.js");
var CamlinternalLazy = require("./camlinternalLazy.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function create(param) do
  return Obj.Ephemeron.create(1);
end

function get_key(t) do
  return Obj.Ephemeron.get_key(t, 0);
end

function get_key_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 0);
end

function set_key(t, k) do
  return Obj.Ephemeron.set_key(t, 0, k);
end

function unset_key(t) do
  return Obj.Ephemeron.unset_key(t, 0);
end

function check_key(t) do
  return Obj.Ephemeron.check_key(t, 0);
end

function blit_key(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 1);
end

function get_data(t) do
  return Obj.Ephemeron.get_data(t);
end

function get_data_copy(t) do
  return Obj.Ephemeron.get_data_copy(t);
end

function set_data(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end

function unset_data(t) do
  return Obj.Ephemeron.unset_data(t);
end

function check_data(t) do
  return Obj.Ephemeron.check_data(t);
end

function blit_data(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end

function MakeSeeded(H) do
  var create = function (k, d) do
    var c = Obj.Ephemeron.create(1);
    Obj.Ephemeron.set_data(c, d);
    set_key(c, k);
    return c;
  end;
  var hash = H.hash;
  var equal = function (c, k) do
    var match = Obj.Ephemeron.get_key(c, 0);
    if (match ~= undefined) then do
      if (Curry._2(H.equal, k, Caml_option.valFromOption(match))) then do
        return --[ ETrue ]--0;
      end else do
        return --[ EFalse ]--1;
      end end 
    end else do
      return --[ EDead ]--2;
    end end 
  end;
  var set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    set_key(c, k);
    return Obj.Ephemeron.set_data(c, d);
  end;
  var power_2_above = function (_x, n) do
    while(true) do
      var x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end;
  var prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[ () ]--0);
        end));
  var create$1 = function (randomOpt, initial_size) do
    var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
    var s = power_2_above(16, initial_size);
    var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
            seed: seed,
            initial_size: s
          end;
  end;
  var clear = function (h) do
    h.size = 0;
    var len = #h.data;
    for var i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end
    return --[ () ]--0;
  end;
  var reset = function (h) do
    var len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
      return --[ () ]--0;
    end end 
  end;
  var copy = function (h) do
    return do
            size: h.size,
            data: $$Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end;
  var key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end;
  var clean = function (h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (check_key(c)) then do
            return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var resize = function (h) do
    var odata = h.data;
    var osize = #odata;
    var nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
      h.data = ndata;
      var insert_bucket = function (param) do
        if (param) then do
          var hkey = param[0];
          insert_bucket(param[2]);
          var nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[ () ]--0;
        end end 
      end;
      for var i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end;
  var add = function (h, key, info) do
    var hkey = Curry._2(hash, h.seed, key);
    var i = key_index(h, hkey);
    var container = create(key, info);
    var bucket_002 = Caml_array.caml_array_get(h.data, i);
    var bucket = --[ Cons ]--[
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
  end;
  var remove = function (h, key) do
    var hkey = Curry._2(hash, h.seed, key);
    var remove_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          var hk = param[0];
          if (hkey == hk) then do
            var match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[ ETrue ]-- then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[ EFalse ]-- then do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[ EDead ]-- then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[ Cons ]--[
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end;
  var find = function (h, key) do
    var hkey = Curry._2(hash, h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var match$1 = get_data(c);
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
  end;
  var find_opt = function (h, key) do
    var hkey = Curry._2(hash, h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var d = get_data(c);
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
  end;
  var find_all = function (h, key) do
    var hkey = Curry._2(hash, h.seed, key);
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              var match$1 = get_data(c);
              if (match$1 ~= undefined) then do
                return --[ :: ]--[
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
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end;
  var replace = function (h, key, info) do
    var hkey = Curry._2(hash, h.seed, key);
    var i = key_index(h, hkey);
    var l = Caml_array.caml_array_get(h.data, i);
    try do
      var _param = l;
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
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
        var container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
  end;
  var mem = function (h, key) do
    var hkey = Curry._2(hash, h.seed, key);
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        if (param[0] == hkey) then do
          var match = equal(param[1], key);
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
  end;
  var iter = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data(c);
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
          return --[ () ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[ () ]--0;
  end;
  var fold = function (f, h, init) do
    var do_bucket = function (_b, _accu) do
      while(true) do
        var accu = _accu;
        var b = _b;
        if (b) then do
          var c = b[1];
          var match = get_key(c);
          var match$1 = get_data(c);
          var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end;
    var d = h.data;
    var accu = init;
    for var i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end;
  var filter_map_inplace = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              var k = Caml_option.valFromOption(match);
              var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var length = function (h) do
    return h.size;
  end;
  var bucket_length = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var stats = function (h) do
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var bucket_length_alive = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var rest = param[2];
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
  end;
  var stats_alive = function (h) do
    var size = do
      contents: 0
    end;
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end

function Make(H) do
  var equal = H.equal;
  var hash = function (_seed, x) do
    return Curry._1(H.hash, x);
  end;
  var create = function (k, d) do
    var c = Obj.Ephemeron.create(1);
    Obj.Ephemeron.set_data(c, d);
    set_key(c, k);
    return c;
  end;
  var equal$1 = function (c, k) do
    var match = Obj.Ephemeron.get_key(c, 0);
    if (match ~= undefined) then do
      if (Curry._2(equal, k, Caml_option.valFromOption(match))) then do
        return --[ ETrue ]--0;
      end else do
        return --[ EFalse ]--1;
      end end 
    end else do
      return --[ EDead ]--2;
    end end 
  end;
  var set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    set_key(c, k);
    return Obj.Ephemeron.set_data(c, d);
  end;
  var power_2_above = function (_x, n) do
    while(true) do
      var x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end;
  var prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[ () ]--0);
        end));
  var clear = function (h) do
    h.size = 0;
    var len = #h.data;
    for var i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end
    return --[ () ]--0;
  end;
  var reset = function (h) do
    var len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
      return --[ () ]--0;
    end end 
  end;
  var copy = function (h) do
    return do
            size: h.size,
            data: $$Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end;
  var key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end;
  var clean = function (h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (check_key(c)) then do
            return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var resize = function (h) do
    var odata = h.data;
    var osize = #odata;
    var nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
      h.data = ndata;
      var insert_bucket = function (param) do
        if (param) then do
          var hkey = param[0];
          insert_bucket(param[2]);
          var nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[ () ]--0;
        end end 
      end;
      for var i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end;
  var add = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var container = create(key, info);
    var bucket_002 = Caml_array.caml_array_get(h.data, i);
    var bucket = --[ Cons ]--[
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
  end;
  var remove = function (h, key) do
    var hkey = hash(h.seed, key);
    var remove_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          var hk = param[0];
          if (hkey == hk) then do
            var match = equal$1(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[ ETrue ]-- then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[ EFalse ]-- then do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[ EDead ]-- then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[ Cons ]--[
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end;
  var find = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var match$1 = get_data(c);
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
  end;
  var find_opt = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var d = get_data(c);
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
  end;
  var find_all = function (h, key) do
    var hkey = hash(h.seed, key);
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal$1(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              var match$1 = get_data(c);
              if (match$1 ~= undefined) then do
                return --[ :: ]--[
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
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end;
  var replace = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var l = Caml_array.caml_array_get(h.data, i);
    try do
      var _param = l;
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal$1(c, key);
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
        var container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
  end;
  var mem = function (h, key) do
    var hkey = hash(h.seed, key);
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        if (param[0] == hkey) then do
          var match = equal$1(param[1], key);
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
  end;
  var iter = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data(c);
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
          return --[ () ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[ () ]--0;
  end;
  var fold = function (f, h, init) do
    var do_bucket = function (_b, _accu) do
      while(true) do
        var accu = _accu;
        var b = _b;
        if (b) then do
          var c = b[1];
          var match = get_key(c);
          var match$1 = get_data(c);
          var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end;
    var d = h.data;
    var accu = init;
    for var i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end;
  var filter_map_inplace = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              var k = Caml_option.valFromOption(match);
              var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var length = function (h) do
    return h.size;
  end;
  var bucket_length = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var stats = function (h) do
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var bucket_length_alive = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var rest = param[2];
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
  end;
  var stats_alive = function (h) do
    var size = do
      contents: 0
    end;
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var create$1 = function (sz) do
    var randomOpt = false;
    var initial_size = sz;
    var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
    var s = power_2_above(16, initial_size);
    var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
            seed: seed,
            initial_size: s
          end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end

function create$1(param) do
  return Obj.Ephemeron.create(2);
end

function get_key1(t) do
  return Obj.Ephemeron.get_key(t, 0);
end

function get_key1_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 0);
end

function set_key1(t, k) do
  return Obj.Ephemeron.set_key(t, 0, k);
end

function unset_key1(t) do
  return Obj.Ephemeron.unset_key(t, 0);
end

function check_key1(t) do
  return Obj.Ephemeron.check_key(t, 0);
end

function get_key2(t) do
  return Obj.Ephemeron.get_key(t, 1);
end

function get_key2_copy(t) do
  return Obj.Ephemeron.get_key_copy(t, 1);
end

function set_key2(t, k) do
  return Obj.Ephemeron.set_key(t, 1, k);
end

function unset_key2(t) do
  return Obj.Ephemeron.unset_key(t, 1);
end

function check_key2(t) do
  return Obj.Ephemeron.check_key(t, 1);
end

function blit_key1(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 1);
end

function blit_key2(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 1, t2, 1, 1);
end

function blit_key12(t1, t2) do
  return Obj.Ephemeron.blit_key(t1, 0, t2, 0, 2);
end

function get_data$1(t) do
  return Obj.Ephemeron.get_data(t);
end

function get_data_copy$1(t) do
  return Obj.Ephemeron.get_data_copy(t);
end

function set_data$1(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end

function unset_data$1(t) do
  return Obj.Ephemeron.unset_data(t);
end

function check_data$1(t) do
  return Obj.Ephemeron.check_data(t);
end

function blit_data$1(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end

function MakeSeeded$1(H1, H2) do
  var create = function (param, d) do
    var c = Obj.Ephemeron.create(2);
    Obj.Ephemeron.set_data(c, d);
    set_key1(c, param[0]);
    set_key2(c, param[1]);
    return c;
  end;
  var hash = function (seed, param) do
    return Curry._2(H1.hash, seed, param[0]) + Caml_int32.imul(Curry._2(H2.hash, seed, param[1]), 65599) | 0;
  end;
  var equal = function (c, param) do
    var match = Obj.Ephemeron.get_key(c, 0);
    var match$1 = Obj.Ephemeron.get_key(c, 1);
    if (match ~= undefined and match$1 ~= undefined) then do
      if (Curry._2(H1.equal, param[0], Caml_option.valFromOption(match)) and Curry._2(H2.equal, param[1], Caml_option.valFromOption(match$1))) then do
        return --[ ETrue ]--0;
      end else do
        return --[ EFalse ]--1;
      end end 
    end else do
      return --[ EDead ]--2;
    end end 
  end;
  var get_key = function (c) do
    var match = Obj.Ephemeron.get_key(c, 0);
    var match$1 = Obj.Ephemeron.get_key(c, 1);
    if (match ~= undefined and match$1 ~= undefined) then do
      return --[ tuple ]--[
              Caml_option.valFromOption(match),
              Caml_option.valFromOption(match$1)
            ];
    end
     end 
  end;
  var set_key_data = function (c, param, d) do
    Obj.Ephemeron.unset_data(c);
    set_key1(c, param[0]);
    set_key2(c, param[1]);
    return Obj.Ephemeron.set_data(c, d);
  end;
  var check_key = function (c) do
    if (Obj.Ephemeron.check_key(c, 0)) then do
      return Obj.Ephemeron.check_key(c, 1);
    end else do
      return false;
    end end 
  end;
  var power_2_above = function (_x, n) do
    while(true) do
      var x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end;
  var prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[ () ]--0);
        end));
  var create$1 = function (randomOpt, initial_size) do
    var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
    var s = power_2_above(16, initial_size);
    var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
            seed: seed,
            initial_size: s
          end;
  end;
  var clear = function (h) do
    h.size = 0;
    var len = #h.data;
    for var i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end
    return --[ () ]--0;
  end;
  var reset = function (h) do
    var len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
      return --[ () ]--0;
    end end 
  end;
  var copy = function (h) do
    return do
            size: h.size,
            data: $$Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end;
  var key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end;
  var clean = function (h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (check_key(c)) then do
            return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var resize = function (h) do
    var odata = h.data;
    var osize = #odata;
    var nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
      h.data = ndata;
      var insert_bucket = function (param) do
        if (param) then do
          var hkey = param[0];
          insert_bucket(param[2]);
          var nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[ () ]--0;
        end end 
      end;
      for var i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end;
  var add = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var container = create(key, info);
    var bucket_002 = Caml_array.caml_array_get(h.data, i);
    var bucket = --[ Cons ]--[
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
  end;
  var remove = function (h, key) do
    var hkey = hash(h.seed, key);
    var remove_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          var hk = param[0];
          if (hkey == hk) then do
            var match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[ ETrue ]-- then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[ EFalse ]-- then do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[ EDead ]-- then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[ Cons ]--[
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end;
  var find = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var match$1 = get_data$1(c);
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
  end;
  var find_opt = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var d = get_data$1(c);
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
  end;
  var find_all = function (h, key) do
    var hkey = hash(h.seed, key);
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              var match$1 = get_data$1(c);
              if (match$1 ~= undefined) then do
                return --[ :: ]--[
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
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end;
  var replace = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var l = Caml_array.caml_array_get(h.data, i);
    try do
      var _param = l;
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
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
        var container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
  end;
  var mem = function (h, key) do
    var hkey = hash(h.seed, key);
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        if (param[0] == hkey) then do
          var match = equal(param[1], key);
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
  end;
  var iter = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$1(c);
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
          return --[ () ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[ () ]--0;
  end;
  var fold = function (f, h, init) do
    var do_bucket = function (_b, _accu) do
      while(true) do
        var accu = _accu;
        var b = _b;
        if (b) then do
          var c = b[1];
          var match = get_key(c);
          var match$1 = get_data$1(c);
          var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end;
    var d = h.data;
    var accu = init;
    for var i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end;
  var filter_map_inplace = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$1(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              var k = Caml_option.valFromOption(match);
              var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var length = function (h) do
    return h.size;
  end;
  var bucket_length = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var stats = function (h) do
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var bucket_length_alive = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var rest = param[2];
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
  end;
  var stats_alive = function (h) do
    var size = do
      contents: 0
    end;
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end

function Make$1(H1, H2) do
  var hash = function (_seed, x) do
    return Curry._1(H1.hash, x);
  end;
  var partial_arg_equal = H1.equal;
  var hash$1 = function (_seed, x) do
    return Curry._1(H2.hash, x);
  end;
  var include = (function (param) do
        var create = function (param, d) do
          var c = Obj.Ephemeron.create(2);
          Obj.Ephemeron.set_data(c, d);
          set_key1(c, param[0]);
          set_key2(c, param[1]);
          return c;
        end;
        var hash$2 = function (seed, param$1) do
          return Curry._2(hash, seed, param$1[0]) + Caml_int32.imul(Curry._2(param.hash, seed, param$1[1]), 65599) | 0;
        end;
        var equal = function (c, param$1) do
          var match = Obj.Ephemeron.get_key(c, 0);
          var match$1 = Obj.Ephemeron.get_key(c, 1);
          if (match ~= undefined and match$1 ~= undefined) then do
            if (Curry._2(partial_arg_equal, param$1[0], Caml_option.valFromOption(match)) and Curry._2(param.equal, param$1[1], Caml_option.valFromOption(match$1))) then do
              return --[ ETrue ]--0;
            end else do
              return --[ EFalse ]--1;
            end end 
          end else do
            return --[ EDead ]--2;
          end end 
        end;
        var get_key = function (c) do
          var match = Obj.Ephemeron.get_key(c, 0);
          var match$1 = Obj.Ephemeron.get_key(c, 1);
          if (match ~= undefined and match$1 ~= undefined) then do
            return --[ tuple ]--[
                    Caml_option.valFromOption(match),
                    Caml_option.valFromOption(match$1)
                  ];
          end
           end 
        end;
        var set_key_data = function (c, param, d) do
          Obj.Ephemeron.unset_data(c);
          set_key1(c, param[0]);
          set_key2(c, param[1]);
          return Obj.Ephemeron.set_data(c, d);
        end;
        var check_key = function (c) do
          if (Obj.Ephemeron.check_key(c, 0)) then do
            return Obj.Ephemeron.check_key(c, 1);
          end else do
            return false;
          end end 
        end;
        var power_2_above = function (_x, n) do
          while(true) do
            var x = _x;
            if (x >= n or (x << 1) > Sys.max_array_length) then do
              return x;
            end else do
              _x = (x << 1);
              continue ;
            end end 
          end;
        end;
        var prng = Caml_obj.caml_lazy_make((function (param) do
                return Random.State.make_self_init(--[ () ]--0);
              end));
        var create$1 = function (randomOpt, initial_size) do
          var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
          var s = power_2_above(16, initial_size);
          var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
          return do
                  size: 0,
                  data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
                  seed: seed,
                  initial_size: s
                end;
        end;
        var clear = function (h) do
          h.size = 0;
          var len = #h.data;
          for var i = 0 , len - 1 | 0 , 1 do
            Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
          end
          return --[ () ]--0;
        end;
        var reset = function (h) do
          var len = #h.data;
          if (len == h.initial_size) then do
            return clear(h);
          end else do
            h.size = 0;
            h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
            return --[ () ]--0;
          end end 
        end;
        var copy = function (h) do
          return do
                  size: h.size,
                  data: $$Array.copy(h.data),
                  seed: h.seed,
                  initial_size: h.initial_size
                end;
        end;
        var key_index = function (h, hkey) do
          return hkey & (#h.data - 1 | 0);
        end;
        var clean = function (h) do
          var do_bucket = function (_param) do
            while(true) do
              var param = _param;
              if (param) then do
                var rest = param[2];
                var c = param[1];
                if (Curry._1(check_key, c)) then do
                  return --[ Cons ]--[
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
                return --[ Empty ]--0;
              end end 
            end;
          end;
          var d = h.data;
          for var i = 0 , #d - 1 | 0 , 1 do
            Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
          end
          return --[ () ]--0;
        end;
        var resize = function (h) do
          var odata = h.data;
          var osize = #odata;
          var nsize = (osize << 1);
          clean(h);
          if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
            var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
            h.data = ndata;
            var insert_bucket = function (param) do
              if (param) then do
                var hkey = param[0];
                insert_bucket(param[2]);
                var nidx = key_index(h, hkey);
                return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                            hkey,
                            param[1],
                            Caml_array.caml_array_get(ndata, nidx)
                          ]);
              end else do
                return --[ () ]--0;
              end end 
            end;
            for var i = 0 , osize - 1 | 0 , 1 do
              insert_bucket(Caml_array.caml_array_get(odata, i));
            end
            return --[ () ]--0;
          end else do
            return 0;
          end end 
        end;
        var add = function (h, key, info) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var i = key_index(h, hkey);
          var container = Curry._2(create, key, info);
          var bucket_002 = Caml_array.caml_array_get(h.data, i);
          var bucket = --[ Cons ]--[
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
        end;
        var remove = function (h, key) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var remove_bucket = function (_param) do
            while(true) do
              var param = _param;
              if (param) then do
                var next = param[2];
                var c = param[1];
                var hk = param[0];
                if (hkey == hk) then do
                  var match = Curry._2(equal, c, key);
                  local ___conditional___=(match);
                  do
                     if ___conditional___ = 0--[ ETrue ]-- then do
                        h.size = h.size - 1 | 0;
                        return next;end end end 
                     if ___conditional___ = 1--[ EFalse ]-- then do
                        return --[ Cons ]--[
                                hk,
                                c,
                                remove_bucket(next)
                              ];end end end 
                     if ___conditional___ = 2--[ EDead ]-- then do
                        h.size = h.size - 1 | 0;
                        _param = next;
                        continue ;end end end 
                     do
                    
                  end
                end else do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];
                end end 
              end else do
                return --[ Empty ]--0;
              end end 
            end;
          end;
          var i = key_index(h, hkey);
          return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
        end;
        var find = function (h, key) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var key$1 = key;
          var hkey$1 = hkey;
          var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              var c = param[1];
              if (hkey$1 == param[0]) then do
                var match = Curry._2(equal, c, key$1);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  var match$1 = Curry._1(get_data$1, c);
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
        end;
        var find_opt = function (h, key) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var key$1 = key;
          var hkey$1 = hkey;
          var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              var c = param[1];
              if (hkey$1 == param[0]) then do
                var match = Curry._2(equal, c, key$1);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  var d = Curry._1(get_data$1, c);
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
        end;
        var find_all = function (h, key) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var find_in_bucket = function (_param) do
            while(true) do
              var param = _param;
              if (param) then do
                var rest = param[2];
                var c = param[1];
                if (hkey == param[0]) then do
                  var match = Curry._2(equal, c, key);
                  if (match ~= 0) then do
                    _param = rest;
                    continue ;
                  end else do
                    var match$1 = Curry._1(get_data$1, c);
                    if (match$1 ~= undefined) then do
                      return --[ :: ]--[
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
                return --[ [] ]--0;
              end end 
            end;
          end;
          return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
        end;
        var replace = function (h, key, info) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var i = key_index(h, hkey);
          var l = Caml_array.caml_array_get(h.data, i);
          try do
            var _param = l;
            while(true) do
              var param = _param;
              if (param) then do
                var next = param[2];
                var c = param[1];
                if (hkey == param[0]) then do
                  var match = Curry._2(equal, c, key);
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
              var container = Curry._2(create, key, info);
              Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
        end;
        var mem = function (h, key) do
          var hkey = Curry._2(hash$2, h.seed, key);
          var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              if (param[0] == hkey) then do
                var match = Curry._2(equal, param[1], key);
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
        end;
        var iter = function (f, h) do
          var do_bucket = function (_param) do
            while(true) do
              var param = _param;
              if (param) then do
                var c = param[1];
                var match = Curry._1(get_key, c);
                var match$1 = Curry._1(get_data$1, c);
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
                return --[ () ]--0;
              end end 
            end;
          end;
          var d = h.data;
          for var i = 0 , #d - 1 | 0 , 1 do
            do_bucket(Caml_array.caml_array_get(d, i));
          end
          return --[ () ]--0;
        end;
        var fold = function (f, h, init) do
          var do_bucket = function (_b, _accu) do
            while(true) do
              var accu = _accu;
              var b = _b;
              if (b) then do
                var c = b[1];
                var match = Curry._1(get_key, c);
                var match$1 = Curry._1(get_data$1, c);
                var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
                _accu = accu$1;
                _b = b[2];
                continue ;
              end else do
                return accu;
              end end 
            end;
          end;
          var d = h.data;
          var accu = init;
          for var i = 0 , #d - 1 | 0 , 1 do
            accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
          end
          return accu;
        end;
        var filter_map_inplace = function (f, h) do
          var do_bucket = function (_param) do
            while(true) do
              var param = _param;
              if (param) then do
                var rest = param[2];
                var c = param[1];
                var match = Curry._1(get_key, c);
                var match$1 = Curry._1(get_data$1, c);
                if (match ~= undefined) then do
                  if (match$1 ~= undefined) then do
                    var k = Caml_option.valFromOption(match);
                    var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
                    if (match$2 ~= undefined) then do
                      Curry._3(set_key_data, c, k, Caml_option.valFromOption(match$2));
                      return --[ Cons ]--[
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
                return --[ Empty ]--0;
              end end 
            end;
          end;
          var d = h.data;
          for var i = 0 , #d - 1 | 0 , 1 do
            Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
          end
          return --[ () ]--0;
        end;
        var length = function (h) do
          return h.size;
        end;
        var bucket_length = function (_accu, _param) do
          while(true) do
            var param = _param;
            var accu = _accu;
            if (param) then do
              _param = param[2];
              _accu = accu + 1 | 0;
              continue ;
            end else do
              return accu;
            end end 
          end;
        end;
        var stats = function (h) do
          var mbl = $$Array.fold_left((function (m, b) do
                  return Caml_primitive.caml_int_max(m, bucket_length(0, b));
                end), 0, h.data);
          var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
          $$Array.iter((function (b) do
                  var l = bucket_length(0, b);
                  return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
                end), h.data);
          return do
                  num_bindings: h.size,
                  num_buckets: #h.data,
                  max_bucket_length: mbl,
                  bucket_histogram: histo
                end;
        end;
        var bucket_length_alive = function (_accu, _param) do
          while(true) do
            var param = _param;
            var accu = _accu;
            if (param) then do
              var rest = param[2];
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
        end;
        var stats_alive = function (h) do
          var size = do
            contents: 0
          end;
          var mbl = $$Array.fold_left((function (m, b) do
                  return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
                end), 0, h.data);
          var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
          $$Array.iter((function (b) do
                  var l = bucket_length_alive(0, b);
                  size.contents = size.contents + l | 0;
                  return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
                end), h.data);
          return do
                  num_bindings: size.contents,
                  num_buckets: #h.data,
                  max_bucket_length: mbl,
                  bucket_histogram: histo
                end;
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
                stats: stats,
                clean: clean,
                stats_alive: stats_alive
              end;
      end)(do
        equal: H2.equal,
        hash: hash$1
      end);
  var create = include.create;
  var create$1 = function (sz) do
    return Curry._2(create, false, sz);
  end;
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
end

function create$2(n) do
  return Obj.Ephemeron.create(n);
end

function get_key$1(t, n) do
  return Obj.Ephemeron.get_key(t, n);
end

function get_key_copy$1(t, n) do
  return Obj.Ephemeron.get_key_copy(t, n);
end

function set_key$1(t, n, k) do
  return Obj.Ephemeron.set_key(t, n, k);
end

function unset_key$1(t, n) do
  return Obj.Ephemeron.unset_key(t, n);
end

function check_key$1(t, n) do
  return Obj.Ephemeron.check_key(t, n);
end

function blit_key$1(t1, o1, t2, o2, l) do
  return Obj.Ephemeron.blit_key(t1, o1, t2, o2, l);
end

function get_data$2(t) do
  return Obj.Ephemeron.get_data(t);
end

function get_data_copy$2(t) do
  return Obj.Ephemeron.get_data_copy(t);
end

function set_data$2(t, d) do
  return Obj.Ephemeron.set_data(t, d);
end

function unset_data$2(t) do
  return Obj.Ephemeron.unset_data(t);
end

function check_data$2(t) do
  return Obj.Ephemeron.check_data(t);
end

function blit_data$2(t1, t2) do
  return Obj.Ephemeron.blit_data(t1, t2);
end

function MakeSeeded$2(H) do
  var create = function (k, d) do
    var c = Obj.Ephemeron.create(#k);
    Obj.Ephemeron.set_data(c, d);
    for var i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return c;
  end;
  var hash = function (seed, k) do
    var h = 0;
    for var i = 0 , #k - 1 | 0 , 1 do
      h = Caml_int32.imul(Curry._2(H.hash, seed, Caml_array.caml_array_get(k, i)), 65599) + h | 0;
    end
    return h;
  end;
  var equal = function (c, k) do
    var len = #k;
    var len$prime = Obj.Ephemeron.length(c);
    if (len ~= len$prime) then do
      return --[ EFalse ]--1;
    end else do
      var k$1 = k;
      var c$1 = c;
      var _i = len - 1 | 0;
      while(true) do
        var i = _i;
        if (i < 0) then do
          return --[ ETrue ]--0;
        end else do
          var match = Obj.Ephemeron.get_key(c$1, i);
          if (match ~= undefined) then do
            if (Curry._2(H.equal, Caml_array.caml_array_get(k$1, i), Caml_option.valFromOption(match))) then do
              _i = i - 1 | 0;
              continue ;
            end else do
              return --[ EFalse ]--1;
            end end 
          end else do
            return --[ EDead ]--2;
          end end 
        end end 
      end;
    end end 
  end;
  var get_key = function (c) do
    var len = Obj.Ephemeron.length(c);
    if (len == 0) then do
      return [];
    end else do
      var match = Obj.Ephemeron.get_key(c, 0);
      if (match ~= undefined) then do
        var a = Caml_array.caml_make_vect(len, Caml_option.valFromOption(match));
        var a$1 = a;
        var _i = len - 1 | 0;
        while(true) do
          var i = _i;
          if (i < 1) then do
            return a$1;
          end else do
            var match$1 = Obj.Ephemeron.get_key(c, i);
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
  end;
  var set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    for var i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return Obj.Ephemeron.set_data(c, d);
  end;
  var check_key = function (c) do
    var c$1 = c;
    var _i = Obj.Ephemeron.length(c) - 1 | 0;
    while(true) do
      var i = _i;
      if (i < 0) then do
        return true;
      end else if (Obj.Ephemeron.check_key(c$1, i)) then do
        _i = i - 1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end;
  var power_2_above = function (_x, n) do
    while(true) do
      var x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end;
  var prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[ () ]--0);
        end));
  var create$1 = function (randomOpt, initial_size) do
    var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
    var s = power_2_above(16, initial_size);
    var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
            seed: seed,
            initial_size: s
          end;
  end;
  var clear = function (h) do
    h.size = 0;
    var len = #h.data;
    for var i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end
    return --[ () ]--0;
  end;
  var reset = function (h) do
    var len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
      return --[ () ]--0;
    end end 
  end;
  var copy = function (h) do
    return do
            size: h.size,
            data: $$Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end;
  var key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end;
  var clean = function (h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (check_key(c)) then do
            return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var resize = function (h) do
    var odata = h.data;
    var osize = #odata;
    var nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
      h.data = ndata;
      var insert_bucket = function (param) do
        if (param) then do
          var hkey = param[0];
          insert_bucket(param[2]);
          var nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[ () ]--0;
        end end 
      end;
      for var i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end;
  var add = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var container = create(key, info);
    var bucket_002 = Caml_array.caml_array_get(h.data, i);
    var bucket = --[ Cons ]--[
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
  end;
  var remove = function (h, key) do
    var hkey = hash(h.seed, key);
    var remove_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          var hk = param[0];
          if (hkey == hk) then do
            var match = equal(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[ ETrue ]-- then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[ EFalse ]-- then do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[ EDead ]-- then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[ Cons ]--[
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end;
  var find = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var match$1 = get_data$2(c);
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
  end;
  var find_opt = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var d = get_data$2(c);
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
  end;
  var find_all = function (h, key) do
    var hkey = hash(h.seed, key);
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              var match$1 = get_data$2(c);
              if (match$1 ~= undefined) then do
                return --[ :: ]--[
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
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end;
  var replace = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var l = Caml_array.caml_array_get(h.data, i);
    try do
      var _param = l;
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal(c, key);
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
        var container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
  end;
  var mem = function (h, key) do
    var hkey = hash(h.seed, key);
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        if (param[0] == hkey) then do
          var match = equal(param[1], key);
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
  end;
  var iter = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
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
          return --[ () ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[ () ]--0;
  end;
  var fold = function (f, h, init) do
    var do_bucket = function (_b, _accu) do
      while(true) do
        var accu = _accu;
        var b = _b;
        if (b) then do
          var c = b[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
          var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end;
    var d = h.data;
    var accu = init;
    for var i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end;
  var filter_map_inplace = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              var k = Caml_option.valFromOption(match);
              var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var length = function (h) do
    return h.size;
  end;
  var bucket_length = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var stats = function (h) do
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var bucket_length_alive = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var rest = param[2];
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
  end;
  var stats_alive = function (h) do
    var size = do
      contents: 0
    end;
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end

function Make$2(H) do
  var equal = H.equal;
  var create = function (k, d) do
    var c = Obj.Ephemeron.create(#k);
    Obj.Ephemeron.set_data(c, d);
    for var i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return c;
  end;
  var hash = function (seed, k) do
    var h = 0;
    for var i = 0 , #k - 1 | 0 , 1 do
      h = Caml_int32.imul(Curry._1(H.hash, Caml_array.caml_array_get(k, i)), 65599) + h | 0;
    end
    return h;
  end;
  var equal$1 = function (c, k) do
    var len = #k;
    var len$prime = Obj.Ephemeron.length(c);
    if (len ~= len$prime) then do
      return --[ EFalse ]--1;
    end else do
      var k$1 = k;
      var c$1 = c;
      var _i = len - 1 | 0;
      while(true) do
        var i = _i;
        if (i < 0) then do
          return --[ ETrue ]--0;
        end else do
          var match = Obj.Ephemeron.get_key(c$1, i);
          if (match ~= undefined) then do
            if (Curry._2(equal, Caml_array.caml_array_get(k$1, i), Caml_option.valFromOption(match))) then do
              _i = i - 1 | 0;
              continue ;
            end else do
              return --[ EFalse ]--1;
            end end 
          end else do
            return --[ EDead ]--2;
          end end 
        end end 
      end;
    end end 
  end;
  var get_key = function (c) do
    var len = Obj.Ephemeron.length(c);
    if (len == 0) then do
      return [];
    end else do
      var match = Obj.Ephemeron.get_key(c, 0);
      if (match ~= undefined) then do
        var a = Caml_array.caml_make_vect(len, Caml_option.valFromOption(match));
        var a$1 = a;
        var _i = len - 1 | 0;
        while(true) do
          var i = _i;
          if (i < 1) then do
            return a$1;
          end else do
            var match$1 = Obj.Ephemeron.get_key(c, i);
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
  end;
  var set_key_data = function (c, k, d) do
    Obj.Ephemeron.unset_data(c);
    for var i = 0 , #k - 1 | 0 , 1 do
      set_key$1(c, i, Caml_array.caml_array_get(k, i));
    end
    return Obj.Ephemeron.set_data(c, d);
  end;
  var check_key = function (c) do
    var c$1 = c;
    var _i = Obj.Ephemeron.length(c) - 1 | 0;
    while(true) do
      var i = _i;
      if (i < 0) then do
        return true;
      end else if (Obj.Ephemeron.check_key(c$1, i)) then do
        _i = i - 1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end;
  var power_2_above = function (_x, n) do
    while(true) do
      var x = _x;
      if (x >= n or (x << 1) > Sys.max_array_length) then do
        return x;
      end else do
        _x = (x << 1);
        continue ;
      end end 
    end;
  end;
  var prng = Caml_obj.caml_lazy_make((function (param) do
          return Random.State.make_self_init(--[ () ]--0);
        end));
  var clear = function (h) do
    h.size = 0;
    var len = #h.data;
    for var i = 0 , len - 1 | 0 , 1 do
      Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
    end
    return --[ () ]--0;
  end;
  var reset = function (h) do
    var len = #h.data;
    if (len == h.initial_size) then do
      return clear(h);
    end else do
      h.size = 0;
      h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
      return --[ () ]--0;
    end end 
  end;
  var copy = function (h) do
    return do
            size: h.size,
            data: $$Array.copy(h.data),
            seed: h.seed,
            initial_size: h.initial_size
          end;
  end;
  var key_index = function (h, hkey) do
    return hkey & (#h.data - 1 | 0);
  end;
  var clean = function (h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (check_key(c)) then do
            return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var resize = function (h) do
    var odata = h.data;
    var osize = #odata;
    var nsize = (osize << 1);
    clean(h);
    if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
      var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
      h.data = ndata;
      var insert_bucket = function (param) do
        if (param) then do
          var hkey = param[0];
          insert_bucket(param[2]);
          var nidx = key_index(h, hkey);
          return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                      hkey,
                      param[1],
                      Caml_array.caml_array_get(ndata, nidx)
                    ]);
        end else do
          return --[ () ]--0;
        end end 
      end;
      for var i = 0 , osize - 1 | 0 , 1 do
        insert_bucket(Caml_array.caml_array_get(odata, i));
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end;
  var add = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var container = create(key, info);
    var bucket_002 = Caml_array.caml_array_get(h.data, i);
    var bucket = --[ Cons ]--[
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
  end;
  var remove = function (h, key) do
    var hkey = hash(h.seed, key);
    var remove_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          var hk = param[0];
          if (hkey == hk) then do
            var match = equal$1(c, key);
            local ___conditional___=(match);
            do
               if ___conditional___ = 0--[ ETrue ]-- then do
                  h.size = h.size - 1 | 0;
                  return next;end end end 
               if ___conditional___ = 1--[ EFalse ]-- then do
                  return --[ Cons ]--[
                          hk,
                          c,
                          remove_bucket(next)
                        ];end end end 
               if ___conditional___ = 2--[ EDead ]-- then do
                  h.size = h.size - 1 | 0;
                  _param = next;
                  continue ;end end end 
               do
              
            end
          end else do
            return --[ Cons ]--[
                    hk,
                    c,
                    remove_bucket(next)
                  ];
          end end 
        end else do
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var i = key_index(h, hkey);
    return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
  end;
  var find = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var match$1 = get_data$2(c);
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
  end;
  var find_opt = function (h, key) do
    var hkey = hash(h.seed, key);
    var key$1 = key;
    var hkey$1 = hkey;
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        var c = param[1];
        if (hkey$1 == param[0]) then do
          var match = equal$1(c, key$1);
          if (match ~= 0) then do
            _param = rest;
            continue ;
          end else do
            var d = get_data$2(c);
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
  end;
  var find_all = function (h, key) do
    var hkey = hash(h.seed, key);
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal$1(c, key);
            if (match ~= 0) then do
              _param = rest;
              continue ;
            end else do
              var match$1 = get_data$2(c);
              if (match$1 ~= undefined) then do
                return --[ :: ]--[
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
          return --[ [] ]--0;
        end end 
      end;
    end;
    return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
  end;
  var replace = function (h, key, info) do
    var hkey = hash(h.seed, key);
    var i = key_index(h, hkey);
    var l = Caml_array.caml_array_get(h.data, i);
    try do
      var _param = l;
      while(true) do
        var param = _param;
        if (param) then do
          var next = param[2];
          var c = param[1];
          if (hkey == param[0]) then do
            var match = equal$1(c, key);
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
        var container = create(key, info);
        Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
  end;
  var mem = function (h, key) do
    var hkey = hash(h.seed, key);
    var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
    while(true) do
      var param = _param;
      if (param) then do
        var rest = param[2];
        if (param[0] == hkey) then do
          var match = equal$1(param[1], key);
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
  end;
  var iter = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
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
          return --[ () ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      do_bucket(Caml_array.caml_array_get(d, i));
    end
    return --[ () ]--0;
  end;
  var fold = function (f, h, init) do
    var do_bucket = function (_b, _accu) do
      while(true) do
        var accu = _accu;
        var b = _b;
        if (b) then do
          var c = b[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
          var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
          _accu = accu$1;
          _b = b[2];
          continue ;
        end else do
          return accu;
        end end 
      end;
    end;
    var d = h.data;
    var accu = init;
    for var i = 0 , #d - 1 | 0 , 1 do
      accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
    end
    return accu;
  end;
  var filter_map_inplace = function (f, h) do
    var do_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var rest = param[2];
          var c = param[1];
          var match = get_key(c);
          var match$1 = get_data$2(c);
          if (match ~= undefined) then do
            if (match$1 ~= undefined) then do
              var k = Caml_option.valFromOption(match);
              var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
              if (match$2 ~= undefined) then do
                set_key_data(c, k, Caml_option.valFromOption(match$2));
                return --[ Cons ]--[
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
          return --[ Empty ]--0;
        end end 
      end;
    end;
    var d = h.data;
    for var i = 0 , #d - 1 | 0 , 1 do
      Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
    end
    return --[ () ]--0;
  end;
  var length = function (h) do
    return h.size;
  end;
  var bucket_length = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[2];
        _accu = accu + 1 | 0;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var stats = function (h) do
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length(0, b);
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: h.size,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var bucket_length_alive = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        var rest = param[2];
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
  end;
  var stats_alive = function (h) do
    var size = do
      contents: 0
    end;
    var mbl = $$Array.fold_left((function (m, b) do
            return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
          end), 0, h.data);
    var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
    $$Array.iter((function (b) do
            var l = bucket_length_alive(0, b);
            size.contents = size.contents + l | 0;
            return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
          end), h.data);
    return do
            num_bindings: size.contents,
            num_buckets: #h.data,
            max_bucket_length: mbl,
            bucket_histogram: histo
          end;
  end;
  var create$1 = function (sz) do
    var randomOpt = false;
    var initial_size = sz;
    var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
    var s = power_2_above(16, initial_size);
    var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
    return do
            size: 0,
            data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
            seed: seed,
            initial_size: s
          end;
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
          stats: stats,
          clean: clean,
          stats_alive: stats_alive
        end;
end

var K1 = do
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

var K2 = do
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

var Kn = do
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

var GenHashTable = do
  MakeSeeded: (function (funarg) do
      var H = do
        create: funarg.create,
        hash: funarg.hash,
        equal: funarg.equal,
        get_data: funarg.get_data,
        get_key: funarg.get_key,
        set_key_data: funarg.set_key_data,
        check_key: funarg.check_key
      end;
      var power_2_above = function (_x, n) do
        while(true) do
          var x = _x;
          if (x >= n or (x << 1) > Sys.max_array_length) then do
            return x;
          end else do
            _x = (x << 1);
            continue ;
          end end 
        end;
      end;
      var prng = Caml_obj.caml_lazy_make((function (param) do
              return Random.State.make_self_init(--[ () ]--0);
            end));
      var create = function (randomOpt, initial_size) do
        var random = randomOpt ~= undefined and randomOpt or Hashtbl.is_randomized(--[ () ]--0);
        var s = power_2_above(16, initial_size);
        var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
        return do
                size: 0,
                data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
                seed: seed,
                initial_size: s
              end;
      end;
      var clear = function (h) do
        h.size = 0;
        var len = #h.data;
        for var i = 0 , len - 1 | 0 , 1 do
          Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
        end
        return --[ () ]--0;
      end;
      var reset = function (h) do
        var len = #h.data;
        if (len == h.initial_size) then do
          return clear(h);
        end else do
          h.size = 0;
          h.data = Caml_array.caml_make_vect(h.initial_size, --[ Empty ]--0);
          return --[ () ]--0;
        end end 
      end;
      var copy = function (h) do
        return do
                size: h.size,
                data: $$Array.copy(h.data),
                seed: h.seed,
                initial_size: h.initial_size
              end;
      end;
      var key_index = function (h, hkey) do
        return hkey & (#h.data - 1 | 0);
      end;
      var clean = function (h) do
        var do_bucket = function (_param) do
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              var c = param[1];
              if (Curry._1(H.check_key, c)) then do
                return --[ Cons ]--[
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
              return --[ Empty ]--0;
            end end 
          end;
        end;
        var d = h.data;
        for var i = 0 , #d - 1 | 0 , 1 do
          Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
        end
        return --[ () ]--0;
      end;
      var resize = function (h) do
        var odata = h.data;
        var osize = #odata;
        var nsize = (osize << 1);
        clean(h);
        if (nsize < Sys.max_array_length and h.size >= (osize >>> 1)) then do
          var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
          h.data = ndata;
          var insert_bucket = function (param) do
            if (param) then do
              var hkey = param[0];
              insert_bucket(param[2]);
              var nidx = key_index(h, hkey);
              return Caml_array.caml_array_set(ndata, nidx, --[ Cons ]--[
                          hkey,
                          param[1],
                          Caml_array.caml_array_get(ndata, nidx)
                        ]);
            end else do
              return --[ () ]--0;
            end end 
          end;
          for var i = 0 , osize - 1 | 0 , 1 do
            insert_bucket(Caml_array.caml_array_get(odata, i));
          end
          return --[ () ]--0;
        end else do
          return 0;
        end end 
      end;
      var add = function (h, key, info) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var i = key_index(h, hkey);
        var container = Curry._2(H.create, key, info);
        var bucket_002 = Caml_array.caml_array_get(h.data, i);
        var bucket = --[ Cons ]--[
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
      end;
      var remove = function (h, key) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var remove_bucket = function (_param) do
          while(true) do
            var param = _param;
            if (param) then do
              var next = param[2];
              var c = param[1];
              var hk = param[0];
              if (hkey == hk) then do
                var match = Curry._2(H.equal, c, key);
                local ___conditional___=(match);
                do
                   if ___conditional___ = 0--[ ETrue ]-- then do
                      h.size = h.size - 1 | 0;
                      return next;end end end 
                   if ___conditional___ = 1--[ EFalse ]-- then do
                      return --[ Cons ]--[
                              hk,
                              c,
                              remove_bucket(next)
                            ];end end end 
                   if ___conditional___ = 2--[ EDead ]-- then do
                      h.size = h.size - 1 | 0;
                      _param = next;
                      continue ;end end end 
                   do
                  
                end
              end else do
                return --[ Cons ]--[
                        hk,
                        c,
                        remove_bucket(next)
                      ];
              end end 
            end else do
              return --[ Empty ]--0;
            end end 
          end;
        end;
        var i = key_index(h, hkey);
        return Caml_array.caml_array_set(h.data, i, remove_bucket(Caml_array.caml_array_get(h.data, i)));
      end;
      var find = function (h, key) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var key$1 = key;
        var hkey$1 = hkey;
        var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          var param = _param;
          if (param) then do
            var rest = param[2];
            var c = param[1];
            if (hkey$1 == param[0]) then do
              var match = Curry._2(H.equal, c, key$1);
              if (match ~= 0) then do
                _param = rest;
                continue ;
              end else do
                var match$1 = Curry._1(H.get_data, c);
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
      end;
      var find_opt = function (h, key) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var key$1 = key;
        var hkey$1 = hkey;
        var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          var param = _param;
          if (param) then do
            var rest = param[2];
            var c = param[1];
            if (hkey$1 == param[0]) then do
              var match = Curry._2(H.equal, c, key$1);
              if (match ~= 0) then do
                _param = rest;
                continue ;
              end else do
                var d = Curry._1(H.get_data, c);
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
      end;
      var find_all = function (h, key) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var find_in_bucket = function (_param) do
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              var c = param[1];
              if (hkey == param[0]) then do
                var match = Curry._2(H.equal, c, key);
                if (match ~= 0) then do
                  _param = rest;
                  continue ;
                end else do
                  var match$1 = Curry._1(H.get_data, c);
                  if (match$1 ~= undefined) then do
                    return --[ :: ]--[
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
              return --[ [] ]--0;
            end end 
          end;
        end;
        return find_in_bucket(Caml_array.caml_array_get(h.data, key_index(h, hkey)));
      end;
      var replace = function (h, key, info) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var i = key_index(h, hkey);
        var l = Caml_array.caml_array_get(h.data, i);
        try do
          var _param = l;
          while(true) do
            var param = _param;
            if (param) then do
              var next = param[2];
              var c = param[1];
              if (hkey == param[0]) then do
                var match = Curry._2(H.equal, c, key);
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
            var container = Curry._2(H.create, key, info);
            Caml_array.caml_array_set(h.data, i, --[ Cons ]--[
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
      end;
      var mem = function (h, key) do
        var hkey = Curry._2(H.hash, h.seed, key);
        var _param = Caml_array.caml_array_get(h.data, key_index(h, hkey));
        while(true) do
          var param = _param;
          if (param) then do
            var rest = param[2];
            if (param[0] == hkey) then do
              var match = Curry._2(H.equal, param[1], key);
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
      end;
      var iter = function (f, h) do
        var do_bucket = function (_param) do
          while(true) do
            var param = _param;
            if (param) then do
              var c = param[1];
              var match = Curry._1(H.get_key, c);
              var match$1 = Curry._1(H.get_data, c);
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
              return --[ () ]--0;
            end end 
          end;
        end;
        var d = h.data;
        for var i = 0 , #d - 1 | 0 , 1 do
          do_bucket(Caml_array.caml_array_get(d, i));
        end
        return --[ () ]--0;
      end;
      var fold = function (f, h, init) do
        var do_bucket = function (_b, _accu) do
          while(true) do
            var accu = _accu;
            var b = _b;
            if (b) then do
              var c = b[1];
              var match = Curry._1(H.get_key, c);
              var match$1 = Curry._1(H.get_data, c);
              var accu$1 = match ~= undefined and match$1 ~= undefined and Curry._3(f, Caml_option.valFromOption(match), Caml_option.valFromOption(match$1), accu) or accu;
              _accu = accu$1;
              _b = b[2];
              continue ;
            end else do
              return accu;
            end end 
          end;
        end;
        var d = h.data;
        var accu = init;
        for var i = 0 , #d - 1 | 0 , 1 do
          accu = do_bucket(Caml_array.caml_array_get(d, i), accu);
        end
        return accu;
      end;
      var filter_map_inplace = function (f, h) do
        var do_bucket = function (_param) do
          while(true) do
            var param = _param;
            if (param) then do
              var rest = param[2];
              var c = param[1];
              var match = Curry._1(H.get_key, c);
              var match$1 = Curry._1(H.get_data, c);
              if (match ~= undefined) then do
                if (match$1 ~= undefined) then do
                  var k = Caml_option.valFromOption(match);
                  var match$2 = Curry._2(f, k, Caml_option.valFromOption(match$1));
                  if (match$2 ~= undefined) then do
                    Curry._3(H.set_key_data, c, k, Caml_option.valFromOption(match$2));
                    return --[ Cons ]--[
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
              return --[ Empty ]--0;
            end end 
          end;
        end;
        var d = h.data;
        for var i = 0 , #d - 1 | 0 , 1 do
          Caml_array.caml_array_set(d, i, do_bucket(Caml_array.caml_array_get(d, i)));
        end
        return --[ () ]--0;
      end;
      var length = function (h) do
        return h.size;
      end;
      var bucket_length = function (_accu, _param) do
        while(true) do
          var param = _param;
          var accu = _accu;
          if (param) then do
            _param = param[2];
            _accu = accu + 1 | 0;
            continue ;
          end else do
            return accu;
          end end 
        end;
      end;
      var stats = function (h) do
        var mbl = $$Array.fold_left((function (m, b) do
                return Caml_primitive.caml_int_max(m, bucket_length(0, b));
              end), 0, h.data);
        var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
        $$Array.iter((function (b) do
                var l = bucket_length(0, b);
                return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
              end), h.data);
        return do
                num_bindings: h.size,
                num_buckets: #h.data,
                max_bucket_length: mbl,
                bucket_histogram: histo
              end;
      end;
      var bucket_length_alive = function (_accu, _param) do
        while(true) do
          var param = _param;
          var accu = _accu;
          if (param) then do
            var rest = param[2];
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
      end;
      var stats_alive = function (h) do
        var size = do
          contents: 0
        end;
        var mbl = $$Array.fold_left((function (m, b) do
                return Caml_primitive.caml_int_max(m, bucket_length_alive(0, b));
              end), 0, h.data);
        var histo = Caml_array.caml_make_vect(mbl + 1 | 0, 0);
        $$Array.iter((function (b) do
                var l = bucket_length_alive(0, b);
                size.contents = size.contents + l | 0;
                return Caml_array.caml_array_set(histo, l, Caml_array.caml_array_get(histo, l) + 1 | 0);
              end), h.data);
        return do
                num_bindings: size.contents,
                num_buckets: #h.data,
                max_bucket_length: mbl,
                bucket_histogram: histo
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
              stats: stats,
              clean: clean,
              stats_alive: stats_alive
            end;
    end)
end;

exports.K1 = K1;
exports.K2 = K2;
exports.Kn = Kn;
exports.GenHashTable = GenHashTable;
--[ No side effect ]--
