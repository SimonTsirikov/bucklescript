

local Belt_internalAVLset = require "..belt_internalAVLset.lua";

function add(t, x, cmp) do
  if (t ~= nil) then do
    k = t.value;
    c = cmp(x, k);
    if (c == 0) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (c < 0) then do
        ll = add(l, x, cmp);
        if (ll == l) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(ll, k, r);
        end end 
      end else do
        rr = add(r, x, cmp);
        if (rr == r) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(l, k, rr);
        end end 
      end end 
    end end 
  end else do
    return Belt_internalAVLset.singleton(x);
  end end 
end end

function remove(t, x, cmp) do
  if (t ~= nil) then do
    l = t.left;
    v = t.value;
    r = t.right;
    c = cmp(x, v);
    if (c == 0) then do
      if (l ~= nil) then do
        if (r ~= nil) then do
          v_1 = {
            contents = r.value
          };
          r_1 = Belt_internalAVLset.removeMinAuxWithRef(r, v_1);
          return Belt_internalAVLset.bal(l, v_1.contents, r_1);
        end else do
          return l;
        end end 
      end else do
        return r;
      end end 
    end else if (c < 0) then do
      ll = remove(l, x, cmp);
      if (ll == l) then do
        return t;
      end else do
        return Belt_internalAVLset.bal(ll, v, r);
      end end 
    end else do
      rr = remove(r, x, cmp);
      if (rr == r) then do
        return t;
      end else do
        return Belt_internalAVLset.bal(l, v, rr);
      end end 
    end end  end 
  end else do
    return t;
  end end 
end end

function mergeMany(h, arr, cmp) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    key = arr[i];
    v = add(v, key, cmp);
  end
  return v;
end end

function removeMany(h, arr, cmp) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    key = arr[i];
    v = remove(v, key, cmp);
  end
  return v;
end end

function splitAuxNoPivot(cmp, n, x) do
  l = n.left;
  v = n.value;
  r = n.right;
  c = cmp(x, v);
  if (c == 0) then do
    return --[[ tuple ]]{
            l,
            r
          };
  end else if (c < 0) then do
    if (l ~= nil) then do
      match = splitAuxNoPivot(cmp, l, x);
      return --[[ tuple ]]{
              match[1],
              Belt_internalAVLset.joinShared(match[2], v, r)
            };
    end else do
      return --[[ tuple ]]{
              nil,
              n
            };
    end end 
  end else if (r ~= nil) then do
    match_1 = splitAuxNoPivot(cmp, r, x);
    return --[[ tuple ]]{
            Belt_internalAVLset.joinShared(l, v, match_1[1]),
            match_1[2]
          };
  end else do
    return --[[ tuple ]]{
            n,
            nil
          };
  end end  end  end 
end end

function splitAuxPivot(cmp, n, x, pres) do
  l = n.left;
  v = n.value;
  r = n.right;
  c = cmp(x, v);
  if (c == 0) then do
    pres.contents = true;
    return --[[ tuple ]]{
            l,
            r
          };
  end else if (c < 0) then do
    if (l ~= nil) then do
      match = splitAuxPivot(cmp, l, x, pres);
      return --[[ tuple ]]{
              match[1],
              Belt_internalAVLset.joinShared(match[2], v, r)
            };
    end else do
      return --[[ tuple ]]{
              nil,
              n
            };
    end end 
  end else if (r ~= nil) then do
    match_1 = splitAuxPivot(cmp, r, x, pres);
    return --[[ tuple ]]{
            Belt_internalAVLset.joinShared(l, v, match_1[1]),
            match_1[2]
          };
  end else do
    return --[[ tuple ]]{
            n,
            nil
          };
  end end  end  end 
end end

function split(t, x, cmp) do
  if (t ~= nil) then do
    pres = {
      contents = false
    };
    v = splitAuxPivot(cmp, t, x, pres);
    return --[[ tuple ]]{
            v,
            pres.contents
          };
  end else do
    return --[[ tuple ]]{
            --[[ tuple ]]{
              nil,
              nil
            },
            false
          };
  end end 
end end

