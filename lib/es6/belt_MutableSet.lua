

local Curry = require "..curry.lua";
local Belt_SortArray = require "..belt_SortArray.lua";
local Belt_internalAVLset = require "..belt_internalAVLset.lua";

function remove0(nt, x, cmp) do
  k = nt.value;
  c = cmp(x, k);
  if (c == 0) then do
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
  end else if (c < 0) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = remove0(match, x, cmp);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match_1 = nt.right;
    if (match_1 ~= nil) then do
      nt.right = remove0(match_1, x, cmp);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function remove(d, v) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    newRoot = remove0(oldRoot, v, d.cmp);
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

function removeMany0(_t, xs, _i, len, cmp) do
  while(true) do
    i = _i;
    t = _t;
    if (i < len) then do
      ele = xs[i];
      u = remove0(t, ele, cmp);
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
    d.data = removeMany0(oldRoot, xs, 0, len, d.cmp);
    return --[[ () ]]0;
  end else do
    return --[[ () ]]0;
  end end 
end end

function removeCheck0(nt, x, removed, cmp) do
  k = nt.value;
  c = cmp(x, k);
  if (c == 0) then do
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
  end else if (c < 0) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = removeCheck0(match, x, removed, cmp);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match_1 = nt.right;
    if (match_1 ~= nil) then do
      nt.right = removeCheck0(match_1, x, removed, cmp);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function removeCheck(d, v) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    removed = {
      contents = false
    };
    newRoot = removeCheck0(oldRoot, v, removed, d.cmp);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
    end
     end 
    return removed.contents;
  end else do
    return false;
  end end 
end end

function addCheck0(t, x, added, cmp) do
  if (t ~= nil) then do
    k = t.value;
    c = cmp(x, k);
    if (c == 0) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (c < 0) then do
        ll = addCheck0(l, x, added, cmp);
        t.left = ll;
      end else do
        t.right = addCheck0(r, x, added, cmp);
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
  added = {
    contents = false
  };
  newRoot = addCheck0(oldRoot, e, added, m.cmp);
  if (newRoot ~= oldRoot) then do
    m.data = newRoot;
  end
   end 
  return added.contents;
end end

function add(m, e) do
  oldRoot = m.data;
  newRoot = Belt_internalAVLset.addMutate(m.cmp, oldRoot, e);
  if (newRoot ~= oldRoot) then do
    m.data = newRoot;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function addArrayMutate(t, xs, cmp) do
  v = t;
  for i = 0 , #xs - 1 | 0 , 1 do
    v = Belt_internalAVLset.addMutate(cmp, v, xs[i]);
  end
  return v;
end end

function mergeMany(d, xs) do
  d.data = addArrayMutate(d.data, xs, d.cmp);
  return --[[ () ]]0;
end end

function make(id) do
  return {
          cmp = id.cmp,
          data = nil
        };
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

function fromSortedArrayUnsafe(xs, id) do
  return {
          cmp = id.cmp,
          data = Belt_internalAVLset.fromSortedArrayUnsafe(xs)
        };
end end

function checkInvariantInternal(d) do
  return Belt_internalAVLset.checkInvariantInternal(d.data);
end end

function fromArray(data, id) do
  cmp = id.cmp;
  return {
          cmp = cmp,
          data = Belt_internalAVLset.fromArray(data, cmp)
        };
end end

function cmp(d0, d1) do
  return Belt_internalAVLset.cmp(d0.data, d1.data, d0.cmp);
end end

function eq(d0, d1) do
  return Belt_internalAVLset.eq(d0.data, d1.data, d0.cmp);
end end

function get(d, x) do
  return Belt_internalAVLset.get(d.data, x, d.cmp);
end end

function getUndefined(d, x) do
  return Belt_internalAVLset.getUndefined(d.data, x, d.cmp);
end end

function getExn(d, x) do
  return Belt_internalAVLset.getExn(d.data, x, d.cmp);
end end

function split(d, key) do
  arr = Belt_internalAVLset.toArray(d.data);
  cmp = d.cmp;
  i = Belt_SortArray.binarySearchByU(arr, key, cmp);
  len = #arr;
  if (i < 0) then do
    next = (-i | 0) - 1 | 0;
    return --[[ tuple ]]{
            --[[ tuple ]]{
              {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(arr, 0, next)
              },
              {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(arr, next, len - next | 0)
              }
            },
            false
          };
  end else do
    return --[[ tuple ]]{
            --[[ tuple ]]{
              {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(arr, 0, i)
              },
              {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(arr, i + 1 | 0, (len - i | 0) - 1 | 0)
              }
            },
            true
          };
  end end 
