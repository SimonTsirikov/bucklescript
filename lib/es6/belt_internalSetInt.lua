

import * as Belt_SortArrayInt from "./belt_SortArrayInt.lua";
import * as Belt_internalAVLset from "./belt_internalAVLset.lua";

function has(_t, x) do
  while(true) do
    t = _t;
    if (t ~= nil) then do
      v = t.value;
      if (x == v) then do
        return true;
      end else do
        _t = x < v and t.left or t.right;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function compareAux(_e1, _e2) do
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1 and e2) then do
      h2 = e2[0];
      h1 = e1[0];
      k1 = h1.value;
      k2 = h2.value;
      if (k1 == k2) then do
        _e2 = Belt_internalAVLset.stackAllLeft(h2.right, e2[1]);
        _e1 = Belt_internalAVLset.stackAllLeft(h1.right, e1[1]);
        ::continue:: ;
      end else if (k1 < k2) then do
        return -1;
      end else do
        return 1;
      end end  end 
    end else do
      return 0;
    end end 
  end;
end end

function cmp(s1, s2) do
  len1 = Belt_internalAVLset.size(s1);
  len2 = Belt_internalAVLset.size(s2);
  if (len1 == len2) then do
    return compareAux(Belt_internalAVLset.stackAllLeft(s1, --[[ [] ]]0), Belt_internalAVLset.stackAllLeft(s2, --[[ [] ]]0));
  end else if (len1 < len2) then do
    return -1;
  end else do
    return 1;
  end end  end 
end end

function eq(s1, s2) do
  return cmp(s1, s2) == 0;
end end

function subset(_s1, _s2) do
  while(true) do
    s2 = _s2;
    s1 = _s1;
    if (s1 ~= nil) then do
      if (s2 ~= nil) then do
        l1 = s1.left;
        v1 = s1.value;
        r1 = s1.right;
        l2 = s2.left;
        v2 = s2.value;
        r2 = s2.right;
        if (v1 == v2) then do
          if (subset(l1, l2)) then do
            _s2 = r2;
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (v1 < v2) then do
          if (subset(Belt_internalAVLset.create(l1, v1, nil), l2)) then do
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (subset(Belt_internalAVLset.create(nil, v1, r1), r2)) then do
          _s1 = l1;
          ::continue:: ;
        end else do
          return false;
        end end  end  end 
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function get(_n, x) do
  while(true) do
    n = _n;
    if (n ~= nil) then do
      v = n.value;
      if (x == v) then do
        return v;
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
      v = n.value;
      if (x == v) then do
        return v;
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
      v = n.value;
      if (x == v) then do
        return v;
      end else do
        _n = x < v and n.left or n.right;
        ::continue:: ;
      end end 
    end else do
      error (new Error("getExn"))
    end end 
  end;
end end

function addMutate(t, x) do
  if (t ~= nil) then do
    k = t.value;
    if (x == k) then do
      return t;
    end else do
      l = t.left;
      r = t.right;
      if (x < k) then do
        t.left = addMutate(l, x);
      end else do
        t.right = addMutate(r, x);
      end end 
      return Belt_internalAVLset.balMutate(t);
    end end 
  end else do
    return Belt_internalAVLset.singleton(x);
  end end 
end end

function fromArray(xs) do
  len = #xs;
  if (len == 0) then do
    return nil;
  end else do
    next = Belt_SortArrayInt.strictlySortedLength(xs);
    result;
    if (next >= 0) then do
      result = Belt_internalAVLset.fromSortedArrayAux(xs, 0, next);
    end else do
      next = -next | 0;
      result = Belt_internalAVLset.fromSortedArrayRevAux(xs, next - 1 | 0, next);
    end end 
    for i = next , len - 1 | 0 , 1 do
      result = addMutate(result, xs[i]);
    end
    return result;
  end end 
end end

S = --[[ alias ]]0;

N = --[[ alias ]]0;

A = --[[ alias ]]0;

export do
  S ,
  N ,
  A ,
  has ,
  compareAux ,
  cmp ,
  eq ,
  subset ,
  get ,
  getUndefined ,
  getExn ,
  addMutate ,
  fromArray ,
  
end
--[[ No side effect ]]
