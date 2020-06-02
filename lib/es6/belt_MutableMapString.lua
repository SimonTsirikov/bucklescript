

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.lua";
import * as Belt_internalMapString from "./belt_internalMapString.lua";

function make(param) do
  return do
          data: nil
        end;
end end

function isEmpty(m) do
  x = m.data;
  return x == nil;
end end

function clear(m) do
  m.data = nil;
  return --[[ () ]]0;
end end

function minKeyUndefined(m) do
  return Belt_internalAVLtree.minKeyUndefined(m.data);
end end

function minKey(m) do
  return Belt_internalAVLtree.minKey(m.data);
end end

function maxKeyUndefined(m) do
  return Belt_internalAVLtree.maxKeyUndefined(m.data);
end end

function maxKey(m) do
  return Belt_internalAVLtree.maxKey(m.data);
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

function set(m, k, v) do
  old_data = m.data;
  v_1 = Belt_internalMapString.addMutate(old_data, k, v);
  if (v_1 ~= old_data) then do
    m.data = v_1;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function forEachU(d, f) do
  return Belt_internalAVLtree.forEachU(d.data, f);
end end

function forEach(d, f) do
  return Belt_internalAVLtree.forEachU(d.data, Curry.__2(f));
end end

function mapU(d, f) do
  return do
          data: Belt_internalAVLtree.mapU(d.data, f)
        end;
end end

function map(d, f) do
  return mapU(d, Curry.__1(f));
end end

function mapWithKeyU(d, f) do
  return do
          data: Belt_internalAVLtree.mapWithKeyU(d.data, f)
        end;
end end

function mapWithKey(d, f) do
  return mapWithKeyU(d, Curry.__2(f));
end end

function reduceU(d, acc, f) do
  return Belt_internalAVLtree.reduceU(d.data, acc, f);
end end

function reduce(d, acc, f) do
  return reduceU(d, acc, Curry.__3(f));
end end

function everyU(d, f) do
  return Belt_internalAVLtree.everyU(d.data, f);
end end

function every(d, f) do
  return Belt_internalAVLtree.everyU(d.data, Curry.__2(f));
end end

function someU(d, f) do
  return Belt_internalAVLtree.someU(d.data, f);
end end

function some(d, f) do
  return Belt_internalAVLtree.someU(d.data, Curry.__2(f));
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

function has(d, v) do
  return Belt_internalMapString.has(d.data, v);
end end

function removeMutateAux(nt, x) do
  k = nt.key;
  if (x == k) then do
    l = nt.left;
    r = nt.right;
    if (l ~= nil) then do
      if (r ~= nil) then do
        nt.right = Belt_internalAVLtree.removeMinAuxWithRootMutate(nt, r);
        return Belt_internalAVLtree.balMutate(nt);
      end else do
        return l;
      end end 
    end else do
      return r;
    end end 
  end else if (x < k) then do
    match = nt.left;
    if (match ~= nil) then do
      nt.left = removeMutateAux(match, x);
      return Belt_internalAVLtree.balMutate(nt);
    end else do
      return nt;
    end end 
  end else do
    match_1 = nt.right;
    if (match_1 ~= nil) then do
      nt.right = removeMutateAux(match_1, x);
      return Belt_internalAVLtree.balMutate(nt);
    end else do
      return nt;
    end end 
  end end  end 
end end

function remove(d, v) do
  oldRoot = d.data;
  if (oldRoot ~= nil) then do
    newRoot = removeMutateAux(oldRoot, v);
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

function updateDone(t, x, f) do
  if (t ~= nil) then do
    k = t.key;
    if (k == x) then do
      match = f(Caml_option.some(t.value));
      if (match ~= undefined) then do
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
        end else do
          return r;
        end end 
      end end 
    end else do
      l_1 = t.left;
      r_1 = t.right;
      if (x < k) then do
        ll = updateDone(l_1, x, f);
        t.left = ll;
      end else do
        t.right = updateDone(r_1, x, f);
      end end 
      return Belt_internalAVLtree.balMutate(t);
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

function updateU(t, x, f) do
  oldRoot = t.data;
  newRoot = updateDone(oldRoot, x, f);
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

function removeArrayMutateAux(_t, xs, _i, len) do
  while(true) do
    i = _i;
    t = _t;
    if (i < len) then do
      ele = xs[i];
      u = removeMutateAux(t, ele);
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
    newRoot = removeArrayMutateAux(oldRoot, xs, 0, len);
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

function fromArray(xs) do
  return do
          data: Belt_internalMapString.fromArray(xs)
        end;
end end

function cmpU(d0, d1, f) do
  return Belt_internalMapString.cmpU(d0.data, d1.data, f);
end end

function cmp(d0, d1, f) do
  return cmpU(d0, d1, Curry.__2(f));
end end

function eqU(d0, d1, f) do
  return Belt_internalMapString.eqU(d0.data, d1.data, f);
end end

function eq(d0, d1, f) do
  return eqU(d0, d1, Curry.__2(f));
end end

function get(d, x) do
  return Belt_internalMapString.get(d.data, x);
end end

function getUndefined(d, x) do
  return Belt_internalMapString.getUndefined(d.data, x);
end end

function getWithDefault(d, x, def) do
  return Belt_internalMapString.getWithDefault(d.data, x, def);
end end

function getExn(d, x) do
  return Belt_internalMapString.getExn(d.data, x);
end end

export do
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
  mapU ,
  map ,
  mapWithKeyU ,
  mapWithKey ,
  
end
--[[ No side effect ]]