console = {log = print};

Curry = require "./curry";
Caml_option = require "./caml_option";
Belt_internalAVLtree = require "./belt_internalAVLtree";
Belt_internalMapString = require "./belt_internalMapString";

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
            r_1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
            return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r_1);
          end else do
            return l;
          end end 
        end else do
          return r;
        end end 
      end end 
    end else do
      l_1 = t.left;
      r_2 = t.right;
      v = t.value;
      if (x < k) then do
        ll = updateU(l_1, x, f);
        if (l_1 == ll) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(ll, k, v, r_2);
        end end 
      end else do
        rr = updateU(r_2, x, f);
        if (r_2 == rr) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(l_1, k, v, rr);
        end end 
      end end 
    end end 
  end else do
    match_1 = f(undefined);
    if (match_1 ~= undefined) then do
      return Belt_internalAVLtree.singleton(x, Caml_option.valFromOption(match_1));
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
        r_1 = Belt_internalAVLtree.removeMinAuxWithRef(r, kr, vr);
        return Belt_internalAVLtree.bal(l, kr.contents, vr.contents, r_1);
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
    len_1 = len;
    while(true) do
      i = _i;
      t_1 = _t;
      if (i < len_1) then do
        ele = xs[i];
        u = removeAux(t_1, ele);
        if (u ~= nil) then do
          _i = i + 1 | 0;
          _t = u;
          ::continue:: ;
        end else do
          return u;
        end end 
      end else do
        return t_1;
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

has = Belt_internalMapString.has;

cmpU = Belt_internalMapString.cmpU;

cmp = Belt_internalMapString.cmp;

eqU = Belt_internalMapString.eqU;

eq = Belt_internalMapString.eq;

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

fromArray = Belt_internalMapString.fromArray;

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

get = Belt_internalMapString.get;

getUndefined = Belt_internalMapString.getUndefined;

getWithDefault = Belt_internalMapString.getWithDefault;

getExn = Belt_internalMapString.getExn;

checkInvariantInternal = Belt_internalAVLtree.checkInvariantInternal;

mergeU = Belt_internalMapString.mergeU;

merge = Belt_internalMapString.merge;

keepU = Belt_internalAVLtree.keepSharedU;

keep = Belt_internalAVLtree.keepShared;

partitionU = Belt_internalAVLtree.partitionSharedU;

partition = Belt_internalAVLtree.partitionShared;

split = Belt_internalMapString.split;

mapU = Belt_internalAVLtree.mapU;

map = Belt_internalAVLtree.map;

mapWithKeyU = Belt_internalAVLtree.mapWithKeyU;

mapWithKey = Belt_internalAVLtree.mapWithKey;

exports = {}
exports.empty = empty;
exports.isEmpty = isEmpty;
exports.has = has;
exports.cmpU = cmpU;
exports.cmp = cmp;
exports.eqU = eqU;
exports.eq = eq;
exports.findFirstByU = findFirstByU;
exports.findFirstBy = findFirstBy;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.size = size;
exports.toList = toList;
exports.toArray = toArray;
exports.fromArray = fromArray;
exports.keysToArray = keysToArray;
exports.valuesToArray = valuesToArray;
exports.minKey = minKey;
exports.minKeyUndefined = minKeyUndefined;
exports.maxKey = maxKey;
exports.maxKeyUndefined = maxKeyUndefined;
exports.minimum = minimum;
exports.minUndefined = minUndefined;
exports.maximum = maximum;
exports.maxUndefined = maxUndefined;
exports.get = get;
exports.getUndefined = getUndefined;
exports.getWithDefault = getWithDefault;
exports.getExn = getExn;
exports.checkInvariantInternal = checkInvariantInternal;
exports.remove = remove;
exports.removeMany = removeMany;
exports.set = set;
exports.updateU = updateU;
exports.update = update;
exports.mergeU = mergeU;
exports.merge = merge;
exports.mergeMany = mergeMany;
exports.keepU = keepU;
exports.keep = keep;
exports.partitionU = partitionU;
exports.partition = partition;
exports.split = split;
exports.mapU = mapU;
exports.map = map;
exports.mapWithKeyU = mapWithKeyU;
exports.mapWithKey = mapWithKey;
--[[ No side effect ]]
