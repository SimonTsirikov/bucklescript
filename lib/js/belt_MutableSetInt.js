'use strict';

var Curry = require("./curry.js");
var Belt_SortArrayInt = require("./belt_SortArrayInt.js");
var Belt_internalAVLset = require("./belt_internalAVLset.js");
var Belt_internalSetInt = require("./belt_internalSetInt.js");

function remove0(nt, x) do
  var k = nt.value;
  if (x == k) then do
    var l = nt.left;
    var r = nt.right;
    if (l ~= null) then do
      if (r ~= null) then do
        nt.right = Belt_internalAVLset.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLset.balMutate(nt);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < k) then do
    var match = nt.left;
    if (match ~= null) then do
      nt.left = remove0(match, x);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    var match$1 = nt.right;
    if (match$1 ~= null) then do
      nt.right = remove0(match$1, x);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end

function remove(d, v) do
  var oldRoot = d.data;
  if (oldRoot ~= null) then do
    var newRoot = remove0(oldRoot, v);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end else do
    return --[ () ]--0;
  end end 
end

function removeMany0(_t, xs, _i, len) do
  while(true) do
    var i = _i;
    var t = _t;
    if (i < len) then do
      var ele = xs[i];
      var u = remove0(t, ele);
      if (u ~= null) then do
        _i = i + 1 | 0;
        _t = u;
        continue ;
      end else do
        return null;
      end end 
    end else do
      return t;
    end end 
  end;
end

function removeMany(d, xs) do
  var oldRoot = d.data;
  if (oldRoot ~= null) then do
    var len = #xs;
    d.data = removeMany0(oldRoot, xs, 0, len);
    return --[ () ]--0;
  end else do
    return --[ () ]--0;
  end end 
end

function removeCheck0(nt, x, removed) do
  var k = nt.value;
  if (x == k) then do
    removed.contents = true;
    var l = nt.left;
    var r = nt.right;
    if (l ~= null) then do
      if (r ~= null) then do
        nt.right = Belt_internalAVLset.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLset.balMutate(nt);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < k) then do
    var match = nt.left;
    if (match ~= null) then do
      nt.left = removeCheck0(match, x, removed);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    var match$1 = nt.right;
    if (match$1 ~= null) then do
      nt.right = removeCheck0(match$1, x, removed);
      return Belt_internalAVLset.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end

function removeCheck(d, v) do
  var oldRoot = d.data;
  if (oldRoot ~= null) then do
    var removed = do
      contents: false
    end;
    var newRoot = removeCheck0(oldRoot, v, removed);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
    end
     end 
    return removed.contents;
  end else do
    return false;
  end end 
end

function addCheck0(t, x, added) do
  if (t ~= null) then do
    var k = t.value;
    if (x == k) then do
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (x < k) then do
        var ll = addCheck0(l, x, added);
        t.left = ll;
      end else do
        t.right = addCheck0(r, x, added);
      end end 
      return Belt_internalAVLset.balMutate(t);
    end end 
  end else do
    added.contents = true;
    return Belt_internalAVLset.singleton(x);
  end end 
end

function addCheck(m, e) do
  var oldRoot = m.data;
  var added = do
    contents: false
  end;
  var newRoot = addCheck0(oldRoot, e, added);
  if (newRoot ~= oldRoot) then do
    m.data = newRoot;
  end
   end 
  return added.contents;
end

function add(d, k) do
  var oldRoot = d.data;
  var v = Belt_internalSetInt.addMutate(oldRoot, k);
  if (v ~= oldRoot) then do
    d.data = v;
    return --[ () ]--0;
  end else do
    return 0;
  end end 
end

function addArrayMutate(t, xs) do
  var v = t;
  for var i = 0 , #xs - 1 | 0 , 1 do
    v = Belt_internalSetInt.addMutate(v, xs[i]);
  end
  return v;
end

function mergeMany(d, arr) do
  d.data = addArrayMutate(d.data, arr);
  return --[ () ]--0;
end

function make(param) do
  return do
          data: null
        end;
end

function isEmpty(d) do
  var n = d.data;
  return n == null;
end

function minimum(d) do
  return Belt_internalAVLset.minimum(d.data);
end

function minUndefined(d) do
  return Belt_internalAVLset.minUndefined(d.data);
end

function maximum(d) do
  return Belt_internalAVLset.maximum(d.data);
end

function maxUndefined(d) do
  return Belt_internalAVLset.maxUndefined(d.data);
end

function forEachU(d, f) do
  return Belt_internalAVLset.forEachU(d.data, f);
end

function forEach(d, f) do
  return Belt_internalAVLset.forEachU(d.data, Curry.__1(f));
end

function reduceU(d, acc, cb) do
  return Belt_internalAVLset.reduceU(d.data, acc, cb);
end

function reduce(d, acc, cb) do
  return reduceU(d, acc, Curry.__2(cb));
end

function everyU(d, p) do
  return Belt_internalAVLset.everyU(d.data, p);
end

function every(d, p) do
  return Belt_internalAVLset.everyU(d.data, Curry.__1(p));
end

function someU(d, p) do
  return Belt_internalAVLset.someU(d.data, p);
end

function some(d, p) do
  return Belt_internalAVLset.someU(d.data, Curry.__1(p));
end

function size(d) do
  return Belt_internalAVLset.size(d.data);
end

function toList(d) do
  return Belt_internalAVLset.toList(d.data);
end

function toArray(d) do
  return Belt_internalAVLset.toArray(d.data);
end

function fromSortedArrayUnsafe(xs) do
  return do
          data: Belt_internalAVLset.fromSortedArrayUnsafe(xs)
        end;
end

function checkInvariantInternal(d) do
  return Belt_internalAVLset.checkInvariantInternal(d.data);
