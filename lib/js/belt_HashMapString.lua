--[['use strict';]]

Caml_option = require "./caml_option";
Caml_hash_primitive = require "./caml_hash_primitive";
Belt_internalBuckets = require "./belt_internalBuckets";
Belt_internalBucketsType = require "./belt_internalBucketsType";

function copyBucketReHash(h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    old_bucket = _old_bucket;
    if (old_bucket ~= undefined) then do
      s = old_bucket.key;
      nidx = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, s)) & (#h_buckets - 1 | 0);
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

function replaceInBucket(key, info, _cell) do
  while(true) do
    cell = _cell;
    if (cell.key == key) then do
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

function set(h, key, value) do
  h_buckets = h.buckets;
  buckets_len = #h_buckets;
  i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (buckets_len - 1 | 0);
  l = h_buckets[i];
  if (l ~= undefined) then do
    if (replaceInBucket(key, value, l)) then do
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
    h$1 = h;
    odata = h$1.buckets;
    osize = #odata;
    nsize = (osize << 1);
    if (nsize >= osize) then do
      h_buckets$1 = new Array(nsize);
      ndata_tail = new Array(nsize);
      h$1.buckets = h_buckets$1;
      for i$1 = 0 , osize - 1 | 0 , 1 do
        copyBucketReHash(h_buckets$1, ndata_tail, odata[i$1]);
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

function remove(h, key) do
  h_buckets = h.buckets;
  i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  bucket = h_buckets[i];
  if (bucket ~= undefined) then do
    if (bucket.key == key) then do
      h_buckets[i] = bucket.next;
      h.size = h.size - 1 | 0;
      return --[[ () ]]0;
    end else do
      h$1 = h;
      key$1 = key;
      _prec = bucket;
      _buckets = bucket.next;
      while(true) do
        buckets = _buckets;
        prec = _prec;
        if (buckets ~= undefined) then do
          cell_next = buckets.next;
          if (buckets.key == key$1) then do
            prec.next = cell_next;
            h$1.size = h$1.size - 1 | 0;
            return --[[ () ]]0;
          end else do
            _buckets = cell_next;
            _prec = buckets;
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
  nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  match = h_buckets[nid];
  if (match ~= undefined) then do
    if (key == match.key) then do
      return Caml_option.some(match.value);
    end else do
      match$1 = match.next;
      if (match$1 ~= undefined) then do
        if (key == match$1.key) then do
          return Caml_option.some(match$1.value);
        end else do
          match$2 = match$1.next;
          if (match$2 ~= undefined) then do
            if (key == match$2.key) then do
              return Caml_option.some(match$2.value);
            end else do
              key$1 = key;
              _buckets = match$2.next;
              while(true) do
                buckets = _buckets;
                if (buckets ~= undefined) then do
                  if (key$1 == buckets.key) then do
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
  nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  bucket = h_buckets[nid];
  if (bucket ~= undefined) then do
    key$1 = key;
    _cell = bucket;
    while(true) do
      cell = _cell;
      if (cell.key == key$1) then do
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
    match = arr[i];
    set(v, match[0], match[1]);
  end
  return v;
end end

function mergeMany(h, arr) do
  len = #arr;
  for i = 0 , len - 1 | 0 , 1 do
    match = arr[i];
    set(h, match[0], match[1]);
  end
  return --[[ () ]]0;
end end

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
