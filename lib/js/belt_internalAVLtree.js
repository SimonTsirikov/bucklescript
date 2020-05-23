'use strict';

var Curry = require("./curry.js");
var Caml_option = require("./caml_option.js");
var Belt_SortArray = require("./belt_SortArray.js");

function treeHeight(n) do
  if (n ~= null) do
    return n.height;
  end else do
    return 0;
  end
end

function copy(n) do
  if (n ~= null) do
    var l = n.left;
    var r = n.right;
    return do
            key: n.key,
            value: n.value,
            height: n.height,
            left: copy(l),
            right: copy(r)
          end;
  end else do
    return n;
  end
end

function create(l, x, d, r) do
  var hl = treeHeight(l);
  var hr = treeHeight(r);
  return do
          key: x,
          value: d,
          height: hl >= hr ? hl + 1 | 0 : hr + 1 | 0,
          left: l,
          right: r
        end;
end

function singleton(x, d) do
  return do
          key: x,
          value: d,
          height: 1,
          left: null,
          right: null
        end;
end

function heightGe(l, r) do
  if (r ~= null) do
    if (l ~= null) do
      return l.height >= r.height;
    end else do
      return false;
    end
  end else do
    return true;
  end
end

function updateValue(n, newValue) do
  if (n.value == newValue) do
    return n;
  end else do
    return do
            key: n.key,
            value: newValue,
            height: n.height,
            left: n.left,
            right: n.right
          end;
  end
end

function bal(l, x, d, r) do
  var hl = l ~= null ? l.height : 0;
  var hr = r ~= null ? r.height : 0;
  if (hl > (hr + 2 | 0)) do
    var ll = l.left;
    var lv = l.key;
    var ld = l.value;
    var lr = l.right;
    if (treeHeight(ll) >= treeHeight(lr)) do
      return create(ll, lv, ld, create(lr, x, d, r));
    end else do
      var lrl = lr.left;
      var lrv = lr.key;
      var lrd = lr.value;
      var lrr = lr.right;
      return create(create(ll, lv, ld, lrl), lrv, lrd, create(lrr, x, d, r));
    end
  end else if (hr > (hl + 2 | 0)) do
    var rl = r.left;
    var rv = r.key;
    var rd = r.value;
    var rr = r.right;
    if (treeHeight(rr) >= treeHeight(rl)) do
      return create(create(l, x, d, rl), rv, rd, rr);
    end else do
      var rll = rl.left;
      var rlv = rl.key;
      var rld = rl.value;
      var rlr = rl.right;
      return create(create(l, x, d, rll), rlv, rld, create(rlr, rv, rd, rr));
    end
  end else do
    return do
            key: x,
            value: d,
            height: hl >= hr ? hl + 1 | 0 : hr + 1 | 0,
            left: l,
            right: r
          end;
  end
end

function minKey0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.left;
    if (match ~= null) do
      _n = match;
      continue ;
    end else do
      return n.key;
    end
  end;
end

function minKey(n) do
  if (n ~= null) do
    return Caml_option.some(minKey0Aux(n));
  end
  
end

function minKeyUndefined(n) do
  if (n ~= null) do
    return minKey0Aux(n);
  end
  
end

function maxKey0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.right;
    if (match ~= null) do
      _n = match;
      continue ;
    end else do
      return n.key;
    end
  end;
end

function maxKey(n) do
  if (n ~= null) do
    return Caml_option.some(maxKey0Aux(n));
  end
  
end

function maxKeyUndefined(n) do
  if (n ~= null) do
    return maxKey0Aux(n);
  end
  
end

function minKV0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.left;
    if (match ~= null) do
      _n = match;
      continue ;
    end else do
      return --[ tuple ]--[
              n.key,
              n.value
            ];
    end
  end;
end

function minimum(n) do
  if (n ~= null) do
    return minKV0Aux(n);
  end
  
end

function minUndefined(n) do
  if (n ~= null) do
    return minKV0Aux(n);
  end
  
end

function maxKV0Aux(_n) do
  while(true) do
    var n = _n;
    var match = n.right;
    if (match ~= null) do
      _n = match;
      continue ;
    end else do
      return --[ tuple ]--[
              n.key,
              n.value
            ];
    end
  end;
