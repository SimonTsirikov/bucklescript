

import * as Belt_internalSetBuckets from "./belt_internalSetBuckets.lua";
import * as Belt_internalBucketsType from "./belt_internalBucketsType.lua";

function copyBucket(hash, h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    old_bucket = _old_bucket;
    if (old_bucket ~= nil) then do
      nidx = hash(old_bucket.key) & (#h_buckets - 1 | 0);
      match = ndata_tail[nidx];
      if (match ~= nil) then do
        match.next = old_bucket;
      end else do
        h_buckets[nidx] = old_bucket;
      end end 
      ndata_tail[nidx] = old_bucket;
      _old_bucket = old_bucket.next;
      ::continue:: ;
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
  if (l ~= nil) then do
    next_cell = l.next;
    if (eq(l.key, key)) then do
      h.size = h.size - 1 | 0;
      h_buckets[i] = next_cell;
      return --[[ () ]]0;
    end else if (next_cell ~= nil) then do
      eq_1 = eq;
      h_1 = h;
      key_1 = key;
      _prec = l;
      _cell = next_cell;
      while(true) do
        cell = _cell;
        prec = _prec;
        cell_next = cell.next;
        if (eq_1(cell.key, key_1)) then do
          prec.next = cell_next;
          h_1.size = h_1.size - 1 | 0;
          return --[[ () ]]0;
        end else if (cell_next ~= nil) then do
          _cell = cell_next;
          _prec = cell;
          ::continue:: ;
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
      if (n ~= nil) then do
        _cell = n;
        ::continue:: ;
      end else do
        h.size = h.size + 1 | 0;
        cell.next = {
          key = key,
          next = nil
        };
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
  if (l ~= nil) then do
    addBucket(h, key, l, eq);
  end else do
    h.size = h.size + 1 | 0;
    h_buckets[i] = {
      key = key,
      next = nil
    };
  end end 
  if (h.size > (buckets_len << 1)) then do
    hash_1 = hash;
    h_1 = h;
    odata = h_1.buckets;
    osize = #odata;
    nsize = (osize << 1);
    if (nsize >= osize) then do
      h_buckets_1 = new Array(nsize);
      ndata_tail = new Array(nsize);
      h_1.buckets = h_buckets_1;
      for i_1 = 0 , osize - 1 | 0 , 1 do
        copyBucket(hash_1, h_buckets_1, ndata_tail, odata[i_1]);
      end
      for i_2 = 0 , nsize - 1 | 0 , 1 do
        match = ndata_tail[i_2];
        if (match ~= nil) then do
          match.next = nil;
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
  if (bucket ~= nil) then do
    eq_1 = eq;
    key_1 = key;
    _cell = bucket;
    while(true) do
      cell = _cell;
      if (eq_1(cell.key, key_1)) then do
        return true;
      end else do
        match = cell.next;
        if (match ~= nil) then do
          _cell = match;
          ::continue:: ;
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

__String = --[[ alias ]]0;

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

export do
  Int ,
  __String ,
  make ,
  clear ,
  isEmpty ,
  add ,
  copy ,
  has ,
  remove ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  size ,
  logStats ,
  toArray ,
  fromArray ,
  mergeMany ,
  getBucketHistogram ,
  
end
--[[ No side effect ]]
