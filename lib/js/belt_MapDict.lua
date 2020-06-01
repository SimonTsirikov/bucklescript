'use strict';

Curry = require("./curry.lua");
Caml_option = require("./caml_option.lua");
Belt_internalAVLtree = require("./belt_internalAVLtree.lua");

function set(t, newK, newD, cmp) do
  if (t ~= null) then do
    k = t.key;
    c = cmp(newK, k);
    if (c == 0) then do
      return Belt_internalAVLtree.updateValue(t, newD);
    end else do
      l = t.left;
      r = t.right;
      v = t.value;
      if (c < 0) then do
        return Belt_internalAVLtree.bal(set(l, newK, newD, cmp), k, v, r);
      end else do
        return Belt_internalAVLtree.bal(l, k, v, set(r, newK, newD, cmp));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(newK, newD);
  end end 
end end

function updateU(t, newK, f, cmp) do
  if (t ~= null) then do
    k = t.key;
    c = cmp(newK, k);
    if (c == 0) then do
      match = f(Caml_option.some(t.value));
      if (match ~= undefined) then do
        return Belt_internalAVLtree.updateValue(t, Caml_option.valFromOption(match));
      end else do
        l = t.left;
        r = t.right;
        if (l ~= null) then do
          if (r ~= null) then do
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
      if (c < 0) then do
        ll = updateU(l$1, newK, f, cmp);
        if (l$1 == ll) then do
          return t;
        end else do
          return Belt_internalAVLtree.bal(ll, k, v, r$2);
        end end 
      end else do
        rr = updateU(r$2, newK, f, cmp);
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
      return Belt_internalAVLtree.singleton(newK, Caml_option.valFromOption(match$1));
    end else do
      return t;
    end end 
  end end 
end end

function update(t, newK, f, cmp) do
  return updateU(t, newK, Curry.__1(f), cmp);
end end

function removeAux0(n, x, cmp) do
  l = n.left;
  v = n.key;
  r = n.right;
  c = cmp(x, v);
  if (c == 0) then do
    if (l ~= null) then do
      if (r ~= null) then do
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
  end else if (c < 0) then do
    if (l ~= null) then do
      ll = removeAux0(l, x, cmp);
      if (ll == l) then do
        return n;
      end else do
        return Belt_internalAVLtree.bal(ll, v, n.value, r);
      end end 
    end else do
      return n;
    end end 
  end else if (r ~= null) then do
    rr = removeAux0(r, x, cmp);
    if (rr == r) then do
      return n;
    end else do
      return Belt_internalAVLtree.bal(l, v, n.value, rr);
    end end 
  end else do
    return n;
  end end  end  end 
end end

function remove(n, x, cmp) do
  if (n ~= null) then do
    return removeAux0(n, x, cmp);
  end else do
    return null;
  end end 
end end

function mergeMany(h, arr, cmp) do
  len = #arr;
  v = h;
  for i = 0 , len - 1 | 0 , 1 do
    match = arr[i];
    v = set(v, match[0], match[1], cmp);
  end
  return v;
end end

function splitAuxPivot(n, x, pres, cmp) do
  l = n.left;
  v = n.key;
  d = n.value;
  r = n.right;
  c = cmp(x, v);
  if (c == 0) then do
    pres.contents = Caml_option.some(d);
    return --[[ tuple ]][
            l,
            r
          ];
  end else if (c < 0) then do
    if (l ~= null) then do
      match = splitAuxPivot(l, x, pres, cmp);
      return --[[ tuple ]][
              match[0],
              Belt_internalAVLtree.join(match[1], v, d, r)
            ];
    end else do
      return --[[ tuple ]][
              null,
              n
            ];
    end end 
  end else if (r ~= null) then do
    match$1 = splitAuxPivot(r, x, pres, cmp);
    return --[[ tuple ]][
            Belt_internalAVLtree.join(l, v, d, match$1[0]),
            match$1[1]
          ];
  end else do
    return --[[ tuple ]][
            n,
            null
          ];
  end end  end  end 