end end

function keepU(d, p) do
  return {
          cmp = d.cmp,
          data = Belt_internalAVLset.keepCopyU(d.data, p)
        };
end end

function keep(d, p) do
  return keepU(d, Curry.__1(p));
end end

function partitionU(d, p) do
  cmp = d.cmp;
  match = Belt_internalAVLset.partitionCopyU(d.data, p);
  return --[[ tuple ]]{
          {
            cmp = cmp,
            data = match[1]
          },
          {
            cmp = cmp,
            data = match[2]
          }
        };
end end

function partition(d, p) do
  return partitionU(d, Curry.__1(p));
end end

function subset(a, b) do
  return Belt_internalAVLset.subset(a.data, b.data, a.cmp);
end end

function intersect(a, b) do
  cmp = a.cmp;
  match = a.data;
  match_1 = b.data;
  if (match ~= nil) then do
    if (match_1 ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(match);
      sizeb = Belt_internalAVLset.lengthNode(match_1);
      totalSize = sizea + sizeb | 0;
      tmp = new __Array(totalSize);
      Belt_internalAVLset.fillArray(match, 0, tmp);
      Belt_internalAVLset.fillArray(match_1, sizea, tmp);
      if (cmp(tmp[sizea - 1 | 0], tmp[sizea]) < 0 or cmp(tmp[totalSize - 1 | 0], tmp[0]) < 0) then do
        return {
                cmp = cmp,
                data = nil
              };
      end else do
        tmp2 = new __Array(sizea < sizeb and sizea or sizeb);
        k = Belt_SortArray.intersectU(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0, cmp);
        return {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              };
      end end 
    end else do
      return {
              cmp = cmp,
              data = nil
            };
    end end 
  end else do
    return {
            cmp = cmp,
            data = nil
          };
  end end 
end end

function diff(a, b) do
  cmp = a.cmp;
  dataa = a.data;
  match = b.data;
  if (dataa ~= nil) then do
    if (match ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(dataa);
      sizeb = Belt_internalAVLset.lengthNode(match);
      totalSize = sizea + sizeb | 0;
      tmp = new __Array(totalSize);
      Belt_internalAVLset.fillArray(dataa, 0, tmp);
      Belt_internalAVLset.fillArray(match, sizea, tmp);
      if (cmp(tmp[sizea - 1 | 0], tmp[sizea]) < 0 or cmp(tmp[totalSize - 1 | 0], tmp[0]) < 0) then do
        return {
                cmp = cmp,
                data = Belt_internalAVLset.copy(dataa)
              };
      end else do
        tmp2 = new __Array(sizea);
        k = Belt_SortArray.diffU(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0, cmp);
        return {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              };
      end end 
    end else do
      return {
              cmp = cmp,
              data = Belt_internalAVLset.copy(dataa)
            };
    end end 
  end else do
    return {
            cmp = cmp,
            data = nil
          };
  end end 
end end

function union(a, b) do
  cmp = a.cmp;
  dataa = a.data;
  datab = b.data;
  if (dataa ~= nil) then do
    if (datab ~= nil) then do
      sizea = Belt_internalAVLset.lengthNode(dataa);
      sizeb = Belt_internalAVLset.lengthNode(datab);
      totalSize = sizea + sizeb | 0;
      tmp = new __Array(totalSize);
      Belt_internalAVLset.fillArray(dataa, 0, tmp);
      Belt_internalAVLset.fillArray(datab, sizea, tmp);
      if (cmp(tmp[sizea - 1 | 0], tmp[sizea]) < 0) then do
        return {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(tmp, 0, totalSize)
              };
      end else do
        tmp2 = new __Array(totalSize);
        k = Belt_SortArray.unionU(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0, cmp);
        return {
                cmp = cmp,
                data = Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              };
      end end 
    end else do
      return {
              cmp = cmp,
              data = Belt_internalAVLset.copy(dataa)
            };
    end end 
  end else do
    return {
            cmp = cmp,
            data = Belt_internalAVLset.copy(datab)
          };
  end end 
end end

function has(d, x) do
  return Belt_internalAVLset.has(d.data, x, d.cmp);
end end

function copy(d) do
  return {
          cmp = d.cmp,
          data = Belt_internalAVLset.copy(d.data)
        };
end end

Int = --[[ alias ]]0;

__String = --[[ alias ]]0;

export do
  Int ,
  __String ,
  make ,
  fromArray ,
  fromSortedArrayUnsafe ,
  copy ,
  isEmpty ,
  has ,
  add ,
  addCheck ,
  mergeMany ,
  remove ,
  removeCheck ,
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
