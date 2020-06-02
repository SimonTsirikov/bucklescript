

import * as Curry from "./curry.lua";
import * as Belt_Array from "./belt_Array.lua";

function copyAuxCont(_c, _prec) do
  while(true) do
    prec = _prec;
    c = _c;
    if (c ~= undefined) then do
      ncopy = do
        key: c.key,
        next: undefined
      end;
      prec.next = ncopy;
      _prec = ncopy;
      _c = c.next;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyBucket(c) do
  if (c ~= undefined) then do
    head = do
      key: c.key,
      next: undefined
    end;
    copyAuxCont(c.next, head);
    return head;
  end else do
    return c;
  end end 
end end

function copyBuckets(buckets) do
  len = #buckets;
  newBuckets = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    newBuckets[i] = copyBucket(buckets[i]);
  end
  return newBuckets;
end end

function copy(x) do
  return do
          size: x.size,
          buckets: copyBuckets(x.buckets),
          hash: x.hash,
          eq: x.eq
        end;
end end

function bucketLength(_accu, _buckets) do
  while(true) do
    buckets = _buckets;
    accu = _accu;
    if (buckets ~= undefined) then do
      _buckets = buckets.next;
      _accu = accu + 1 | 0;
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function doBucketIter(f, _buckets) do
  while(true) do
    buckets = _buckets;
    if (buckets ~= undefined) then do
      f(buckets.key);
      _buckets = buckets.next;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEachU(h, f) do
  d = h.buckets;
  for i = 0 , #d - 1 | 0 , 1 do
    doBucketIter(f, d[i]);
  end
  return --[[ () ]]0;
end end

function forEach(h, f) do
  return forEachU(h, Curry.__1(f));
end end

function fillArray(_i, arr, _cell) do
  while(true) do
    cell = _cell;
    i = _i;
    arr[i] = cell.key;
    match = cell.next;
    if (match ~= undefined) then do
      _cell = match;
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return i + 1 | 0;
    end end 
  end;
end end

function toArray(h) do
  d = h.buckets;
  current = 0;
  arr = new Array(h.size);
  for i = 0 , #d - 1 | 0 , 1 do
    cell = d[i];
    if (cell ~= undefined) then do
      current = fillArray(current, arr, cell);
    end
     end 
  end
  return arr;
end end

function doBucketFold(f, _b, _accu) do
  while(true) do
    accu = _accu;
    b = _b;
    if (b ~= undefined) then do
      _accu = f(accu, b.key);
      _b = b.next;
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function reduceU(h, init, f) do
  d = h.buckets;
  accu = init;
  for i = 0 , #d - 1 | 0 , 1 do
    accu = doBucketFold(f, d[i], accu);
  end
  return accu;
end end

function reduce(h, init, f) do
  return reduceU(h, init, Curry.__2(f));
end end

function getMaxBucketLength(h) do
  return Belt_Array.reduceU(h.buckets, 0, (function (m, b) do
                len = bucketLength(0, b);
                if (m > len) then do
                  return m;
                end else do
                  return len;
                end end 
              end end));
end end

function getBucketHistogram(h) do
  mbl = getMaxBucketLength(h);
  histo = Belt_Array.makeByU(mbl + 1 | 0, (function (param) do
          return 0;
        end end));
  Belt_Array.forEachU(h.buckets, (function (b) do
          l = bucketLength(0, b);
          histo[l] = histo[l] + 1 | 0;
          return --[[ () ]]0;
        end end));
  return histo;
end end

function logStats(h) do
  histogram = getBucketHistogram(h);
  console.log(do
        bindings: h.size,
        buckets: #h.buckets,
        histogram: histogram
      end);
  return --[[ () ]]0;
end end

C = --[[ alias ]]0;

export do
  C ,
  copy ,
  forEachU ,
  forEach ,
  fillArray ,
  toArray ,
  reduceU ,
  reduce ,
  logStats ,
  getBucketHistogram ,
  
end
--[[ No side effect ]]
