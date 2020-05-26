'use strict';

var Obj = require("../../lib/js/obj.js");
var Sys = require("../../lib/js/sys.js");
var List = require("../../lib/js/list.js");
var $$Array = require("../../lib/js/array.js");
var Curry = require("../../lib/js/curry.js");
var Caml_oo = require("../../lib/js/caml_oo.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Caml_string = require("../../lib/js/caml_string.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function copy(o) do
  return Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(o));
end

var params = do
  compact_table: true,
  copy_parent: true,
  clean_when_copying: true,
  retry_count: 3,
  bucket_small_size: 16
end;

var step = Sys.word_size / 16 | 0;

function public_method_label(s) do
  var accu = 0;
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    accu = Caml_int32.imul(223, accu) + Caml_string.get(s, i) | 0;
  end
  accu = accu & 2147483647;
  if (accu > 1073741823) then do
    return accu - -2147483648 | 0;
  end else do
    return accu;
  end end 
end

function height(param) do
  if (param) then do
    return param[--[ h ]--4];
  end else do
    return 0;
  end end 
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end

function singleton(x, d) do
  return --[ Node ]--[
          --[ l : Empty ]--0,
          --[ v ]--x,
          --[ d ]--d,
          --[ r : Empty ]--0,
          --[ h ]--1
        ];
end

