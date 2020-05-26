'use strict';

var Curry = require("./curry.js");
var Belt_Array = require("./belt_Array.js");

function copyAuxCont(_c, _prec) do
  while(true) do
    var prec = _prec;
    var c = _c;
    if (c ~= undefined) then do
      var ncopy = do
        key: c.key,
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
  for var i = 0 , len - 1 | 0 , 1 do
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

function doBucketIter(f, _buckets) do
  while(true) do
    var buckets = _buckets;
    if (buckets ~= undefined) then do
      f(buckets.key);
      _buckets = buckets.next;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEachU(h, f) do
  var d = h.buckets;
  for var i = 0 , #d - 1 | 0 , 1 do
    doBucketIter(f, d[i]);
  end
  return --[ () ]--0;
end

function forEach(h, f) do
  return forEachU(h, Curry.__1(f));
end

function fillArray(_i, arr, _cell) do
  while(true) do
    var cell = _cell;
    var i = _i;
    arr[i] = cell.key;
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

function toArray(h) do
  var d = h.buckets;
  var current = 0;
  var arr = new Array(h.size);
  for var i = 0 , #d - 1 | 0 , 1 do
    var cell = d[i];
    if (cell ~= undefined) then do
      current = fillArray(current, arr, cell);
    end
     end 
  end
  return arr;
end

function doBucketFold(f, _b, _accu) do
  while(true) do
    var accu = _accu;
    var b = _b;
    if (b ~= undefined) then do
      _accu = f(accu, b.key);
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
  for var i = 0 , #d - 1 | 0 , 1 do
    accu = doBucketFold(f, d[i], accu);
  end
  return accu;
end

function reduce(h, init, f) do
  return reduceU(h, init, Curry.__2(f));
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

var C = --[ alias ]--0;

exports.C = C;
exports.copy = copy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.fillArray = fillArray;
exports.toArray = toArray;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.logStats = logStats;
exports.getBucketHistogram = getBucketHistogram;
--[ No side effect ]--
