--[['use strict';]]

Belt_internalSetBuckets = require "./belt_internalSetBuckets.lua";
Belt_internalBucketsType = require "./belt_internalBucketsType.lua";

function copyBucket(hash, h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    old_bucket = _old_bucket;
    if (old_bucket ~= undefined) then do
      nidx = hash(old_bucket.key) & (#h_buckets - 1 | 0);
      match = ndata_tail[nidx];
      if (match ~= undefined) then do
        match.next = old_bucket;
      end else do
        h_buckets[nidx] = old_bucket;
      end end 
      ndata_tail[nidx] = old_bucket;
      _old_bucket = old_bucket.next;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function remove(h, key) do
  eq = h.eq;
  h_buckets = h.buckets;
  i = h.hash(key) & (#h_buckets - 1 | 0);
  l = h_buckets[i];
  if (l ~= undefined) then do
    next_cell = l.next;
    if (eq(l.key, key)) then do
      h.size = h.size - 1 | 0;
      h_buckets[i] = next_cell;
      return --[[ () ]]0;
    end else if (next_cell ~= undefined) then do
      eq$1 = eq;
      h$1 = h;
      key$1 = key;
      _prec = l;
      _cell = next_cell;
      while(true) do
        cell = _cell;
        prec = _prec;
        cell_next = cell.next;
        if (eq$1(cell.key, key$1)) then do
          prec.next = cell_next;
          h$1.size = h$1.size - 1 | 0;
          return --[[ () ]]0;
        end else if (cell_next ~= undefined) then do
          _cell = cell_next;
          _prec = cell;
          continue ;
        end else do
          return --[[ () ]]0;
        end end  end 
      end;
    end else do
      return --[[ () ]]0;
    end end  end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function addBucket(h, key, _cell, eq) do
  while(true) do
    cell = _cell;
    if (eq(cell.key, key)) then do
      return 0;
    end else do
      n = cell.next;
      if (n ~= undefined) then do
        _cell = n;
        continue ;
      end else do
        h.size = h.size + 1 | 0;
        cell.next = do
          key: key,
          next: undefined
        end;
        return --[[ () ]]0;
      end end 
    end end 
  end;
end end

function add0(h, key, hash, eq) do
  h_buckets = h.buckets;
  buckets_len = #h_buckets;
  i = hash(key) & (buckets_len - 1 | 0);
  l = h_buckets[i];
  if (l ~= undefined) then do
    addBucket(h, key, l, eq);
  end else do
    h.size = h.size + 1 | 0;
    h_buckets[i] = do
      key: key,
      next: undefined
    end;
  end end 
  if (h.size > (buckets_len << 1)) then do
    hash$1 = hash;
    h$1 = h;
    odata = h$1.buckets;
    osize = #odata;
    nsize = (osize << 1);
    if (nsize >= osize) then do
      h_buckets$1 = new Array(nsize);
      ndata_tail = new Array(nsize);
      h$1.buckets = h_buckets$1;
      for i$1 = 0 , osize - 1 | 0 , 1 do
        copyBucket(hash$1, h_buckets$1, ndata_tail, odata[i$1]);
      end
      for i$2 = 0 , nsize - 1 | 0 , 1 do
        match = ndata_tail[i$2];
        if (match ~= undefined) then do
          match.next = undefined;
        end
         end 
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end end

function add(h, key) do
  return add0(h, key, h.hash, h.eq);
end end

function has(h, key) do
  eq = h.eq;
  h_buckets = h.buckets;
  nid = h.hash(key) & (#h_buckets - 1 | 0);
  bucket = h_buckets[nid];
  if (bucket ~= undefined) then do
    eq$1 = eq;
    key$1 = key;
    _cell = bucket;
    while(true) do
      cell = _cell;
      if (eq$1(cell.key, key$1)) then do
        return true;
      end else do
        match = cell.next;
        if (match ~= undefined) then do
          _cell = match;
          continue ;
        end else do
          return false;
        end end 
      end end 
    end;
  end else do
    return false;
  end end 
end end

function make(hintSize, id) do
  return Belt_internalBucketsType.make(id.hash, id.eq, hintSize);
end end

function size(prim) do
  return prim.size;
end end

function fromArray(arr, id) do
  eq = id.eq;
  hash = id.hash;
  len = #arr;
  v = Belt_internalBucketsType.make(hash, eq, len);
  for i = 0 , len - 1 | 0 , 1 do
    add0(v, arr[i], hash, eq);
  end
  return v;
end end

function mergeMany(h, arr) do
  eq = h.eq;
  hash = h.hash;
  len = #arr;
  for i = 0 , len - 1 | 0 , 1 do
    add0(h, arr[i], hash, eq);
  end
  return --[[ () ]]0;
end end

Int = --[[ alias ]]0;

$$String = --[[ alias ]]0;

clear = Belt_internalBucketsType.clear;

isEmpty = Belt_internalBucketsType.isEmpty;

copy = Belt_internalSetBuckets.copy;

forEachU = Belt_internalSetBuckets.forEachU;

forEach = Belt_internalSetBuckets.forEach;

reduceU = Belt_internalSetBuckets.reduceU;

reduce = Belt_internalSetBuckets.reduce;

logStats = Belt_internalSetBuckets.logStats;

toArray = Belt_internalSetBuckets.toArray;

getBucketHistogram = Belt_internalSetBuckets.getBucketHistogram;

exports.Int = Int;
exports.$$String = $$String;
exports.make = make;
exports.clear = clear;
exports.isEmpty = isEmpty;
exports.add = add;
exports.copy = copy;
exports.has = has;
exports.remove = remove;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.size = size;
exports.logStats = logStats;
exports.toArray = toArray;
exports.fromArray = fromArray;
exports.mergeMany = mergeMany;
exports.getBucketHistogram = getBucketHistogram;
--[[ No side effect ]]
