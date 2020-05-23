

import * as Caml_option from "./caml_option.js";
import * as Caml_hash_primitive from "./caml_hash_primitive.js";
import * as Belt_internalBuckets from "./belt_internalBuckets.js";
import * as Belt_internalBucketsType from "./belt_internalBucketsType.js";

function copyBucketReHash(h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    var old_bucket = _old_bucket;
    if (old_bucket ~= undefined) do
      var s = old_bucket.key;
      var nidx = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, s)) & (#h_buckets - 1 | 0);
      var match = ndata_tail[nidx];
      if (match ~= undefined) do
        match.next = old_bucket;
      end else do
        h_buckets[nidx] = old_bucket;
      end
      ndata_tail[nidx] = old_bucket;
      _old_bucket = old_bucket.next;
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function replaceInBucket(key, info, _cell) do
  while(true) do
    var cell = _cell;
    if (cell.key == key) do
      cell.value = info;
      return false;
    end else do
      var match = cell.next;
      if (match ~= undefined) do
        _cell = match;
        continue ;
      end else do
        return true;
      end
    end
  end;
end

function set(h, key, value) do
  var h_buckets = h.buckets;
  var buckets_len = #h_buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (buckets_len - 1 | 0);
  var l = h_buckets[i];
  if (l ~= undefined) do
    if (replaceInBucket(key, value, l)) do
      h_buckets[i] = do
        key: key,
        value: value,
        next: l
      end;
      h.size = h.size + 1 | 0;
    end
    
  end else do
    h_buckets[i] = do
      key: key,
      value: value,
      next: undefined
    end;
    h.size = h.size + 1 | 0;
  end
  if (h.size > (buckets_len << 1)) do
    var h$1 = h;
    var odata = h$1.buckets;
    var osize = #odata;
    var nsize = (osize << 1);
    if (nsize >= osize) do
      var h_buckets$1 = new Array(nsize);
      var ndata_tail = new Array(nsize);
      h$1.buckets = h_buckets$1;
      for(var i$1 = 0 ,i_finish = osize - 1 | 0; i$1 <= i_finish; ++i$1)do
        copyBucketReHash(h_buckets$1, ndata_tail, odata[i$1]);
      end
      for(var i$2 = 0 ,i_finish$1 = nsize - 1 | 0; i$2 <= i_finish$1; ++i$2)do
        var match = ndata_tail[i$2];
        if (match ~= undefined) do
          match.next = undefined;
        end
        
      end
      return --[ () ]--0;
    end else do
      return 0;
    end
  end else do
    return 0;
  end
end

function remove(h, key) do
  var h_buckets = h.buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  var bucket = h_buckets[i];
  if (bucket ~= undefined) do
    if (bucket.key == key) do
      h_buckets[i] = bucket.next;
      h.size = h.size - 1 | 0;
      return --[ () ]--0;
    end else do
      var h$1 = h;
      var key$1 = key;
      var _prec = bucket;
      var _buckets = bucket.next;
      while(true) do
        var buckets = _buckets;
        var prec = _prec;
        if (buckets ~= undefined) do
          var cell_next = buckets.next;
          if (buckets.key == key$1) do
            prec.next = cell_next;
            h$1.size = h$1.size - 1 | 0;
            return --[ () ]--0;
          end else do
            _buckets = cell_next;
            _prec = buckets;
            continue ;
          end
        end else do
          return --[ () ]--0;
        end
      end;
    end
  end else do
    return --[ () ]--0;
  end
end

function get(h, key) do
  var h_buckets = h.buckets;
  var nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  var match = h_buckets[nid];
  if (match ~= undefined) do
    if (key == match.key) do
      return Caml_option.some(match.value);
    end else do
      var match$1 = match.next;
      if (match$1 ~= undefined) do
        if (key == match$1.key) do
          return Caml_option.some(match$1.value);
        end else do
          var match$2 = match$1.next;
          if (match$2 ~= undefined) do
            if (key == match$2.key) do
              return Caml_option.some(match$2.value);
            end else do
              var key$1 = key;
              var _buckets = match$2.next;
              while(true) do
                var buckets = _buckets;
                if (buckets ~= undefined) do
                  if (key$1 == buckets.key) do
                    return Caml_option.some(buckets.value);
                  end else do
                    _buckets = buckets.next;
                    continue ;
                  end
                end else do
                  return ;
                end
              end;
            end
          end else do
            return ;
          end
        end
      end else do
        return ;
      end
    end
  end
  
end

function has(h, key) do
  var h_buckets = h.buckets;
  var nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  var bucket = h_buckets[nid];
  if (bucket ~= undefined) do
    var key$1 = key;
    var _cell = bucket;
    while(true) do
      var cell = _cell;
      if (cell.key == key$1) do
        return true;
      end else do
        var match = cell.next;
        if (match ~= undefined) do
          _cell = match;
          continue ;
        end else do
          return false;
        end
      end
    end;
  end else do
    return false;
  end
end

function make(hintSize) do
  return Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, hintSize);
end

function size(prim) do
  return prim.size;
end

function fromArray(arr) do
  var len = #arr;
  var v = Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    var match = arr[i];
    set(v, match[0], match[1]);
  end
  return v;
end

function mergeMany(h, arr) do
  var len = #arr;
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    var match = arr[i];
    set(h, match[0], match[1]);
  end
  return --[ () ]--0;
end

var clear = Belt_internalBucketsType.clear;

var isEmpty = Belt_internalBucketsType.isEmpty;

var copy = Belt_internalBuckets.copy;

var forEachU = Belt_internalBuckets.forEachU;

var forEach = Belt_internalBuckets.forEach;

var reduceU = Belt_internalBuckets.reduceU;

var reduce = Belt_internalBuckets.reduce;

var keepMapInPlaceU = Belt_internalBuckets.keepMapInPlaceU;

var keepMapInPlace = Belt_internalBuckets.keepMapInPlace;

var toArray = Belt_internalBuckets.toArray;

var keysToArray = Belt_internalBuckets.keysToArray;

var valuesToArray = Belt_internalBuckets.valuesToArray;

var getBucketHistogram = Belt_internalBuckets.getBucketHistogram;

var logStats = Belt_internalBuckets.logStats;

export do
  make ,
  clear ,
  isEmpty ,
  set ,
  copy ,
  get ,
  has ,
  remove ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  keepMapInPlaceU ,
  keepMapInPlace ,
  size ,
  toArray ,
  keysToArray ,
  valuesToArray ,
  fromArray ,
  mergeMany ,
  getBucketHistogram ,
  logStats ,
  
end
--[ No side effect ]--
