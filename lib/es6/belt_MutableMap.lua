

local Curry = require "..curry.lua";
local Caml_option = require "..caml_option.lua";
local Belt_internalAVLtree = require "..belt_internalAVLtree.lua";

function removeMutateAux(nt, x, cmp) do
  k = nt.key;
  c = cmp(x, k);
  if (c == 0) then do
    l = nt.left;
    r = nt.right;
    if (l ~= nil) then do
      if (r ~= nil) then do
        nt.right = Belt_internalAVLtree.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLtree.balMutate(nt);
      end else do
        return l;
      end end 
    end else if (r ~= nil) then do
      return r;
    end else do
      return l;
    end end  end 
  end else if (c < 0) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = removeMutateAux(match, x, cmp);
      return Belt_internalAVLtree.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match_1 = nt.right;
    if (match_1 ~= nil) then do
      nt.right = removeMutateAux(match_1, x, cmp);
      return Belt_internalAVLtree.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function remove(d, k) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    newRoot = removeMutateAux(oldRoot, k, d.cmp);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function removeArrayMutateAux(_t, xs, _i, len, cmp) do
  while(true) do
    i = _i;
    t = _t;
    if (i < len) then do
      ele = xs[i];
      u = removeMutateAux(t, ele, cmp);
      if (u ~= nil) then do
        _i = i + 1 | 0;
        _t = u;
        ::continue:: ;
      end else do
        return nil;
      end end 
    end else do
      return t;
    end end 
  end;
end end

function removeMany(d, xs) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    len = #xs;
    newRoot = removeArrayMutateAux(oldRoot, xs, 0, len, d.cmp);
    if (newRoot ~= oldRoot) then do
      d.data = newRoot;
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function updateDone(t, x, f, cmp) do
  if (t ~= nil) then do
    k = t.key;
    c = cmp(x, k);
    if (c == 0) then do
      match = f(Caml_option.some(t.value));
      if (match ~= nil) then do
        t.value = Caml_option.valFromOption(match);
        return t;
      end else do
        l = t.left;
        r = t.right;
        if (l ~= nil) then do
          if (r ~= nil) then do
            t.right = Belt_internalAVLtree.removeMinAuxWithRootMutate(t, r);
            return Belt_internalAVLtree.balMutate(t);
          end else do
            return l;
          end end 
        end else if (r ~= nil) then do
          return r;
        end else do
          return l;
        end end  end 
      end end 
    end else do
      l_1 = t.left;
      r_1 = t.right;
      if (c < 0) then do
        ll = updateDone(l_1, x, f, cmp);
        t.left = ll;
      end else do
        t.right = updateDone(r_1, x, f, cmp);
      end end 
      return Belt_internalAVLtree.balMutate(t);
    end end 
  end else do
    match_1 = f(nil);
    if (match_1 ~= nil) then do
      return Belt_internalAVLtree.singleton(x, Caml_option.valFromOption(match_1));
    end else do
      return t;
    end end 
  end end 
end end

function updateU(t, x, f) do
  oldRoot = t.data;
  newRoot = updateDone(oldRoot, x, f, t.cmp);
  if (newRoot ~= oldRoot) then do
    t.data = newRoot;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function update(t, x, f) do
  return updateU(t, x, Curry.__1(f));
end end

function make(id) do
  return {
          cmp = id.cmp,
          data = nil
        };
end end

function clear(m) do
  m.data = nil;
  return --[[ () ]]0;
end end

function isEmpty(d) do
  x = d.data;
  return x == nil;
end end

function minKey(m) do
  return Belt_internalAVLtree.minKey(m.data);
end end

function minKeyUndefined(m) do
  return Belt_internalAVLtree.minKeyUndefined(m.data);
end end

function maxKey(m) do
  return Belt_internalAVLtree.maxKey(m.data);
end end

function maxKeyUndefined(m) do
  return Belt_internalAVLtree.maxKeyUndefined(m.data);
end end

function minimum(m) do
  return Belt_internalAVLtree.minimum(m.data);
end end

function minUndefined(m) do
  return Belt_internalAVLtree.minUndefined(m.data);
end end

function maximum(m) do
  return Belt_internalAVLtree.maximum(m.data);
end end

function maxUndefined(m) do
  return Belt_internalAVLtree.maxUndefined(m.data);
end end

