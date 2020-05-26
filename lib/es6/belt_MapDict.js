

import * as Curry from "./curry.js";
import * as Caml_option from "./caml_option.js";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.js";

function set(t, newK, newD, cmp) do
  if (t ~= null) then do
    var k = t.key;
    var c = cmp(newK, k);
    if (c == 0) then do
      return Belt_internalAVLtree.updateValue(t, newD);
    end else do
      var l = t.left;
      var r = t.right;
      var v = t.value;
      if (c < 0) then do
        return Belt_internalAVLtree.bal(set(l, newK, newD, cmp), k, v, r);
      end else do
        return Belt_internalAVLtree.bal(l, k, v, set(r, newK, newD, cmp));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(newK, newD);
  end end 
end

function updateU(t, newK, f, cmp) do
  if (t ~= null) then do
    var k = t.key;
    var c = cmp(newK, k);
    if (c == 0) then do
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
      if (c < 0) then do
        var ll = updateU(l$1, newK, f, cmp);
        if (l$1 == ll) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(ll, k, v, r$2);
        end end 
      end else do
        var rr = updateU(r$2, newK, f, cmp);
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
      return Belt_internalAVLtree.singleton(newK, Caml_option.valFromOption(match$1));
    end else do
      return t;
    end end 
  end end 
end

function update(t, newK, f, cmp) do
  return updateU(t, newK, Curry.__1(f), cmp);
end

function removeAux0(n, x, cmp) do
  var l = n.left;
  var v = n.key;
  var r = n.right;
  var c = cmp(x, v);
  if (c == 0) then do
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
  end else if (c < 0) then do
    if (l ~= null) then do
      var ll = removeAux0(l, x, cmp);
      if (ll == l) then do
        return n;
      end else do
        return Belt_internalAVLtree.bal(ll, v, n.value, r);
      end end 
    end else do
      return n;
    end end 
  end else if (r ~= null) then do
    var rr = removeAux0(r, x, cmp);
    if (rr == r) then do
      return n;
    end else do
      return Belt_internalAVLtree.bal(l, v, n.value, rr);
    end end 
  end else do
    return n;
  end end  end  end 
end

function remove(n, x, cmp) do
  if (n ~= null) then do
    return removeAux0(n, x, cmp);
  end else do
    return null;
  end end 
end

function mergeMany(h, arr, cmp) do
  var len = #arr;
  var v = h;
  for var i = 0 , len - 1 | 0 , 1 do
    var match = arr[i];
    v = set(v, match[0], match[1], cmp);
  end
  return v;
end

function splitAuxPivot(n, x, pres, cmp) do
  var l = n.left;
  var v = n.key;
  var d = n.value;
  var r = n.right;
  var c = cmp(x, v);
  if (c == 0) then do
    pres.contents = Caml_option.some(d);
    return --[ tuple ]--[
            l,
            r
          ];
  end else if (c < 0) then do
    if (l ~= null) then do
      var match = splitAuxPivot(l, x, pres, cmp);
      return --[ tuple ]--[
              match[0],
              Belt_internalAVLtree.join(match[1], v, d, r)
            ];
    end else do
      return --[ tuple ]--[
              null,
              n
            ];
    end end 
  end else if (r ~= null) then do
    var match$1 = splitAuxPivot(r, x, pres, cmp);
    return --[ tuple ]--[
            Belt_internalAVLtree.join(l, v, d, match$1[0]),
            match$1[1]
          ];
  end else do
    return --[ tuple ]--[
            n,
            null
          ];
  end end  end  end 
end

function split(n, x, cmp) do
  if (n ~= null) then do
    var pres = do
      contents: undefined
    end;
    var v = splitAuxPivot(n, x, pres, cmp);
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
            undefined
          ];
  end end 
end

function mergeU(s1, s2, f, cmp) do
  if (s1 ~= null) then do
    if (s2 ~= null) then do
      if (s1.height >= s2.height) then do
        var l1 = s1.left;
        var v1 = s1.key;
        var d1 = s1.value;
        var r1 = s1.right;
        var d2 = do
          contents: undefined
        end;
        var match = splitAuxPivot(s2, v1, d2, cmp);
        var d2$1 = d2.contents;
        var newLeft = mergeU(l1, match[0], f, cmp);
        var newD = f(v1, Caml_option.some(d1), d2$1);
        var newRight = mergeU(r1, match[1], f, cmp);
        return Belt_internalAVLtree.concatOrJoin(newLeft, v1, newD, newRight);
      end else do
        var l2 = s2.left;
        var v2 = s2.key;
        var d2$2 = s2.value;
        var r2 = s2.right;
        var d1$1 = do
          contents: undefined
        end;
        var match$1 = splitAuxPivot(s1, v2, d1$1, cmp);
        var d1$2 = d1$1.contents;
        var newLeft$1 = mergeU(match$1[0], l2, f, cmp);
        var newD$1 = f(v2, d1$2, Caml_option.some(d2$2));
        var newRight$1 = mergeU(match$1[1], r2, f, cmp);
        return Belt_internalAVLtree.concatOrJoin(newLeft$1, v2, newD$1, newRight$1);
      end end 
    end else do
      return Belt_internalAVLtree.keepMapU(s1, (function (k, v) do
                    return f(k, Caml_option.some(v), undefined);
                  end));
    end end 
  end else if (s2 ~= null) then do
    return Belt_internalAVLtree.keepMapU(s2, (function (k, v) do
                  return f(k, undefined, Caml_option.some(v));
                end));
  end else do
    return null;
  end end  end 
end

function merge(s1, s2, f, cmp) do
  return mergeU(s1, s2, Curry.__3(f), cmp);
end

function removeMany(t, keys, cmp) do
  var len = #keys;
  if (t ~= null) then do
    var _t = t;
    var xs = keys;
    var _i = 0;
    var len$1 = len;
    var cmp$1 = cmp;
    while(true) do
      var i = _i;
      var t$1 = _t;
      if (i < len$1) then do
        var ele = xs[i];
        var u = removeAux0(t$1, ele, cmp$1);
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

var empty = null;

var isEmpty = Belt_internalAVLtree.isEmpty;

var has = Belt_internalAVLtree.has;

var cmpU = Belt_internalAVLtree.cmpU;

var cmp = Belt_internalAVLtree.cmp;

var eqU = Belt_internalAVLtree.eqU;

var eq = Belt_internalAVLtree.eq;

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

var fromArray = Belt_internalAVLtree.fromArray;

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

var get = Belt_internalAVLtree.get;

var getUndefined = Belt_internalAVLtree.getUndefined;

var getWithDefault = Belt_internalAVLtree.getWithDefault;

var getExn = Belt_internalAVLtree.getExn;

var checkInvariantInternal = Belt_internalAVLtree.checkInvariantInternal;

var keepU = Belt_internalAVLtree.keepSharedU;

var keep = Belt_internalAVLtree.keepShared;

var partitionU = Belt_internalAVLtree.partitionSharedU;

var partition = Belt_internalAVLtree.partitionShared;

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
