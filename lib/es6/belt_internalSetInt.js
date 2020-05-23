

import * as Belt_SortArrayInt from "./belt_SortArrayInt.js";
import * as Belt_internalAVLset from "./belt_internalAVLset.js";

function has(_t, x) do
  while(true) do
    var t = _t;
    if (t ~= null) do
      var v = t.value;
      if (x == v) do
        return true;
      end else do
        _t = x < v ? t.left : t.right;
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function compareAux(_e1, _e2) do
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1 and e2) do
      var h2 = e2[0];
      var h1 = e1[0];
      var k1 = h1.value;
      var k2 = h2.value;
      if (k1 == k2) do
        _e2 = Belt_internalAVLset.stackAllLeft(h2.right, e2[1]);
        _e1 = Belt_internalAVLset.stackAllLeft(h1.right, e1[1]);
        continue ;
      end else if (k1 < k2) do
        return -1;
      end else do
        return 1;
      end
    end else do
      return 0;
    end
  end;
end

function cmp(s1, s2) do
  var len1 = Belt_internalAVLset.size(s1);
  var len2 = Belt_internalAVLset.size(s2);
  if (len1 == len2) do
    return compareAux(Belt_internalAVLset.stackAllLeft(s1, --[ [] ]--0), Belt_internalAVLset.stackAllLeft(s2, --[ [] ]--0));
  end else if (len1 < len2) do
    return -1;
  end else do
    return 1;
  end
end

function eq(s1, s2) do
  return cmp(s1, s2) == 0;
end

function subset(_s1, _s2) do
  while(true) do
    var s2 = _s2;
    var s1 = _s1;
    if (s1 ~= null) do
      if (s2 ~= null) do
        var l1 = s1.left;
        var v1 = s1.value;
        var r1 = s1.right;
        var l2 = s2.left;
        var v2 = s2.value;
        var r2 = s2.right;
        if (v1 == v2) do
          if (subset(l1, l2)) do
            _s2 = r2;
            _s1 = r1;
            continue ;
          end else do
            return false;
          end
        end else if (v1 < v2) do
          if (subset(Belt_internalAVLset.create(l1, v1, null), l2)) do
            _s1 = r1;
            continue ;
          end else do
            return false;
          end
        end else if (subset(Belt_internalAVLset.create(null, v1, r1), r2)) do
          _s1 = l1;
          continue ;
        end else do
          return false;
        end
      end else do
        return false;
      end
    end else do
      return true;
    end
  end;
end

function get(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.value;
      if (x == v) do
        return v;
      end else do
        _n = x < v ? n.left : n.right;
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function getUndefined(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.value;
      if (x == v) do
        return v;
      end else do
        _n = x < v ? n.left : n.right;
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function getExn(_n, x) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.value;
      if (x == v) do
        return v;
      end else do
        _n = x < v ? n.left : n.right;
        continue ;
      end
    end else do
      throw new Error("getExn");
    end
  end;
end

function addMutate(t, x) do
  if (t ~= null) do
    var k = t.value;
    if (x == k) do
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (x < k) do
        t.left = addMutate(l, x);
      end else do
        t.right = addMutate(r, x);
      end
      return Belt_internalAVLset.balMutate(t);
    end
  end else do
    return Belt_internalAVLset.singleton(x);
  end
end

function fromArray(xs) do
  var len = #xs;
  if (len == 0) do
    return null;
  end else do
    var next = Belt_SortArrayInt.strictlySortedLength(xs);
    var result;
    if (next >= 0) do
      result = Belt_internalAVLset.fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = Belt_internalAVLset.fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end
    for(var i = next ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      result = addMutate(result, xs[i]);
    end
    return result;
  end
end

var S = --[ alias ]--0;

var N = --[ alias ]--0;

var A = --[ alias ]--0;

export do
  S ,
  N ,
  A ,
  has ,
  compareAux ,
  cmp ,
  eq ,
  subset ,
  get ,
  getUndefined ,
  getExn ,
  addMutate ,
  fromArray ,
  
end
--[ No side effect ]--
