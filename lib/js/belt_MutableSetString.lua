--[['use strict';]]

Curry = require "./curry";
Belt_internalAVLset = require "./belt_internalAVLset";
Belt_SortArrayString = require "./belt_SortArrayString";
Belt_internalSetString = require "./belt_internalSetString";

function remove0(nt, x) do
  k = nt.value;
  if (x == k) then do
    l = nt.left;
    r = nt.right;
    if (l ~= nil) then do
      if (r ~= nil) then do
        nt.right = Belt_internalAVLset.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLset.balMutate(nt);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < k) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = remove0(match, x);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match$1 = nt.right;
    if (match$1 ~= nil) then do
      nt.right = remove0(match$1, x);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function remove(d, v) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    newRoot = remove0(oldRoot, v);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function removeMany0(_t, xs, _i, len) do
  while(true) do
    i = _i;
    t = _t;
    if (i < len) then do
      ele = xs[i];
      u = remove0(t, ele);
      if (u ~= nil) then do
        _i = i + 1 | 0;
        _t = u;
        ::continue:: ;
      end else do
        return nil;
      end end 
    end else do
      return t;
    end end 
  end;
end end

function removeMany(d, xs) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    len = #xs;
    d.data = removeMany0(oldRoot, xs, 0, len);
    return --[[ () ]]0;
  end else do
    return --[[ () ]]0;
  end end 
end end

function removeCheck0(nt, x, removed) do
  k = nt.value;
  if (x == k) then do
    removed.contents = true;
    l = nt.left;
    r = nt.right;
    if (l ~= nil) then do
      if (r ~= nil) then do
        nt.right = Belt_internalAVLset.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLset.balMutate(nt);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < k) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = removeCheck0(match, x, removed);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match$1 = nt.right;
    if (match$1 ~= nil) then do
      nt.right = removeCheck0(match$1, x, removed);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function removeCheck(d, v) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    removed = do
      contents: false
    end;
    newRoot = removeCheck0(oldRoot, v, removed);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
    end
     end 
    return removed.contents;
  end else do
    return false;
  end end 
end end

function addCheck0(t, x, added) do
  if (t ~= nil) then do
    k = t.value;
    if (x == k) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (x < k) then do
        ll = addCheck0(l, x, added);
        t.left = ll;
      end else do
        t.right = addCheck0(r, x, added);
      end end 
      return Belt_internalAVLset.balMutate(t);
    end end 
  end else do
    added.contents = true;
    return Belt_internalAVLset.singleton(x);
  end end 
end end

function addCheck(m, e) do
  oldRoot = m.data;
  added = do
    contents: false
  end;
  newRoot = addCheck0(oldRoot, e, added);
  if (newRoot ~= oldRoot) then do
    m.data = newRoot;
  end
   end 
  return added.contents;
end end

function add(d, k) do
  oldRoot = d.data;
  v = Belt_internalSetString.addMutate(oldRoot, k);
  if (v ~= oldRoot) then do
    d.data = v;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function addArrayMutate(t, xs) do
  v = t;
  for i = 0 , #xs - 1 | 0 , 1 do
    v = Belt_internalSetString.addMutate(v, xs[i]);
  end
  return v;
end end

function mergeMany(d, arr) do
  d.data = addArrayMutate(d.data, arr);
  return --[[ () ]]0;
end end

function make(param) do
  return do
          data: nil
        end;
end end

function isEmpty(d) do
  n = d.data;
  return n == nil;
end end

function minimum(d) do
  return Belt_internalAVLset.minimum(d.data);
end end

function minUndefined(d) do
  return Belt_internalAVLset.minUndefined(d.data);
end end

function maximum(d) do
  return Belt_internalAVLset.maximum(d.data);
end end

function maxUndefined(d) do
  return Belt_internalAVLset.maxUndefined(d.data);
end end

function forEachU(d, f) do
  return Belt_internalAVLset.forEachU(d.data, f);
end end

function forEach(d, f) do
  return Belt_internalAVLset.forEachU(d.data, Curry.__1(f));
end end

function reduceU(d, acc, cb) do
  return Belt_internalAVLset.reduceU(d.data, acc, cb);
end end

function reduce(d, acc, cb) do
  return reduceU(d, acc, Curry.__2(cb));
end end

function everyU(d, p) do
  return Belt_internalAVLset.everyU(d.data, p);
end end

function every(d, p) do
  return Belt_internalAVLset.everyU(d.data, Curry.__1(p));
end end

function someU(d, p) do
  return Belt_internalAVLset.someU(d.data, p);
end end

function some(d, p) do
  return Belt_internalAVLset.someU(d.data, Curry.__1(p));
end end

function size(d) do
  return Belt_internalAVLset.size(d.data);
end end

function toList(d) do
  return Belt_internalAVLset.toList(d.data);