end

function maximum(n) do
  if (n ~= null) do
    return maxKV0Aux(n);
  end
  
end

function maxUndefined(n) do
  if (n ~= null) do
    return maxKV0Aux(n);
  end
  
end

function removeMinAuxWithRef(n, kr, vr) do
  var ln = n.left;
  var rn = n.right;
  var kn = n.key;
  var vn = n.value;
  if (ln ~= null) do
    return bal(removeMinAuxWithRef(ln, kr, vr), kn, vn, rn);
  end else do
    kr.contents = kn;
    vr.contents = vn;
    return rn;
  end
end

function isEmpty(x) do
  return x == null;
end

function stackAllLeft(_v, _s) do
  while(true) do
    var s = _s;
    var v = _v;
    if (v ~= null) do
      _s = --[ :: ]--[
        v,
        s
      ];
      _v = v.left;
      continue ;
    end else do
      return s;
    end
  end;
end

function findFirstByU(n, p) do
  if (n ~= null) do
    var left = findFirstByU(n.left, p);
    if (left ~= undefined) do
      return left;
    end else do
      var v = n.key;
      var d = n.value;
      var pvd = p(v, d);
      if (pvd) do
        return --[ tuple ]--[
                v,
                d
              ];
      end else do
        var right = findFirstByU(n.right, p);
        if (right ~= undefined) do
          return right;
        end else do
          return ;
        end
      end
    end
  end
  
end

function findFirstBy(n, p) do
  return findFirstByU(n, Curry.__2(p));
end

function forEachU(_n, f) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      forEachU(n.left, f);
      f(n.key, n.value);
      _n = n.right;
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function forEach(n, f) do
  return forEachU(n, Curry.__2(f));
end

function mapU(n, f) do
  if (n ~= null) do
    var newLeft = mapU(n.left, f);
    var newD = f(n.value);
    var newRight = mapU(n.right, f);
    return do
            key: n.key,
            value: newD,
            height: n.height,
            left: newLeft,
            right: newRight
          end;
  end else do
    return null;
  end
end

function map(n, f) do
  return mapU(n, Curry.__1(f));
end

function mapWithKeyU(n, f) do
  if (n ~= null) do
    var key = n.key;
    var newLeft = mapWithKeyU(n.left, f);
    var newD = f(key, n.value);
    var newRight = mapWithKeyU(n.right, f);
    return do
            key: key,
            value: newD,
            height: n.height,
            left: newLeft,
            right: newRight
          end;
  end else do
    return null;
  end
end

function mapWithKey(n, f) do
  return mapWithKeyU(n, Curry.__2(f));
end

function reduceU(_m, _accu, f) do
  while(true) do
    var accu = _accu;
    var m = _m;
    if (m ~= null) do
      var l = m.left;
      var v = m.key;
      var d = m.value;
      var r = m.right;
      _accu = f(reduceU(l, accu, f), v, d);
      _m = r;
      continue ;
    end else do
      return accu;
    end
  end;
end

function reduce(m, accu, f) do
  return reduceU(m, accu, Curry.__3(f));
end

function everyU(_n, p) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      if (p(n.key, n.value) and everyU(n.left, p)) do
        _n = n.right;
        continue ;
      end else do
        return false;
      end
    end else do
      return true;
    end
  end;
end

function every(n, p) do
  return everyU(n, Curry.__2(p));
end

function someU(_n, p) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      if (p(n.key, n.value) or someU(n.left, p)) do
        return true;
      end else do
        _n = n.right;
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function some(n, p) do
  return someU(n, Curry.__2(p));
end

function addMinElement(n, k, v) do
  if (n ~= null) do
    return bal(addMinElement(n.left, k, v), n.key, n.value, n.right);
  end else do
    return singleton(k, v);
  end
end

function addMaxElement(n, k, v) do
  if (n ~= null) do
    return bal(n.left, n.key, n.value, addMaxElement(n.right, k, v));
  end else do
    return singleton(k, v);
  end
end

