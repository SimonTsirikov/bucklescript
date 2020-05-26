'use strict';

var Curry = require("./curry.js");
var Caml_option = require("./caml_option.js");
var Belt_SortArray = require("./belt_SortArray.js");

function treeHeight(n) do
  if (n ~= null) then do
    return n.height;
  end else do
    return 0;
  end end 
end

function copy(n) do
  if (n ~= null) then do
    var l = n.left;
    var r = n.right;
    return do
            value: n.value,
            height: n.height,
            left: copy(l),
            right: copy(r)
          end;
  end else do
    return n;
  end end 
end

function create(l, v, r) do
  var hl = l ~= null and l.height or 0;
  var hr = r ~= null and r.height or 0;
  return do
          value: v,
          height: hl >= hr and hl + 1 | 0 or hr + 1 | 0,
          left: l,
          right: r
        end;
end

function singleton(x) do
  return do
          value: x,
          height: 1,
          left: null,
          right: null
        end;
end

function heightGe(l, r) do
  if (r ~= null) then do
    if (l ~= null) then do
      return l.height >= r.height;
    end else do
      return false;
    end end 
  end else do
    return true;
  end end 
end

function bal(l, v, r) do
  var hl = l ~= null and l.height or 0;
  var hr = r ~= null and r.height or 0;
  if (hl > (hr + 2 | 0)) then do
    var ll = l.left;
    var lv = l.value;
    var lr = l.right;
    if (heightGe(ll, lr)) then do
      return create(ll, lv, create(lr, v, r));
    end else do
      var lrl = lr.left;
      var lrv = lr.value;
      var lrr = lr.right;
      return create(create(ll, lv, lrl), lrv, create(lrr, v, r));
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    var rl = r.left;
    var rv = r.value;
    var rr = r.right;
    if (heightGe(rr, rl)) then do
      return create(create(l, v, rl), rv, rr);
    end else do
      var rll = rl.left;
      var rlv = rl.value;
      var rlr = rl.right;
      return create(create(l, v, rll), rlv, create(rlr, rv, rr));
    end end 
  end else do
    return do
            value: v,
            height: hl >= hr and hl + 1 | 0 or hr + 1 | 0,
            left: l,
            right: r
          end;
  end end  end 
end

function min0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.left;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return n.value;
    end end 
  end;
end

function minimum(n) do
  if (n ~= null) then do
    return Caml_option.some(min0Aux(n));
  end
   end 
end

function minUndefined(n) do
  if (n ~= null) then do
    return min0Aux(n);
  end
   end 
end

function max0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.right;
    if (match ~= null) then do
      _n = match;
      continue ;
    end else do
      return n.value;
    end end 
  end;
end

function maximum(n) do
  if (n ~= null) then do
    return Caml_option.some(max0Aux(n));
  end
   end 
end

function maxUndefined(n) do
  if (n ~= null) then do
    return max0Aux(n);
  end
   end 
end

function removeMinAuxWithRef(n, v) do
  var ln = n.left;
  var rn = n.right;
  var kn = n.value;
  if (ln ~= null) then do
    return bal(removeMinAuxWithRef(ln, v), kn, rn);
  end else do
    v.contents = kn;
    return rn;
  end end 
end

function isEmpty(n) do
  return n == null;
end

function stackAllLeft(_v, _s) do
  while(true) do
    var s = _s;
    var v = _v;
    if (v ~= null) then do
      _s = --[ :: ]--[
        v,
        s
      ];
      _v = v.left;
      continue ;
    end else do
      return s;
    end end 
  end;
end

function forEachU(_n, f) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      forEachU(n.left, f);
      f(n.value);
      _n = n.right;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEach(n, f) do
  return forEachU(n, Curry.__1(f));
end

function reduceU(_s, _accu, f) do
  while(true) do
    var accu = _accu;
    var s = _s;
    if (s ~= null) then do
      var l = s.left;
      var k = s.value;
      var r = s.right;
      _accu = f(reduceU(l, accu, f), k);
      _s = r;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function reduce(s, accu, f) do
  return reduceU(s, accu, Curry.__2(f));