end

function fromArray(xs) do
  return do
          data: Belt_internalSetInt.fromArray(xs)
        end;
end

function cmp(d0, d1) do
  return Belt_internalSetInt.cmp(d0.data, d1.data);
end

function eq(d0, d1) do
  return Belt_internalSetInt.eq(d0.data, d1.data);
end

function get(d, x) do
  return Belt_internalSetInt.get(d.data, x);
end

function getUndefined(d, x) do
  return Belt_internalSetInt.getUndefined(d.data, x);
end

function getExn(d, x) do
  return Belt_internalSetInt.getExn(d.data, x);
end

function split(d, key) do
  var arr = Belt_internalAVLset.toArray(d.data);
  var i = Belt_SortArrayInt.binarySearch(arr, key);
  var len = #arr;
  if (i < 0) then do
    var next = (-i | 0) - 1 | 0;
    return --[ tuple ]--[
            --[ tuple ]--[
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, 0, next)
              end,
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, next, len - next | 0)
              end
            ],
            false
          ];
  end else do
    return --[ tuple ]--[
            --[ tuple ]--[
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, 0, i)
              end,
              do
                data: Belt_internalAVLset.fromSortedArrayAux(arr, i + 1 | 0, (len - i | 0) - 1 | 0)
              end
            ],
            true
          ];
  end end 
end

function keepU(d, p) do
  return do
          data: Belt_internalAVLset.keepCopyU(d.data, p)
        end;
end

function keep(d, p) do
  return keepU(d, Curry.__1(p));
end

function partitionU(d, p) do
  var match = Belt_internalAVLset.partitionCopyU(d.data, p);
  return --[ tuple ]--[
          do
            data: match[0]
          end,
          do
            data: match[1]
          end
        ];
end

function partition(d, p) do
  return partitionU(d, Curry.__1(p));
end

function subset(a, b) do
  return Belt_internalSetInt.subset(a.data, b.data);
end

function intersect(dataa, datab) do
  var dataa$1 = dataa.data;
  var datab$1 = datab.data;
  if (dataa$1 ~= null) then do
    if (datab$1 ~= null) then do
      var sizea = Belt_internalAVLset.lengthNode(dataa$1);
      var sizeb = Belt_internalAVLset.lengthNode(datab$1);
      var totalSize = sizea + sizeb | 0;
      var tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea] or tmp[totalSize - 1 | 0] < tmp[0]) then do
        return do
                data: null
              end;
      end else do
        var tmp2 = new Array(sizea < sizeb and sizea or sizeb);
        var k = Belt_SortArrayInt.intersect(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: null
            end;
    end end 
  end else do
    return do
            data: null
          end;
  end end 
end

function diff(dataa, datab) do
  var dataa$1 = dataa.data;
  var datab$1 = datab.data;
  if (dataa$1 ~= null) then do
    if (datab$1 ~= null) then do
      var sizea = Belt_internalAVLset.lengthNode(dataa$1);
      var sizeb = Belt_internalAVLset.lengthNode(datab$1);
      var totalSize = sizea + sizeb | 0;
      var tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea] or tmp[totalSize - 1 | 0] < tmp[0]) then do
        return do
                data: Belt_internalAVLset.copy(dataa$1)
              end;
      end else do
        var tmp2 = new Array(sizea);
        var k = Belt_SortArrayInt.diff(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: Belt_internalAVLset.copy(dataa$1)
            end;
    end end 
  end else do
    return do
            data: null
          end;
  end end 
end

function union(dataa, datab) do
  var dataa$1 = dataa.data;
  var datab$1 = datab.data;
  if (dataa$1 ~= null) then do
    if (datab$1 ~= null) then do
      var sizea = Belt_internalAVLset.lengthNode(dataa$1);
      var sizeb = Belt_internalAVLset.lengthNode(datab$1);
      var totalSize = sizea + sizeb | 0;
      var tmp = new Array(totalSize);
      Belt_internalAVLset.fillArray(dataa$1, 0, tmp);
      Belt_internalAVLset.fillArray(datab$1, sizea, tmp);
      if (tmp[sizea - 1 | 0] < tmp[sizea]) then do
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp, 0, totalSize)
              end;
      end else do
        var tmp2 = new Array(totalSize);
        var k = Belt_SortArrayInt.union(tmp, 0, sizea, tmp, sizea, sizeb, tmp2, 0);
        return do
                data: Belt_internalAVLset.fromSortedArrayAux(tmp2, 0, k)
              end;
      end end 
    end else do
      return do
              data: Belt_internalAVLset.copy(dataa$1)
            end;
    end end 
  end else do
    return do
            data: Belt_internalAVLset.copy(datab$1)
          end;
  end end 
end

function has(d, x) do
  return Belt_internalSetInt.has(d.data, x);
end

function copy(d) do
  return do
          data: Belt_internalAVLset.copy(d.data)
        end;
end

exports.make = make;
exports.fromArray = fromArray;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.copy = copy;
exports.isEmpty = isEmpty;
exports.has = has;
exports.add = add;
exports.addCheck = addCheck;
exports.mergeMany = mergeMany;
exports.remove = remove;
exports.removeCheck = removeCheck;
exports.removeMany = removeMany;
exports.union = union;
exports.intersect = intersect;
exports.diff = diff;
exports.subset = subset;
exports.cmp = cmp;
exports.eq = eq;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.keepU = keepU;
exports.keep = keep;
exports.partitionU = partitionU;
exports.partition = partition;
exports.size = size;
exports.toList = toList;
exports.toArray = toArray;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getExn = getExn;
exports.split = split;
exports.checkInvariantInternal = checkInvariantInternal;
--[ No side effect ]--
