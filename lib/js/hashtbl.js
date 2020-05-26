'use strict';

var $$Array = require("./array.js");
var Curry = require("./curry.js");
var Random = require("./random.js");
var Caml_obj = require("./caml_obj.js");
var Caml_hash = require("./caml_hash.js");
var Caml_array = require("./caml_array.js");
var Pervasives = require("./pervasives.js");
var Caml_option = require("./caml_option.js");
var Caml_primitive = require("./caml_primitive.js");
var CamlinternalLazy = require("./camlinternalLazy.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

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

var randomized = do
  contents: false
end;

function randomize(param) do
  randomized.contents = true;
  return --[ () ]--0;
end

function is_randomized(param) do
  return randomized.contents;
end

var prng = Caml_obj.caml_lazy_make((function (param) do
        return Random.State.make_self_init(--[ () ]--0);
      end));

function power_2_above(_x, n) do
  while(true) do
    var x = _x;
    if (x >= n or (x << 1) < x) then do
      return x;
    end else do
      _x = (x << 1);
      continue ;
    end end 
  end;
end

function create(randomOpt, initial_size) do
  var random = randomOpt ~= undefined and randomOpt or randomized.contents;
  var s = power_2_above(16, initial_size);
  var seed = random and Random.State.bits(CamlinternalLazy.force(prng)) or 0;
  return do
          size: 0,
          data: Caml_array.caml_make_vect(s, --[ Empty ]--0),
          seed: seed,
          initial_size: s
        end;
end

function clear(h) do
  h.size = 0;
  var len = #h.data;
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    Caml_array.caml_array_set(h.data, i, --[ Empty ]--0);
  end
  return --[ () ]--0;
end

function reset(h) do
  var len = #h.data;
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
    var key = param[--[ key ]--0];
    var data = param[--[ data ]--1];
    var next = param[--[ next ]--2];
    var loop = function (_prec, _param) do
      while(true) do
        var param = _param;
        var prec = _prec;
        if (param) then do
          var key = param[--[ key ]--0];
          var data = param[--[ data ]--1];
          var next = param[--[ next ]--2];
          var r = --[ Cons ]--[
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
    var r = --[ Cons ]--[
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
  var odata = h.data;
  var osize = #odata;
  var nsize = (osize << 1);
  if (nsize >= osize) then do
    var ndata = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
    var ndata_tail = Caml_array.caml_make_vect(nsize, --[ Empty ]--0);
    var inplace = h.initial_size >= 0;
    h.data = ndata;
    var insert_bucket = function (_cell) do
      while(true) do
        var cell = _cell;
        if (cell) then do
          var key = cell[--[ key ]--0];
          var data = cell[--[ data ]--1];
          var next = cell[--[ next ]--2];
          var cell$1 = inplace and cell or --[ Cons ]--[
              --[ key ]--key,
              --[ data ]--data,
              --[ next : Empty ]--0
            ];
          var nidx = Curry._2(indexfun, h, key);
          var match = Caml_array.caml_array_get(ndata_tail, nidx);
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
    for(var i = 0 ,i_finish = osize - 1 | 0; i <= i_finish; ++i)do
      insert_bucket(Caml_array.caml_array_get(odata, i));
    end
    if (inplace) then do
      for(var i$1 = 0 ,i_finish$1 = nsize - 1 | 0; i$1 <= i_finish$1; ++i$1)do
        var match = Caml_array.caml_array_get(ndata_tail, i$1);
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
  var i = key_index(h, key);
  var bucket = --[ Cons ]--[
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
  var i = key_index(h, key);
  var h$1 = h;
  var i$1 = i;
  var key$1 = key;
  var _prec = --[ Empty ]--0;
  var _c = Caml_array.caml_array_get(h.data, i);
  while(true) do
    var c = _c;
    var prec = _prec;
    if (c) then do
      var k = c[--[ key ]--0];
      var next = c[--[ next ]--2];
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
  var match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    var k1 = match[--[ key ]--0];
    var d1 = match[--[ data ]--1];
    var next1 = match[--[ next ]--2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return d1;
    end else if (next1) then do
      var k2 = next1[--[ key ]--0];
      var d2 = next1[--[ data ]--1];
      var next2 = next1[--[ next ]--2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return d2;
      end else if (next2) then do
        var k3 = next2[--[ key ]--0];
        var d3 = next2[--[ data ]--1];
        var next3 = next2[--[ next ]--2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return d3;
        end else do
          var key$1 = key;
          var _param = next3;
          while(true) do
            var param = _param;
            if (param) then do
              var k = param[--[ key ]--0];
              var data = param[--[ data ]--1];
              var next = param[--[ next ]--2];
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
  var match = Caml_array.caml_array_get(h.data, key_index(h, key));
  if (match) then do
    var k1 = match[--[ key ]--0];
    var d1 = match[--[ data ]--1];
    var next1 = match[--[ next ]--2];
    if (Caml_obj.caml_equal(key, k1)) then do
      return Caml_option.some(d1);
    end else if (next1) then do
      var k2 = next1[--[ key ]--0];
      var d2 = next1[--[ data ]--1];
      var next2 = next1[--[ next ]--2];
      if (Caml_obj.caml_equal(key, k2)) then do
        return Caml_option.some(d2);
      end else if (next2) then do
        var k3 = next2[--[ key ]--0];
        var d3 = next2[--[ data ]--1];
        var next3 = next2[--[ next ]--2];
        if (Caml_obj.caml_equal(key, k3)) then do
          return Caml_option.some(d3);
        end else do
          var key$1 = key;
          var _param = next3;
          while(true) do
            var param = _param;
            if (param) then do
              var k = param[--[ key ]--0];
              var data = param[--[ data ]--1];
              var next = param[--[ next ]--2];
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
  var find_in_bucket = function (_param) do
    while(true) do
      var param = _param;
      if (param) then do
        var k = param[--[ key ]--0];
        var data = param[--[ data ]--1];
        var next = param[--[ next ]--2];
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
    var param = _param;
    if (param) then do
      var k = param[--[ key ]--0];
      var next = param[--[ next ]--2];
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
  var i = key_index(h, key);
  var l = Caml_array.caml_array_get(h.data, i);
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
  var _param = Caml_array.caml_array_get(h.data, key_index(h, key));
  while(true) do
    var param = _param;
    if (param) then do
      var k = param[--[ key ]--0];
      var next = param[--[ next ]--2];
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
  var do_bucket = function (_param) do
    while(true) do
      var param = _param;
      if (param) then do
        var key = param[--[ key ]--0];
        var data = param[--[ data ]--1];
        var next = param[--[ next ]--2];
        Curry._2(f, key, data);
        _param = next;
        continue ;
      end else do
        return --[ () ]--0;
      end end 
    end;
  end;
  var old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    var d = h.data;
    for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
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
    var slot = _slot;
    var prec = _prec;
    if (slot) then do
      var key = slot[--[ key ]--0];
      var data = slot[--[ data ]--1];
      var next = slot[--[ next ]--2];
      var match = Curry._2(f, key, data);
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
  var d = h.data;
  var old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
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
  var do_bucket = function (_b, _accu) do
    while(true) do
      var accu = _accu;
      var b = _b;
      if (b) then do
        var key = b[--[ key ]--0];
        var data = b[--[ data ]--1];
        var next = b[--[ next ]--2];
        _accu = Curry._3(f, key, data, accu);
        _b = next;
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var old_trav = h.initial_size < 0;
  if (!old_trav) then do
    flip_ongoing_traversal(h);
  end
   end 
  try do
    var d = h.data;
    var accu = init;
    for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
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
    var param = _param;
    var accu = _accu;
    if (param) then do
      var next = param[--[ next ]--2];
      _param = next;
      _accu = accu + 1 | 0;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function stats(h) do
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
end

function MakeSeeded(H) do
  var key_index = function (h, key) do
    return Curry._2(H.hash, h.seed, key) & (#h.data - 1 | 0);
  end;
  var add = function (h, key, data) do
    var i = key_index(h, key);
    var bucket = --[ Cons ]--[
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
  var remove = function (h, key) do
    var i = key_index(h, key);
    var h$1 = h;
    var i$1 = i;
    var key$1 = key;
    var _prec = --[ Empty ]--0;
    var _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      var c = _c;
      var prec = _prec;
      if (c) then do
        var k = c[--[ key ]--0];
        var next = c[--[ next ]--2];
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
  var find = function (h, key) do
    var match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      var k1 = match[--[ key ]--0];
      var d1 = match[--[ data ]--1];
      var next1 = match[--[ next ]--2];
      if (Curry._2(H.equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        var k2 = next1[--[ key ]--0];
        var d2 = next1[--[ data ]--1];
        var next2 = next1[--[ next ]--2];
        if (Curry._2(H.equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          var k3 = next2[--[ key ]--0];
          var d3 = next2[--[ data ]--1];
          var next3 = next2[--[ next ]--2];
          if (Curry._2(H.equal, key, k3)) then do
            return d3;
          end else do
            var key$1 = key;
            var _param = next3;
            while(true) do
              var param = _param;
              if (param) then do
                var k = param[--[ key ]--0];
                var data = param[--[ data ]--1];
                var next = param[--[ next ]--2];
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
  var find_opt = function (h, key) do
    var match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      var k1 = match[--[ key ]--0];
      var d1 = match[--[ data ]--1];
      var next1 = match[--[ next ]--2];
      if (Curry._2(H.equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        var k2 = next1[--[ key ]--0];
        var d2 = next1[--[ data ]--1];
        var next2 = next1[--[ next ]--2];
        if (Curry._2(H.equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          var k3 = next2[--[ key ]--0];
          var d3 = next2[--[ data ]--1];
          var next3 = next2[--[ next ]--2];
          if (Curry._2(H.equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            var key$1 = key;
            var _param = next3;
            while(true) do
              var param = _param;
              if (param) then do
                var k = param[--[ key ]--0];
                var data = param[--[ data ]--1];
                var next = param[--[ next ]--2];
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
  var find_all = function (h, key) do
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var k = param[--[ key ]--0];
          var d = param[--[ data ]--1];
          var next = param[--[ next ]--2];
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
  var replace_bucket = function (key, data, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        var k = param[--[ key ]--0];
        var next = param[--[ next ]--2];
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
  var replace = function (h, key, data) do
    var i = key_index(h, key);
    var l = Caml_array.caml_array_get(h.data, i);
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
  var mem = function (h, key) do
    var _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      var param = _param;
      if (param) then do
        var k = param[--[ key ]--0];
        var next = param[--[ next ]--2];
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
  var equal = H.equal;
  var key_index = function (h, key) do
    return Curry._1(H.hash, key) & (#h.data - 1 | 0);
  end;
  var add = function (h, key, data) do
    var i = key_index(h, key);
    var bucket = --[ Cons ]--[
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
  var remove = function (h, key) do
    var i = key_index(h, key);
    var h$1 = h;
    var i$1 = i;
    var key$1 = key;
    var _prec = --[ Empty ]--0;
    var _c = Caml_array.caml_array_get(h.data, i);
    while(true) do
      var c = _c;
      var prec = _prec;
      if (c) then do
        var k = c[--[ key ]--0];
        var next = c[--[ next ]--2];
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
  var find = function (h, key) do
    var match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      var k1 = match[--[ key ]--0];
      var d1 = match[--[ data ]--1];
      var next1 = match[--[ next ]--2];
      if (Curry._2(equal, key, k1)) then do
        return d1;
      end else if (next1) then do
        var k2 = next1[--[ key ]--0];
        var d2 = next1[--[ data ]--1];
        var next2 = next1[--[ next ]--2];
        if (Curry._2(equal, key, k2)) then do
          return d2;
        end else if (next2) then do
          var k3 = next2[--[ key ]--0];
          var d3 = next2[--[ data ]--1];
          var next3 = next2[--[ next ]--2];
          if (Curry._2(equal, key, k3)) then do
            return d3;
          end else do
            var key$1 = key;
            var _param = next3;
            while(true) do
              var param = _param;
              if (param) then do
                var k = param[--[ key ]--0];
                var data = param[--[ data ]--1];
                var next = param[--[ next ]--2];
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
  var find_opt = function (h, key) do
    var match = Caml_array.caml_array_get(h.data, key_index(h, key));
    if (match) then do
      var k1 = match[--[ key ]--0];
      var d1 = match[--[ data ]--1];
      var next1 = match[--[ next ]--2];
      if (Curry._2(equal, key, k1)) then do
        return Caml_option.some(d1);
      end else if (next1) then do
        var k2 = next1[--[ key ]--0];
        var d2 = next1[--[ data ]--1];
        var next2 = next1[--[ next ]--2];
        if (Curry._2(equal, key, k2)) then do
          return Caml_option.some(d2);
        end else if (next2) then do
          var k3 = next2[--[ key ]--0];
          var d3 = next2[--[ data ]--1];
          var next3 = next2[--[ next ]--2];
          if (Curry._2(equal, key, k3)) then do
            return Caml_option.some(d3);
          end else do
            var key$1 = key;
            var _param = next3;
            while(true) do
              var param = _param;
              if (param) then do
                var k = param[--[ key ]--0];
                var data = param[--[ data ]--1];
                var next = param[--[ next ]--2];
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
  var find_all = function (h, key) do
    var find_in_bucket = function (_param) do
      while(true) do
        var param = _param;
        if (param) then do
          var k = param[--[ key ]--0];
          var d = param[--[ data ]--1];
          var next = param[--[ next ]--2];
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
  var replace_bucket = function (key, data, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        var k = param[--[ key ]--0];
        var next = param[--[ next ]--2];
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
  var replace = function (h, key, data) do
    var i = key_index(h, key);
    var l = Caml_array.caml_array_get(h.data, i);
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
  var mem = function (h, key) do
    var _param = Caml_array.caml_array_get(h.data, key_index(h, key));
    while(true) do
      var param = _param;
      if (param) then do
        var k = param[--[ key ]--0];
        var next = param[--[ next ]--2];
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
  var create$1 = function (sz) do
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

var seeded_hash_param = Caml_hash.caml_hash;

exports.create = create;
exports.clear = clear;
exports.reset = reset;
exports.copy = copy;
exports.add = add;
exports.find = find;
exports.find_opt = find_opt;
exports.find_all = find_all;
exports.mem = mem;
exports.remove = remove;
exports.replace = replace;
exports.iter = iter;
exports.filter_map_inplace = filter_map_inplace;
exports.fold = fold;
exports.length = length;
exports.randomize = randomize;
exports.is_randomized = is_randomized;
exports.stats = stats;
exports.Make = Make;
exports.MakeSeeded = MakeSeeded;
exports.hash = hash;
exports.seeded_hash = seeded_hash;
exports.hash_param = hash_param;
exports.seeded_hash_param = seeded_hash_param;
--[ No side effect ]--
