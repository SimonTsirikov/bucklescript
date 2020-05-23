

import * as Curry from "./curry.js";
import * as Caml_obj from "./caml_obj.js";
import * as Caml_array from "./caml_array.js";
import * as Caml_exceptions from "./caml_exceptions.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

var make_float = Caml_array.caml_make_float_vect;

var Floatarray = { };

function init(l, f) do
  if (l == 0) then do
    return [];
  end else do
    if (l < 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Array.init"
          ];
    end
     end 
    var res = Caml_array.caml_make_vect(l, Curry._1(f, 0));
    for(var i = 1 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      res[i] = Curry._1(f, i);
    end
    return res;
  end end 
end

function make_matrix(sx, sy, init) do
  var res = Caml_array.caml_make_vect(sx, []);
  for(var x = 0 ,x_finish = sx - 1 | 0; x <= x_finish; ++x)do
    res[x] = Caml_array.caml_make_vect(sy, init);
  end
  return res;
end

function copy(a) do
  var l = #a;
  if (l == 0) then do
    return [];
  end else do
    return Caml_array.caml_array_sub(a, 0, l);
  end end 
end

function append(a1, a2) do
  var l1 = #a1;
  if (l1 == 0) then do
    return copy(a2);
  end else if (#a2 == 0) then do
    return Caml_array.caml_array_sub(a1, 0, l1);
  end else do
    return a1.concat(a2);
  end end  end 
end

function sub(a, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#a - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.sub"
        ];
  end
   end 
  return Caml_array.caml_array_sub(a, ofs, len);
end

function fill(a, ofs, len, v) do
  if (ofs < 0 or len < 0 or ofs > (#a - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.fill"
        ];
  end
   end 
  for(var i = ofs ,i_finish = (ofs + len | 0) - 1 | 0; i <= i_finish; ++i)do
    a[i] = v;
  end
  return --[ () ]--0;
end

function blit(a1, ofs1, a2, ofs2, len) do
  if (len < 0 or ofs1 < 0 or ofs1 > (#a1 - len | 0) or ofs2 < 0 or ofs2 > (#a2 - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.blit"
        ];
  end
   end 
  return Caml_array.caml_array_blit(a1, ofs1, a2, ofs2, len);
end

function iter(f, a) do
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    Curry._1(f, a[i]);
  end
  return --[ () ]--0;
end

function iter2(f, a, b) do
  if (#a ~= #b) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.iter2: arrays must have the same length"
        ];
  end
   end 
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    Curry._2(f, a[i], b[i]);
  end
  return --[ () ]--0;
end

function map(f, a) do
  var l = #a;
  if (l == 0) then do
    return [];
  end else do
    var r = Caml_array.caml_make_vect(l, Curry._1(f, a[0]));
    for(var i = 1 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = Curry._1(f, a[i]);
    end
    return r;
  end end 
end

function map2(f, a, b) do
  var la = #a;
  var lb = #b;
  if (la ~= lb) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.map2: arrays must have the same length"
        ];
  end
   end 
  if (la == 0) then do
    return [];
  end else do
    var r = Caml_array.caml_make_vect(la, Curry._2(f, a[0], b[0]));
    for(var i = 1 ,i_finish = la - 1 | 0; i <= i_finish; ++i)do
      r[i] = Curry._2(f, a[i], b[i]);
    end
    return r;
  end end 
end

function iteri(f, a) do
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    Curry._2(f, i, a[i]);
  end
  return --[ () ]--0;
end

function mapi(f, a) do
  var l = #a;
  if (l == 0) then do
    return [];
  end else do
    var r = Caml_array.caml_make_vect(l, Curry._2(f, 0, a[0]));
    for(var i = 1 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = Curry._2(f, i, a[i]);
    end
    return r;
  end end 
end

function to_list(a) do
  var _i = #a - 1 | 0;
  var _res = --[ [] ]--0;
  while(true) do
    var res = _res;
    var i = _i;
    if (i < 0) then do
      return res;
    end else do
      _res = --[ :: ]--[
        a[i],
        res
      ];
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end

function list_length(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) then do
      _param = param[1];
      _accu = accu + 1 | 0;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function of_list(l) do
  if (l) then do
    var a = Caml_array.caml_make_vect(list_length(0, l), l[0]);
    var _i = 1;
    var _param = l[1];
    while(true) do
      var param = _param;
      var i = _i;
      if (param) then do
        a[i] = param[0];
        _param = param[1];
        _i = i + 1 | 0;
        continue ;
      end else do
        return a;
      end end 
    end;
  end else do
    return [];
  end end 
end

function fold_left(f, x, a) do
  var r = x;
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    r = Curry._2(f, r, a[i]);
  end
  return r;
end

function fold_right(f, a, x) do
  var r = x;
  for(var i = #a - 1 | 0; i >= 0; --i)do
    r = Curry._2(f, a[i], r);
  end
  return r;
end

function exists(p, a) do
  var n = #a;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i == n) then do
      return false;
    end else if (Curry._1(p, a[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end

function for_all(p, a) do
  var n = #a;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i == n) then do
      return true;
    end else if (Curry._1(p, a[i])) then do
      _i = i + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end

function mem(x, a) do
  var n = #a;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i == n) then do
      return false;
    end else if (Caml_obj.caml_equal(a[i], x)) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end

function memq(x, a) do
  var n = #a;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i == n) then do
      return false;
    end else if (x == a[i]) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end

var Bottom = Caml_exceptions.create("Array.Bottom");

function sort(cmp, a) do
  var maxson = function (l, i) do
    var i31 = ((i + i | 0) + i | 0) + 1 | 0;
    var x = i31;
    if ((i31 + 2 | 0) < l) then do
      if (Curry._2(cmp, Caml_array.caml_array_get(a, i31), Caml_array.caml_array_get(a, i31 + 1 | 0)) < 0) then do
        x = i31 + 1 | 0;
      end
       end 
      if (Curry._2(cmp, Caml_array.caml_array_get(a, x), Caml_array.caml_array_get(a, i31 + 2 | 0)) < 0) then do
        x = i31 + 2 | 0;
      end
       end 
      return x;
    end else if ((i31 + 1 | 0) < l and Curry._2(cmp, Caml_array.caml_array_get(a, i31), Caml_array.caml_array_get(a, i31 + 1 | 0)) < 0) then do
      return i31 + 1 | 0;
    end else if (i31 < l) then do
      return i31;
    end else do
      throw [
            Bottom,
            i
          ];
    end end  end  end 
  end;
  var trickle = function (l, i, e) do
    try do
      var l$1 = l;
      var _i = i;
      var e$1 = e;
      while(true) do
        var i$1 = _i;
        var j = maxson(l$1, i$1);
        if (Curry._2(cmp, Caml_array.caml_array_get(a, j), e$1) > 0) then do
          Caml_array.caml_array_set(a, i$1, Caml_array.caml_array_get(a, j));
          _i = j;
          continue ;
        end else do
          return Caml_array.caml_array_set(a, i$1, e$1);
        end end 
      end;
    end
    catch (raw_exn)do
      var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Bottom) then do
        return Caml_array.caml_array_set(a, exn[1], e);
      end else do
        throw exn;
      end end 
    end
  end;
  var bubble = function (l, i) do
    try do
      var l$1 = l;
      var _i = i;
      while(true) do
        var i$1 = _i;
        var j = maxson(l$1, i$1);
        Caml_array.caml_array_set(a, i$1, Caml_array.caml_array_get(a, j));
        _i = j;
        continue ;
      end;
    end
    catch (raw_exn)do
      var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn[0] == Bottom) then do
        return exn[1];
      end else do
        throw exn;
      end end 
    end
  end;
  var trickleup = function (_i, e) do
    while(true) do
      var i = _i;
      var father = (i - 1 | 0) / 3 | 0;
      if (i == father) then do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "array.ml",
                238,
                4
              ]
            ];
      end
       end 
      if (Curry._2(cmp, Caml_array.caml_array_get(a, father), e) < 0) then do
        Caml_array.caml_array_set(a, i, Caml_array.caml_array_get(a, father));
        if (father > 0) then do
          _i = father;
          continue ;
        end else do
          return Caml_array.caml_array_set(a, 0, e);
        end end 
      end else do
        return Caml_array.caml_array_set(a, i, e);
      end end 
    end;
  end;
  var l = #a;
  for(var i = ((l + 1 | 0) / 3 | 0) - 1 | 0; i >= 0; --i)do
    trickle(l, i, Caml_array.caml_array_get(a, i));
  end
  for(var i$1 = l - 1 | 0; i$1 >= 2; --i$1)do
    var e = Caml_array.caml_array_get(a, i$1);
    Caml_array.caml_array_set(a, i$1, Caml_array.caml_array_get(a, 0));
    trickleup(bubble(i$1, 0), e);
  end
  if (l > 1) then do
    var e$1 = Caml_array.caml_array_get(a, 1);
    Caml_array.caml_array_set(a, 1, Caml_array.caml_array_get(a, 0));
    return Caml_array.caml_array_set(a, 0, e$1);
  end else do
    return 0;
  end end 
end

function stable_sort(cmp, a) do
  var merge = function (src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs) do
    var src1r = src1ofs + src1len | 0;
    var src2r = src2ofs + src2len | 0;
    var _i1 = src1ofs;
    var _s1 = Caml_array.caml_array_get(a, src1ofs);
    var _i2 = src2ofs;
    var _s2 = Caml_array.caml_array_get(src2, src2ofs);
    var _d = dstofs;
    while(true) do
      var d = _d;
      var s2 = _s2;
      var i2 = _i2;
      var s1 = _s1;
      var i1 = _i1;
      if (Curry._2(cmp, s1, s2) <= 0) then do
        Caml_array.caml_array_set(dst, d, s1);
        var i1$1 = i1 + 1 | 0;
        if (i1$1 < src1r) then do
          _d = d + 1 | 0;
          _s1 = Caml_array.caml_array_get(a, i1$1);
          _i1 = i1$1;
          continue ;
        end else do
          return blit(src2, i2, dst, d + 1 | 0, src2r - i2 | 0);
        end end 
      end else do
        Caml_array.caml_array_set(dst, d, s2);
        var i2$1 = i2 + 1 | 0;
        if (i2$1 < src2r) then do
          _d = d + 1 | 0;
          _s2 = Caml_array.caml_array_get(src2, i2$1);
          _i2 = i2$1;
          continue ;
        end else do
          return blit(a, i1, dst, d + 1 | 0, src1r - i1 | 0);
        end end 
      end end 
    end;
  end;
  var isortto = function (srcofs, dst, dstofs, len) do
    for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      var e = Caml_array.caml_array_get(a, srcofs + i | 0);
      var j = (dstofs + i | 0) - 1 | 0;
      while(j >= dstofs and Curry._2(cmp, Caml_array.caml_array_get(dst, j), e) > 0) do
        Caml_array.caml_array_set(dst, j + 1 | 0, Caml_array.caml_array_get(dst, j));
        j = j - 1 | 0;
      end;
      Caml_array.caml_array_set(dst, j + 1 | 0, e);
    end
    return --[ () ]--0;
  end;
  var sortto = function (srcofs, dst, dstofs, len) do
    if (len <= 5) then do
      return isortto(srcofs, dst, dstofs, len);
    end else do
      var l1 = len / 2 | 0;
      var l2 = len - l1 | 0;
      sortto(srcofs + l1 | 0, dst, dstofs + l1 | 0, l2);
      sortto(srcofs, a, srcofs + l2 | 0, l1);
      return merge(srcofs + l2 | 0, l1, dst, dstofs + l1 | 0, l2, dst, dstofs);
    end end 
  end;
  var l = #a;
  if (l <= 5) then do
    return isortto(0, a, 0, l);
  end else do
    var l1 = l / 2 | 0;
    var l2 = l - l1 | 0;
    var t = Caml_array.caml_make_vect(l2, Caml_array.caml_array_get(a, 0));
    sortto(l1, t, 0, l2);
    sortto(0, a, l2, l1);
    return merge(l2, l1, t, 0, l2, a, 0);
  end end 
end

var create_matrix = make_matrix;

var concat = Caml_array.caml_array_concat;

var fast_sort = stable_sort;

export do
  make_float ,
  init ,
  make_matrix ,
  create_matrix ,
  append ,
  concat ,
  sub ,
  copy ,
  fill ,
  blit ,
  to_list ,
  of_list ,
  iter ,
  iteri ,
  map ,
  mapi ,
  fold_left ,
  fold_right ,
  iter2 ,
  map2 ,
  for_all ,
  exists ,
  mem ,
  memq ,
  sort ,
  stable_sort ,
  fast_sort ,
  Floatarray ,
  
end
--[ No side effect ]--
