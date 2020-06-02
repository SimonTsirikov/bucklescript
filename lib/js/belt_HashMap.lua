console.log = print;

Caml_option = require "./caml_option";
Belt_internalBuckets = require "./belt_internalBuckets";
Belt_internalBucketsType = require "./belt_internalBucketsType";

function size(prim) do
  return prim.size;
end end

function copyBucketReHash(hash, h_buckets, ndata_tail, _old_bucket) do
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
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function replaceInBucket(eq, key, info, _cell) do
  while(true) do
    cell = _cell;
    if (eq(cell.key, key)) then do
      cell.value = info;
      return false;
    end else do
      match = cell.next;
      if (match ~= undefined) then do
        _cell = match;
        ::continue:: ;
      end else do
        return true;
      end end 
    end end 
  end;
end end

function set0(h, key, value, eq, hash) do
  h_buckets = h.buckets;
  buckets_len = #h_buckets;
  i = hash(key) & (buckets_len - 1 | 0);
  l = h_buckets[i];
  if (l ~= undefined) then do
    if (replaceInBucket(eq, key, value, l)) then do
      h_buckets[i] = do
        key: key,
        value: value,
        next: l
      end;
      h.size = h.size + 1 | 0;
    end
     end 
  end else do
    h_buckets[i] = do
      key: key,
      value: value,
      next: undefined
    end;
    h.size = h.size + 1 | 0;
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
        copyBucketReHash(hash_1, h_buckets_1, ndata_tail, odata[i_1]);
      end
      for i_2 = 0 , nsize - 1 | 0 , 1 do
        match = ndata_tail[i_2];
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

function set(h, key, value) do
  return set0(h, key, value, h.eq, h.hash);
end end

function remove(h, key) do
  h_buckets = h.buckets;
  i = h.hash(key) & (#h_buckets - 1 | 0);
  bucket = h_buckets[i];
  if (bucket ~= undefined) then do
    eq = h.eq;
    if (eq(bucket.key, key)) then do
      h_buckets[i] = bucket.next;
      h.size = h.size - 1 | 0;
      return --[[ () ]]0;
    end else do
      h_1 = h;
      key_1 = key;
      _prec = bucket;
      _bucket = bucket.next;
      eq_1 = eq;
      while(true) do
        bucket_1 = _bucket;
        prec = _prec;
        if (bucket_1 ~= undefined) then do
          cell_next = bucket_1.next;
          if (eq_1(bucket_1.key, key_1)) then do
            prec.next = cell_next;
            h_1.size = h_1.size - 1 | 0;
            return --[[ () ]]0;
          end else do
            _bucket = cell_next;
            _prec = bucket_1;
            ::continue:: ;
          end end 
        end else do
          return --[[ () ]]0;
        end end 
      end;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function get(h, key) do
  h_buckets = h.buckets;
  nid = h.hash(key) & (#h_buckets - 1 | 0);
  match = h_buckets[nid];
  if (match ~= undefined) then do
    eq = h.eq;
    if (eq(key, match.key)) then do
      return Caml_option.some(match.value);
    end else do
      match_1 = match.next;
      if (match_1 ~= undefined) then do
        if (eq(key, match_1.key)) then do
          return Caml_option.some(match_1.value);
        end else do
          match_2 = match_1.next;
          if (match_2 ~= undefined) then do
            if (eq(key, match_2.key)) then do
              return Caml_option.some(match_2.value);
            end else do
              eq_1 = eq;
              key_1 = key;
              _buckets = match_2.next;
              while(true) do
                buckets = _buckets;
                if (buckets ~= undefined) then do
                  if (eq_1(key_1, buckets.key)) then do
                    return Caml_option.some(buckets.value);
                  end else do
                    _buckets = buckets.next;
                    ::continue:: ;
                  end end 
                end else do
                  return ;
                end end 
              end;
            end end 
          end else do
            return ;
          end end 
        end end 
      end else do
        return ;
      end end 
    end end 
  end
   end 
end end

function has(h, key) do
  h_buckets = h.buckets;
  nid = h.hash(key) & (#h_buckets - 1 | 0);
  bucket = h_buckets[nid];
  if (bucket ~= undefined) then do
    key_1 = key;
    _cell = bucket;
    eq = h.eq;
    while(true) do
      cell = _cell;
      if (eq(cell.key, key_1)) then do
        return true;
      end else do
        match = cell.next;
        if (match ~= undefined) then do
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

function fromArray(arr, id) do
  hash = id.hash;
  eq = id.eq;
  len = #arr;
  v = Belt_internalBucketsType.make(hash, eq, len);
  for i = 0 , len - 1 | 0 , 1 do
    match = arr[i];
    set0(v, match[0], match[1], eq, hash);
  end
  return v;
end end

function mergeMany(h, arr) do
  hash = h.hash;
  eq = h.eq;
  len = #arr;
  for i = 0 , len - 1 | 0 , 1 do
    match = arr[i];
    set0(h, match[0], match[1], eq, hash);
  end
  return --[[ () ]]0;
end end

Int = --[[ alias ]]0;

__String = --[[ alias ]]0;

clear = Belt_internalBucketsType.clear;

isEmpty = Belt_internalBucketsType.isEmpty;

copy = Belt_internalBuckets.copy;

forEachU = Belt_internalBuckets.forEachU;

forEach = Belt_internalBuckets.forEach;

reduceU = Belt_internalBuckets.reduceU;

reduce = Belt_internalBuckets.reduce;

keepMapInPlaceU = Belt_internalBuckets.keepMapInPlaceU;

keepMapInPlace = Belt_internalBuckets.keepMapInPlace;

toArray = Belt_internalBuckets.toArray;

keysToArray = Belt_internalBuckets.keysToArray;

valuesToArray = Belt_internalBuckets.valuesToArray;

getBucketHistogram = Belt_internalBuckets.getBucketHistogram;

logStats = Belt_internalBuckets.logStats;

exports.Int = Int;
exports.__String = __String;
exports.make = make;
exports.clear = clear;
exports.isEmpty = isEmpty;
exports.set = set;
exports.copy = copy;
exports.get = get;
exports.has = has;
exports.remove = remove;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.keepMapInPlaceU = keepMapInPlaceU;
exports.keepMapInPlace = keepMapInPlace;
exports.size = size;
exports.toArray = toArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.fromArray = fromArray;
exports.mergeMany = mergeMany;
exports.getBucketHistogram = getBucketHistogram;
exports.logStats = logStats;
--[[ No side effect ]]
