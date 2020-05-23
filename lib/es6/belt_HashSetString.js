

import * as Caml_hash_primitive from "./caml_hash_primitive.js";
import * as Belt_internalSetBuckets from "./belt_internalSetBuckets.js";
import * as Belt_internalBucketsType from "./belt_internalBucketsType.js";

function copyBucket(h_buckets, ndata_tail, _old_bucket) do
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

function remove(h, key) do
  var h_buckets = h.buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (#h_buckets - 1 | 0);
  var l = h_buckets[i];
  if (l ~= undefined) do
    var next_cell = l.next;
    if (l.key == key) do
      h.size = h.size - 1 | 0;
      h_buckets[i] = next_cell;
      return --[ () ]--0;
    end else if (next_cell ~= undefined) do
      var h$1 = h;
      var key$1 = key;
      var _prec = l;
      var _cell = next_cell;
      while(true) do
        var cell = _cell;
        var prec = _prec;
        var cell_next = cell.next;
        if (cell.key == key$1) do
          prec.next = cell_next;
          h$1.size = h$1.size - 1 | 0;
          return --[ () ]--0;
        end else if (cell_next ~= undefined) do
          _cell = cell_next;
          _prec = cell;
          continue ;
        end else do
          return --[ () ]--0;
        end
      end;
    end else do
      return --[ () ]--0;
    end
  end else do
    return --[ () ]--0;
  end
end

function addBucket(h, key, _cell) do
  while(true) do
    var cell = _cell;
    if (cell.key ~= key) do
      var n = cell.next;
      if (n ~= undefined) do
        _cell = n;
        continue ;
      end else do
        h.size = h.size + 1 | 0;
        cell.next = do
          key: key,
          next: undefined
        end;
        return --[ () ]--0;
      end
    end else do
      return 0;
    end
  end;
end

function add(h, key) do
  var h_buckets = h.buckets;
  var buckets_len = #h_buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, key)) & (buckets_len - 1 | 0);
  var l = h_buckets[i];
  if (l ~= undefined) do
    addBucket(h, key, l);
  end else do
    h_buckets[i] = do
      key: key,
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
        copyBucket(h_buckets$1, ndata_tail, odata[i$1]);
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
    add(v, arr[i]);
  end
  return v;
end

function mergeMany(h, arr) do
  var len = #arr;
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    add(h, arr[i]);
  end
  return --[ () ]--0;
end

var clear = Belt_internalBucketsType.clear;

var isEmpty = Belt_internalBucketsType.isEmpty;

var copy = Belt_internalSetBuckets.copy;

var forEachU = Belt_internalSetBuckets.forEachU;

var forEach = Belt_internalSetBuckets.forEach;

var reduceU = Belt_internalSetBuckets.reduceU;

var reduce = Belt_internalSetBuckets.reduce;

var logStats = Belt_internalSetBuckets.logStats;

var toArray = Belt_internalSetBuckets.toArray;

var getBucketHistogram = Belt_internalSetBuckets.getBucketHistogram;

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
--[ No side effect ]--