end end

function toArray(d) do
  return Belt_internalAVLset.toArray(d.data);
end end

function fromSortedArrayUnsafe(xs) do
  return do
          data: Belt_internalAVLset.fromSortedArrayUnsafe(xs)
        end;
end end

function checkInvariantInternal(d) do
  return Belt_internalAVLset.checkInvariantInternal(d.data);
end end

function fromArray(xs) do
  return do
          data: Belt_internalSetString.fromArray(xs)
        end;
end end

function cmp(d0, d1) do
  return Belt_internalSetString.cmp(d0.data, d1.data);
end end

function eq(d0, d1) do
  return Belt_internalSetString.eq(d0.data, d1.data);
end end

function get(d, x) do
  return Belt_internalSetString.get(d.data, x);
end end

function getUndefined(d, x) do
  return Belt_internalSetString.getUndefined(d.data, x);
end end

function getExn(d, x) do
  return Belt_internalSetString.getExn(d.data, x);
end end

function split(d, key) do
  arr = Belt_internalAVLset.toArray(d.data);
  i = Belt_SortArrayString.binarySearch(arr, key);
  len = #arr;
  if (i < 0) then do
    next = (-i | 0) - 1 | 0;
    return --[[ tuple ]]{
            --[[ tuple ]]{
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, 0, next)
              end,
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, next, len - next | 0)
              end
            },
            false
          };
  end else do
    return --[[ tuple ]]{
            --[[ tuple ]]{
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, 0, i)
              end,
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, i + 1 | 0, (len - i | 0) - 1 | 0)
              end
            },
            true
          };
  end end 
end end

function keepU(d, p) do
  return do
          data: Belt_internalAVLset.keepCopyU(d.data, p)
        end;
end end

function keep(d, p) do
  return keepU(d, Curry.__1(p));
end end

function partitionU(d, p) do
  match = Belt_internalAVLset.partitionCopyU(d.data, p);
  return --[[ tuple ]]{
          do
            data: match[0]
          end,
          do
            data: match[1]
          end
        };
end end

function partition(d, p) do
  return partitionU(d, Curry.__1(p));
end end

function subset(a, b) do
  return Belt_internalSetString.subset(a.data, b.data);
end end

function intersect(dataa, datab) do
  dataa$1 = dataa.data;
  datab$1 = datab.data;
  if (dataa$1 ~= nil) then do
    if (datab$1 ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(dataa$1);
      sizeb = Belt_internalAVLset.lengthNode(datab$1);
      totalSize = sizea + sizeb | 0;
      tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea] or tmp[totalSize - 1 | 0] < tmp[0]) then do
        return do
                data: nil
              end;
      end else do
        tmp2 = new Array(sizea < sizeb and sizea or sizeb);
        k = Belt_SortArrayString.intersect(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: nil
            end;
    end end 
  end else do
    return do
            data: nil
          end;
  end end 
end end

function diff(dataa, datab) do
  dataa$1 = dataa.data;
  datab$1 = datab.data;
  if (dataa$1 ~= nil) then do
    if (datab$1 ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(dataa$1);
      sizeb = Belt_internalAVLset.lengthNode(datab$1);
      totalSize = sizea + sizeb | 0;
      tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea] or tmp[totalSize - 1 | 0] < tmp[0]) then do
        return do
                data: Belt_internalAVLset.copy(dataa$1)
              end;
      end else do
        tmp2 = new Array(sizea);
        k = Belt_SortArrayString.diff(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: Belt_internalAVLset.copy(dataa$1)
            end;
    end end 
  end else do
    return do
            data: nil
          end;
  end end 
end end

function union(dataa, datab) do
  dataa$1 = dataa.data;
  datab$1 = datab.data;
  if (dataa$1 ~= nil) then do
    if (datab$1 ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(dataa$1);
      sizeb = Belt_internalAVLset.lengthNode(datab$1);
      totalSize = sizea + sizeb | 0;
      tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea]) then do
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp, 0, totalSize)
              end;
      end else do
        tmp2 = new Array(totalSize);
        k = Belt_SortArrayString.union(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: Belt_internalAVLset.copy(dataa$1)
            end;
    end end 
  end else do
    return do
            data: Belt_internalAVLset.copy(datab$1)
          end;
  end end 
end end

function has(d, x) do
  return Belt_internalSetString.has(d.data, x);
end end

function copy(d) do
  return do
          data: Belt_internalAVLset.copy(d.data)
        end;
end end

exports.make = make;
exports.fromArray = fromArray;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.copy = copy;
exports.isEmpty = isEmpty;
exports.has = has;
exports.add = add;
exports.addCheck = addCheck;
exports.mergeMany = mergeMany;
exports.remove = remove;
exports.removeCheck = removeCheck;
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
