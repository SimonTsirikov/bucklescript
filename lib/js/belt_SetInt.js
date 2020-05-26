'use strict';

var Belt_internalAVLset = require("./belt_internalAVLset.js");
var Belt_internalSetInt = require("./belt_internalSetInt.js");

function add(t, x) do
  if (t ~= null) then do
    var v = t.value;
    if (x == v) then do
      return t;
    end else do
      var l = t.left;
      var r = t.right;
      if (x < v) then do
        var ll = add(l, x);
        if (ll == l) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(ll, v, r);
        end end 
      end else do
        var rr = add(r, x);
        if (rr == r) then do
          return t;
        end else do
          return Belt_internalAVLset.bal(l, v, rr);
        end end 
      end end 
    end end 
  end else do
    return Belt_internalAVLset.singleton(x);
  end end 
end

function mergeMany(h, arr) do
  var len = #arr;
  var v = h;
  for var i = 0 , len - 1 | 0 , 1 do
    var key = arr[i];
    v = add(v, key);
  end
  return v;
end

function remove(t, x) do
  if (t ~= null) then do
    var l = t.left;
    var v = t.value;
    var r = t.right;
    if (x == v) then do
      if (l ~= null) then do
        if (r ~= null) then do
          var v$1 = do
            contents: r.value
          end;
          var r$1 = Belt_internalAVLset.removeMinAuxWithRef(r, v$1);
          return Belt_internalAVLset.bal(l, v$1.contents, r$1);
        end else do
          return l;
        end end 
      end else do
        return r;
      end end 
    end else if (x < v) then do
      var ll = remove(l, x);
      if (ll == l) then do
        return t;
      end else do
        return Belt_internalAVLset.bal(ll, v, r);
      end end 
    end else do
      var rr = remove(r, x);
      if (rr == r) then do
        return t;
      end else do
        return Belt_internalAVLset.bal(l, v, rr);
      end end 
    end end  end 
  end else do
    return t;
  end end 
end

function removeMany(h, arr) do
  var len = #arr;
  var v = h;
  for var i = 0 , len - 1 | 0 , 1 do
    var key = arr[i];
    v = remove(v, key);
  end
  return v;
end

function splitAuxNoPivot(n, x) do
  var l = n.left;
  var v = n.value;
  var r = n.right;
  if (x == v) then do
    return --[ tuple ]--[
            l,
            r
          ];
  end else if (x < v) then do
    if (l ~= null) then do
      var match = splitAuxNoPivot(l, x);
      return --[ tuple ]--[
              match[0],
              Belt_internalAVLset.joinShared(match[1], v, r)
            ];
    end else do
      return --[ tuple ]--[
              null,
              n
            ];
    end end 
  end else if (r ~= null) then do
    var match$1 = splitAuxNoPivot(r, x);
    return --[ tuple ]--[
            Belt_internalAVLset.joinShared(l, v, match$1[0]),
            match$1[1]
          ];
  end else do
    return --[ tuple ]--[
            n,
            null
          ];
  end end  end  end 
end

function splitAuxPivot(n, x, pres) do
  var l = n.left;
  var v = n.value;
  var r = n.right;
  if (x == v) then do
    pres.contents = true;
    return --[ tuple ]--[
            l,
            r
          ];
  end else if (x < v) then do
    if (l ~= null) then do
      var match = splitAuxPivot(l, x, pres);
      return --[ tuple ]--[
              match[0],
              Belt_internalAVLset.joinShared(match[1], v, r)
            ];
    end else do
      return --[ tuple ]--[
              null,
              n
            ];
    end end 
  end else if (r ~= null) then do
    var match$1 = splitAuxPivot(r, x, pres);
    return --[ tuple ]--[
            Belt_internalAVLset.joinShared(l, v, match$1[0]),
            match$1[1]
          ];
  end else do
    return --[ tuple ]--[
            n,
            null
          ];
  end end  end  end 
end

function split(t, x) do
  if (t ~= null) then do
    var pres = do
      contents: false
    end;
    var v = splitAuxPivot(t, x, pres);
    return --[ tuple ]--[
            v,
            pres.contents
          ];
  end else do
    return --[ tuple ]--[
            --[ tuple ]--[
              null,
              null
            ],
            false
          ];
  end end 
