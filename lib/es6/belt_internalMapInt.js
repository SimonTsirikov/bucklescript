

import * as Curry from "./curry.js";
import * as Caml_option from "./caml_option.js";
import * as Belt_SortArray from "./belt_SortArray.js";
import * as Caml_primitive from "./caml_primitive.js";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.js";

function add(t, x, data) do
  if (t ~= null) then do
    var k = t.key;
    if (x == k) then do
      return Belt_internalAVLtree.updateValue(t, data);
    end else do
      var v = t.value;
      if (x < k) then do
        return Belt_internalAVLtree.bal(add(t.left, x, data), k, v, t.right);
      end else do
        return Belt_internalAVLtree.bal(t.left, k, v, add(t.right, x, data));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(x, data);
  end end 
end

function get(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.key;
      if (x == v) then do
        return Caml_option.some(n.value);
      end else do
        _n = x < v and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getUndefined(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getExn(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        continue ;
      end end 
    end else do
      throw new Error("getExn");
    end end 
  end;
end

function getWithDefault(_n, x, def) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        continue ;
      end end 
    end else do
      return def;
    end end 
  end;
end

function has(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.key;
      if (x == v) then do
        return true;
      end else do
        _n = x < v and n.left or n.right;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function remove(n, x) do
  if (n ~= null) then do
    var l = n.left;
    var v = n.key;
    var r = n.right;
    if (x == v) then do
      if (l ~= null) then do
        if (r ~= null) then do
          var kr = do
            contents: r.key
          end;
          var vr = do
            contents: r.value
          end;
          var r$1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
          return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r$1);
        end else do
          return l;
        end end 
      end else do
        return r;
      end end 
    end else if (x < v) then do
      return Belt_internalAVLtree.bal(remove(l, x), v, n.value, r);
    end else do
      return Belt_internalAVLtree.bal(l, v, n.value, remove(r, x));
    end end  end 
  end else do
    return n;
  end end 
end

function splitAux(x, n) do
  var l = n.left;
  var v = n.key;
  var d = n.value;
  var r = n.right;
  if (x == v) then do
    return --[ tuple ]--[
            l,
            Caml_option.some(d),
            r
          ];
  end else if (x < v) then do
    if (l ~= null) then do
      var match = splitAux(x, l);
      return --[ tuple ]--[
              match[0],
              match[1],
              Belt_internalAVLtree.join(match[2], v, d, r)
            ];
    end else do
      return --[ tuple ]--[
              null,
              undefined,
              n
            ];
    end end 
  end else if (r ~= null) then do
    var match$1 = splitAux(x, r);
    return --[ tuple ]--[
            Belt_internalAVLtree.join(l, v, d, match$1[0]),
            match$1[1],
            match$1[2]
          ];
  end else do
    return --[ tuple ]--[
            n,
            undefined,
            null
          ];
  end end  end  end 
end

function split(x, n) do
  if (n ~= null) then do
    return splitAux(x, n);
  end else do
    return --[ tuple ]--[
            null,
            undefined,
            null
          ];
  end end 
end

function mergeU(s1, s2, f) do
  if (s1 ~= null) then do
    if (s1.height >= (
        s2 ~= null and s2.height or 0
      )) then do
      var l1 = s1.left;
      var v1 = s1.key;
      var d1 = s1.value;
      var r1 = s1.right;
      var match = split(v1, s2);
      return Belt_internalAVLtree.concatOrJoin(mergeU(l1, match[0], f), v1, f(v1, Caml_option.some(d1), match[1]), mergeU(r1, match[2], f));
    end
     end 
  end else if (s2 == null) then do
    return null;
  end
   end  end 
  if (s2 ~= null) then do
    var l2 = s2.left;
    var v2 = s2.key;
    var d2 = s2.value;
    var r2 = s2.right;
    var match$1 = split(v2, s1);
    return Belt_internalAVLtree.concatOrJoin(mergeU(match$1[0], l2, f), v2, f(v2, match$1[1], Caml_option.some(d2)), mergeU(match$1[2], r2, f));
  end else do
    return --[ assert false ]--0;
  end end 
end

function merge(s1, s2, f) do
  return mergeU(s1, s2, Curry.__3(f));
end

function compareAux(_e1, _e2, vcmp) do
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1 and e2) then do
      var h2 = e2[0];
      var h1 = e1[0];
      var c = Caml_primitive.caml_int_compare(h1.key, h2.key);
      if (c == 0) then do
        var cx = vcmp(h1.value, h2.value);
        if (cx == 0) then do
          _e2 = Belt_internalAVLtree.stackAllLeft(h2.right, e2[1]);
          _e1 = Belt_internalAVLtree.stackAllLeft(h1.right, e1[1]);
          continue ;
        end else do
          return cx;
        end end 
      end else do
        return c;
      end end 
    end else do
      return 0;
    end end 
  end;
end

function cmpU(s1, s2, cmp) do
  var len1 = Belt_internalAVLtree.size(s1);
  var len2 = Belt_internalAVLtree.size(s2);
  if (len1 == len2) then do
    return compareAux(Belt_internalAVLtree.stackAllLeft(s1, --[ [] ]--0), Belt_internalAVLtree.stackAllLeft(s2, --[ [] ]--0), cmp);
  end else if (len1 < len2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end

function cmp(s1, s2, f) do
  return cmpU(s1, s2, Curry.__2(f));
end

function eqAux(_e1, _e2, eq) do
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1 and e2) then do
      var h2 = e2[0];
      var h1 = e1[0];
      if (h1.key == h2.key and eq(h1.value, h2.value)) then do
        _e2 = Belt_internalAVLtree.stackAllLeft(h2.right, e2[1]);
        _e1 = Belt_internalAVLtree.stackAllLeft(h1.right, e1[1]);
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function eqU(s1, s2, eq) do
  var len1 = Belt_internalAVLtree.size(s1);
  var len2 = Belt_internalAVLtree.size(s2);
  if (len1 == len2) then do
    return eqAux(Belt_internalAVLtree.stackAllLeft(s1, --[ [] ]--0), Belt_internalAVLtree.stackAllLeft(s2, --[ [] ]--0), eq);
  end else do
    return false;
  end end 
end

function eq(s1, s2, f) do
  return eqU(s1, s2, Curry.__2(f));
end

function addMutate(t, x, data) do
  if (t ~= null) then do
    var k = t.key;
    if (x == k) then do
      t.key = x;
      t.value = data;
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (x < k) then do
        var ll = addMutate(l, x, data);
        t.left = ll;
      end else do
        t.right = addMutate(r, x, data);
      end end 
      return Belt_internalAVLtree.balMutate(t);
    end end 
  end else do
    return Belt_internalAVLtree.singleton(x, data);
  end end 
end

function fromArray(xs) do
  var len = #xs;
  if (len == 0) then do
    return null;
  end else do
    var next = Belt_SortArray.strictlySortedLengthU(xs, (function (param, param$1) do
            return param[0] < param$1[0];
          end));
    var result;
    if (next >= 0) then do
      result = Belt_internalAVLtree.fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = Belt_internalAVLtree.fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for(var i = next ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      var match = xs[i];
      result = addMutate(result, match[0], match[1]);
    end
    return result;
  end end 
end

var N = --[ alias ]--0;

var A = --[ alias ]--0;

var S = --[ alias ]--0;

export do
  N ,
  A ,
  S ,
  add ,
  get ,
  getUndefined ,
  getExn ,
  getWithDefault ,
  has ,
  remove ,
  splitAux ,
  split ,
  mergeU ,
  merge ,
  compareAux ,
  cmpU ,
  cmp ,
  eqAux ,
  eqU ,
  eq ,
  addMutate ,
  fromArray ,
  
end
--[ No side effect ]--
