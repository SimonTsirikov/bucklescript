

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";
import * as Belt_internalMapInt from "./belt_internalMapInt.lua";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.lua";

function set(t, newK, newD) do
  if (t ~= nil) then do
    k = t.key;
    if (newK == k) then do
      return Belt_internalAVLtree.updateValue(t, newD);
    end else do
      v = t.value;
      if (newK < k) then do
        return Belt_internalAVLtree.bal(set(t.left, newK, newD), k, v, t.right);
      end else do
        return Belt_internalAVLtree.bal(t.left, k, v, set(t.right, newK, newD));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(newK, newD);
  end end 
end end

function updateU(t, x, f) do
  if (t ~= nil) then do
    k = t.key;
    if (x == k) then do
      match = f(Caml_option.some(t.value));
      if (match ~= undefined) then do
        return Belt_internalAVLtree.updateValue(t, Caml_option.valFromOption(match));
      end else do
        l = t.left;
        r = t.right;
        if (l ~= nil) then do
          if (r ~= nil) then do
            kr = do
              contents: r.key
            end;
            vr = do
              contents: r.value
            end;
            r$1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
            return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r$1);
          end else do
            return l;
          end end 
        end else do
          return r;
        end end 
      end end 
    end else do
      l$1 = t.left;
      r$2 = t.right;
      v = t.value;
      if (x < k) then do
        ll = updateU(l$1, x, f);
        if (l$1 == ll) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(ll, k, v, r$2);
        end end 
      end else do
        rr = updateU(r$2, x, f);
        if (r$2 == rr) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(l$1, k, v, rr);
        end end 
      end end 
    end end 
  end else do
    match$1 = f(undefined);
    if (match$1 ~= undefined) then do
      return Belt_internalAVLtree.singleton(x, Caml_option.valFromOption(match$1));
    end else do
      return t;
    end end 
  end end 
end end

function update(t, x, f) do
  return updateU(t, x, Curry.__1(f));
end end

function removeAux(n, x) do
  l = n.left;
  v = n.key;
  r = n.right;
  if (x == v) then do
    if (l ~= nil) then do
      if (r ~= nil) then do
        kr = do
          contents: r.key
        end;
        vr = do
          contents: r.value
        end;
        r$1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
        return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r$1);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < v) then do
    if (l ~= nil) then do
      ll = removeAux(l, x);
      if (ll == l) then do
        return n;
      end else do
        return Belt_internalAVLtree.bal(ll, v, n.value, r);
      end end 
    end else do
      return n;
    end end 
  end else if (r ~= nil) then do
    rr = removeAux(r, x);
    return Belt_internalAVLtree.bal(l, v, n.value, rr);
  end else do
    return n;
  end end  end  end 
end end

function remove(n, x) do
  if (n ~= nil) then do
    return removeAux(n, x);
  end else do
    return nil;
  end end 
end end

function removeMany(t, keys) do
  len = #keys;
  if (t ~= nil) then do
    _t = t;
    xs = keys;
    _i = 0;
    len$1 = len;
    while(true) do
      i = _i;
      t$1 = _t;
      if (i < len$1) then do
        ele = xs[i];
        u = removeAux(t$1, ele);
        if (u ~= nil) then do
          _i = i + 1 | 0;
          _t = u;
          ::continue:: ;
        end else do
          return u;
        end end 
      end else do
        return t$1;
      end end 
    end;
  end else do
    return nil;
  end end 
end end

function mergeMany(h, arr) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    match = arr[i];
    v = set(v, match[0], match[1]);
  end
  return v;
end end

empty = nil;

isEmpty = Belt_internalAVLtree.isEmpty;

has = Belt_internalMapInt.has;

cmpU = Belt_internalMapInt.cmpU;

cmp = Belt_internalMapInt.cmp;

eqU = Belt_internalMapInt.eqU;

eq = Belt_internalMapInt.eq;

findFirstByU = Belt_internalAVLtree.findFirstByU;

findFirstBy = Belt_internalAVLtree.findFirstBy;

forEachU = Belt_internalAVLtree.forEachU;

forEach = Belt_internalAVLtree.forEach;

reduceU = Belt_internalAVLtree.reduceU;

reduce = Belt_internalAVLtree.reduce;

everyU = Belt_internalAVLtree.everyU;

every = Belt_internalAVLtree.every;

someU = Belt_internalAVLtree.someU;

some = Belt_internalAVLtree.some;

size = Belt_internalAVLtree.size;

toList = Belt_internalAVLtree.toList;

toArray = Belt_internalAVLtree.toArray;

fromArray = Belt_internalMapInt.fromArray;

keysToArray = Belt_internalAVLtree.keysToArray;

valuesToArray = Belt_internalAVLtree.valuesToArray;

minKey = Belt_internalAVLtree.minKey;

minKeyUndefined = Belt_internalAVLtree.minKeyUndefined;

maxKey = Belt_internalAVLtree.maxKey;

maxKeyUndefined = Belt_internalAVLtree.maxKeyUndefined;

minimum = Belt_internalAVLtree.minimum;

minUndefined = Belt_internalAVLtree.minUndefined;

maximum = Belt_internalAVLtree.maximum;

maxUndefined = Belt_internalAVLtree.maxUndefined;

get = Belt_internalMapInt.get;

getUndefined = Belt_internalMapInt.getUndefined;

getWithDefault = Belt_internalMapInt.getWithDefault;

getExn = Belt_internalMapInt.getExn;

checkInvariantInternal = Belt_internalAVLtree.checkInvariantInternal;

mergeU = Belt_internalMapInt.mergeU;

merge = Belt_internalMapInt.merge;

keepU = Belt_internalAVLtree.keepSharedU;

keep = Belt_internalAVLtree.keepShared;

partitionU = Belt_internalAVLtree.partitionSharedU;

partition = Belt_internalAVLtree.partitionShared;

split = Belt_internalMapInt.split;

mapU = Belt_internalAVLtree.mapU;

map = Belt_internalAVLtree.map;

mapWithKeyU = Belt_internalAVLtree.mapWithKeyU;

mapWithKey = Belt_internalAVLtree.mapWithKey;

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
--[[ No side effect ]]