function forEachU(d, f) do
  return Belt_internalAVLtree.forEachU(d.data, f);
end end

function forEach(d, f) do
  return Belt_internalAVLtree.forEachU(d.data, Curry.__2(f));
end end

function reduceU(d, acc, cb) do
  return Belt_internalAVLtree.reduceU(d.data, acc, cb);
end end

function reduce(d, acc, cb) do
  return reduceU(d, acc, Curry.__3(cb));
end end

function everyU(d, p) do
  return Belt_internalAVLtree.everyU(d.data, p);
end end

function every(d, p) do
  return Belt_internalAVLtree.everyU(d.data, Curry.__2(p));
end end

function someU(d, p) do
  return Belt_internalAVLtree.someU(d.data, p);
end end

function some(d, p) do
  return Belt_internalAVLtree.someU(d.data, Curry.__2(p));
end end

function size(d) do
  return Belt_internalAVLtree.size(d.data);
end end

function toList(d) do
  return Belt_internalAVLtree.toList(d.data);
end end

function toArray(d) do
  return Belt_internalAVLtree.toArray(d.data);
end end

function keysToArray(d) do
  return Belt_internalAVLtree.keysToArray(d.data);
end end

function valuesToArray(d) do
  return Belt_internalAVLtree.valuesToArray(d.data);
end end

function checkInvariantInternal(d) do
  return Belt_internalAVLtree.checkInvariantInternal(d.data);
end end

function cmpU(m1, m2, cmp) do
  return Belt_internalAVLtree.cmpU(m1.data, m2.data, m1.cmp, cmp);
end end

function cmp(m1, m2, cmp_1) do
  return cmpU(m1, m2, Curry.__2(cmp_1));
end end

function eqU(m1, m2, cmp) do
  return Belt_internalAVLtree.eqU(m1.data, m2.data, m1.cmp, cmp);
end end

function eq(m1, m2, cmp) do
  return eqU(m1, m2, Curry.__2(cmp));
end end

function mapU(m, f) do
  return {
          cmp = m.cmp,
          data = Belt_internalAVLtree.mapU(m.data, f)
        };
end end

function map(m, f) do
  return mapU(m, Curry.__1(f));
end end

function mapWithKeyU(m, f) do
  return {
          cmp = m.cmp,
          data = Belt_internalAVLtree.mapWithKeyU(m.data, f)
        };
end end

function mapWithKey(m, f) do
  return mapWithKeyU(m, Curry.__2(f));
end end

function get(m, x) do
  return Belt_internalAVLtree.get(m.data, x, m.cmp);
end end

function getUndefined(m, x) do
  return Belt_internalAVLtree.getUndefined(m.data, x, m.cmp);
end end

function getWithDefault(m, x, def) do
  return Belt_internalAVLtree.getWithDefault(m.data, x, def, m.cmp);
end end

function getExn(m, x) do
  return Belt_internalAVLtree.getExn(m.data, x, m.cmp);
end end

function has(m, x) do
  return Belt_internalAVLtree.has(m.data, x, m.cmp);
end end

function fromArray(data, id) do
  cmp = id.cmp;
  return {
          cmp = cmp,
          data = Belt_internalAVLtree.fromArray(data, cmp)
        };
end end

function set(m, e, v) do
  oldRoot = m.data;
  newRoot = Belt_internalAVLtree.updateMutate(oldRoot, e, v, m.cmp);
  if (newRoot ~= oldRoot) then do
    m.data = newRoot;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function mergeManyAux(t, xs, cmp) do
  v = t;
  for i = 0 , #xs - 1 | 0 , 1 do
    match = xs[i];
    v = Belt_internalAVLtree.updateMutate(v, match[1], match[2], cmp);
  end
  return v;
end end

function mergeMany(d, xs) do
  oldRoot = d.data;
  newRoot = mergeManyAux(oldRoot, xs, d.cmp);
  if (newRoot ~= oldRoot) then do
    d.data = newRoot;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

Int = --[[ alias ]]0;

__String = --[[ alias ]]0;

export do
  Int ,
  __String ,
  make ,
  clear ,
  isEmpty ,
  has ,
  cmpU ,
  cmp ,
  eqU ,
  eq ,
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
  mergeMany ,
  mapU ,
  map ,
  mapWithKeyU ,
  mapWithKey ,
  
end
--[[ No side effect ]]
