

import * as Curry from "./curry.lua";
import * as Caml_option from "./caml_option.lua";
import * as Belt_SortArray from "./belt_SortArray.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Belt_internalAVLtree from "./belt_internalAVLtree.lua";

function add(t, x, data) do
  if (t ~= nil) then do
    k = t.key;
    if (x == k) then do
      return Belt_internalAVLtree.updateValue(t, data);
    end else do
      v = t.value;
      if (x < k) then do
        return Belt_internalAVLtree.bal(add(t.left, x, data), k, v, t.right);
      end else do
        return Belt_internalAVLtree.bal(t.left, k, v, add(t.right, x, data));
      end end 
    end end 
  end else do
    return Belt_internalAVLtree.singleton(x, data);
  end end 
end end

function get(_n, x) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.key;
      if (x == v) then do
        return Caml_option.some(n.value);
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getUndefined(_n, x) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getExn(_n, x) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      error (new Error("getExn"))
    end end 
  end;
end end

function getWithDefault(_n, x, def) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.key;
      if (x == v) then do
        return n.value;
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return def;
    end end 
  end;
end end

function has(_n, x) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.key;
      if (x == v) then do
        return true;
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function remove(n, x) do
  if (n ~= nil) then do
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
      return Belt_internalAVLtree.bal(remove(l, x), v, n.value, r);
    end else do
      return Belt_internalAVLtree.bal(l, v, n.value, remove(r, x));
    end end  end 
  end else do
    return n;
  end end 
end end

function splitAux(x, n) do
  l = n.left;
  v = n.key;
  d = n.value;
  r = n.right;
  if (x == v) then do
    return --[[ tuple ]]{
            l,
            Caml_option.some(d),
            r
          };
  end else if (x < v) then do
    if (l ~= nil) then do
      match = splitAux(x, l);
      return --[[ tuple ]]{
              match[0],
              match[1],
              Belt_internalAVLtree.join(match[2], v, d, r)
            };
    end else do
      return --[[ tuple ]]{
              nil,
              undefined,
              n
            };
    end end 
  end else if (r ~= nil) then do
    match$1 = splitAux(x, r);
    return --[[ tuple ]]{
            Belt_internalAVLtree.join(l, v, d, match$1[0]),
            match$1[1],
            match$1[2]
          };
  end else do
    return --[[ tuple ]]{
            n,
            undefined,
            nil
          };
  end end  end  end 
end end

function split(x, n) do
  if (n ~= nil) then do
    return splitAux(x, n);
  end else do
    return --[[ tuple ]]{
            nil,
            undefined,
            nil
          };
  end end 
end end

function mergeU(s1, s2, f) do
  if (s1 ~= nil) then do
    if (s1.height >= (
        s2 ~= nil and s2.height or 0
      )) then do
      l1 = s1.left;
      v1 = s1.key;
      d1 = s1.value;
      r1 = s1.right;
      match = split(v1, s2);
      return Belt_internalAVLtree.concatOrJoin(mergeU(l1, match[0], f), v1, f(v1, Caml_option.some(d1), match[1]), mergeU(r1, match[2], f));
    end
     end 
  end else if (s2 == nil) then do
    return nil;
  end
   end  end 
  if (s2 ~= nil) then do
    l2 = s2.left;
    v2 = s2.key;
    d2 = s2.value;
    r2 = s2.right;
    match$1 = split(v2, s1);
    return Belt_internalAVLtree.concatOrJoin(mergeU(match$1[0], l2, f), v2, f(v2, match$1[1], Caml_option.some(d2)), mergeU(match$1[2], r2, f));
  end else do
    return --[[ assert false ]]0;
  end end 
end end

function merge(s1, s2, f) do
  return mergeU(s1, s2, Curry.__3(f));
end end

function compareAux(_e1, _e2, vcmp) do
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1 and e2) then do
      h2 = e2[0];
      h1 = e1[0];
      c = Caml_primitive.caml_int_compare(h1.key, h2.key);
      if (c == 0) then do
        cx = vcmp(h1.value, h2.value);
        if (cx == 0) then do
          _e2 = Belt_internalAVLtree.stackAllLeft(h2.right, e2[1]);
          _e1 = Belt_internalAVLtree.stackAllLeft(h1.right, e1[1]);
          ::continue:: ;
        end else do
          return cx;
        end end 
      end else do
        return c;
      end end 
    end else do
      return 0;
    end end 
  end;
end end

function cmpU(s1, s2, cmp) do
  len1 = Belt_internalAVLtree.size(s1);
  len2 = Belt_internalAVLtree.size(s2);
  if (len1 == len2) then do
    return compareAux(Belt_internalAVLtree.stackAllLeft(s1, --[[ [] ]]0), Belt_internalAVLtree.stackAllLeft(s2, --[[ [] ]]0), cmp);
  end else if (len1 < len2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end end

function cmp(s1, s2, f) do
  return cmpU(s1, s2, Curry.__2(f));
end end

function eqAux(_e1, _e2, eq) do
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1 and e2) then do
      h2 = e2[0];
      h1 = e1[0];
      if (h1.key == h2.key and eq(h1.value, h2.value)) then do
        _e2 = Belt_internalAVLtree.stackAllLeft(h2.right, e2[1]);
        _e1 = Belt_internalAVLtree.stackAllLeft(h1.right, e1[1]);
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function eqU(s1, s2, eq) do
  len1 = Belt_internalAVLtree.size(s1);
  len2 = Belt_internalAVLtree.size(s2);
  if (len1 == len2) then do
    return eqAux(Belt_internalAVLtree.stackAllLeft(s1, --[[ [] ]]0), Belt_internalAVLtree.stackAllLeft(s2, --[[ [] ]]0), eq);
  end else do
    return false;
  end end 
end end

function eq(s1, s2, f) do
  return eqU(s1, s2, Curry.__2(f));
end end

function addMutate(t, x, data) do
  if (t ~= nil) then do
    k = t.key;
    if (x == k) then do
      t.key = x;
      t.value = data;
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (x < k) then do
        ll = addMutate(l, x, data);
        t.left = ll;
      end else do
        t.right = addMutate(r, x, data);
      end end 
      return Belt_internalAVLtree.balMutate(t);
    end end 
  end else do
    return Belt_internalAVLtree.singleton(x, data);
  end end 
end end

function fromArray(xs) do
  len = #xs;
  if (len == 0) then do
    return nil;
  end else do
    next = Belt_SortArray.strictlySortedLengthU(xs, (function (param, param$1) do
            return param[0] < param$1[0];
          end end));
    result;
    if (next >= 0) then do
      result = Belt_internalAVLtree.fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = Belt_internalAVLtree.fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for i = next , len - 1 | 0 , 1 do
      match = xs[i];
      result = addMutate(result, match[0], match[1]);
    end
    return result;
  end end 
end end

N = --[[ alias ]]0;

A = --[[ alias ]]0;

S = --[[ alias ]]0;

export do
  N ,
  A ,
  S ,
  add ,
  get ,
  getUndefined ,
  getExn ,
  getWithDefault ,
  has ,
  remove ,
  splitAux ,
  split ,
  mergeU ,
  merge ,
  compareAux ,
  cmpU ,
  cmp ,
  eqAux ,
  eqU ,
  eq ,
  addMutate ,
  fromArray ,
  
end
--[[ No side effect ]]
