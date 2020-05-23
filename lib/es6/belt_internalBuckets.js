

import * as Curry from "./curry.js";
import * as Belt_Array from "./belt_Array.js";
import * as Caml_option from "./caml_option.js";

function copyAuxCont(_c, _prec) do
  while(true) do
    var prec = _prec;
    var c = _c;
    if (c ~= undefined) then do
      var ncopy = do
        key: c.key,
        value: c.value,
        next: undefined
      end;
      prec.next = ncopy;
      _prec = ncopy;
      _c = c.next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyBucket(c) do
  if (c ~= undefined) then do
    var head = do
      key: c.key,
      value: c.value,
      next: undefined
    end;
    copyAuxCont(c.next, head);
    return head;
  end else do
    return c;
  end end 
end

function copyBuckets(buckets) do
  var len = #buckets;
  var newBuckets = new Array(len);
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    newBuckets[i] = copyBucket(buckets[i]);
  end
  return newBuckets;
end

function copy(x) do
  return do
          size: x.size,
          buckets: copyBuckets(x.buckets),
          hash: x.hash,
          eq: x.eq
        end;
end

function bucketLength(_accu, _buckets) do
  while(true) do
    var buckets = _buckets;
    var accu = _accu;
    if (buckets ~= undefined) then do
      _buckets = buckets.next;
      _accu = accu + 1 | 0;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function do_bucket_iter(f, _buckets) do
  while(true) do
    var buckets = _buckets;
    if (buckets ~= undefined) then do
      f(buckets.key, buckets.value);
      _buckets = buckets.next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEachU(h, f) do
  var d = h.buckets;
  for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
    do_bucket_iter(f, d[i]);
  end
  return --[ () ]--0;
end

function forEach(h, f) do
  return forEachU(h, Curry.__2(f));
end

function do_bucket_fold(f, _b, _accu) do
  while(true) do
    var accu = _accu;
    var b = _b;
    if (b ~= undefined) then do
      _accu = f(accu, b.key, b.value);
      _b = b.next;
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function reduceU(h, init, f) do
  var d = h.buckets;
  var accu = init;
  for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
    accu = do_bucket_fold(f, d[i], accu);
  end
  return accu;
end

function reduce(h, init, f) do
  return reduceU(h, init, Curry.__3(f));
end

function getMaxBucketLength(h) do
  return Belt_Array.reduceU(h.buckets, 0, (function (m, b) do
                var len = bucketLength(0, b);
                if (m > len) then do
                  return m;
                end else do
                  return len;
                end end 
              end));
end

function getBucketHistogram(h) do
  var mbl = getMaxBucketLength(h);
  var histo = Belt_Array.makeByU(mbl + 1 | 0, (function (param) do
          return 0;
        end));
  Belt_Array.forEachU(h.buckets, (function (b) do
          var l = bucketLength(0, b);
          histo[l] = histo[l] + 1 | 0;
          return --[ () ]--0;
        end));
  return histo;
end

function logStats(h) do
  var histogram = getBucketHistogram(h);
  console.log(do
        bindings: h.size,
        buckets: #h.buckets,
        histogram: histogram
      end);
  return --[ () ]--0;
end

function filterMapInplaceBucket(f, h, i, _prec, _cell) do
  while(true) do
    var cell = _cell;
    var prec = _prec;
    var n = cell.next;
    var match = f(cell.key, cell.value);
    if (match ~= undefined) then do
      if (prec ~= undefined) then do
        cell.next = cell;
      end else do
        h.buckets[i] = cell;
      end end 
      cell.value = Caml_option.valFromOption(match);
      if (n ~= undefined) then do
        _cell = n;
        _prec = cell;
        continue ;
      end else do
        cell.next = n;
        return --[ () ]--0;
      end end 
    end else do
      h.size = h.size - 1 | 0;
      if (n ~= undefined) then do
        _cell = n;
        continue ;
      end else if (prec ~= undefined) then do
        prec.next = n;
        return --[ () ]--0;
      end else do
        h.buckets[i] = prec;
        return --[ () ]--0;
      end end  end 
    end end 
  end;
end

function keepMapInPlaceU(h, f) do
  var h_buckets = h.buckets;
  for(var i = 0 ,i_finish = #h_buckets - 1 | 0; i <= i_finish; ++i)do
    var v = h_buckets[i];
    if (v ~= undefined) then do
      filterMapInplaceBucket(f, h, i, undefined, v);
    end
     end 
  end
  return --[ () ]--0;
end

function keepMapInPlace(h, f) do
  return keepMapInPlaceU(h, Curry.__2(f));
end

function fillArray(_i, arr, _cell) do
  while(true) do
    var cell = _cell;
    var i = _i;
    arr[i] = --[ tuple ]--[
      cell.key,
      cell.value
    ];
    var match = cell.next;
    if (match ~= undefined) then do
      _cell = match;
      _i = i + 1 | 0;
      continue ;
    end else do
      return i + 1 | 0;
    end end 
  end;
end

function fillArrayMap(_i, arr, _cell, f) do
  while(true) do
    var cell = _cell;
    var i = _i;
    arr[i] = f(cell);
    var match = cell.next;
    if (match ~= undefined) then do
      _cell = match;
      _i = i + 1 | 0;
      continue ;
    end else do
      return i + 1 | 0;
    end end 
  end;
end

function linear(h, f) do
  var d = h.buckets;
  var current = 0;
  var arr = new Array(h.size);
  for(var i = 0 ,i_finish = #d - 1 | 0; i <= i_finish; ++i)do
    var cell = d[i];
    if (cell ~= undefined) then do
      current = fillArrayMap(current, arr, cell, f);
    end
     end 
  end
  return arr;
end

function keysToArray(h) do
  return linear(h, (function (x) do
                return x.key;
              end));
end

function valuesToArray(h) do
  return linear(h, (function (x) do
                return x.value;
              end));
end

function toArray(h) do
  return linear(h, (function (x) do
                return --[ tuple ]--[
                        x.key,
                        x.value
                      ];
              end));
end

var C = --[ alias ]--0;

export do
  C ,
  copy ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  logStats ,
  keepMapInPlaceU ,
  keepMapInPlace ,
  fillArray ,
  keysToArray ,
  valuesToArray ,
  toArray ,
  getBucketHistogram ,
  
end
--[ No side effect ]--