end end

function split(n, x, cmp) do
  if (n ~= null) then do
    pres = do
      contents: undefined
    end;
    v = splitAuxPivot(n, x, pres, cmp);
    return --[[ tuple ]][
            v,
            pres.contents
          ];
  end else do
    return --[[ tuple ]][
            --[[ tuple ]][
              null,
              null
            ],
            undefined
          ];
  end end 
end end

function mergeU(s1, s2, f, cmp) do
  if (s1 ~= null) then do
    if (s2 ~= null) then do
      if (s1.height >= s2.height) then do
        l1 = s1.left;
        v1 = s1.key;
        d1 = s1.value;
        r1 = s1.right;
        d2 = do
          contents: undefined
        end;
        match = splitAuxPivot(s2, v1, d2, cmp);
        d2$1 = d2.contents;
        newLeft = mergeU(l1, match[0], f, cmp);
        newD = f(v1, Caml_option.some(d1), d2$1);
        newRight = mergeU(r1, match[1], f, cmp);
        return Belt_internalAVLtree.concatOrJoin(newLeft, v1, newD, newRight);
      end else do
        l2 = s2.left;
        v2 = s2.key;
        d2$2 = s2.value;
        r2 = s2.right;
        d1$1 = do
          contents: undefined
        end;
        match$1 = splitAuxPivot(s1, v2, d1$1, cmp);
        d1$2 = d1$1.contents;
        newLeft$1 = mergeU(match$1[0], l2, f, cmp);
        newD$1 = f(v2, d1$2, Caml_option.some(d2$2));
        newRight$1 = mergeU(match$1[1], r2, f, cmp);
        return Belt_internalAVLtree.concatOrJoin(newLeft$1, v2, newD$1, newRight$1);
      end end 
    end else do
      return Belt_internalAVLtree.keepMapU(s1, (function (k, v) do
                    return f(k, Caml_option.some(v), undefined);
                  end end));
    end end 
  end else if (s2 ~= null) then do
    return Belt_internalAVLtree.keepMapU(s2, (function (k, v) do
                  return f(k, undefined, Caml_option.some(v));
                end end));
  end else do
    return null;
  end end  end 
end end

function merge(s1, s2, f, cmp) do
  return mergeU(s1, s2, Curry.__3(f), cmp);
end end

function removeMany(t, keys, cmp) do
  len = #keys;
  if (t ~= null) then do
    _t = t;
    xs = keys;
    _i = 0;
    len$1 = len;
    cmp$1 = cmp;
    while(true) do
      i = _i;
      t$1 = _t;
      if (i < len$1) then do
        ele = xs[i];
        u = removeAux0(t$1, ele, cmp$1);
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
end end

empty = null;

isEmpty = Belt_internalAVLtree.isEmpty;

has = Belt_internalAVLtree.has;

cmpU = Belt_internalAVLtree.cmpU;

cmp = Belt_internalAVLtree.cmp;

eqU = Belt_internalAVLtree.eqU;

eq = Belt_internalAVLtree.eq;

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

fromArray = Belt_internalAVLtree.fromArray;

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

get = Belt_internalAVLtree.get;

getUndefined = Belt_internalAVLtree.getUndefined;

getWithDefault = Belt_internalAVLtree.getWithDefault;

getExn = Belt_internalAVLtree.getExn;

checkInvariantInternal = Belt_internalAVLtree.checkInvariantInternal;

keepU = Belt_internalAVLtree.keepSharedU;

keep = Belt_internalAVLtree.keepShared;

partitionU = Belt_internalAVLtree.partitionSharedU;

partition = Belt_internalAVLtree.partitionShared;

mapU = Belt_internalAVLtree.mapU;

map = Belt_internalAVLtree.map;

mapWithKeyU = Belt_internalAVLtree.mapWithKeyU;

mapWithKey = Belt_internalAVLtree.mapWithKey;

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
