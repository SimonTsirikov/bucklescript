console = {log = print};

Belt_internalAVLset = require "./belt_internalAVLset";
Belt_internalSetInt = require "./belt_internalSetInt";

function add(t, x) do
  if (t ~= nil) then do
    v = t.value;
    if (x == v) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (x < v) then do
        ll = add(l, x);
        if (ll == l) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(ll, v, r);
        end end 
      end else do
        rr = add(r, x);
        if (rr == r) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(l, v, rr);
        end end 
      end end 
    end end 
  end else do
    return Belt_internalAVLset.singleton(x);
  end end 
end end

function mergeMany(h, arr) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    key = arr[i];
    v = add(v, key);
  end
  return v;
end end

function remove(t, x) do
  if (t ~= nil) then do
    l = t.left;
    v = t.value;
    r = t.right;
    if (x == v) then do
      if (l ~= nil) then do
        if (r ~= nil) then do
          v_1 = do
            contents: r.value
          end;
          r_1 = Belt_internalAVLset.removeMinAuxWithRef(r, v_1);
          return Belt_internalAVLset.bal(l, v_1.contents, r_1);
        end else do
          return l;
        end end 
      end else do
        return r;
      end end 
    end else if (x < v) then do
      ll = remove(l, x);
      if (ll == l) then do
        return t;
      end else do
        return Belt_internalAVLset.bal(ll, v, r);
      end end 
    end else do
      rr = remove(r, x);
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

function removeMany(h, arr) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    key = arr[i];
    v = remove(v, key);
  end
  return v;
end end

function splitAuxNoPivot(n, x) do
  l = n.left;
  v = n.value;
  r = n.right;
  if (x == v) then do
    return --[[ tuple ]]{
            l,
            r
          };
  end else if (x < v) then do
    if (l ~= nil) then do
      match = splitAuxNoPivot(l, x);
      return --[[ tuple ]]{
              match[0],
              Belt_internalAVLset.joinShared(match[1], v, r)
            };
    end else do
      return --[[ tuple ]]{
              nil,
              n
            };
    end end 
  end else if (r ~= nil) then do
    match_1 = splitAuxNoPivot(r, x);
    return --[[ tuple ]]{
            Belt_internalAVLset.joinShared(l, v, match_1[0]),
            match_1[1]
          };
  end else do
    return --[[ tuple ]]{
            n,
            nil
          };
  end end  end  end 
end end

function splitAuxPivot(n, x, pres) do
  l = n.left;
  v = n.value;
  r = n.right;
  if (x == v) then do
    pres.contents = true;
    return --[[ tuple ]]{
            l,
            r
          };
  end else if (x < v) then do
    if (l ~= nil) then do
      match = splitAuxPivot(l, x, pres);
      return --[[ tuple ]]{
              match[0],
              Belt_internalAVLset.joinShared(match[1], v, r)
            };
    end else do
      return --[[ tuple ]]{
              nil,
              n
            };
    end end 
  end else if (r ~= nil) then do
    match_1 = splitAuxPivot(r, x, pres);
    return --[[ tuple ]]{
            Belt_internalAVLset.joinShared(l, v, match_1[0]),
            match_1[1]
          };
  end else do
    return --[[ tuple ]]{
            n,
            nil
          };
  end end  end  end 
end end

function split(t, x) do
  if (t ~= nil) then do
    pres = do
      contents: false
    end;
    v = splitAuxPivot(t, x, pres);
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

function union(s1, s2) do
  if (s1 ~= nil) then do
    if (s2 ~= nil) then do
      h1 = s1.height;
      h2 = s2.height;
      if (h1 >= h2) then do
        if (h2 == 1) then do
          return add(s1, s2.value);
        end else do
          l1 = s1.left;
          v1 = s1.value;
          r1 = s1.right;
          match = splitAuxNoPivot(s2, v1);
          return Belt_internalAVLset.joinShared(union(l1, match[0]), v1, union(r1, match[1]));
        end end 
      end else if (h1 == 1) then do
        return add(s2, s1.value);
      end else do
        l2 = s2.left;
        v2 = s2.value;
        r2 = s2.right;
        match_1 = splitAuxNoPivot(s1, v2);
        return Belt_internalAVLset.joinShared(union(match_1[0], l2), v2, union(match_1[1], r2));
      end end  end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function intersect(s1, s2) do
  if (s1 ~= nil and s2 ~= nil) then do
    l1 = s1.left;
    v1 = s1.value;
    r1 = s1.right;
    pres = do
      contents: false
    end;
    match = splitAuxPivot(s2, v1, pres);
    ll = intersect(l1, match[0]);
    rr = intersect(r1, match[1]);
    if (pres.contents) then do
      return Belt_internalAVLset.joinShared(ll, v1, rr);
    end else do
      return Belt_internalAVLset.concatShared(ll, rr);
    end end 
  end else do
    return nil;
  end end 
end end

function diff(s1, s2) do
  if (s1 ~= nil and s2 ~= nil) then do
    l1 = s1.left;
    v1 = s1.value;
    r1 = s1.right;
    pres = do
      contents: false
    end;
    match = splitAuxPivot(s2, v1, pres);
    ll = diff(l1, match[0]);
    rr = diff(r1, match[1]);
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

fromArray = Belt_internalSetInt.fromArray;

fromSortedArrayUnsafe = Belt_internalAVLset.fromSortedArrayUnsafe;

isEmpty = Belt_internalAVLset.isEmpty;

has = Belt_internalSetInt.has;

subset = Belt_internalSetInt.subset;

cmp = Belt_internalSetInt.cmp;

eq = Belt_internalSetInt.eq;

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

get = Belt_internalSetInt.get;

getUndefined = Belt_internalSetInt.getUndefined;

getExn = Belt_internalSetInt.getExn;

checkInvariantInternal = Belt_internalAVLset.checkInvariantInternal;

exports = {}
exports.empty = empty;
exports.fromArray = fromArray;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.isEmpty = isEmpty;
exports.has = has;
exports.add = add;
exports.mergeMany = mergeMany;
exports.remove = remove;
exports.removeMany = removeMany;
exports.union = union;
exports.intersect = intersect;
exports.diff = diff;
exports.subset = subset;
exports.cmp = cmp;
exports.eq = eq;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.keepU = keepU;
exports.keep = keep;
exports.partitionU = partitionU;
exports.partition = partition;
exports.size = size;
exports.toList = toList;
exports.toArray = toArray;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getExn = getExn;
exports.split = split;
exports.checkInvariantInternal = checkInvariantInternal;
--[[ No side effect ]]