end

function union(s1, s2) do
  if (s1 ~= null) then do
    if (s2 ~= null) then do
      var h1 = s1.height;
      var h2 = s2.height;
      if (h1 >= h2) then do
        if (h2 == 1) then do
          return add(s1, s2.value);
        end else do
          var l1 = s1.left;
          var v1 = s1.value;
          var r1 = s1.right;
          var match = splitAuxNoPivot(s2, v1);
          return Belt_internalAVLset.joinShared(union(l1, match[0]), v1, union(r1, match[1]));
        end end 
      end else if (h1 == 1) then do
        return add(s2, s1.value);
      end else do
        var l2 = s2.left;
        var v2 = s2.value;
        var r2 = s2.right;
        var match$1 = splitAuxNoPivot(s1, v2);
        return Belt_internalAVLset.joinShared(union(match$1[0], l2), v2, union(match$1[1], r2));
      end end  end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end

function intersect(s1, s2) do
  if (s1 ~= null and s2 ~= null) then do
    var l1 = s1.left;
    var v1 = s1.value;
    var r1 = s1.right;
    var pres = do
      contents: false
    end;
    var match = splitAuxPivot(s2, v1, pres);
    var ll = intersect(l1, match[0]);
    var rr = intersect(r1, match[1]);
    if (pres.contents) then do
      return Belt_internalAVLset.joinShared(ll, v1, rr);
    end else do
      return Belt_internalAVLset.concatShared(ll, rr);
    end end 
  end else do
    return null;
  end end 
end

function diff(s1, s2) do
  if (s1 ~= null and s2 ~= null) then do
    var l1 = s1.left;
    var v1 = s1.value;
    var r1 = s1.right;
    var pres = do
      contents: false
    end;
    var match = splitAuxPivot(s2, v1, pres);
    var ll = diff(l1, match[0]);
    var rr = diff(r1, match[1]);
    if (pres.contents) then do
      return Belt_internalAVLset.concatShared(ll, rr);
    end else do
      return Belt_internalAVLset.joinShared(ll, v1, rr);
    end end 
  end else do
    return s1;
  end end 
end

var empty = null;

var fromArray = Belt_internalSetInt.fromArray;

var fromSortedArrayUnsafe = Belt_internalAVLset.fromSortedArrayUnsafe;

var isEmpty = Belt_internalAVLset.isEmpty;

var has = Belt_internalSetInt.has;

var subset = Belt_internalSetInt.subset;

var cmp = Belt_internalSetInt.cmp;

var eq = Belt_internalSetInt.eq;

var forEachU = Belt_internalAVLset.forEachU;

var forEach = Belt_internalAVLset.forEach;

var reduceU = Belt_internalAVLset.reduceU;

var reduce = Belt_internalAVLset.reduce;

var everyU = Belt_internalAVLset.everyU;

var every = Belt_internalAVLset.every;

var someU = Belt_internalAVLset.someU;

var some = Belt_internalAVLset.some;

var keepU = Belt_internalAVLset.keepSharedU;

var keep = Belt_internalAVLset.keepShared;

var partitionU = Belt_internalAVLset.partitionSharedU;

var partition = Belt_internalAVLset.partitionShared;

var size = Belt_internalAVLset.size;

var toList = Belt_internalAVLset.toList;

var toArray = Belt_internalAVLset.toArray;

var minimum = Belt_internalAVLset.minimum;

var minUndefined = Belt_internalAVLset.minUndefined;

var maximum = Belt_internalAVLset.maximum;

var maxUndefined = Belt_internalAVLset.maxUndefined;

var get = Belt_internalSetInt.get;

var getUndefined = Belt_internalSetInt.getUndefined;

var getExn = Belt_internalSetInt.getExn;

var checkInvariantInternal = Belt_internalAVLset.checkInvariantInternal;

exports.empty = empty;
exports.fromArray = fromArray;
exports.fromSortedArrayUnsafe = fromSortedArrayUnsafe;
exports.isEmpty = isEmpty;
exports.has = has;
exports.add = add;
exports.mergeMany = mergeMany;
exports.remove = remove;
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