function join(ln, v, d, rn) do
  if (ln ~= null) do
    if (rn ~= null) do
      var ll = ln.left;
      var lv = ln.key;
      var ld = ln.value;
      var lr = ln.right;
      var lh = ln.height;
      var rl = rn.left;
      var rv = rn.key;
      var rd = rn.value;
      var rr = rn.right;
      var rh = rn.height;
      if (lh > (rh + 2 | 0)) do
        return bal(ll, lv, ld, join(lr, v, d, rn));
      end else if (rh > (lh + 2 | 0)) do
        return bal(join(ln, v, d, rl), rv, rd, rr);
      end else do
        return create(ln, v, d, rn);
      end
    end else do
      return addMaxElement(ln, v, d);
    end
  end else do
    return addMinElement(rn, v, d);
  end
end

function concat(t1, t2) do
  if (t1 ~= null) do
    if (t2 ~= null) do
      var kr = do
        contents: t2.key
      end;
      var vr = do
        contents: t2.value
      end;
      var t2r = removeMinAuxWithRef(t2, kr, vr);
      return join(t1, kr.contents, vr.contents, t2r);
    end else do
      return t1;
    end
  end else do
    return t2;
  end
end

function concatOrJoin(t1, v, d, t2) do
  if (d ~= undefined) do
    return join(t1, v, Caml_option.valFromOption(d), t2);
  end else do
    return concat(t1, t2);
  end
end

function keepSharedU(n, p) do
  if (n ~= null) do
    var v = n.key;
    var d = n.value;
    var newLeft = keepSharedU(n.left, p);
    var pvd = p(v, d);
    var newRight = keepSharedU(n.right, p);
    if (pvd) do
      return join(newLeft, v, d, newRight);
    end else do
      return concat(newLeft, newRight);
    end
  end else do
    return null;
  end
end

function keepShared(n, p) do
  return keepSharedU(n, Curry.__2(p));
end

function keepMapU(n, p) do
  if (n ~= null) do
    var v = n.key;
    var d = n.value;
    var newLeft = keepMapU(n.left, p);
    var pvd = p(v, d);
    var newRight = keepMapU(n.right, p);
    if (pvd ~= undefined) do
      return join(newLeft, v, Caml_option.valFromOption(pvd), newRight);
    end else do
      return concat(newLeft, newRight);
    end
  end else do
    return null;
  end
end

function keepMap(n, p) do
  return keepMapU(n, Curry.__2(p));
end

