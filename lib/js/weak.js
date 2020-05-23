'use strict';

var Sys = require("./sys.js");
var $$Array = require("./array.js");
var Curry = require("./curry.js");
var Caml_obj = require("./caml_obj.js");
var Caml_weak = require("./caml_weak.js");
var Caml_array = require("./caml_array.js");
var Caml_int32 = require("./caml_int32.js");
var Pervasives = require("./pervasives.js");
var Caml_option = require("./caml_option.js");
var Caml_primitive = require("./caml_primitive.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function fill(ar, ofs, len, x) do
  if (ofs < 0 or len < 0 or (ofs + len | 0) > #ar) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Weak.fill"
        ];
  end
  for(var i = ofs ,i_finish = (ofs + len | 0) - 1 | 0; i <= i_finish; ++i)do
    Caml_weak.caml_weak_set(ar, i, x);
  end
  return --[ () ]--0;
end

function Make(H) do
  var emptybucket = Caml_weak.caml_weak_create(0);
  var get_index = function (t, h) do
    return (h & Pervasives.max_int) % #t.table;
  end;
  var create = function (sz) do
    var sz$1 = sz < 7 ? 7 : sz;
    var sz$2 = sz$1 > Sys.max_array_length ? Sys.max_array_length : sz$1;
    return do
            table: Caml_array.caml_make_vect(sz$2, emptybucket),
            hashes: Caml_array.caml_make_vect(sz$2, []),
            limit: 7,
            oversize: 0,
            rover: 0
          end;
  end;
  var clear = function (t) do
    for(var i = 0 ,i_finish = #t.table - 1 | 0; i <= i_finish; ++i)do
      Caml_array.caml_array_set(t.table, i, emptybucket);
      Caml_array.caml_array_set(t.hashes, i, []);
    end
    t.limit = 7;
    t.oversize = 0;
    return --[ () ]--0;
  end;
  var fold = function (f, t, init) do
    return $$Array.fold_right((function (param, param$1) do
                  var _i = 0;
                  var b = param;
                  var _accu = param$1;
                  while(true) do
                    var accu = _accu;
                    var i = _i;
                    if (i >= #b) do
                      return accu;
                    end else do
                      var match = Caml_weak.caml_weak_get(b, i);
                      if (match ~= undefined) do
                        _accu = Curry._2(f, Caml_option.valFromOption(match), accu);
                        _i = i + 1 | 0;
                        continue ;
                      end else do
                        _i = i + 1 | 0;
                        continue ;
                      end
                    end
                  end;
                end), t.table, init);
  end;
  var iter = function (f, t) do
    return $$Array.iter((function (param) do
                  var _i = 0;
                  var b = param;
                  while(true) do
                    var i = _i;
                    if (i >= #b) do
                      return --[ () ]--0;
                    end else do
                      var match = Caml_weak.caml_weak_get(b, i);
                      if (match ~= undefined) do
                        Curry._1(f, Caml_option.valFromOption(match));
                        _i = i + 1 | 0;
                        continue ;
                      end else do
                        _i = i + 1 | 0;
                        continue ;
                      end
                    end
                  end;
                end), t.table);
  end;
  var iter_weak = function (f, t) do
    return $$Array.iteri((function (param, param$1) do
                  var _i = 0;
                  var j = param;
                  var b = param$1;
                  while(true) do
                    var i = _i;
                    if (i >= #b) do
                      return --[ () ]--0;
                    end else if (Caml_weak.caml_weak_check(b, i)) do
                      Curry._3(f, b, Caml_array.caml_array_get(t.hashes, j), i);
                      _i = i + 1 | 0;
                      continue ;
                    end else do
                      _i = i + 1 | 0;
                      continue ;
                    end
                  end;
                end), t.table);
  end;
  var count_bucket = function (_i, b, _accu) do
    while(true) do
      var accu = _accu;
      var i = _i;
      if (i >= #b) do
        return accu;
      end else do
        _accu = accu + (
          Caml_weak.caml_weak_check(b, i) ? 1 : 0
        ) | 0;
        _i = i + 1 | 0;
        continue ;
      end
    end;
  end;
  var count = function (t) do
    return $$Array.fold_right((function (param, param$1) do
                  return count_bucket(0, param, param$1);
                end), t.table, 0);
  end;
  var next_sz = function (n) do
    return Caml_primitive.caml_int_min((Caml_int32.imul(3, n) / 2 | 0) + 3 | 0, Sys.max_array_length);
  end;
  var prev_sz = function (n) do
    return (((n - 3 | 0) << 1) + 2 | 0) / 3 | 0;
  end;
  var test_shrink_bucket = function (t) do
    var bucket = Caml_array.caml_array_get(t.table, t.rover);
    var hbucket = Caml_array.caml_array_get(t.hashes, t.rover);
    var len = #bucket;
    var prev_len = prev_sz(len);
    var live = count_bucket(0, bucket, 0);
    if (live <= prev_len) do
      var loop = function (_i, _j) do
        while(true) do
          var j = _j;
          var i = _i;
          if (j >= prev_len) do
            if (Caml_weak.caml_weak_check(bucket, i)) do
              _i = i + 1 | 0;
              continue ;
            end else if (Caml_weak.caml_weak_check(bucket, j)) do
              Caml_weak.caml_weak_blit(bucket, j, bucket, i, 1);
              Caml_array.caml_array_set(hbucket, i, Caml_array.caml_array_get(hbucket, j));
              _j = j - 1 | 0;
              _i = i + 1 | 0;
              continue ;
            end else do
              _j = j - 1 | 0;
              continue ;
            end
          end else do
            return 0;
          end
        end;
      end;
      loop(0, #bucket - 1 | 0);
      if (prev_len == 0) do
        Caml_array.caml_array_set(t.table, t.rover, emptybucket);
        Caml_array.caml_array_set(t.hashes, t.rover, []);
      end else do
        Caml_obj.caml_obj_truncate(bucket, prev_len + 0 | 0);
        Caml_obj.caml_obj_truncate(hbucket, prev_len);
      end
      if (len > t.limit and prev_len <= t.limit) do
        t.oversize = t.oversize - 1 | 0;
      end
      
    end
    t.rover = (t.rover + 1 | 0) % #t.table;
    return --[ () ]--0;
  end;
  var add_aux = function (t, setter, d, h, index) do
    var bucket = Caml_array.caml_array_get(t.table, index);
    var hashes = Caml_array.caml_array_get(t.hashes, index);
    var sz = #bucket;
    var _i = 0;
    while(true) do
      var i = _i;
      if (i >= sz) do
        var newsz = Caml_primitive.caml_int_min((Caml_int32.imul(3, sz) / 2 | 0) + 3 | 0, Sys.max_array_length - 0 | 0);
        if (newsz <= sz) do
          throw [
                Caml_builtin_exceptions.failure,
                "Weak.Make: hash bucket cannot grow more"
              ];
        end
        var newbucket = Caml_weak.caml_weak_create(newsz);
        var newhashes = Caml_array.caml_make_vect(newsz, 0);
        Caml_weak.caml_weak_blit(bucket, 0, newbucket, 0, sz);
        $$Array.blit(hashes, 0, newhashes, 0, sz);
        Curry._3(setter, newbucket, sz, d);
        Caml_array.caml_array_set(newhashes, sz, h);
        Caml_array.caml_array_set(t.table, index, newbucket);
        Caml_array.caml_array_set(t.hashes, index, newhashes);
        if (sz <= t.limit and newsz > t.limit) do
          t.oversize = t.oversize + 1 | 0;
          for(var _i$1 = 0; _i$1 <= 2; ++_i$1)do
            test_shrink_bucket(t);
          end
        end
        if (t.oversize > (#t.table >> 1)) do
          var t$1 = t;
          var oldlen = #t$1.table;
          var newlen = next_sz(oldlen);
          if (newlen > oldlen) do
            var newt = create(newlen);
            var add_weak = (function(newt)do
            return function add_weak(ob, oh, oi) do
              var setter = function (nb, ni, param) do
                return Caml_weak.caml_weak_blit(ob, oi, nb, ni, 1);
              end;
              var h = Caml_array.caml_array_get(oh, oi);
              return add_aux(newt, setter, undefined, h, get_index(newt, h));
            end
            end(newt));
            iter_weak(add_weak, t$1);
            t$1.table = newt.table;
            t$1.hashes = newt.hashes;
            t$1.limit = newt.limit;
            t$1.oversize = newt.oversize;
            t$1.rover = t$1.rover % #newt.table;
            return --[ () ]--0;
          end else do
            t$1.limit = Pervasives.max_int;
            t$1.oversize = 0;
            return --[ () ]--0;
          end
        end else do
          return 0;
        end
      end else if (Caml_weak.caml_weak_check(bucket, i)) do
        _i = i + 1 | 0;
        continue ;
      end else do
        Curry._3(setter, bucket, i, d);
        return Caml_array.caml_array_set(hashes, i, h);
      end
    end;
  end;
  var add = function (t, d) do
    var h = Curry._1(H.hash, d);
    return add_aux(t, Caml_weak.caml_weak_set, Caml_option.some(d), h, get_index(t, h));
  end;
  var find_or = function (t, d, ifnotfound) do
    var h = Curry._1(H.hash, d);
    var index = get_index(t, h);
    var bucket = Caml_array.caml_array_get(t.table, index);
    var hashes = Caml_array.caml_array_get(t.hashes, index);
    var sz = #bucket;
    var _i = 0;
    while(true) do
      var i = _i;
      if (i >= sz) do
        return Curry._2(ifnotfound, h, index);
      end else if (h == Caml_array.caml_array_get(hashes, i)) do
        var match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= undefined) do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) do
            var match$1 = Caml_weak.caml_weak_get(bucket, i);
            if (match$1 ~= undefined) do
              return Caml_option.valFromOption(match$1);
            end else do
              _i = i + 1 | 0;
              continue ;
            end
          end else do
            _i = i + 1 | 0;
            continue ;
          end
        end else do
          _i = i + 1 | 0;
          continue ;
        end
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end;
  end;
  var merge = function (t, d) do
    return find_or(t, d, (function (h, index) do
                  add_aux(t, Caml_weak.caml_weak_set, Caml_option.some(d), h, index);
                  return d;
                end));
  end;
  var find = function (t, d) do
    return find_or(t, d, (function (_h, _index) do
                  throw Caml_builtin_exceptions.not_found;
                end));
  end;
  var find_opt = function (t, d) do
    var h = Curry._1(H.hash, d);
    var index = get_index(t, h);
    var bucket = Caml_array.caml_array_get(t.table, index);
    var hashes = Caml_array.caml_array_get(t.hashes, index);
    var sz = #bucket;
    var _i = 0;
    while(true) do
      var i = _i;
      if (i >= sz) do
        return ;
      end else if (h == Caml_array.caml_array_get(hashes, i)) do
        var match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= undefined) do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) do
            var v = Caml_weak.caml_weak_get(bucket, i);
            if (v ~= undefined) do
              return v;
            end else do
              _i = i + 1 | 0;
              continue ;
            end
          end else do
            _i = i + 1 | 0;
            continue ;
          end
        end else do
          _i = i + 1 | 0;
          continue ;
        end
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end;
  end;
  var find_shadow = function (t, d, iffound, ifnotfound) do
    var h = Curry._1(H.hash, d);
    var index = get_index(t, h);
    var bucket = Caml_array.caml_array_get(t.table, index);
    var hashes = Caml_array.caml_array_get(t.hashes, index);
    var sz = #bucket;
    var _i = 0;
    while(true) do
      var i = _i;
      if (i >= sz) do
        return ifnotfound;
      end else if (h == Caml_array.caml_array_get(hashes, i)) do
        var match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= undefined) do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) do
            return Curry._2(iffound, bucket, i);
          end else do
            _i = i + 1 | 0;
            continue ;
          end
        end else do
          _i = i + 1 | 0;
          continue ;
        end
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end;
  end;
  var remove = function (t, d) do
    return find_shadow(t, d, (function (w, i) do
                  return Caml_weak.caml_weak_set(w, i, undefined);
                end), --[ () ]--0);
  end;
  var mem = function (t, d) do
    return find_shadow(t, d, (function (_w, _i) do
                  return true;
                end), false);
  end;
  var find_all = function (t, d) do
    var h = Curry._1(H.hash, d);
    var index = get_index(t, h);
    var bucket = Caml_array.caml_array_get(t.table, index);
    var hashes = Caml_array.caml_array_get(t.hashes, index);
    var sz = #bucket;
    var _i = 0;
    var _accu = --[ [] ]--0;
    while(true) do
      var accu = _accu;
      var i = _i;
      if (i >= sz) do
        return accu;
      end else if (h == Caml_array.caml_array_get(hashes, i)) do
        var match = Caml_weak.caml_weak_get_copy(bucket, i);
        if (match ~= undefined) do
          if (Curry._2(H.equal, Caml_option.valFromOption(match), d)) do
            var match$1 = Caml_weak.caml_weak_get(bucket, i);
            if (match$1 ~= undefined) do
              _accu = --[ :: ]--[
                Caml_option.valFromOption(match$1),
                accu
              ];
              _i = i + 1 | 0;
              continue ;
            end else do
              _i = i + 1 | 0;
              continue ;
            end
          end else do
            _i = i + 1 | 0;
            continue ;
          end
        end else do
          _i = i + 1 | 0;
          continue ;
        end
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end;
  end;
  var stats = function (t) do
    var len = #t.table;
    var lens = $$Array.map((function (prim) do
            return #prim;
          end), t.table);
    $$Array.sort(Caml_primitive.caml_int_compare, lens);
    var totlen = $$Array.fold_left((function (prim, prim$1) do
            return prim + prim$1 | 0;
          end), 0, lens);
    return --[ tuple ]--[
            len,
            count(t),
            totlen,
            Caml_array.caml_array_get(lens, 0),
            Caml_array.caml_array_get(lens, len / 2 | 0),
            Caml_array.caml_array_get(lens, len - 1 | 0)
          ];
  end;
  return do
          create: create,
          clear: clear,
          merge: merge,
          add: add,
          remove: remove,
          find: find,
          find_opt: find_opt,
          find_all: find_all,
          mem: mem,
          iter: iter,
          fold: fold,
          count: count,
          stats: stats
        end;
end

var create = Caml_weak.caml_weak_create;

function length(prim) do
  return #prim;
end

var set = Caml_weak.caml_weak_set;

var get = Caml_weak.caml_weak_get;

var get_copy = Caml_weak.caml_weak_get_copy;

var check = Caml_weak.caml_weak_check;

var blit = Caml_weak.caml_weak_blit;

exports.create = create;
exports.length = length;
exports.set = set;
exports.get = get;
exports.get_copy = get_copy;
exports.check = check;
exports.fill = fill;
exports.blit = blit;
exports.Make = Make;
--[ No side effect ]--