end

function everyU(_n, p) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      if (p(n.value) and everyU(n.left, p)) then do
        _n = n.right;
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function every(n, p) do
  return everyU(n, Curry.__1(p));
end

function someU(_n, p) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      if (p(n.value) or someU(n.left, p)) then do
        return true;
      end else do
        _n = n.right;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function some(n, p) do
  return someU(n, Curry.__1(p));
end

function addMinElement(n, v) do
  if (n ~= null) then do
    return bal(addMinElement(n.left, v), n.value, n.right);
  end else do
    return singleton(v);
  end end 
end

function addMaxElement(n, v) do
  if (n ~= null) then do
    return bal(n.left, n.value, addMaxElement(n.right, v));
  end else do
    return singleton(v);
  end end 
end

function joinShared(ln, v, rn) do
  if (ln ~= null) then do
    if (rn ~= null) then do
      var lh = ln.height;
      var rh = rn.height;
      if (lh > (rh + 2 | 0)) then do
        return bal(ln.left, ln.value, joinShared(ln.right, v, rn));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(joinShared(ln, v, rn.left), rn.value, rn.right);
      end else do
        return create(ln, v, rn);
      end end  end 
    end else do
      return addMaxElement(ln, v);
    end end 
  end else do
    return addMinElement(rn, v);
  end end 
end

function concatShared(t1, t2) do
  if (t1 ~= null) then do
    if (t2 ~= null) then do
      var v = do
        contents: t2.value
      end;
      var t2r = removeMinAuxWithRef(t2, v);
      return joinShared(t1, v.contents, t2r);
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end

