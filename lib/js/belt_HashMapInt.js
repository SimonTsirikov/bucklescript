'use strict';

var Caml_option = require("./caml_option.js");
var Caml_hash_primitive = require("./caml_hash_primitive.js");
var Belt_internalBuckets = require("./belt_internalBuckets.js");
var Belt_internalBucketsType = require("./belt_internalBucketsType.js");

function copyBucketReHash(h_buckets, ndata_tail, _old_bucket) do
  while(true) do
    var old_bucket = _old_bucket;
    if (old_bucket ~= undefined) then do
      var s = old_bucket.key;
      var nidx = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, s)) & (#h_buckets - 1 | 0);
      var match = ndata_tail[nidx];
      if (match ~= undefined) then do
        match.next = old_bucket;
      end else do
        h_buckets[nidx] = old_bucket;
      end end 
      ndata_tail[nidx] = old_bucket;
      _old_bucket = old_bucket.next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function replaceInBucket(key, info, _cell) do
  while(true) do
    var cell = _cell;
    if (cell.key == key) then do
      cell.value = info;
      return false;
    end else do
      var match = cell.next;
      if (match ~= undefined) then do
        _cell = match;
        continue ;
      end else do
        return true;
      end end 
    end end 
  end;
end

function set(h, key, value) do
  var h_buckets = h.buckets;
  var buckets_len = #h_buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (buckets_len - 1 | 0);
  var l = h_buckets[i];
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
    var h$1 = h;
    var odata = h$1.buckets;
    var osize = #odata;
    var nsize = (osize << 1);
    if (nsize >= osize) then do
      var h_buckets$1 = new Array(nsize);
      var ndata_tail = new Array(nsize);
      h$1.buckets = h_buckets$1;
      for var i$1 = 0 , osize - 1 | 0 , 1 do
        copyBucketReHash(h_buckets$1, ndata_tail, odata[i$1]);
      end
      for var i$2 = 0 , nsize - 1 | 0 , 1 do
        var match = ndata_tail[i$2];
        if (match ~= undefined) then do
          match.next = undefined;
        end
         end 
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end

function remove(h, key) do
  var h_buckets = h.buckets;
  var i = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (#h_buckets - 1 | 0);
  var bucket = h_buckets[i];
  if (bucket ~= undefined) then do
    if (bucket.key == key) then do
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
        if (buckets ~= undefined) then do
          var cell_next = buckets.next;
          if (buckets.key == key$1) then do
            prec.next = cell_next;
            h$1.size = h$1.size - 1 | 0;
            return --[ () ]--0;
          end else do
            _buckets = cell_next;
            _prec = buckets;
            continue ;
          end end 
        end else do
          return --[ () ]--0;
        end end 
      end;
    end end 
  end else do
    return --[ () ]--0;
  end end 
end

function get(h, key) do
  var h_buckets = h.buckets;
  var nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (#h_buckets - 1 | 0);
  var match = h_buckets[nid];
  if (match ~= undefined) then do
    if (key == match.key) then do
      return Caml_option.some(match.value);
    end else do
      var match$1 = match.next;
      if (match$1 ~= undefined) then do
        if (key == match$1.key) then do
          return Caml_option.some(match$1.value);
        end else do
          var match$2 = match$1.next;
          if (match$2 ~= undefined) then do
            if (key == match$2.key) then do
              return Caml_option.some(match$2.value);
            end else do
              var key$1 = key;
              var _buckets = match$2.next;
              while(true) do
                var buckets = _buckets;
                if (buckets ~= undefined) then do
                  if (key$1 == buckets.key) then do
                    return Caml_option.some(buckets.value);
                  end else do
                    _buckets = buckets.next;
                    continue ;
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
end

function has(h, key) do
  var h_buckets = h.buckets;
  var nid = Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_int(0, key)) & (#h_buckets - 1 | 0);
  var bucket = h_buckets[nid];
  if (bucket ~= undefined) then do
    var key$1 = key;
    var _cell = bucket;
    while(true) do
      var cell = _cell;
      if (cell.key == key$1) then do
        return true;
      end else do
        var match = cell.next;
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
  for var i = 0 , len - 1 | 0 , 1 do
    var match = arr[i];
    set(v, match[0], match[1]);
  end
  return v;
end

function mergeMany(h, arr) do
  var len = #arr;
  for var i = 0 , len - 1 | 0 , 1 do
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
--[ No side effect ]--