function bal(l, x, d, r) do
  var hl = l and l[--[ h ]--4] or 0;
  var hr = r and r[--[ h ]--4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end

function is_empty(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end

function add(x, data, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end end 
    end else if (c < 0) then do
      var ll = add(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      var rr = add(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end end 
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first_opt(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_last(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_last_opt(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_opt(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return Caml_option.some(param[--[ d ]--2]);
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function mem(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function min_binding(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function min_binding_opt(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function max_binding(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function max_binding_opt(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function remove_min_binding(param) do
  if (param) then do
    var l = param[--[ l ]--0];
    if (l) then do
      return bal(remove_min_binding(l), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
    end else do
      return param[--[ r ]--3];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Map.remove_min_elt"
        ];
  end end 
end

function merge(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding(t2);
      return bal(t1, match[0], match[1], remove_min_binding(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function remove(x, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return merge(l, r);
    end else if (c < 0) then do
      var ll = remove(x, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      var rr = remove(x, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Empty ]--0;
  end end 
end

function update(x, f, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      var match = Curry._1(f, Caml_option.some(d));
      if (match ~= undefined) then do
        var data = Caml_option.valFromOption(match);
        if (d == data) then do
          return m;
        end else do
          return --[ Node ]--[
                  --[ l ]--l,
                  --[ v ]--x,
                  --[ d ]--data,
                  --[ r ]--r,
                  --[ h ]--m[--[ h ]--4]
                ];
        end end 
      end else do
        return merge(l, r);
      end end 
    end else if (c < 0) then do
      var ll = update(x, f, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      var rr = update(x, f, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    var match$1 = Curry._1(f, undefined);
    if (match$1 ~= undefined) then do
      return --[ Node ]--[
              --[ l : Empty ]--0,
              --[ v ]--x,
              --[ d ]--Caml_option.valFromOption(match$1),
              --[ r : Empty ]--0,
              --[ h ]--1
            ];
    end else do
      return --[ Empty ]--0;
    end end 
  end end 
end

function iter(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      iter(f, param[--[ l ]--0]);
      Curry._2(f, param[--[ v ]--1], param[--[ d ]--2]);
      _param = param[--[ r ]--3];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function map(f, param) do
  if (param) then do
    var l$prime = map(f, param[--[ l ]--0]);
    var d$prime = Curry._1(f, param[--[ d ]--2]);
    var r$prime = map(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--param[--[ v ]--1],
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function mapi(f, param) do
  if (param) then do
    var v = param[--[ v ]--1];
    var l$prime = mapi(f, param[--[ l ]--0]);
    var d$prime = Curry._2(f, v, param[--[ d ]--2]);
    var r$prime = mapi(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--v,
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function fold(f, _m, _accu) do
  while(true) do
    var accu = _accu;
    var m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[ v ]--1], m[--[ d ]--2], fold(f, m[--[ l ]--0], accu));
      _m = m[--[ r ]--3];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function for_all(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) and for_all(p, param[--[ l ]--0])) then do
        _param = param[--[ r ]--3];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function exists(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) or exists(p, param[--[ l ]--0])) then do
        return true;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function add_min_binding(k, x, param) do
  if (param) then do
    return bal(add_min_binding(k, x, param[--[ l ]--0]), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
  end else do
    return singleton(k, x);
  end end 
end

function add_max_binding(k, x, param) do
  if (param) then do
    return bal(param[--[ l ]--0], param[--[ v ]--1], param[--[ d ]--2], add_max_binding(k, x, param[--[ r ]--3]));
  end else do
    return singleton(k, x);
  end end 
end

function join(l, v, d, r) do
  if (l) then do
    if (r) then do
      var rh = r[--[ h ]--4];
      var lh = l[--[ h ]--4];
      if (lh > (rh + 2 | 0)) then do
        return bal(l[--[ l ]--0], l[--[ v ]--1], l[--[ d ]--2], join(l[--[ r ]--3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(join(l, v, d, r[--[ l ]--0]), r[--[ v ]--1], r[--[ d ]--2], r[--[ r ]--3]);
      end else do
        return create(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding(v, d, l);
    end end 
  end else do
    return add_min_binding(v, d, r);
  end end 
end

function concat(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding(t2);
      return join(t1, match[0], match[1], remove_min_binding(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function concat_or_join(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat(t1, t2);
  end end 
end

function split(x, param) do
  if (param) then do
    var r = param[--[ r ]--3];
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var l = param[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[ tuple ]--[
              l,
              Caml_option.some(d),
              r
            ];
    end else if (c < 0) then do
      var match = split(x, l);
      return --[ tuple ]--[
              match[0],
              match[1],
              join(match[2], v, d, r)
            ];
    end else do
      var match$1 = split(x, r);
      return --[ tuple ]--[
              join(l, v, d, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end end  end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            undefined,
            --[ Empty ]--0
          ];
  end end 
end

function merge$1(f, s1, s2) do
  if (s1) then do
    var v1 = s1[--[ v ]--1];
    if (s1[--[ h ]--4] >= height(s2)) then do
      var match = split(v1, s2);
      return concat_or_join(merge$1(f, s1[--[ l ]--0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[ d ]--2]), match[1]), merge$1(f, s1[--[ r ]--3], match[2]));
    end
     end 
  end else if (!s2) then do
    return --[ Empty ]--0;
  end
   end  end 
  if (s2) then do
    var v2 = s2[--[ v ]--1];
    var match$1 = split(v2, s1);
    return concat_or_join(merge$1(f, match$1[0], s2[--[ l ]--0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[--[ d ]--2])), merge$1(f, match$1[2], s2[--[ r ]--3]));
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "map.ml",
            393,
            10
          ]
        ];
  end end 
end

function union(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      var d2 = s2[--[ d ]--2];
      var v2 = s2[--[ v ]--1];
      var d1 = s1[--[ d ]--2];
      var v1 = s1[--[ v ]--1];
      if (s1[--[ h ]--4] >= s2[--[ h ]--4]) then do
        var match = split(v1, s2);
        var d2$1 = match[1];
        var l = union(f, s1[--[ l ]--0], match[0]);
        var r = union(f, s1[--[ r ]--3], match[2]);
        if (d2$1 ~= undefined) then do
          return concat_or_join(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2$1)), r);
        end else do
          return join(l, v1, d1, r);
        end end 
      end else do
        var match$1 = split(v2, s1);
        var d1$1 = match$1[1];
        var l$1 = union(f, match$1[0], s2[--[ l ]--0]);
        var r$1 = union(f, match$1[2], s2[--[ r ]--3]);
        if (d1$1 ~= undefined) then do
          return concat_or_join(l$1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1$1), d2), r$1);
        end else do
          return join(l$1, v2, d2, r$1);
        end end 
      end end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end

function filter(p, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var l$prime = filter(p, l);
    var pvd = Curry._2(p, v, d);
    var r$prime = filter(p, r);
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
    return --[ Empty ]--0;
  end end 
end

function partition(p, param) do
  if (param) then do
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var match = partition(p, param[--[ l ]--0]);
    var lf = match[1];
    var lt = match[0];
    var pvd = Curry._2(p, v, d);
    var match$1 = partition(p, param[--[ r ]--3]);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pvd) then do
      return --[ tuple ]--[
              join(lt, v, d, rt),
              concat(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concat(lt, rt),
              join(lf, v, d, rf)
            ];
    end end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            --[ Empty ]--0
          ];
  end end 
end

function cons_enum(_m, _e) do
  while(true) do
    var e = _e;
    var m = _m;
    if (m) then do
      _e = --[ More ]--[
        m[--[ v ]--1],
        m[--[ d ]--2],
        m[--[ r ]--3],
        e
      ];
      _m = m[--[ l ]--0];
      continue ;
    end else do
      return e;
    end end 
  end;
end

function compare(cmp, m1, m2) do
  var _e1 = cons_enum(m1, --[ End ]--0);
  var _e2 = cons_enum(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2) then do
        var c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          var c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) then do
            return c$1;
          end else do
            _e2 = cons_enum(e2[2], e2[3]);
            _e1 = cons_enum(e1[2], e1[3]);
            continue ;
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
end

function equal(cmp, m1, m2) do
  var _e1 = cons_enum(m1, --[ End ]--0);
  var _e2 = cons_enum(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2 and Caml_primitive.caml_string_compare(e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum(e2[2], e2[3]);
        _e1 = cons_enum(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function cardinal(param) do
  if (param) then do
    return (cardinal(param[--[ l ]--0]) + 1 | 0) + cardinal(param[--[ r ]--3]) | 0;
  end else do
    return 0;
  end end 
end

function bindings_aux(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) then do
      _param = param[--[ l ]--0];
      _accu = --[ :: ]--[
        --[ tuple ]--[
          param[--[ v ]--1],
          param[--[ d ]--2]
        ],
        bindings_aux(accu, param[--[ r ]--3])
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function bindings(s) do
  return bindings_aux(--[ [] ]--0, s);
end

var Vars = do
  empty: --[ Empty ]--0,
  is_empty: is_empty,
  mem: mem,
  add: add,
  update: update,
  singleton: singleton,
  remove: remove,
  merge: merge$1,
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

function height$1(param) do
  if (param) then do
    return param[--[ h ]--4];
  end else do
    return 0;
  end end 
end

function create$1(l, x, d, r) do
  var hl = height$1(l);
  var hr = height$1(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end

function singleton$1(x, d) do
  return --[ Node ]--[
          --[ l : Empty ]--0,
          --[ v ]--x,
          --[ d ]--d,
          --[ r : Empty ]--0,
          --[ h ]--1
        ];
end

function bal$1(l, x, d, r) do
  var hl = l and l[--[ h ]--4] or 0;
  var hr = r and r[--[ h ]--4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height$1(ll) >= height$1(lr)) then do
        return create$1(ll, lv, ld, create$1(lr, x, d, r));
      end else if (lr) then do
        return create$1(create$1(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create$1(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height$1(rr) >= height$1(rl)) then do
        return create$1(create$1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create$1(create$1(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create$1(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end

function is_empty$1(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end

function add$1(x, data, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end end 
    end else if (c < 0) then do
      var ll = add$1(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$1(ll, v, d, r);
      end end 
    end else do
      var rr = add$1(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end end 
end

function find$1(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first$1(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first_opt$1(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_last$1(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_last_opt$1(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_opt$1(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return Caml_option.some(param[--[ d ]--2]);
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function mem$1(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function min_binding$1(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function min_binding_opt$1(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function max_binding$1(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function max_binding_opt$1(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function remove_min_binding$1(param) do
  if (param) then do
    var l = param[--[ l ]--0];
    if (l) then do
      return bal$1(remove_min_binding$1(l), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
    end else do
      return param[--[ r ]--3];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Map.remove_min_elt"
        ];
  end end 
end

function merge$2(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding$1(t2);
      return bal$1(t1, match[0], match[1], remove_min_binding$1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function remove$1(x, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return merge$2(l, r);
    end else if (c < 0) then do
      var ll = remove$1(x, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$1(ll, v, d, r);
      end end 
    end else do
      var rr = remove$1(x, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Empty ]--0;
  end end 
end

function update$1(x, f, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      var match = Curry._1(f, Caml_option.some(d));
      if (match ~= undefined) then do
        var data = Caml_option.valFromOption(match);
        if (d == data) then do
          return m;
        end else do
          return --[ Node ]--[
                  --[ l ]--l,
                  --[ v ]--x,
                  --[ d ]--data,
                  --[ r ]--r,
                  --[ h ]--m[--[ h ]--4]
                ];
        end end 
      end else do
        return merge$2(l, r);
      end end 
    end else if (c < 0) then do
      var ll = update$1(x, f, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$1(ll, v, d, r);
      end end 
    end else do
      var rr = update$1(x, f, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    var match$1 = Curry._1(f, undefined);
    if (match$1 ~= undefined) then do
      return --[ Node ]--[
              --[ l : Empty ]--0,
              --[ v ]--x,
              --[ d ]--Caml_option.valFromOption(match$1),
              --[ r : Empty ]--0,
              --[ h ]--1
            ];
    end else do
      return --[ Empty ]--0;
    end end 
  end end 
end

function iter$1(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      iter$1(f, param[--[ l ]--0]);
      Curry._2(f, param[--[ v ]--1], param[--[ d ]--2]);
      _param = param[--[ r ]--3];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function map$1(f, param) do
  if (param) then do
    var l$prime = map$1(f, param[--[ l ]--0]);
    var d$prime = Curry._1(f, param[--[ d ]--2]);
    var r$prime = map$1(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--param[--[ v ]--1],
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function mapi$1(f, param) do
  if (param) then do
    var v = param[--[ v ]--1];
    var l$prime = mapi$1(f, param[--[ l ]--0]);
    var d$prime = Curry._2(f, v, param[--[ d ]--2]);
    var r$prime = mapi$1(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--v,
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function fold$1(f, _m, _accu) do
  while(true) do
    var accu = _accu;
    var m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[ v ]--1], m[--[ d ]--2], fold$1(f, m[--[ l ]--0], accu));
      _m = m[--[ r ]--3];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function for_all$1(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) and for_all$1(p, param[--[ l ]--0])) then do
        _param = param[--[ r ]--3];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function exists$1(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) or exists$1(p, param[--[ l ]--0])) then do
        return true;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function add_min_binding$1(k, x, param) do
  if (param) then do
    return bal$1(add_min_binding$1(k, x, param[--[ l ]--0]), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
  end else do
    return singleton$1(k, x);
  end end 
end

function add_max_binding$1(k, x, param) do
  if (param) then do
    return bal$1(param[--[ l ]--0], param[--[ v ]--1], param[--[ d ]--2], add_max_binding$1(k, x, param[--[ r ]--3]));
  end else do
    return singleton$1(k, x);
  end end 
end

function join$1(l, v, d, r) do
  if (l) then do
    if (r) then do
      var rh = r[--[ h ]--4];
      var lh = l[--[ h ]--4];
      if (lh > (rh + 2 | 0)) then do
        return bal$1(l[--[ l ]--0], l[--[ v ]--1], l[--[ d ]--2], join$1(l[--[ r ]--3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal$1(join$1(l, v, d, r[--[ l ]--0]), r[--[ v ]--1], r[--[ d ]--2], r[--[ r ]--3]);
      end else do
        return create$1(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding$1(v, d, l);
    end end 
  end else do
    return add_min_binding$1(v, d, r);
  end end 
end

function concat$1(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding$1(t2);
      return join$1(t1, match[0], match[1], remove_min_binding$1(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function concat_or_join$1(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join$1(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat$1(t1, t2);
  end end 
end

function split$1(x, param) do
  if (param) then do
    var r = param[--[ r ]--3];
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var l = param[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[ tuple ]--[
              l,
              Caml_option.some(d),
              r
            ];
    end else if (c < 0) then do
      var match = split$1(x, l);
      return --[ tuple ]--[
              match[0],
              match[1],
              join$1(match[2], v, d, r)
            ];
    end else do
      var match$1 = split$1(x, r);
      return --[ tuple ]--[
              join$1(l, v, d, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end end  end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            undefined,
            --[ Empty ]--0
          ];
  end end 
end

function merge$3(f, s1, s2) do
  if (s1) then do
    var v1 = s1[--[ v ]--1];
    if (s1[--[ h ]--4] >= height$1(s2)) then do
      var match = split$1(v1, s2);
      return concat_or_join$1(merge$3(f, s1[--[ l ]--0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[ d ]--2]), match[1]), merge$3(f, s1[--[ r ]--3], match[2]));
    end
     end 
  end else if (!s2) then do
    return --[ Empty ]--0;
  end
   end  end 
  if (s2) then do
    var v2 = s2[--[ v ]--1];
    var match$1 = split$1(v2, s1);
    return concat_or_join$1(merge$3(f, match$1[0], s2[--[ l ]--0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[--[ d ]--2])), merge$3(f, match$1[2], s2[--[ r ]--3]));
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "map.ml",
            393,
            10
          ]
        ];
  end end 
end

function union$1(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      var d2 = s2[--[ d ]--2];
      var v2 = s2[--[ v ]--1];
      var d1 = s1[--[ d ]--2];
      var v1 = s1[--[ v ]--1];
      if (s1[--[ h ]--4] >= s2[--[ h ]--4]) then do
        var match = split$1(v1, s2);
        var d2$1 = match[1];
        var l = union$1(f, s1[--[ l ]--0], match[0]);
        var r = union$1(f, s1[--[ r ]--3], match[2]);
        if (d2$1 ~= undefined) then do
          return concat_or_join$1(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2$1)), r);
        end else do
          return join$1(l, v1, d1, r);
        end end 
      end else do
        var match$1 = split$1(v2, s1);
        var d1$1 = match$1[1];
        var l$1 = union$1(f, match$1[0], s2[--[ l ]--0]);
        var r$1 = union$1(f, match$1[2], s2[--[ r ]--3]);
        if (d1$1 ~= undefined) then do
          return concat_or_join$1(l$1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1$1), d2), r$1);
        end else do
          return join$1(l$1, v2, d2, r$1);
        end end 
      end end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end

function filter$1(p, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var l$prime = filter$1(p, l);
    var pvd = Curry._2(p, v, d);
    var r$prime = filter$1(p, r);
    if (pvd) then do
      if (l == l$prime and r == r$prime) then do
        return m;
      end else do
        return join$1(l$prime, v, d, r$prime);
      end end 
    end else do
      return concat$1(l$prime, r$prime);
    end end 
  end else do
    return --[ Empty ]--0;
  end end 
end

function partition$1(p, param) do
  if (param) then do
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var match = partition$1(p, param[--[ l ]--0]);
    var lf = match[1];
    var lt = match[0];
    var pvd = Curry._2(p, v, d);
    var match$1 = partition$1(p, param[--[ r ]--3]);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pvd) then do
      return --[ tuple ]--[
              join$1(lt, v, d, rt),
              concat$1(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concat$1(lt, rt),
              join$1(lf, v, d, rf)
            ];
    end end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            --[ Empty ]--0
          ];
  end end 
end

function cons_enum$1(_m, _e) do
  while(true) do
    var e = _e;
    var m = _m;
    if (m) then do
      _e = --[ More ]--[
        m[--[ v ]--1],
        m[--[ d ]--2],
        m[--[ r ]--3],
        e
      ];
      _m = m[--[ l ]--0];
      continue ;
    end else do
      return e;
    end end 
  end;
end

function compare$1(cmp, m1, m2) do
  var _e1 = cons_enum$1(m1, --[ End ]--0);
  var _e2 = cons_enum$1(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2) then do
        var c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          var c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) then do
            return c$1;
          end else do
            _e2 = cons_enum$1(e2[2], e2[3]);
            _e1 = cons_enum$1(e1[2], e1[3]);
            continue ;
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
end

function equal$1(cmp, m1, m2) do
  var _e1 = cons_enum$1(m1, --[ End ]--0);
  var _e2 = cons_enum$1(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2 and Caml_primitive.caml_string_compare(e1[0], e2[0]) == 0 and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum$1(e2[2], e2[3]);
        _e1 = cons_enum$1(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function cardinal$1(param) do
  if (param) then do
    return (cardinal$1(param[--[ l ]--0]) + 1 | 0) + cardinal$1(param[--[ r ]--3]) | 0;
  end else do
    return 0;
  end end 
end

function bindings_aux$1(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) then do
      _param = param[--[ l ]--0];
      _accu = --[ :: ]--[
        --[ tuple ]--[
          param[--[ v ]--1],
          param[--[ d ]--2]
        ],
        bindings_aux$1(accu, param[--[ r ]--3])
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function bindings$1(s) do
  return bindings_aux$1(--[ [] ]--0, s);
end

var Meths = do
  empty: --[ Empty ]--0,
  is_empty: is_empty$1,
  mem: mem$1,
  add: add$1,
  update: update$1,
  singleton: singleton$1,
  remove: remove$1,
  merge: merge$3,
  union: union$1,
  compare: compare$1,
  equal: equal$1,
  iter: iter$1,
  fold: fold$1,
  for_all: for_all$1,
  exists: exists$1,
  filter: filter$1,
  partition: partition$1,
  cardinal: cardinal$1,
  bindings: bindings$1,
  min_binding: min_binding$1,
  min_binding_opt: min_binding_opt$1,
  max_binding: max_binding$1,
  max_binding_opt: max_binding_opt$1,
  choose: min_binding$1,
  choose_opt: min_binding_opt$1,
  split: split$1,
  find: find$1,
  find_opt: find_opt$1,
  find_first: find_first$1,
  find_first_opt: find_first_opt$1,
  find_last: find_last$1,
  find_last_opt: find_last_opt$1,
  map: map$1,
  mapi: mapi$1
end;

function height$2(param) do
  if (param) then do
    return param[--[ h ]--4];
  end else do
    return 0;
  end end 
end

function create$2(l, x, d, r) do
  var hl = height$2(l);
  var hr = height$2(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end

function singleton$2(x, d) do
  return --[ Node ]--[
          --[ l : Empty ]--0,
          --[ v ]--x,
          --[ d ]--d,
          --[ r : Empty ]--0,
          --[ h ]--1
        ];
end

function bal$2(l, x, d, r) do
  var hl = l and l[--[ h ]--4] or 0;
  var hr = r and r[--[ h ]--4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height$2(ll) >= height$2(lr)) then do
        return create$2(ll, lv, ld, create$2(lr, x, d, r));
      end else if (lr) then do
        return create$2(create$2(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create$2(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height$2(rr) >= height$2(rl)) then do
        return create$2(create$2(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create$2(create$2(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create$2(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end

function is_empty$2(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end

function add$2(x, data, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end end 
    end else if (c < 0) then do
      var ll = add$2(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$2(ll, v, d, r);
      end end 
    end else do
      var rr = add$2(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end end 
end

function find$2(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_int_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first$2(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_first_opt$2(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ l ]--0];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--3];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_last$2(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_last_opt$2(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) then do
        var _v0 = v;
        var _d0 = param[--[ d ]--2];
        var f$1 = f;
        var _param$1 = param[--[ r ]--3];
        while(true) do
          var param$1 = _param$1;
          var d0 = _d0;
          var v0 = _v0;
          if (param$1) then do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) then do
              _param$1 = param$1[--[ r ]--3];
              _d0 = param$1[--[ d ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end end 
          end else do
            return --[ tuple ]--[
                    v0,
                    d0
                  ];
          end end 
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function find_opt$2(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_int_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return Caml_option.some(param[--[ d ]--2]);
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function mem$2(x, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var c = Caml_primitive.caml_int_compare(x, param[--[ v ]--1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[ l ]--0] or param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function min_binding$2(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function min_binding_opt$2(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var l = param[--[ l ]--0];
      if (l) then do
        _param = l;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function max_binding$2(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function max_binding_opt$2(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var r = param[--[ r ]--3];
      if (r) then do
        _param = r;
        continue ;
      end else do
        return --[ tuple ]--[
                param[--[ v ]--1],
                param[--[ d ]--2]
              ];
      end end 
    end else do
      return ;
    end end 
  end;
end

function remove_min_binding$2(param) do
  if (param) then do
    var l = param[--[ l ]--0];
    if (l) then do
      return bal$2(remove_min_binding$2(l), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
    end else do
      return param[--[ r ]--3];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Map.remove_min_elt"
        ];
  end end 
end

function merge$4(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding$2(t2);
      return bal$2(t1, match[0], match[1], remove_min_binding$2(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function remove$2(x, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return merge$4(l, r);
    end else if (c < 0) then do
      var ll = remove$2(x, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$2(ll, v, d, r);
      end end 
    end else do
      var rr = remove$2(x, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Empty ]--0;
  end end 
end

function update$2(x, f, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      var match = Curry._1(f, Caml_option.some(d));
      if (match ~= undefined) then do
        var data = Caml_option.valFromOption(match);
        if (d == data) then do
          return m;
        end else do
          return --[ Node ]--[
                  --[ l ]--l,
                  --[ v ]--x,
                  --[ d ]--data,
                  --[ r ]--r,
                  --[ h ]--m[--[ h ]--4]
                ];
        end end 
      end else do
        return merge$4(l, r);
      end end 
    end else if (c < 0) then do
      var ll = update$2(x, f, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$2(ll, v, d, r);
      end end 
    end else do
      var rr = update$2(x, f, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    var match$1 = Curry._1(f, undefined);
    if (match$1 ~= undefined) then do
      return --[ Node ]--[
              --[ l : Empty ]--0,
              --[ v ]--x,
              --[ d ]--Caml_option.valFromOption(match$1),
              --[ r : Empty ]--0,
              --[ h ]--1
            ];
    end else do
      return --[ Empty ]--0;
    end end 
  end end 
end

function iter$2(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      iter$2(f, param[--[ l ]--0]);
      Curry._2(f, param[--[ v ]--1], param[--[ d ]--2]);
      _param = param[--[ r ]--3];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function map$2(f, param) do
  if (param) then do
    var l$prime = map$2(f, param[--[ l ]--0]);
    var d$prime = Curry._1(f, param[--[ d ]--2]);
    var r$prime = map$2(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--param[--[ v ]--1],
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function mapi$2(f, param) do
  if (param) then do
    var v = param[--[ v ]--1];
    var l$prime = mapi$2(f, param[--[ l ]--0]);
    var d$prime = Curry._2(f, v, param[--[ d ]--2]);
    var r$prime = mapi$2(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--v,
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end end 
end

function fold$2(f, _m, _accu) do
  while(true) do
    var accu = _accu;
    var m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[ v ]--1], m[--[ d ]--2], fold$2(f, m[--[ l ]--0], accu));
      _m = m[--[ r ]--3];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function for_all$2(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) and for_all$2(p, param[--[ l ]--0])) then do
        _param = param[--[ r ]--3];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function exists$2(p, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      if (Curry._2(p, param[--[ v ]--1], param[--[ d ]--2]) or exists$2(p, param[--[ l ]--0])) then do
        return true;
      end else do
        _param = param[--[ r ]--3];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function add_min_binding$2(k, x, param) do
  if (param) then do
    return bal$2(add_min_binding$2(k, x, param[--[ l ]--0]), param[--[ v ]--1], param[--[ d ]--2], param[--[ r ]--3]);
  end else do
    return singleton$2(k, x);
  end end 
end

function add_max_binding$2(k, x, param) do
  if (param) then do
    return bal$2(param[--[ l ]--0], param[--[ v ]--1], param[--[ d ]--2], add_max_binding$2(k, x, param[--[ r ]--3]));
  end else do
    return singleton$2(k, x);
  end end 
end

function join$2(l, v, d, r) do
  if (l) then do
    if (r) then do
      var rh = r[--[ h ]--4];
      var lh = l[--[ h ]--4];
      if (lh > (rh + 2 | 0)) then do
        return bal$2(l[--[ l ]--0], l[--[ v ]--1], l[--[ d ]--2], join$2(l[--[ r ]--3], v, d, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal$2(join$2(l, v, d, r[--[ l ]--0]), r[--[ v ]--1], r[--[ d ]--2], r[--[ r ]--3]);
      end else do
        return create$2(l, v, d, r);
      end end  end 
    end else do
      return add_max_binding$2(v, d, l);
    end end 
  end else do
    return add_min_binding$2(v, d, r);
  end end 
end

function concat$2(t1, t2) do
  if (t1) then do
    if (t2) then do
      var match = min_binding$2(t2);
      return join$2(t1, match[0], match[1], remove_min_binding$2(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function concat_or_join$2(t1, v, d, t2) do
  if (d ~= undefined) then do
    return join$2(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat$2(t1, t2);
  end end 
end

function split$2(x, param) do
  if (param) then do
    var r = param[--[ r ]--3];
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var l = param[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[ tuple ]--[
              l,
              Caml_option.some(d),
              r
            ];
    end else if (c < 0) then do
      var match = split$2(x, l);
      return --[ tuple ]--[
              match[0],
              match[1],
              join$2(match[2], v, d, r)
            ];
    end else do
      var match$1 = split$2(x, r);
      return --[ tuple ]--[
              join$2(l, v, d, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end end  end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            undefined,
            --[ Empty ]--0
          ];
  end end 
end

function merge$5(f, s1, s2) do
  if (s1) then do
    var v1 = s1[--[ v ]--1];
    if (s1[--[ h ]--4] >= height$2(s2)) then do
      var match = split$2(v1, s2);
      return concat_or_join$2(merge$5(f, s1[--[ l ]--0], match[0]), v1, Curry._3(f, v1, Caml_option.some(s1[--[ d ]--2]), match[1]), merge$5(f, s1[--[ r ]--3], match[2]));
    end
     end 
  end else if (!s2) then do
    return --[ Empty ]--0;
  end
   end  end 
  if (s2) then do
    var v2 = s2[--[ v ]--1];
    var match$1 = split$2(v2, s1);
    return concat_or_join$2(merge$5(f, match$1[0], s2[--[ l ]--0]), v2, Curry._3(f, v2, match$1[1], Caml_option.some(s2[--[ d ]--2])), merge$5(f, match$1[2], s2[--[ r ]--3]));
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "map.ml",
            393,
            10
          ]
        ];
  end end 
end

function union$2(f, s1, s2) do
  if (s1) then do
    if (s2) then do
      var d2 = s2[--[ d ]--2];
      var v2 = s2[--[ v ]--1];
      var d1 = s1[--[ d ]--2];
      var v1 = s1[--[ v ]--1];
      if (s1[--[ h ]--4] >= s2[--[ h ]--4]) then do
        var match = split$2(v1, s2);
        var d2$1 = match[1];
        var l = union$2(f, s1[--[ l ]--0], match[0]);
        var r = union$2(f, s1[--[ r ]--3], match[2]);
        if (d2$1 ~= undefined) then do
          return concat_or_join$2(l, v1, Curry._3(f, v1, d1, Caml_option.valFromOption(d2$1)), r);
        end else do
          return join$2(l, v1, d1, r);
        end end 
      end else do
        var match$1 = split$2(v2, s1);
        var d1$1 = match$1[1];
        var l$1 = union$2(f, match$1[0], s2[--[ l ]--0]);
        var r$1 = union$2(f, match$1[2], s2[--[ r ]--3]);
        if (d1$1 ~= undefined) then do
          return concat_or_join$2(l$1, v2, Curry._3(f, v2, Caml_option.valFromOption(d1$1), d2), r$1);
        end else do
          return join$2(l$1, v2, d2, r$1);
        end end 
      end end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end

function filter$2(p, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var l$prime = filter$2(p, l);
    var pvd = Curry._2(p, v, d);
    var r$prime = filter$2(p, r);
    if (pvd) then do
      if (l == l$prime and r == r$prime) then do
        return m;
      end else do
        return join$2(l$prime, v, d, r$prime);
      end end 
    end else do
      return concat$2(l$prime, r$prime);
    end end 
  end else do
    return --[ Empty ]--0;
  end end 
end

function partition$2(p, param) do
  if (param) then do
    var d = param[--[ d ]--2];
    var v = param[--[ v ]--1];
    var match = partition$2(p, param[--[ l ]--0]);
    var lf = match[1];
    var lt = match[0];
    var pvd = Curry._2(p, v, d);
    var match$1 = partition$2(p, param[--[ r ]--3]);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pvd) then do
      return --[ tuple ]--[
              join$2(lt, v, d, rt),
              concat$2(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concat$2(lt, rt),
              join$2(lf, v, d, rf)
            ];
    end end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            --[ Empty ]--0
          ];
  end end 
end

function cons_enum$2(_m, _e) do
  while(true) do
    var e = _e;
    var m = _m;
    if (m) then do
      _e = --[ More ]--[
        m[--[ v ]--1],
        m[--[ d ]--2],
        m[--[ r ]--3],
        e
      ];
      _m = m[--[ l ]--0];
      continue ;
    end else do
      return e;
    end end 
  end;
end

function compare$2(cmp, m1, m2) do
  var _e1 = cons_enum$2(m1, --[ End ]--0);
  var _e2 = cons_enum$2(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2) then do
        var c = Caml_primitive.caml_int_compare(e1[0], e2[0]);
        if (c ~= 0) then do
          return c;
        end else do
          var c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) then do
            return c$1;
          end else do
            _e2 = cons_enum$2(e2[2], e2[3]);
            _e1 = cons_enum$2(e1[2], e1[3]);
            continue ;
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
end

function equal$2(cmp, m1, m2) do
  var _e1 = cons_enum$2(m1, --[ End ]--0);
  var _e2 = cons_enum$2(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) then do
      if (e2 and e1[0] == e2[0] and Curry._2(cmp, e1[1], e2[1])) then do
        _e2 = cons_enum$2(e2[2], e2[3]);
        _e1 = cons_enum$2(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function cardinal$2(param) do
  if (param) then do
    return (cardinal$2(param[--[ l ]--0]) + 1 | 0) + cardinal$2(param[--[ r ]--3]) | 0;
  end else do
    return 0;
  end end 
end

function bindings_aux$2(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) then do
      _param = param[--[ l ]--0];
      _accu = --[ :: ]--[
        --[ tuple ]--[
          param[--[ v ]--1],
          param[--[ d ]--2]
        ],
        bindings_aux$2(accu, param[--[ r ]--3])
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function bindings$2(s) do
  return bindings_aux$2(--[ [] ]--0, s);
end

var Labs = do
  empty: --[ Empty ]--0,
  is_empty: is_empty$2,
  mem: mem$2,
  add: add$2,
  update: update$2,
  singleton: singleton$2,
  remove: remove$2,
  merge: merge$5,
  union: union$2,
  compare: compare$2,
  equal: equal$2,
  iter: iter$2,
  fold: fold$2,
  for_all: for_all$2,
  exists: exists$2,
  filter: filter$2,
  partition: partition$2,
  cardinal: cardinal$2,
  bindings: bindings$2,
  min_binding: min_binding$2,
  min_binding_opt: min_binding_opt$2,
  max_binding: max_binding$2,
  max_binding_opt: max_binding_opt$2,
  choose: min_binding$2,
  choose_opt: min_binding_opt$2,
  split: split$2,
  find: find$2,
  find_opt: find_opt$2,
  find_first: find_first$2,
  find_first_opt: find_first_opt$2,
  find_last: find_last$2,
  find_last_opt: find_last_opt$2,
  map: map$2,
  mapi: mapi$2
end;

var dummy_table = do
  size: 0,
  methods: [--[ () ]--0],
  methods_by_name: --[ Empty ]--0,
  methods_by_label: --[ Empty ]--0,
  previous_states: --[ [] ]--0,
  hidden_meths: --[ [] ]--0,
  vars: --[ Empty ]--0,
  initializers: --[ [] ]--0
end;

var table_count = do
  contents: 0
end;

var dummy_met = --[ obj_block ]--[];

function fit_size(n) do
  if (n <= 2) then do
    return n;
  end else do
    return (fit_size((n + 1 | 0) / 2 | 0) << 1);
  end end 
end

function new_table(pub_labels) do
  table_count.contents = table_count.contents + 1 | 0;
  var len = #pub_labels;
  var methods = Caml_array.caml_make_vect((len << 1) + 2 | 0, dummy_met);
  Caml_array.caml_array_set(methods, 0, len);
  Caml_array.caml_array_set(methods, 1, (Caml_int32.imul(fit_size(len), Sys.word_size) / 8 | 0) - 1 | 0);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    Caml_array.caml_array_set(methods, (i << 1) + 3 | 0, Caml_array.caml_array_get(pub_labels, i));
  end
  return do
          size: 2,
          methods: methods,
          methods_by_name: --[ Empty ]--0,
          methods_by_label: --[ Empty ]--0,
          previous_states: --[ [] ]--0,
          hidden_meths: --[ [] ]--0,
          vars: --[ Empty ]--0,
          initializers: --[ [] ]--0
        end;
end

function resize(array, new_size) do
  var old_size = #array.methods;
  if (new_size > old_size) then do
    var new_buck = Caml_array.caml_make_vect(new_size, dummy_met);
    $$Array.blit(array.methods, 0, new_buck, 0, old_size);
    array.methods = new_buck;
    return --[ () ]--0;
  end else do
    return 0;
  end end 
end

function put(array, label, element) do
  resize(array, label + 1 | 0);
  return Caml_array.caml_array_set(array.methods, label, element);
end

var method_count = do
  contents: 0
end;

var inst_var_count = do
  contents: 0
end;

function new_method(table) do
  var index = #table.methods;
  resize(table, index + 1 | 0);
  return index;
end

function get_method_label(table, name) do
  try do
    return find$1(name, table.methods_by_name);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var label = new_method(table);
      table.methods_by_name = add$1(name, label, table.methods_by_name);
      table.methods_by_label = add$2(label, true, table.methods_by_label);
      return label;
    end else do
      throw exn;
    end end 
  end
end

function get_method_labels(table, names) do
  return $$Array.map((function (param) do
                return get_method_label(table, param);
              end), names);
end

function set_method(table, label, element) do
  method_count.contents = method_count.contents + 1 | 0;
  if (find$2(label, table.methods_by_label)) then do
    return put(table, label, element);
  end else do
    table.hidden_meths = --[ :: ]--[
      --[ tuple ]--[
        label,
        element
      ],
      table.hidden_meths
    ];
    return --[ () ]--0;
  end end 
end

function get_method(table, label) do
  try do
    return List.assoc(label, table.hidden_meths);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return Caml_array.caml_array_get(table.methods, label);
    end else do
      throw exn;
    end end 
  end
end

function to_list(arr) do
  if (arr == 0) then do
    return --[ [] ]--0;
  end else do
    return $$Array.to_list(arr);
  end end 
end

function narrow(table, vars, virt_meths, concr_meths) do
  var vars$1 = to_list(vars);
  var virt_meths$1 = to_list(virt_meths);
  var concr_meths$1 = to_list(concr_meths);
  var virt_meth_labs = List.map((function (param) do
          return get_method_label(table, param);
        end), virt_meths$1);
  var concr_meth_labs = List.map((function (param) do
          return get_method_label(table, param);
        end), concr_meths$1);
  table.previous_states = --[ :: ]--[
    --[ tuple ]--[
      table.methods_by_name,
      table.methods_by_label,
      table.hidden_meths,
      table.vars,
      virt_meth_labs,
      vars$1
    ],
    table.previous_states
  ];
  table.vars = fold((function (lab, info, tvars) do
          if (List.mem(lab, vars$1)) then do
            return add(lab, info, tvars);
          end else do
            return tvars;
          end end 
        end), table.vars, --[ Empty ]--0);
  var by_name = do
    contents: --[ Empty ]--0
  end;
  var by_label = do
    contents: --[ Empty ]--0
  end;
  List.iter2((function (met, label) do
          by_name.contents = add$1(met, label, by_name.contents);
          var tmp;
          try do
            tmp = find$2(label, table.methods_by_label);
          end
          catch (exn)do
            if (exn == Caml_builtin_exceptions.not_found) then do
              tmp = true;
            end else do
              throw exn;
            end end 
          end
          by_label.contents = add$2(label, tmp, by_label.contents);
          return --[ () ]--0;
        end), concr_meths$1, concr_meth_labs);
  List.iter2((function (met, label) do
          by_name.contents = add$1(met, label, by_name.contents);
          by_label.contents = add$2(label, false, by_label.contents);
          return --[ () ]--0;
        end), virt_meths$1, virt_meth_labs);
  table.methods_by_name = by_name.contents;
  table.methods_by_label = by_label.contents;
  table.hidden_meths = List.fold_right((function (met, hm) do
          if (List.mem(met[0], virt_meth_labs)) then do
            return hm;
          end else do
            return --[ :: ]--[
                    met,
                    hm
                  ];
          end end 
        end), table.hidden_meths, --[ [] ]--0);
  return --[ () ]--0;
end

function widen(table) do
  var match = List.hd(table.previous_states);
  var virt_meths = match[4];
  table.previous_states = List.tl(table.previous_states);
  table.vars = List.fold_left((function (s, v) do
          return add(v, find(v, table.vars), s);
        end), match[3], match[5]);
  table.methods_by_name = match[0];
  table.methods_by_label = match[1];
  table.hidden_meths = List.fold_right((function (met, hm) do
          if (List.mem(met[0], virt_meths)) then do
            return hm;
          end else do
            return --[ :: ]--[
                    met,
                    hm
                  ];
          end end 
        end), table.hidden_meths, match[2]);
  return --[ () ]--0;
end

function new_slot(table) do
  var index = table.size;
  table.size = index + 1 | 0;
  return index;
end

function new_variable(table, name) do
  try do
    return find(name, table.vars);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var index = new_slot(table);
      if (name ~= "") then do
        table.vars = add(name, index, table.vars);
      end
       end 
      return index;
    end else do
      throw exn;
    end end 
  end
end

function to_array(arr) do
  if (Caml_obj.caml_equal(arr, 0)) then do
    return [];
  end else do
    return arr;
  end end 
end

function new_methods_variables(table, meths, vals) do
  var meths$1 = to_array(meths);
  var nmeths = #meths$1;
  var nvals = #vals;
  var res = Caml_array.caml_make_vect(nmeths + nvals | 0, 0);
  for(var i = 0 ,i_finish = nmeths - 1 | 0; i <= i_finish; ++i)do
    Caml_array.caml_array_set(res, i, get_method_label(table, Caml_array.caml_array_get(meths$1, i)));
  end
  for(var i$1 = 0 ,i_finish$1 = nvals - 1 | 0; i$1 <= i_finish$1; ++i$1)do
    Caml_array.caml_array_set(res, i$1 + nmeths | 0, new_variable(table, Caml_array.caml_array_get(vals, i$1)));
  end
  return res;
end

function get_variable(table, name) do
  try do
    return find(name, table.vars);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "test_internalOO.ml",
              280,
              50
            ]
          ];
    end
     end 
    throw exn;
  end
end

function get_variables(table, names) do
  return $$Array.map((function (param) do
                return get_variable(table, param);
              end), names);
end

function add_initializer(table, f) do
  table.initializers = --[ :: ]--[
    f,
    table.initializers
  ];
  return --[ () ]--0;
end

function create_table(public_methods) do
  if (public_methods == 0) then do
    return new_table([]);
  end else do
    var tags = $$Array.map(public_method_label, public_methods);
    var table = new_table(tags);
    $$Array.iteri((function (i, met) do
            var lab = (i << 1) + 2 | 0;
            table.methods_by_name = add$1(met, lab, table.methods_by_name);
            table.methods_by_label = add$2(lab, true, table.methods_by_label);
            return --[ () ]--0;
          end), public_methods);
    return table;
  end end 
end

function init_class(table) do
  inst_var_count.contents = (inst_var_count.contents + table.size | 0) - 1 | 0;
  table.initializers = List.rev(table.initializers);
  return resize(table, 3 + Caml_int32.div((Caml_array.caml_array_get(table.methods, 1) << 4), Sys.word_size) | 0);
end

function inherits(cla, vals, virt_meths, concr_meths, param, top) do
  var $$super = param[1];
  narrow(cla, vals, virt_meths, concr_meths);
  var init = top and Curry._2($$super, cla, param[3]) or Curry._1($$super, cla);
  widen(cla);
  return Caml_array.caml_array_concat(--[ :: ]--[
              [init],
              --[ :: ]--[
                $$Array.map((function (param) do
                        return get_variable(cla, param);
                      end), to_array(vals)),
                --[ :: ]--[
                  $$Array.map((function (nm) do
                          return get_method(cla, get_method_label(cla, nm));
                        end), to_array(concr_meths)),
                  --[ [] ]--0
                ]
              ]
            ]);
end

function make_class(pub_meths, class_init) do
  var table = create_table(pub_meths);
  var env_init = Curry._1(class_init, table);
  init_class(table);
  return --[ tuple ]--[
          Curry._1(env_init, 0),
          class_init,
          env_init,
          0
        ];
end

function make_class_store(pub_meths, class_init, init_table) do
  var table = create_table(pub_meths);
  var env_init = Curry._1(class_init, table);
  init_class(table);
  init_table.class_init = class_init;
  init_table.env_init = env_init;
  return --[ () ]--0;
end

function dummy_class(loc) do
  var undef = function (param) do
    throw [
          Caml_builtin_exceptions.undefined_recursive_module,
          loc
        ];
  end;
  return --[ tuple ]--[
          undef,
          undef,
          undef,
          0
        ];
end

function create_object(table) do
  var obj = Caml_obj.caml_obj_block(Obj.object_tag, table.size);
  obj[0] = table.methods;
  return Caml_exceptions.caml_set_oo_id(obj);
end

function create_object_opt(obj_0, table) do
  if (obj_0) then do
    return obj_0;
  end else do
    var obj = Caml_obj.caml_obj_block(Obj.object_tag, table.size);
    obj[0] = table.methods;
    return Caml_exceptions.caml_set_oo_id(obj);
  end end 
end

function iter_f(obj, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      Curry._1(param[0], obj);
      _param = param[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function run_initializers(obj, table) do
  var inits = table.initializers;
  if (inits ~= --[ [] ]--0) then do
    return iter_f(obj, inits);
  end else do
    return 0;
  end end 
end

function run_initializers_opt(obj_0, obj, table) do
  if (obj_0) then do
    return obj;
  end else do
    var inits = table.initializers;
    if (inits ~= --[ [] ]--0) then do
      iter_f(obj, inits);
    end
     end 
    return obj;
  end end 
end

function create_object_and_run_initializers(obj_0, table) do
  if (obj_0) then do
    return obj_0;
  end else do
    var obj = create_object(table);
    run_initializers(obj, table);
    return obj;
  end end 
end

function build_path(n, keys, tables) do
  var res = do
    key: 0,
    data: --[ Empty ]--0,
    next: --[ Empty ]--0
  end;
  var r = res;
  for(var i = 0; i <= n; ++i)do
    r = --[ Cons ]--[
      Caml_array.caml_array_get(keys, i),
      r,
      --[ Empty ]--0
    ];
  end
  tables.data = r;
  return res;
end

function lookup_keys(i, keys, tables) do
  if (i < 0) then do
    return tables;
  end else do
    var key = Caml_array.caml_array_get(keys, i);
    var _tables = tables;
    while(true) do
      var tables$1 = _tables;
      if (tables$1.key == key) then do
        return lookup_keys(i - 1 | 0, keys, tables$1.data);
      end else if (tables$1.next ~= --[ Empty ]--0) then do
        _tables = tables$1.next;
        continue ;
      end else do
        var next = --[ Cons ]--[
          key,
          --[ Empty ]--0,
          --[ Empty ]--0
        ];
        tables$1.next = next;
        return build_path(i - 1 | 0, keys, next);
      end end  end 
    end;
  end end 
end

function lookup_tables(root, keys) do
  if (root.data ~= --[ Empty ]--0) then do
    return lookup_keys(#keys - 1 | 0, keys, root.data);
  end else do
    return build_path(#keys - 1 | 0, keys, root);
  end end 
end

function get_const(x) do
  return (function (obj) do
      return x;
    end);
end

function get_var(n) do
  return (function (obj) do
      return obj[n];
    end);
end

function get_env(e, n) do
  return (function (obj) do
      return obj[e][n];
    end);
end

function get_meth(n) do
  return (function (obj) do
      return Curry._1(obj[0][n], obj);
    end);
end

function set_var(n) do
  return (function (obj, x) do
      obj[n] = x;
      return --[ () ]--0;
    end);
end

function app_const(f, x) do
  return (function (obj) do
      return Curry._1(f, x);
    end);
end

function app_var(f, n) do
  return (function (obj) do
      return Curry._1(f, obj[n]);
    end);
end

function app_env(f, e, n) do
  return (function (obj) do
      return Curry._1(f, obj[e][n]);
    end);
end

function app_meth(f, n) do
  return (function (obj) do
      return Curry._1(f, Curry._1(obj[0][n], obj));
    end);
end

function app_const_const(f, x, y) do
  return (function (obj) do
      return Curry._2(f, x, y);
    end);
end

function app_const_var(f, x, n) do
  return (function (obj) do
      return Curry._2(f, x, obj[n]);
    end);
end

function app_const_meth(f, x, n) do
  return (function (obj) do
      return Curry._2(f, x, Curry._1(obj[0][n], obj));
    end);
end

function app_var_const(f, n, x) do
  return (function (obj) do
      return Curry._2(f, obj[n], x);
    end);
end

function app_meth_const(f, n, x) do
  return (function (obj) do
      return Curry._2(f, Curry._1(obj[0][n], obj), x);
    end);
end

function app_const_env(f, x, e, n) do
  return (function (obj) do
      return Curry._2(f, x, obj[e][n]);
    end);
end

function app_env_const(f, e, n, x) do
  return (function (obj) do
      return Curry._2(f, obj[e][n], x);
    end);
end

function meth_app_const(n, x) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, x);
    end);
end

function meth_app_var(n, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, obj[m]);
    end);
end

function meth_app_env(n, e, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, obj[e][m]);
    end);
end

function meth_app_meth(n, m) do
  return (function (obj) do
      return Curry._2(obj[0][n], obj, Curry._1(obj[0][m], obj));
    end);
end

function send_const(m, x, c) do
  return (function (obj) do
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, x, m, 1), x);
    end);
end

function send_var(m, n, c) do
  return (function (obj) do
      var tmp = obj[n];
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 2), tmp);
    end);
end

function send_env(m, e, n, c) do
  return (function (obj) do
      var tmp = obj[e][n];
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 3), tmp);
    end);
end

function send_meth(m, n, c) do
  return (function (obj) do
      var tmp = Curry._1(obj[0][n], obj);
      return Curry._1(Curry._3(Caml_oo.caml_get_public_method, tmp, m, 4), tmp);
    end);
end

function new_cache(table) do
  var n = new_method(table);
  var n$1 = n % 2 == 0 or n > (2 + Caml_int32.div((Caml_array.caml_array_get(table.methods, 1) << 4), Sys.word_size) | 0) and n or new_method(table);
  Caml_array.caml_array_set(table.methods, n$1, 0);
  return n$1;
end

function method_impl(table, i, arr) do
  var next = function (param) do
    i.contents = i.contents + 1 | 0;
    return Caml_array.caml_array_get(arr, i.contents);
  end;
  var clo = next(--[ () ]--0);
  if (typeof clo == "number") then do
    local ___conditional___=(clo);
    do
       if ___conditional___ = 0--[ GetConst ]-- then do
          var x = next(--[ () ]--0);
          return (function (obj) do
              return x;
            end);end end end 
       if ___conditional___ = 1--[ GetVar ]-- then do
          var n = next(--[ () ]--0);
          return (function (obj) do
              return obj[n];
            end);end end end 
       if ___conditional___ = 2--[ GetEnv ]-- then do
          var e = next(--[ () ]--0);
          var n$1 = next(--[ () ]--0);
          return get_env(e, n$1);end end end 
       if ___conditional___ = 3--[ GetMeth ]-- then do
          return get_meth(next(--[ () ]--0));end end end 
       if ___conditional___ = 4--[ SetVar ]-- then do
          var n$2 = next(--[ () ]--0);
          return (function (obj, x) do
              obj[n$2] = x;
              return --[ () ]--0;
            end);end end end 
       if ___conditional___ = 5--[ AppConst ]-- then do
          var f = next(--[ () ]--0);
          var x$1 = next(--[ () ]--0);
          return (function (obj) do
              return Curry._1(f, x$1);
            end);end end end 
       if ___conditional___ = 6--[ AppVar ]-- then do
          var f$1 = next(--[ () ]--0);
          var n$3 = next(--[ () ]--0);
          return (function (obj) do
              return Curry._1(f$1, obj[n$3]);
            end);end end end 
       if ___conditional___ = 7--[ AppEnv ]-- then do
          var f$2 = next(--[ () ]--0);
          var e$1 = next(--[ () ]--0);
          var n$4 = next(--[ () ]--0);
          return app_env(f$2, e$1, n$4);end end end 
       if ___conditional___ = 8--[ AppMeth ]-- then do
          var f$3 = next(--[ () ]--0);
          var n$5 = next(--[ () ]--0);
          return app_meth(f$3, n$5);end end end 
       if ___conditional___ = 9--[ AppConstConst ]-- then do
          var f$4 = next(--[ () ]--0);
          var x$2 = next(--[ () ]--0);
          var y = next(--[ () ]--0);
          return (function (obj) do
              return Curry._2(f$4, x$2, y);
            end);end end end 
       if ___conditional___ = 10--[ AppConstVar ]-- then do
          var f$5 = next(--[ () ]--0);
          var x$3 = next(--[ () ]--0);
          var n$6 = next(--[ () ]--0);
          return app_const_var(f$5, x$3, n$6);end end end 
       if ___conditional___ = 11--[ AppConstEnv ]-- then do
          var f$6 = next(--[ () ]--0);
          var x$4 = next(--[ () ]--0);
          var e$2 = next(--[ () ]--0);
          var n$7 = next(--[ () ]--0);
          return app_const_env(f$6, x$4, e$2, n$7);end end end 
       if ___conditional___ = 12--[ AppConstMeth ]-- then do
          var f$7 = next(--[ () ]--0);
          var x$5 = next(--[ () ]--0);
          var n$8 = next(--[ () ]--0);
          return app_const_meth(f$7, x$5, n$8);end end end 
       if ___conditional___ = 13--[ AppVarConst ]-- then do
          var f$8 = next(--[ () ]--0);
          var n$9 = next(--[ () ]--0);
          var x$6 = next(--[ () ]--0);
          return app_var_const(f$8, n$9, x$6);end end end 
       if ___conditional___ = 14--[ AppEnvConst ]-- then do
          var f$9 = next(--[ () ]--0);
          var e$3 = next(--[ () ]--0);
          var n$10 = next(--[ () ]--0);
          var x$7 = next(--[ () ]--0);
          return app_env_const(f$9, e$3, n$10, x$7);end end end 
       if ___conditional___ = 15--[ AppMethConst ]-- then do
          var f$10 = next(--[ () ]--0);
          var n$11 = next(--[ () ]--0);
          var x$8 = next(--[ () ]--0);
          return app_meth_const(f$10, n$11, x$8);end end end 
       if ___conditional___ = 16--[ MethAppConst ]-- then do
          var n$12 = next(--[ () ]--0);
          var x$9 = next(--[ () ]--0);
          return meth_app_const(n$12, x$9);end end end 
       if ___conditional___ = 17--[ MethAppVar ]-- then do
          var n$13 = next(--[ () ]--0);
          var m = next(--[ () ]--0);
          return meth_app_var(n$13, m);end end end 
       if ___conditional___ = 18--[ MethAppEnv ]-- then do
          var n$14 = next(--[ () ]--0);
          var e$4 = next(--[ () ]--0);
          var m$1 = next(--[ () ]--0);
          return meth_app_env(n$14, e$4, m$1);end end end 
       if ___conditional___ = 19--[ MethAppMeth ]-- then do
          var n$15 = next(--[ () ]--0);
          var m$2 = next(--[ () ]--0);
          return meth_app_meth(n$15, m$2);end end end 
       if ___conditional___ = 20--[ SendConst ]-- then do
          var m$3 = next(--[ () ]--0);
          var x$10 = next(--[ () ]--0);
          return send_const(m$3, x$10, new_cache(table));end end end 
       if ___conditional___ = 21--[ SendVar ]-- then do
          var m$4 = next(--[ () ]--0);
          var n$16 = next(--[ () ]--0);
          return send_var(m$4, n$16, new_cache(table));end end end 
       if ___conditional___ = 22--[ SendEnv ]-- then do
          var m$5 = next(--[ () ]--0);
          var e$5 = next(--[ () ]--0);
          var n$17 = next(--[ () ]--0);
          return send_env(m$5, e$5, n$17, new_cache(table));end end end 
       if ___conditional___ = 23--[ SendMeth ]-- then do
          var m$6 = next(--[ () ]--0);
          var n$18 = next(--[ () ]--0);
          return send_meth(m$6, n$18, new_cache(table));end end end 
       do
      
    end
  end else do
    return clo;
  end end 
end

function set_methods(table, methods) do
  var len = #methods;
  var i = do
    contents: 0
  end;
  while(i.contents < len) do
    var label = Caml_array.caml_array_get(methods, i.contents);
    var clo = method_impl(table, i, methods);
    set_method(table, label, clo);
    i.contents = i.contents + 1 | 0;
  end;
  return --[ () ]--0;
end

function stats(param) do
  return do
          classes: table_count.contents,
          methods: method_count.contents,
          inst_vars: inst_var_count.contents
        end;
end

var initial_object_size = 2;

var dummy_item = --[ () ]--0;

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
--[ No side effect ]--