function partitionSharedU(n, p) do
  if (n ~= null) then do
    var value = n.value;
    var match = partitionSharedU(n.left, p);
    var lf = match[1];
    var lt = match[0];
    var pv = p(value);
    var match$1 = partitionSharedU(n.right, p);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pv) then do
      return --[ tuple ]--[
              joinShared(lt, value, rt),
              concatShared(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concatShared(lt, rt),
              joinShared(lf, value, rf)
            ];
    end end 
  end else do
    return --[ tuple ]--[
            null,
            null
          ];
  end end 
end

function partitionShared(n, p) do
  return partitionSharedU(n, Curry.__1(p));
end

function lengthNode(n) do
  var l = n.left;
  var r = n.right;
  var sizeL = l ~= null and lengthNode(l) or 0;
  var sizeR = r ~= null and lengthNode(r) or 0;
  return (1 + sizeL | 0) + sizeR | 0;
end

function size(n) do
  if (n ~= null) then do
    return lengthNode(n);
  end else do
    return 0;
  end end 
end

function toListAux(_n, _accu) do
  while(true) do
    var accu = _accu;
    var n = _n;
    if (n ~= null) then do
      _accu = --[ :: ]--[
        n.value,
        toListAux(n.right, accu)
      ];
      _n = n.left;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function toList(s) do
  return toListAux(s, --[ [] ]--0);
end

function checkInvariantInternal(_v) do
  while(true) do
    var v = _v;
    if (v ~= null) then do
      var l = v.left;
      var r = v.right;
      var diff = treeHeight(l) - treeHeight(r) | 0;
      if (!(diff <= 2 and diff >= -2)) then do
        throw new Error("File \"belt_internalAVLset.ml\", line 304, characters 6-12");
      end
       end 
      checkInvariantInternal(l);
      _v = r;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function fillArray(_n, _i, arr) do
  while(true) do
    var i = _i;
    var n = _n;
    var l = n.left;
    var v = n.value;
    var r = n.right;
    var next = l ~= null and fillArray(l, i, arr) or i;
    arr[next] = v;
    var rnext = next + 1 | 0;
    if (r ~= null) then do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end end 
  end;
end

function fillArrayWithPartition(_n, cursor, arr, p) do
  while(true) do
    var n = _n;
    var l = n.left;
    var v = n.value;
    var r = n.right;
    if (l ~= null) then do
      fillArrayWithPartition(l, cursor, arr, p);
    end
     end 
    if (p(v)) then do
      var c = cursor.forward;
      arr[c] = v;
      cursor.forward = c + 1 | 0;
    end else do
      var c$1 = cursor.backward;
      arr[c$1] = v;
      cursor.backward = c$1 - 1 | 0;
    end end 
    if (r ~= null) then do
      _n = r;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function fillArrayWithFilter(_n, _i, arr, p) do
  while(true) do
    var i = _i;
    var n = _n;
    var l = n.left;
    var v = n.value;
    var r = n.right;
    var next = l ~= null and fillArrayWithFilter(l, i, arr, p) or i;
    var rnext = p(v) and (arr[next] = v, next + 1 | 0) or next;
    if (r ~= null) then do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end end 
  end;
end

function toArray(n) do
  if (n ~= null) then do
    var size = lengthNode(n);
    var v = new Array(size);
    fillArray(n, 0, v);
    return v;
  end else do
    return [];
  end end 
end

function fromSortedArrayRevAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ = 0 then do
        return null;end end end 
     if ___conditional___ = 1 then do
        return singleton(arr[off]);end end end 
     if ___conditional___ = 2 then do
        var x0 = arr[off];
        var x1 = arr[off - 1 | 0];
        return do
                value: x1,
                height: 2,
                left: singleton(x0),
                right: null
              end;end end end 
     if ___conditional___ = 3 then do
        var x0$1 = arr[off];
        var x1$1 = arr[off - 1 | 0];
        var x2 = arr[off - 2 | 0];
        return do
                value: x1$1,
                height: 2,
                left: singleton(x0$1),
                right: singleton(x2)
              end;end end end 
     do
    else do
      var nl = len / 2 | 0;
      var left = fromSortedArrayRevAux(arr, off, nl);
      var mid = arr[off - nl | 0];
      var right = fromSortedArrayRevAux(arr, (off - nl | 0) - 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, mid, right);
      end end
      
  end
end

function fromSortedArrayAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ = 0 then do
        return null;end end end 
     if ___conditional___ = 1 then do
        return singleton(arr[off]);end end end 
     if ___conditional___ = 2 then do
        var x0 = arr[off];
        var x1 = arr[off + 1 | 0];
        return do
                value: x1,
                height: 2,
                left: singleton(x0),
                right: null
              end;end end end 
     if ___conditional___ = 3 then do
        var x0$1 = arr[off];
        var x1$1 = arr[off + 1 | 0];
        var x2 = arr[off + 2 | 0];
        return do
                value: x1$1,
                height: 2,
                left: singleton(x0$1),
                right: singleton(x2)
              end;end end end 
     do
    else do
      var nl = len / 2 | 0;
      var left = fromSortedArrayAux(arr, off, nl);
      var mid = arr[off + nl | 0];
      var right = fromSortedArrayAux(arr, (off + nl | 0) + 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, mid, right);
      end end
      
  end
end

function fromSortedArrayUnsafe(arr) do
  return fromSortedArrayAux(arr, 0, #arr);
end

function keepSharedU(n, p) do
  if (n ~= null) then do
    var l = n.left;
    var v = n.value;
    var r = n.right;
    var newL = keepSharedU(l, p);
    var pv = p(v);
    var newR = keepSharedU(r, p);
    if (pv) then do
      if (l == newL and r == newR) then do
        return n;
      end else do
        return joinShared(newL, v, newR);
      end end 
    end else do
      return concatShared(newL, newR);
    end end 
  end else do
    return null;
  end end 
end

function keepShared(n, p) do
  return keepSharedU(n, Curry.__1(p));
end

function keepCopyU(n, p) do
  if (n ~= null) then do
    var size = lengthNode(n);
    var v = new Array(size);
    var last = fillArrayWithFilter(n, 0, v, p);
    return fromSortedArrayAux(v, 0, last);
  end else do
    return null;
  end end 
end

function keepCopy(n, p) do
  return keepCopyU(n, Curry.__1(p));
end

function partitionCopyU(n, p) do
  if (n ~= null) then do
    var size = lengthNode(n);
    var v = new Array(size);
    var backward = size - 1 | 0;
    var cursor = do
      forward: 0,
      backward: backward
    end;
    fillArrayWithPartition(n, cursor, v, p);
    var forwardLen = cursor.forward;
    return --[ tuple ]--[
            fromSortedArrayAux(v, 0, forwardLen),
            fromSortedArrayRevAux(v, backward, size - forwardLen | 0)
          ];
  end else do
    return --[ tuple ]--[
            null,
            null
          ];
  end end 
end

function partitionCopy(n, p) do
  return partitionCopyU(n, Curry.__1(p));
end

function has(_t, x, cmp) do
  while(true) do
    var t = _t;
    if (t ~= null) then do
      var v = t.value;
      var c = cmp(x, v);
      if (c == 0) then do
        return true;
      end else do
        _t = c < 0 and t.left or t.right;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function cmp(s1, s2, cmp$1) do
  var len1 = size(s1);
  var len2 = size(s2);
  if (len1 == len2) then do
    var _e1 = stackAllLeft(s1, --[ [] ]--0);
    var _e2 = stackAllLeft(s2, --[ [] ]--0);
    var cmp$2 = cmp$1;
    while(true) do
      var e2 = _e2;
      var e1 = _e1;
      if (e1 and e2) then do
        var h2 = e2[0];
        var h1 = e1[0];
        var c = cmp$2(h1.value, h2.value);
        if (c == 0) then do
          _e2 = stackAllLeft(h2.right, e2[1]);
          _e1 = stackAllLeft(h1.right, e1[1]);
          continue ;
        end else do
          return c;
        end end 
      end else do
        return 0;
      end end 
    end;
  end else if (len1 < len2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end

function eq(s1, s2, c) do
  return cmp(s1, s2, c) == 0;
end

function subset(_s1, _s2, cmp) do
  while(true) do
    var s2 = _s2;
    var s1 = _s1;
    if (s1 ~= null) then do
      if (s2 ~= null) then do
        var l1 = s1.left;
        var v1 = s1.value;
        var r1 = s1.right;
        var l2 = s2.left;
        var v2 = s2.value;
        var r2 = s2.right;
        var c = cmp(v1, v2);
        if (c == 0) then do
          if (subset(l1, l2, cmp)) then do
            _s2 = r2;
            _s1 = r1;
            continue ;
          end else do
            return false;
          end end 
        end else if (c < 0) then do
          if (subset(create(l1, v1, null), l2, cmp)) then do
            _s1 = r1;
            continue ;
          end else do
            return false;
          end end 
        end else if (subset(create(null, v1, r1), r2, cmp)) then do
          _s1 = l1;
          continue ;
        end else do
          return false;
        end end  end  end 
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function get(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.value;
      var c = cmp(x, v);
      if (c == 0) then do
        return Caml_option.some(v);
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getUndefined(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.value;
      var c = cmp(x, v);
      if (c == 0) then do
        return v;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getExn(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) then do
      var v = n.value;
      var c = cmp(x, v);
      if (c == 0) then do
        return v;
      end else do
        _n = c < 0 and n.left or n.right;
        continue ;
      end end 
    end else do
      throw new Error("getExn0");
    end end 
  end;
end

function rotateWithLeftChild(k2) do
  var k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  var hlk2 = treeHeight(k2.left);
  var hrk2 = treeHeight(k2.right);
  k2.height = (
    hlk2 > hrk2 and hlk2 or hrk2
  ) + 1 | 0;
  var hlk1 = treeHeight(k1.left);
  var hk2 = k2.height;
  k1.height = (
    hlk1 > hk2 and hlk1 or hk2
  ) + 1 | 0;
  return k1;
end

function rotateWithRightChild(k1) do
  var k2 = k1.right;
  k1.right = k2.left;
  k2.left = k1;
  var hlk1 = treeHeight(k1.left);
  var hrk1 = treeHeight(k1.right);
  k1.height = (
    hlk1 > hrk1 and hlk1 or hrk1
  ) + 1 | 0;
  var hrk2 = treeHeight(k2.right);
  var hk1 = k1.height;
  k2.height = (
    hrk2 > hk1 and hrk2 or hk1
  ) + 1 | 0;
  return k2;
end

function doubleWithLeftChild(k3) do
  var v = rotateWithRightChild(k3.left);
  k3.left = v;
  return rotateWithLeftChild(k3);
end

function doubleWithRightChild(k2) do
  var v = rotateWithLeftChild(k2.right);
  k2.right = v;
  return rotateWithRightChild(k2);
end

function heightUpdateMutate(t) do
  var hlt = treeHeight(t.left);
  var hrt = treeHeight(t.right);
  t.height = (
    hlt > hrt and hlt or hrt
  ) + 1 | 0;
  return t;
end

function balMutate(nt) do
  var l = nt.left;
  var r = nt.right;
  var hl = treeHeight(l);
  var hr = treeHeight(r);
  if (hl > (2 + hr | 0)) then do
    var ll = l.left;
    var lr = l.right;
    if (heightGe(ll, lr)) then do
      return heightUpdateMutate(rotateWithLeftChild(nt));
    end else do
      return heightUpdateMutate(doubleWithLeftChild(nt));
    end end 
  end else if (hr > (2 + hl | 0)) then do
    var rl = r.left;
    var rr = r.right;
    if (heightGe(rr, rl)) then do
      return heightUpdateMutate(rotateWithRightChild(nt));
    end else do
      return heightUpdateMutate(doubleWithRightChild(nt));
    end end 
  end else do
    nt.height = (
      hl > hr and hl or hr
    ) + 1 | 0;
    return nt;
  end end  end 
end

function addMutate(cmp, t, x) do
  if (t ~= null) then do
    var k = t.value;
    var c = cmp(x, k);
    if (c == 0) then do
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (c < 0) then do
        var ll = addMutate(cmp, l, x);
        t.left = ll;
      end else do
        t.right = addMutate(cmp, r, x);
      end end 
      return balMutate(t);
    end end 
  end else do
    return singleton(x);
  end end 
end

function fromArray(xs, cmp) do
  var len = #xs;
  if (len == 0) then do
    return null;
  end else do
    var next = Belt_SortArray.strictlySortedLengthU(xs, (function (x, y) do
            return cmp(x, y) < 0;
          end));
    var result;
    if (next >= 0) then do
      result = fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for(var i = next ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      result = addMutate(cmp, result, xs[i]);
    end
    return result;
  end end 
end

function removeMinAuxWithRootMutate(nt, n) do
  var rn = n.right;
  var ln = n.left;
  if (ln ~= null) then do
    n.left = removeMinAuxWithRootMutate(nt, ln);
    return balMutate(n);
  end else do
    nt.value = n.value;
    return rn;
  end end 
end

exports.copy = copy;
exports.create = create;
exports.bal = bal;
exports.singleton = singleton;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.removeMinAuxWithRef = removeMinAuxWithRef;
exports.isEmpty = isEmpty;
exports.stackAllLeft = stackAllLeft;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.joinShared = joinShared;
exports.concatShared = concatShared;
exports.keepSharedU = keepSharedU;
exports.keepShared = keepShared;
exports.keepCopyU = keepCopyU;
exports.keepCopy = keepCopy;
exports.partitionSharedU = partitionSharedU;
exports.partitionShared = partitionShared;
exports.partitionCopyU = partitionCopyU;
exports.partitionCopy = partitionCopy;
exports.lengthNode = lengthNode;
exports.size = size;
exports.toList = toList;
exports.checkInvariantInternal = checkInvariantInternal;
exports.fillArray = fillArray;
exports.toArray = toArray;
exports.fromSortedArrayAux = fromSortedArrayAux;
exports.fromSortedArrayRevAux = fromSortedArrayRevAux;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.has = has;
exports.cmp = cmp;
exports.eq = eq;
exports.subset = subset;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getExn = getExn;
exports.fromArray = fromArray;
exports.addMutate = addMutate;
exports.balMutate = balMutate;
exports.removeMinAuxWithRootMutate = removeMinAuxWithRootMutate;
--[ No side effect ]--
