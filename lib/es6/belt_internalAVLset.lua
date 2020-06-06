

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";
import * as Belt_SortArray from "./belt_SortArray.lua";

function treeHeight(n) do
  if (n ~= nil) then do
    return n.height;
  end else do
    return 0;
  end end 
end end

function copy(n) do
  if (n ~= nil) then do
    l = n.left;
    r = n.right;
    return {
            value = n.value,
            height = n.height,
            left = copy(l),
            right = copy(r)
          };
  end else do
    return n;
  end end 
end end

function create(l, v, r) do
  hl = l ~= nil and l.height or 0;
  hr = r ~= nil and r.height or 0;
  return {
          value = v,
          height = hl >= hr and hl + 1 | 0 or hr + 1 | 0,
          left = l,
          right = r
        };
end end

function singleton(x) do
  return {
          value = x,
          height = 1,
          left = nil,
          right = nil
        };
end end

function heightGe(l, r) do
  if (r ~= nil) then do
    if (l ~= nil) then do
      return l.height >= r.height;
    end else do
      return false;
    end end 
  end else do
    return true;
  end end 
end end

function bal(l, v, r) do
  hl = l ~= nil and l.height or 0;
  hr = r ~= nil and r.height or 0;
  if (hl > (hr + 2 | 0)) then do
    ll = l.left;
    lv = l.value;
    lr = l.right;
    if (heightGe(ll, lr)) then do
      return create(ll, lv, create(lr, v, r));
    end else do
      lrl = lr.left;
      lrv = lr.value;
      lrr = lr.right;
      return create(create(ll, lv, lrl), lrv, create(lrr, v, r));
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    rl = r.left;
    rv = r.value;
    rr = r.right;
    if (heightGe(rr, rl)) then do
      return create(create(l, v, rl), rv, rr);
    end else do
      rll = rl.left;
      rlv = rl.value;
      rlr = rl.right;
      return create(create(l, v, rll), rlv, create(rlr, rv, rr));
    end end 
  end else do
    return {
            value = v,
            height = hl >= hr and hl + 1 | 0 or hr + 1 | 0,
            left = l,
            right = r
          };
  end end  end 
end end

function min0Aux(_n) do
  while(true) do
    n = _n;
    match = n.left;
    if (match ~= nil) then do
      _n = match;
      ::continue:: ;
    end else do
      return n.value;
    end end 
  end;
end end

function minimum(n) do
  if (n ~= nil) then do
    return Caml_option.some(min0Aux(n));
  end
   end 
end end

function minUndefined(n) do
  if (n ~= nil) then do
    return min0Aux(n);
  end
   end 
end end

function max0Aux(_n) do
  while(true) do
    n = _n;
    match = n.right;
    if (match ~= nil) then do
      _n = match;
      ::continue:: ;
    end else do
      return n.value;
    end end 
  end;
end end

function maximum(n) do
  if (n ~= nil) then do
    return Caml_option.some(max0Aux(n));
  end
   end 
end end

function maxUndefined(n) do
  if (n ~= nil) then do
    return max0Aux(n);
  end
   end 
end end

function removeMinAuxWithRef(n, v) do
  ln = n.left;
  rn = n.right;
  kn = n.value;
  if (ln ~= nil) then do
    return bal(removeMinAuxWithRef(ln, v), kn, rn);
  end else do
    v.contents = kn;
    return rn;
  end end 
end end

function isEmpty(n) do
  return n == nil;
end end

function stackAllLeft(_v, _s) do
  while(true) do
    s = _s;
    v = _v;
    if (v ~= nil) then do
      _s = --[[ :: ]]{
        v,
        s
      };
      _v = v.left;
      ::continue:: ;
    end else do
      return s;
    end end 
  end;
end end

function forEachU(_n, f) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      forEachU(n.left, f);
      f(n.value);
      _n = n.right;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(n, f) do
  return forEachU(n, Curry.__1(f));
end end

function reduceU(_s, _accu, f) do
  while(true) do
    accu = _accu;
    s = _s;
    if (s ~= nil) then do
      l = s.left;
      k = s.value;
      r = s.right;
      _accu = f(reduceU(l, accu, f), k);
      _s = r;
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce(s, accu, f) do
  return reduceU(s, accu, Curry.__2(f));
end end

function everyU(_n, p) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      if (p(n.value) and everyU(n.left, p)) then do
        _n = n.right;
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every(n, p) do
  return everyU(n, Curry.__1(p));
end end

function someU(_n, p) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      if (p(n.value) or someU(n.left, p)) then do
        return true;
      end else do
        _n = n.right;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some(n, p) do
  return someU(n, Curry.__1(p));
end end

function addMinElement(n, v) do
  if (n ~= nil) then do
    return bal(addMinElement(n.left, v), n.value, n.right);
  end else do
    return singleton(v);
  end end 
