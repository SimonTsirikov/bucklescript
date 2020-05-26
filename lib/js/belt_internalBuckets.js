'use strict';

Curry = require("./curry.js");
Belt_Array = require("./belt_Array.js");
Caml_option = require("./caml_option.js");

function copyAuxCont(_c, _prec) do
  while(true) do
    prec = _prec;
    c = _c;
    if (c ~= undefined) then do
      ncopy = do
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
    head = do
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
  len = #buckets;
  newBuckets = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
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
    buckets = _buckets;
    accu = _accu;
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
    buckets = _buckets;
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
  d = h.buckets;
  for i = 0 , #d - 1 | 0 , 1 do
    do_bucket_iter(f, d[i]);
  end
  return --[ () ]--0;
end

function forEach(h, f) do
  return forEachU(h, Curry.__2(f));
end

function do_bucket_fold(f, _b, _accu) do
  while(true) do
    accu = _accu;
    b = _b;
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
  d = h.buckets;
  accu = init;
  for i = 0 , #d - 1 | 0 , 1 do
    accu = do_bucket_fold(f, d[i], accu);
  end
  return accu;
end

function reduce(h, init, f) do
  return reduceU(h, init, Curry.__3(f));
end

function getMaxBucketLength(h) do
  return Belt_Array.reduceU(h.buckets, 0, (function (m, b) do
                len = bucketLength(0, b);
                if (m > len) then do
                  return m;
                end else do
                  return len;
                end end 
              end));
end

function getBucketHistogram(h) do
  mbl = getMaxBucketLength(h);
  histo = Belt_Array.makeByU(mbl + 1 | 0, (function (param) do
          return 0;
        end));
  Belt_Array.forEachU(h.buckets, (function (b) do
          l = bucketLength(0, b);
          histo[l] = histo[l] + 1 | 0;
          return --[ () ]--0;
        end));
  return histo;
end

function logStats(h) do
  histogram = getBucketHistogram(h);
  console.log(do
        bindings: h.size,
        buckets: #h.buckets,
        histogram: histogram
      end);
  return --[ () ]--0;
end

function filterMapInplaceBucket(f, h, i, _prec, _cell) do
  while(true) do
    cell = _cell;
    prec = _prec;
    n = cell.next;
    match = f(cell.key, cell.value);
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
  h_buckets = h.buckets;
  for i = 0 , #h_buckets - 1 | 0 , 1 do
    v = h_buckets[i];
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
    cell = _cell;
    i = _i;
    arr[i] = --[ tuple ]--[
      cell.key,
      cell.value
    ];
    match = cell.next;
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
    cell = _cell;
    i = _i;
    arr[i] = f(cell);
    match = cell.next;
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
  d = h.buckets;
  current = 0;
  arr = new Array(h.size);
  for i = 0 , #d - 1 | 0 , 1 do
    cell = d[i];
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

C = --[ alias ]--0;

exports.C = C;
exports.copy = copy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.logStats = logStats;
exports.keepMapInPlaceU = keepMapInPlaceU;
exports.keepMapInPlace = keepMapInPlace;
exports.fillArray = fillArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.toArray = toArray;
exports.getBucketHistogram = getBucketHistogram;
--[ No side effect ]--
