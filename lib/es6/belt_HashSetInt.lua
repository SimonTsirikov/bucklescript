

local Caml_hash_primitive = require "..caml_hash_primitive.lua";
local Belt_internalSetBuckets = require "..belt_internalSetBuckets.lua";
local Belt_internalBucketsType = require "..belt_internalBucketsType.lua";

function copyBucket(h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    old_bucket = _old_bucket;
    if (old_bucket ~= nil) then do
      s = old_bucket.key;
      nidx = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, s)) & (#h_buckets - 1 | 0);
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
  h_buckets = h.buckets;
  i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (#h_buckets - 1 | 0);
  l = h_buckets[i];
  if (l ~= nil) then do
    next_cell = l.next;
    if (l.key == key) then do
      h.size = h.size - 1 | 0;
      h_buckets[i] = next_cell;
      return --[[ () ]]0;
    end else if (next_cell ~= nil) then do
      h_1 = h;
      key_1 = key;
      _prec = l;
      _cell = next_cell;
      while(true) do
        cell = _cell;
        prec = _prec;
        cell_next = cell.next;
        if (cell.key == key_1) then do
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

function addBucket(h, key, _cell) do
  while(true) do
    cell = _cell;
    if (cell.key ~= key) then do
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
    end else do
      return 0;
    end end 
  end;
end end

function add(h, key) do
  h_buckets = h.buckets;
  buckets_len = #h_buckets;
  i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (buckets_len - 1 | 0);
  l = h_buckets[i];
  if (l ~= nil) then do
    addBucket(h, key, l);
  end else do
    h_buckets[i] = {
      key = key,
      next = nil
    };
    h.size = h.size + 1 | 0;
  end end 
  if (h.size > (buckets_len << 1)) then do
    h_1 = h;
    odata = h_1.buckets;
    osize = #odata;
    nsize = (osize << 1);
    if (nsize >= osize) then do
      h_buckets_1 = new __Array(nsize);
      ndata_tail = new __Array(nsize);
      h_1.buckets = h_buckets_1;
      for i_1 = 0 , osize - 1 | 0 , 1 do
        copyBucket(h_buckets_1, ndata_tail, odata[i_1]);
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

function has(h, key) do
  h_buckets = h.buckets;
  nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (#h_buckets - 1 | 0);
  bucket = h_buckets[nid];
  if (bucket ~= nil) then do
    key_1 = key;
    _cell = bucket;
    while(true) do
      cell = _cell;
      if (cell.key == key_1) then do
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

function make(hintSize) do
  return Belt_internalBucketsType.make(--[[ () ]]0, --[[ () ]]0, hintSize);
end end

function size(prim) do
  return prim.size;
end end

function fromArray(arr) do
  len = #arr;
  v = Belt_internalBucketsType.make(--[[ () ]]0, --[[ () ]]0, len);
  for i = 0 , len - 1 | 0 , 1 do
    add(v, arr[i]);
  end
  return v;
end end

function mergeMany(h, arr) do
  len = #arr;
  for i = 0 , len - 1 | 0 , 1 do
    add(h, arr[i]);
  end
  return --[[ () ]]0;
end end

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