function partitionSharedU(n, p) do
  if (n ~= null) do
    var key = n.key;
    var value = n.value;
    var match = partitionSharedU(n.left, p);
    var lf = match[1];
    var lt = match[0];
    var pvd = p(key, value);
    var match$1 = partitionSharedU(n.right, p);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pvd) do
      return --[ tuple ]--[
              join(lt, key, value, rt),
              concat(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concat(lt, rt),
              join(lf, key, value, rf)
            ];
    end
  end else do
    return --[ tuple ]--[
            null,
            null
          ];
  end
end

function partitionShared(n, p) do
  return partitionSharedU(n, Curry.__2(p));
end

function lengthNode(n) do
  var l = n.left;
  var r = n.right;
  var sizeL = l ~= null ? lengthNode(l) : 0;
  var sizeR = r ~= null ? lengthNode(r) : 0;
  return (1 + sizeL | 0) + sizeR | 0;
end

function size(n) do
  if (n ~= null) do
    return lengthNode(n);
  end else do
    return 0;
  end
end

function toListAux(_n, _accu) do
  while(true) do
    var accu = _accu;
    var n = _n;
    if (n ~= null) do
      var l = n.left;
      var r = n.right;
      var k = n.key;
      var v = n.value;
      _accu = --[ :: ]--[
        --[ tuple ]--[
          k,
          v
        ],
        toListAux(r, accu)
      ];
      _n = l;
      continue ;
    end else do
      return accu;
    end
  end;
end

function toList(s) do
  return toListAux(s, --[ [] ]--0);
end

function checkInvariantInternal(_v) do
  while(true) do
    var v = _v;
    if (v ~= null) do
      var l = v.left;
      var r = v.right;
      var diff = treeHeight(l) - treeHeight(r) | 0;
      if (!(diff <= 2 and diff >= -2)) do
        throw new Error("File \"belt_internalAVLtree.ml\", line 385, characters 6-12");
      end
      checkInvariantInternal(l);
      _v = r;
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function fillArrayKey(_n, _i, arr) do
  while(true) do
    var i = _i;
    var n = _n;
    var l = n.left;
    var v = n.key;
    var r = n.right;
    var next = l ~= null ? fillArrayKey(l, i, arr) : i;
    arr[next] = v;
    var rnext = next + 1 | 0;
    if (r ~= null) do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end
  end;
end

function fillArrayValue(_n, _i, arr) do
  while(true) do
    var i = _i;
    var n = _n;
    var l = n.left;
    var r = n.right;
    var next = l ~= null ? fillArrayValue(l, i, arr) : i;
    arr[next] = n.value;
    var rnext = next + 1 | 0;
    if (r ~= null) do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end
  end;
end

function fillArray(_n, _i, arr) do
  while(true) do
    var i = _i;
    var n = _n;
    var l = n.left;
    var v = n.key;
    var r = n.right;
    var next = l ~= null ? fillArray(l, i, arr) : i;
    arr[next] = --[ tuple ]--[
      v,
      n.value
    ];
    var rnext = next + 1 | 0;
    if (r ~= null) do
      _i = rnext;
      _n = r;
      continue ;
    end else do
      return rnext;
    end
  end;
end

function toArray(n) do
  if (n ~= null) do
    var size = lengthNode(n);
    var v = new Array(size);
    fillArray(n, 0, v);
    return v;
  end else do
    return [];
  end
end

function keysToArray(n) do
  if (n ~= null) do
    var size = lengthNode(n);
    var v = new Array(size);
    fillArrayKey(n, 0, v);
    return v;
  end else do
    return [];
  end
end

function valuesToArray(n) do
  if (n ~= null) do
    var size = lengthNode(n);
    var v = new Array(size);
    fillArrayValue(n, 0, v);
    return v;
  end else do
    return [];
  end
end

function fromSortedArrayRevAux(arr, off, len) do
  switch (len) do
    case 0 :
        return null;
    case 1 :
        var match = arr[off];
        return singleton(match[0], match[1]);
    case 2 :
        var match_000 = arr[off];
        var match_001 = arr[off - 1 | 0];
        var match$1 = match_001;
        var match$2 = match_000;
        return do
                key: match$1[0],
                value: match$1[1],
                height: 2,
                left: singleton(match$2[0], match$2[1]),
                right: null
              end;
    case 3 :
        var match_000$1 = arr[off];
        var match_001$1 = arr[off - 1 | 0];
        var match_002 = arr[off - 2 | 0];
        var match$3 = match_002;
        var match$4 = match_001$1;
        var match$5 = match_000$1;
        return do
                key: match$4[0],
                value: match$4[1],
                height: 2,
                left: singleton(match$5[0], match$5[1]),
                right: singleton(match$3[0], match$3[1])
              end;
    default:
      var nl = len / 2 | 0;
      var left = fromSortedArrayRevAux(arr, off, nl);
      var match$6 = arr[off - nl | 0];
      var right = fromSortedArrayRevAux(arr, (off - nl | 0) - 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, match$6[0], match$6[1], right);
  end
end

function fromSortedArrayAux(arr, off, len) do
  switch (len) do
    case 0 :
        return null;
    case 1 :
        var match = arr[off];
        return singleton(match[0], match[1]);
    case 2 :
        var match_000 = arr[off];
        var match_001 = arr[off + 1 | 0];
        var match$1 = match_001;
        var match$2 = match_000;
        return do
                key: match$1[0],
                value: match$1[1],
                height: 2,
                left: singleton(match$2[0], match$2[1]),
                right: null
              end;
    case 3 :
        var match_000$1 = arr[off];
        var match_001$1 = arr[off + 1 | 0];
        var match_002 = arr[off + 2 | 0];
        var match$3 = match_002;
        var match$4 = match_001$1;
        var match$5 = match_000$1;
        return do
                key: match$4[0],
                value: match$4[1],
                height: 2,
                left: singleton(match$5[0], match$5[1]),
                right: singleton(match$3[0], match$3[1])
              end;
    default:
      var nl = len / 2 | 0;
      var left = fromSortedArrayAux(arr, off, nl);
      var match$6 = arr[off + nl | 0];
      var right = fromSortedArrayAux(arr, (off + nl | 0) + 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, match$6[0], match$6[1], right);
  end
end

function fromSortedArrayUnsafe(arr) do
  return fromSortedArrayAux(arr, 0, #arr);
end

function cmpU(s1, s2, kcmp, vcmp) do
  var len1 = size(s1);
  var len2 = size(s2);
  if (len1 == len2) do
    var _e1 = stackAllLeft(s1, --[ [] ]--0);
    var _e2 = stackAllLeft(s2, --[ [] ]--0);
    var kcmp$1 = kcmp;
    var vcmp$1 = vcmp;
    while(true) do
      var e2 = _e2;
      var e1 = _e1;
      if (e1 and e2) do
        var h2 = e2[0];
        var h1 = e1[0];
        var c = kcmp$1(h1.key, h2.key);
        if (c == 0) do
          var cx = vcmp$1(h1.value, h2.value);
          if (cx == 0) do
            _e2 = stackAllLeft(h2.right, e2[1]);
            _e1 = stackAllLeft(h1.right, e1[1]);
            continue ;
          end else do
            return cx;
          end
        end else do
          return c;
        end
      end else do
        return 0;
      end
    end;
  end else if (len1 < len2) do
    return -1;
  end else do
    return 1;
  end
end

function cmp(s1, s2, kcmp, vcmp) do
  return cmpU(s1, s2, kcmp, Curry.__2(vcmp));
end

function eqU(s1, s2, kcmp, veq) do
  var len1 = size(s1);
  var len2 = size(s2);
  if (len1 == len2) do
    var _e1 = stackAllLeft(s1, --[ [] ]--0);
    var _e2 = stackAllLeft(s2, --[ [] ]--0);
    var kcmp$1 = kcmp;
    var veq$1 = veq;
    while(true) do
      var e2 = _e2;
      var e1 = _e1;
      if (e1 and e2) do
        var h2 = e2[0];
        var h1 = e1[0];
        if (kcmp$1(h1.key, h2.key) == 0 and veq$1(h1.value, h2.value)) do
          _e2 = stackAllLeft(h2.right, e2[1]);
          _e1 = stackAllLeft(h1.right, e1[1]);
          continue ;
        end else do
          return false;
        end
      end else do
        return true;
      end
    end;
  end else do
    return false;
  end
end

function eq(s1, s2, kcmp, veq) do
  return eqU(s1, s2, kcmp, Curry.__2(veq));
end

function get(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.key;
      var c = cmp(x, v);
      if (c == 0) do
        return Caml_option.some(n.value);
      end else do
        _n = c < 0 ? n.left : n.right;
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function getUndefined(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.key;
      var c = cmp(x, v);
      if (c == 0) do
        return n.value;
      end else do
        _n = c < 0 ? n.left : n.right;
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function getExn(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.key;
      var c = cmp(x, v);
      if (c == 0) do
        return n.value;
      end else do
        _n = c < 0 ? n.left : n.right;
        continue ;
      end
    end else do
      throw new Error("getExn0");
    end
  end;
end

function getWithDefault(_n, x, def, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.key;
      var c = cmp(x, v);
      if (c == 0) do
        return n.value;
      end else do
        _n = c < 0 ? n.left : n.right;
        continue ;
      end
    end else do
      return def;
    end
  end;
end

function has(_n, x, cmp) do
  while(true) do
    var n = _n;
    if (n ~= null) do
      var v = n.key;
      var c = cmp(x, v);
      if (c == 0) do
        return true;
      end else do
        _n = c < 0 ? n.left : n.right;
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function rotateWithLeftChild(k2) do
  var k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  var hlk2 = treeHeight(k2.left);
  var hrk2 = treeHeight(k2.right);
  k2.height = (
    hlk2 > hrk2 ? hlk2 : hrk2
  ) + 1 | 0;
  var hlk1 = treeHeight(k1.left);
  var hk2 = k2.height;
  k1.height = (
    hlk1 > hk2 ? hlk1 : hk2
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
    hlk1 > hrk1 ? hlk1 : hrk1
  ) + 1 | 0;
  var hrk2 = treeHeight(k2.right);
  var hk1 = k1.height;
  k2.height = (
    hrk2 > hk1 ? hrk2 : hk1
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
    hlt > hrt ? hlt : hrt
  ) + 1 | 0;
  return t;
end

function balMutate(nt) do
  var l = nt.left;
  var r = nt.right;
  var hl = treeHeight(l);
  var hr = treeHeight(r);
  if (hl > (2 + hr | 0)) do
    var ll = l.left;
    var lr = l.right;
    if (heightGe(ll, lr)) do
      return heightUpdateMutate(rotateWithLeftChild(nt));
    end else do
      return heightUpdateMutate(doubleWithLeftChild(nt));
    end
  end else if (hr > (2 + hl | 0)) do
    var rl = r.left;
    var rr = r.right;
    if (heightGe(rr, rl)) do
      return heightUpdateMutate(rotateWithRightChild(nt));
    end else do
      return heightUpdateMutate(doubleWithRightChild(nt));
    end
  end else do
    nt.height = (
      hl > hr ? hl : hr
    ) + 1 | 0;
    return nt;
  end
end

function updateMutate(t, x, data, cmp) do
  if (t ~= null) do
    var k = t.key;
    var c = cmp(x, k);
    if (c == 0) do
      t.value = data;
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (c < 0) do
        var ll = updateMutate(l, x, data, cmp);
        t.left = ll;
      end else do
        t.right = updateMutate(r, x, data, cmp);
      end
      return balMutate(t);
    end
  end else do
    return singleton(x, data);
  end
end

function fromArray(xs, cmp) do
  var len = #xs;
  if (len == 0) do
    return null;
  end else do
    var next = Belt_SortArray.strictlySortedLengthU(xs, (function (param, param$1) do
            return cmp(param[0], param$1[0]) < 0;
          end));
    var result;
    if (next >= 0) do
      result = fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end
    for(var i = next ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
      var match = xs[i];
      result = updateMutate(result, match[0], match[1], cmp);
    end
    return result;
  end
end

function removeMinAuxWithRootMutate(nt, n) do
  var rn = n.right;
  var ln = n.left;
  if (ln ~= null) do
    n.left = removeMinAuxWithRootMutate(nt, ln);
    return balMutate(n);
  end else do
    nt.key = n.key;
    return rn;
  end
end

exports.copy = copy;
exports.create = create;
exports.bal = bal;
exports.singleton = singleton;
exports.updateValue = updateValue;
exports.minKey = minKey;
exports.minKeyUndefined = minKeyUndefined;
exports.maxKey = maxKey;
exports.maxKeyUndefined = maxKeyUndefined;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.removeMinAuxWithRef = removeMinAuxWithRef;
exports.isEmpty = isEmpty;
exports.stackAllLeft = stackAllLeft;
exports.findFirstByU = findFirstByU;
exports.findFirstBy = findFirstBy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.mapU = mapU;
exports.map = map;
exports.mapWithKeyU = mapWithKeyU;
exports.mapWithKey = mapWithKey;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.join = join;
exports.concat = concat;
exports.concatOrJoin = concatOrJoin;
exports.keepSharedU = keepSharedU;
exports.keepShared = keepShared;
exports.keepMapU = keepMapU;
exports.keepMap = keepMap;
exports.partitionSharedU = partitionSharedU;
exports.partitionShared = partitionShared;
exports.lengthNode = lengthNode;
exports.size = size;
exports.toList = toList;
exports.checkInvariantInternal = checkInvariantInternal;
exports.fillArray = fillArray;
exports.toArray = toArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.fromSortedArrayAux = fromSortedArrayAux;
exports.fromSortedArrayRevAux = fromSortedArrayRevAux;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.cmpU = cmpU;
exports.cmp = cmp;
exports.eqU = eqU;
exports.eq = eq;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getWithDefault = getWithDefault;
exports.getExn = getExn;
exports.has = has;
exports.fromArray = fromArray;
exports.updateMutate = updateMutate;
exports.balMutate = balMutate;
exports.removeMinAuxWithRootMutate = removeMinAuxWithRootMutate;
--[ No side effect ]--