end end

function addMaxElement(n, v) do
  if (n ~= nil) then do
    return bal(n.left, n.value, addMaxElement(n.right, v));
  end else do
    return singleton(v);
  end end 
end end

function joinShared(ln, v, rn) do
  if (ln ~= nil) then do
    if (rn ~= nil) then do
      lh = ln.height;
      rh = rn.height;
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
end end

function concatShared(t1, t2) do
  if (t1 ~= nil) then do
    if (t2 ~= nil) then do
      v = {
        contents = t2.value
      };
      t2r = removeMinAuxWithRef(t2, v);
      return joinShared(t1, v.contents, t2r);
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function partitionSharedU(n, p) do
  if (n ~= nil) then do
    value = n.value;
    match = partitionSharedU(n.left, p);
    lf = match[1];
    lt = match[0];
    pv = p(value);
    match_1 = partitionSharedU(n.right, p);
    rf = match_1[1];
    rt = match_1[0];
    if (pv) then do
      return --[[ tuple ]]{
              joinShared(lt, value, rt),
              concatShared(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              concatShared(lt, rt),
              joinShared(lf, value, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            nil,
            nil
          };
  end end 
end end

function partitionShared(n, p) do
  return partitionSharedU(n, Curry.__1(p));
end end

function lengthNode(n) do
  l = n.left;
  r = n.right;
  sizeL = l ~= nil and lengthNode(l) or 0;
  sizeR = r ~= nil and lengthNode(r) or 0;
  return (1 + sizeL | 0) + sizeR | 0;
end end

function size(n) do
  if (n ~= nil) then do
    return lengthNode(n);
  end else do
    return 0;
  end end 
end end

function toListAux(_n, _accu) do
  while(true) do
    accu = _accu;
    n = _n;
    if (n ~= nil) then do
      _accu = --[[ :: ]]{
        n.value,
        toListAux(n.right, accu)
      };
      _n = n.left;
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function toList(s) do
  return toListAux(s, --[[ [] ]]0);
end end

function checkInvariantInternal(_v) do
  while(true) do
    v = _v;
    if (v ~= nil) then do
      l = v.left;
      r = v.right;
      diff = treeHeight(l) - treeHeight(r) | 0;
      if (not (diff <= 2 and diff >= -2)) then do
        error(new Error("File \"belt_internalAVLset.ml\", line 304, characters 6-12"))
      end
       end 
      checkInvariantInternal(l);
      _v = r;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fillArray(_n, _i, arr) do
  while(true) do
    i = _i;
    n = _n;
    l = n.left;
    v = n.value;
    r = n.right;
    next = l ~= nil and fillArray(l, i, arr) or i;
    arr[next] = v;
    rnext = next + 1 | 0;
    if (r ~= nil) then do
      _i = rnext;
      _n = r;
      ::continue:: ;
    end else do
      return rnext;
    end end 
  end;
end end

function fillArrayWithPartition(_n, cursor, arr, p) do
  while(true) do
    n = _n;
    l = n.left;
    v = n.value;
    r = n.right;
    if (l ~= nil) then do
      fillArrayWithPartition(l, cursor, arr, p);
    end
     end 
    if (p(v)) then do
      c = cursor.forward;
      arr[c] = v;
      cursor.forward = c + 1 | 0;
    end else do
      c_1 = cursor.backward;
      arr[c_1] = v;
      cursor.backward = c_1 - 1 | 0;
    end end 
    if (r ~= nil) then do
      _n = r;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fillArrayWithFilter(_n, _i, arr, p) do
  while(true) do
    i = _i;
    n = _n;
    l = n.left;
    v = n.value;
    r = n.right;
    next = l ~= nil and fillArrayWithFilter(l, i, arr, p) or i;
    rnext = p(v) and (arr[next] = v, next + 1 | 0) or next;
    if (r ~= nil) then do
      _i = rnext;
      _n = r;
      ::continue:: ;
    end else do
      return rnext;
    end end 
  end;
end end

function toArray(n) do
  if (n ~= nil) then do
    size = lengthNode(n);
    v = new Array(size);
    fillArray(n, 0, v);
    return v;
  end else do
    return {};
  end end 
end end

function fromSortedArrayRevAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ == 0 then do
        return nil; end end 
     if ___conditional___ == 1 then do
        return singleton(arr[off]); end end 
     if ___conditional___ == 2 then do
        x0 = arr[off];
        x1 = arr[off - 1 | 0];
        return {
                value = x1,
                height = 2,
                left = singleton(x0),
                right = nil
              }; end end 
     if ___conditional___ == 3 then do
        x0_1 = arr[off];
        x1_1 = arr[off - 1 | 0];
        x2 = arr[off - 2 | 0];
        return {
                value = x1_1,
                height = 2,
                left = singleton(x0_1),
                right = singleton(x2)
              }; end end 
    nl = len / 2 | 0;
      left = fromSortedArrayRevAux(arr, off, nl);
      mid = arr[off - nl | 0];
      right = fromSortedArrayRevAux(arr, (off - nl | 0) - 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, mid, right);
      
  end
end end

function fromSortedArrayAux(arr, off, len) do
  local ___conditional___=(len);
  do
     if ___conditional___ == 0 then do
        return nil; end end 
     if ___conditional___ == 1 then do
        return singleton(arr[off]); end end 
     if ___conditional___ == 2 then do
        x0 = arr[off];
        x1 = arr[off + 1 | 0];
        return {
                value = x1,
                height = 2,
                left = singleton(x0),
                right = nil
              }; end end 
     if ___conditional___ == 3 then do
        x0_1 = arr[off];
        x1_1 = arr[off + 1 | 0];
        x2 = arr[off + 2 | 0];
        return {
                value = x1_1,
                height = 2,
                left = singleton(x0_1),
                right = singleton(x2)
              }; end end 
    nl = len / 2 | 0;
      left = fromSortedArrayAux(arr, off, nl);
      mid = arr[off + nl | 0];
      right = fromSortedArrayAux(arr, (off + nl | 0) + 1 | 0, (len - nl | 0) - 1 | 0);
      return create(left, mid, right);
      
  end
end end

function fromSortedArrayUnsafe(arr) do
  return fromSortedArrayAux(arr, 0, #arr);
end end

function keepSharedU(n, p) do
  if (n ~= nil) then do
    l = n.left;
    v = n.value;
    r = n.right;
    newL = keepSharedU(l, p);
    pv = p(v);
    newR = keepSharedU(r, p);
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
    return nil;
  end end 
end end

function keepShared(n, p) do
  return keepSharedU(n, Curry.__1(p));
end end

function keepCopyU(n, p) do
  if (n ~= nil) then do
    size = lengthNode(n);
    v = new Array(size);
    last = fillArrayWithFilter(n, 0, v, p);
    return fromSortedArrayAux(v, 0, last);
  end else do
    return nil;
  end end 
end end

function keepCopy(n, p) do
  return keepCopyU(n, Curry.__1(p));
end end

function partitionCopyU(n, p) do
  if (n ~= nil) then do
    size = lengthNode(n);
    v = new Array(size);
    backward = size - 1 | 0;
    cursor = {
      forward = 0,
      backward = backward
    };
    fillArrayWithPartition(n, cursor, v, p);
    forwardLen = cursor.forward;
    return --[[ tuple ]]{
            fromSortedArrayAux(v, 0, forwardLen),
            fromSortedArrayRevAux(v, backward, size - forwardLen | 0)
          };
  end else do
    return --[[ tuple ]]{
            nil,
            nil
          };
  end end 
end end

function partitionCopy(n, p) do
  return partitionCopyU(n, Curry.__1(p));
end end

function has(_t, x, cmp) do
  while(true) do
    t = _t;
    if (t ~= nil) then do
      v = t.value;
      c = cmp(x, v);
      if (c == 0) then do
        return true;
      end else do
        _t = c < 0 and t.left or t.right;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function cmp(s1, s2, cmp_1) do
  len1 = size(s1);
  len2 = size(s2);
  if (len1 == len2) then do
    _e1 = stackAllLeft(s1, --[[ [] ]]0);
    _e2 = stackAllLeft(s2, --[[ [] ]]0);
    cmp_2 = cmp_1;
    while(true) do
      e2 = _e2;
      e1 = _e1;
      if (e1 and e2) then do
        h2 = e2[0];
        h1 = e1[0];
        c = cmp_2(h1.value, h2.value);
        if (c == 0) then do
          _e2 = stackAllLeft(h2.right, e2[1]);
          _e1 = stackAllLeft(h1.right, e1[1]);
          ::continue:: ;
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
end end

function eq(s1, s2, c) do
  return cmp(s1, s2, c) == 0;
end end

function subset(_s1, _s2, cmp) do
  while(true) do
    s2 = _s2;
    s1 = _s1;
    if (s1 ~= nil) then do
      if (s2 ~= nil) then do
        l1 = s1.left;
        v1 = s1.value;
        r1 = s1.right;
        l2 = s2.left;
        v2 = s2.value;
        r2 = s2.right;
        c = cmp(v1, v2);
        if (c == 0) then do
          if (subset(l1, l2, cmp)) then do
            _s2 = r2;
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (c < 0) then do
          if (subset(create(l1, v1, nil), l2, cmp)) then do
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (subset(create(nil, v1, r1), r2, cmp)) then do
          _s1 = l1;
          ::continue:: ;
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
end end

function get(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.value;
      c = cmp(x, v);
      if (c == 0) then do
        return Caml_option.some(v);
      end else do
        _n = c < 0 and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getUndefined(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.value;
      c = cmp(x, v);
      if (c == 0) then do
        return v;
      end else do
        _n = c < 0 and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getExn(_n, x, cmp) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.value;
      c = cmp(x, v);
      if (c == 0) then do
        return v;
      end else do
        _n = c < 0 and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      error(new Error("getExn0"))
    end end 
  end;
end end

function rotateWithLeftChild(k2) do
  k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  hlk2 = treeHeight(k2.left);
  hrk2 = treeHeight(k2.right);
  k2.height = (
    hlk2 > hrk2 and hlk2 or hrk2
  ) + 1 | 0;
  hlk1 = treeHeight(k1.left);
  hk2 = k2.height;
  k1.height = (
    hlk1 > hk2 and hlk1 or hk2
  ) + 1 | 0;
  return k1;
end end

function rotateWithRightChild(k1) do
  k2 = k1.right;
  k1.right = k2.left;
  k2.left = k1;
  hlk1 = treeHeight(k1.left);
  hrk1 = treeHeight(k1.right);
  k1.height = (
    hlk1 > hrk1 and hlk1 or hrk1
  ) + 1 | 0;
  hrk2 = treeHeight(k2.right);
  hk1 = k1.height;
  k2.height = (
    hrk2 > hk1 and hrk2 or hk1
  ) + 1 | 0;
  return k2;
end end

function doubleWithLeftChild(k3) do
  v = rotateWithRightChild(k3.left);
  k3.left = v;
  return rotateWithLeftChild(k3);
end end

function doubleWithRightChild(k2) do
  v = rotateWithLeftChild(k2.right);
  k2.right = v;
  return rotateWithRightChild(k2);
end end

function heightUpdateMutate(t) do
  hlt = treeHeight(t.left);
  hrt = treeHeight(t.right);
  t.height = (
    hlt > hrt and hlt or hrt
  ) + 1 | 0;
  return t;
end end

function balMutate(nt) do
  l = nt.left;
  r = nt.right;
  hl = treeHeight(l);
  hr = treeHeight(r);
  if (hl > (2 + hr | 0)) then do
    ll = l.left;
    lr = l.right;
    if (heightGe(ll, lr)) then do
      return heightUpdateMutate(rotateWithLeftChild(nt));
    end else do
      return heightUpdateMutate(doubleWithLeftChild(nt));
    end end 
  end else if (hr > (2 + hl | 0)) then do
    rl = r.left;
    rr = r.right;
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
end end

function addMutate(cmp, t, x) do
  if (t ~= nil) then do
    k = t.value;
    c = cmp(x, k);
    if (c == 0) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (c < 0) then do
        ll = addMutate(cmp, l, x);
        t.left = ll;
      end else do
        t.right = addMutate(cmp, r, x);
      end end 
      return balMutate(t);
    end end 
  end else do
    return singleton(x);
  end end 
end end

function fromArray(xs, cmp) do
  len = #xs;
  if (len == 0) then do
    return nil;
  end else do
    next = Belt_SortArray.strictlySortedLengthU(xs, (function(x, y) do
            return cmp(x, y) < 0;
          end end));
    result;
    if (next >= 0) then do
      result = fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for i = next , len - 1 | 0 , 1 do
      result = addMutate(cmp, result, xs[i]);
    end
    return result;
  end end 
end end

function removeMinAuxWithRootMutate(nt, n) do
  rn = n.right;
  ln = n.left;
  if (ln ~= nil) then do
    n.left = removeMinAuxWithRootMutate(nt, ln);
    return balMutate(n);
  end else do
    nt.value = n.value;
    return rn;
  end end 
end end

export do
  copy ,
  create ,
  bal ,
  singleton ,
  minimum ,
  minUndefined ,
  maximum ,
  maxUndefined ,
  removeMinAuxWithRef ,
  isEmpty ,
  stackAllLeft ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  everyU ,
  every ,
  someU ,
  some ,
  joinShared ,
  concatShared ,
  keepSharedU ,
  keepShared ,
  keepCopyU ,
  keepCopy ,
  partitionSharedU ,
  partitionShared ,
  partitionCopyU ,
  partitionCopy ,
  lengthNode ,
  size ,
  toList ,
  checkInvariantInternal ,
  fillArray ,
  toArray ,
  fromSortedArrayAux ,
  fromSortedArrayRevAux ,
  fromSortedArrayUnsafe ,
  has ,
  cmp ,
  eq ,
  subset ,
  get ,
  getUndefined ,
  getExn ,
  fromArray ,
  addMutate ,
  balMutate ,
  removeMinAuxWithRootMutate ,
  
end
--[[ No side effect ]]
