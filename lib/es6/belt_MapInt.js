

import * as Curry from "./curry.js";
import * as Caml_option from "./caml_option.js";
import * as Belt_internalMapInt from "./belt_internalMapInt.js";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.js";

function set(t, newK, newD) do
  if (t ~= null) then do
    var k = t.key;
    if (newK == k) then do
      return Belt_internalAVLtree.updateValue(t, newD);
    end else do
      var v = t.value;
      if (newK < k) then do
        return Belt_internalAVLtree.bal(set(t.left, newK, newD), k, v, t.right);
      end else do
        return Belt_internalAVLtree.bal(t.left, k, v, set(t.right, newK, newD));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(newK, newD);
  end end 
end

function updateU(t, x, f) do
  if (t ~= null) then do
    var k = t.key;
    if (x == k) then do
      var match = f(Caml_option.some(t.value));
      if (match ~= undefined) then do
        return Belt_internalAVLtree.updateValue(t, Caml_option.valFromOption(match));
      end else do
        var l = t.left;
        var r = t.right;
        if (l ~= null) then do
          if (r ~= null) then do
            var kr = do
              contents: r.key
            end;
            var vr = do
              contents: r.value
            end;
            var r$1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
            return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r$1);
          end else do
            return l;
          end end 
        end else do
          return r;
        end end 
      end end 
    end else do
      var l$1 = t.left;
      var r$2 = t.right;
      var v = t.value;
      if (x < k) then do
        var ll = updateU(l$1, x, f);
        if (l$1 == ll) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(ll, k, v, r$2);
        end end 
      end else do
        var rr = updateU(r$2, x, f);
        if (r$2 == rr) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(l$1, k, v, rr);
        end end 
      end end 
    end end 
  end else do
    var match$1 = f(undefined);
    if (match$1 ~= undefined) then do
      return Belt_internalAVLtree.singleton(x, Caml_option.valFromOption(match$1));
    end else do
      return t;
    end end 
  end end 
end

function update(t, x, f) do
  return updateU(t, x, Curry.__1(f));
end

function removeAux(n, x) do
  var l = n.left;
  var v = n.key;
  var r = n.right;
  if (x == v) then do
    if (l ~= null) then do
      if (r ~= null) then do
        var kr = do
          contents: r.key
        end;
        var vr = do
          contents: r.value
        end;
        var r$1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
        return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r$1);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < v) then do
    if (l ~= null) then do
      var ll = removeAux(l, x);
      if (ll == l) then do
        return n;
      end else do
        return Belt_internalAVLtree.bal(ll, v, n.value, r);
      end end 
    end else do
      return n;
    end end 
  end else if (r ~= null) then do
    var rr = removeAux(r, x);
    return Belt_internalAVLtree.bal(l, v, n.value, rr);
  end else do
    return n;
  end end  end  end 
end

function remove(n, x) do
  if (n ~= null) then do
    return removeAux(n, x);
  end else do
    return null;
  end end 
end

function removeMany(t, keys) do
  var len = #keys;
  if (t ~= null) then do
    var _t = t;
    var xs = keys;
    var _i = 0;
    var len$1 = len;
    while(true) do
      var i = _i;
      var t$1 = _t;
      if (i < len$1) then do
        var ele = xs[i];
        var u = removeAux(t$1, ele);
        if (u ~= null) then do
          _i = i + 1 | 0;
          _t = u;
          continue ;
        end else do
          return u;
        end end 
      end else do
        return t$1;
      end end 
    end;
  end else do
    return null;
  end end 
end

function mergeMany(h, arr) do
  var len = #arr;
  var v = h;
  for var i = 0 , len - 1 | 0 , 1 do
    var match = arr[i];
    v = set(v, match[0], match[1]);
  end
  return v;
end

var empty = null;

var isEmpty = Belt_internalAVLtree.isEmpty;

var has = Belt_internalMapInt.has;

var cmpU = Belt_internalMapInt.cmpU;

var cmp = Belt_internalMapInt.cmp;

var eqU = Belt_internalMapInt.eqU;

var eq = Belt_internalMapInt.eq;

var findFirstByU = Belt_internalAVLtree.findFirstByU;

var findFirstBy = Belt_internalAVLtree.findFirstBy;

var forEachU = Belt_internalAVLtree.forEachU;

var forEach = Belt_internalAVLtree.forEach;

var reduceU = Belt_internalAVLtree.reduceU;

var reduce = Belt_internalAVLtree.reduce;

var everyU = Belt_internalAVLtree.everyU;

var every = Belt_internalAVLtree.every;

var someU = Belt_internalAVLtree.someU;

var some = Belt_internalAVLtree.some;

var size = Belt_internalAVLtree.size;

var toList = Belt_internalAVLtree.toList;

var toArray = Belt_internalAVLtree.toArray;

var fromArray = Belt_internalMapInt.fromArray;

var keysToArray = Belt_internalAVLtree.keysToArray;

var valuesToArray = Belt_internalAVLtree.valuesToArray;

var minKey = Belt_internalAVLtree.minKey;

var minKeyUndefined = Belt_internalAVLtree.minKeyUndefined;

var maxKey = Belt_internalAVLtree.maxKey;

var maxKeyUndefined = Belt_internalAVLtree.maxKeyUndefined;

var minimum = Belt_internalAVLtree.minimum;

var minUndefined = Belt_internalAVLtree.minUndefined;

var maximum = Belt_internalAVLtree.maximum;

var maxUndefined = Belt_internalAVLtree.maxUndefined;

var get = Belt_internalMapInt.get;

var getUndefined = Belt_internalMapInt.getUndefined;

var getWithDefault = Belt_internalMapInt.getWithDefault;

var getExn = Belt_internalMapInt.getExn;

var checkInvariantInternal = Belt_internalAVLtree.checkInvariantInternal;

var mergeU = Belt_internalMapInt.mergeU;

var merge = Belt_internalMapInt.merge;

var keepU = Belt_internalAVLtree.keepSharedU;

var keep = Belt_internalAVLtree.keepShared;

var partitionU = Belt_internalAVLtree.partitionSharedU;

var partition = Belt_internalAVLtree.partitionShared;

var split = Belt_internalMapInt.split;

var mapU = Belt_internalAVLtree.mapU;

var map = Belt_internalAVLtree.map;

var mapWithKeyU = Belt_internalAVLtree.mapWithKeyU;

var mapWithKey = Belt_internalAVLtree.mapWithKey;

export do
  empty ,
  isEmpty ,
  has ,
  cmpU ,
  cmp ,
  eqU ,
  eq ,
  findFirstByU ,
  findFirstBy ,
  forEachU ,
  forEach ,
  reduceU ,
  reduce ,
  everyU ,
  every ,
  someU ,
  some ,
  size ,
  toList ,
  toArray ,
  fromArray ,
  keysToArray ,
  valuesToArray ,
  minKey ,
  minKeyUndefined ,
  maxKey ,
  maxKeyUndefined ,
  minimum ,
  minUndefined ,
  maximum ,
  maxUndefined ,
  get ,
  getUndefined ,
  getWithDefault ,
  getExn ,
  checkInvariantInternal ,
  remove ,
  removeMany ,
  set ,
  updateU ,
  update ,
  mergeU ,
  merge ,
  mergeMany ,
  keepU ,
  keep ,
  partitionU ,
  partition ,
  split ,
  mapU ,
  map ,
  mapWithKeyU ,
  mapWithKey ,
  
end
--[ No side effect ]--