function union(s1, s2, cmp) do
  if (s1 ~= nil) then do
    if (s2 ~= nil) then do
      h1 = s1.height;
      h2 = s2.height;
      if (h1 >= h2) then do
        if (h2 == 1) then do
          return add(s1, s2.value, cmp);
        end else do
          l1 = s1.left;
          v1 = s1.value;
          r1 = s1.right;
          match = splitAuxNoPivot(cmp, s2, v1);
          return Belt_internalAVLset.joinShared(union(l1, match[1], cmp), v1, union(r1, match[2], cmp));
        end end 
      end else if (h1 == 1) then do
        return add(s2, s1.value, cmp);
      end else do
        l2 = s2.left;
        v2 = s2.value;
        r2 = s2.right;
        match_1 = splitAuxNoPivot(cmp, s1, v2);
        return Belt_internalAVLset.joinShared(union(match_1[1], l2, cmp), v2, union(match_1[2], r2, cmp));
      end end  end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function intersect(s1, s2, cmp) do
  if (s1 ~= nil and s2 ~= nil) then do
    l1 = s1.left;
    v1 = s1.value;
    r1 = s1.right;
    pres = {
      contents = false
    };
    match = splitAuxPivot(cmp, s2, v1, pres);
    ll = intersect(l1, match[1], cmp);
    rr = intersect(r1, match[2], cmp);
    if (pres.contents) then do
      return Belt_internalAVLset.joinShared(ll, v1, rr);
    end else do
      return Belt_internalAVLset.concatShared(ll, rr);
    end end 
  end else do
    return nil;
  end end 
end end

function diff(s1, s2, cmp) do
  if (s1 ~= nil and s2 ~= nil) then do
    l1 = s1.left;
    v1 = s1.value;
    r1 = s1.right;
    pres = {
      contents = false
    };
    match = splitAuxPivot(cmp, s2, v1, pres);
    ll = diff(l1, match[1], cmp);
    rr = diff(r1, match[2], cmp);
    if (pres.contents) then do
      return Belt_internalAVLset.concatShared(ll, rr);
    end else do
      return Belt_internalAVLset.joinShared(ll, v1, rr);
    end end 
  end else do
    return s1;
  end end 
end end

empty = nil;

fromArray = Belt_internalAVLset.fromArray;

fromSortedArrayUnsafe = Belt_internalAVLset.fromSortedArrayUnsafe;

isEmpty = Belt_internalAVLset.isEmpty;

has = Belt_internalAVLset.has;

subset = Belt_internalAVLset.subset;

cmp = Belt_internalAVLset.cmp;

eq = Belt_internalAVLset.eq;

forEachU = Belt_internalAVLset.forEachU;

forEach = Belt_internalAVLset.forEach;

reduceU = Belt_internalAVLset.reduceU;

reduce = Belt_internalAVLset.reduce;

everyU = Belt_internalAVLset.everyU;

every = Belt_internalAVLset.every;

someU = Belt_internalAVLset.someU;

some = Belt_internalAVLset.some;

keepU = Belt_internalAVLset.keepSharedU;

keep = Belt_internalAVLset.keepShared;

partitionU = Belt_internalAVLset.partitionSharedU;

partition = Belt_internalAVLset.partitionShared;

size = Belt_internalAVLset.size;

toList = Belt_internalAVLset.toList;

toArray = Belt_internalAVLset.toArray;

minimum = Belt_internalAVLset.minimum;

minUndefined = Belt_internalAVLset.minUndefined;

maximum = Belt_internalAVLset.maximum;

maxUndefined = Belt_internalAVLset.maxUndefined;

get = Belt_internalAVLset.get;

getUndefined = Belt_internalAVLset.getUndefined;

getExn = Belt_internalAVLset.getExn;

checkInvariantInternal = Belt_internalAVLset.checkInvariantInternal;

export do
  empty ,
  fromArray ,
  fromSortedArrayUnsafe ,
  isEmpty ,
  has ,
  add ,
  mergeMany ,
  remove ,
  removeMany ,
  union ,
  intersect ,
  diff ,
  subset ,
  cmp ,
  eq ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  everyU ,
  every ,
  someU ,
  some ,
  keepU ,
  keep ,
  partitionU ,
  partition ,
  size ,
  toList ,
  toArray ,
  minimum ,
  minUndefined ,
  maximum ,
  maxUndefined ,
  get ,
  getUndefined ,
  getExn ,
  split ,
  checkInvariantInternal ,
  
end
--[[ No side effect ]]
