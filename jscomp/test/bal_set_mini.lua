--[['use strict';]]


function height(param) do
  if (param) then do
    return param[3];
  end else do
    return 0;
  end end 
end end

function create(l, v, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]][
          l,
          v,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end end

function bal(l, v, r) do
  hl = height(l);
  hr = height(r);
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[2];
      lv = l[1];
      ll = l[0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) then do
        return create(create(ll, lv, lr[0]), lr[1], create(lr[2], v, r));
      end else do
        return --[[ Empty ]]0;
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[2];
      rv = r[1];
      rl = r[0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) then do
        return create(create(l, v, rl[0]), rl[1], create(rl[2], rv, rr));
      end else do
        return --[[ Empty ]]0;
      end end  end 
    end else do
      return --[[ Empty ]]0;
    end end 
  end else do
    return --[[ Node ]][
            l,
            v,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end end

function compare_int(x, y) do
  if (x > y) then do
    return 1;
  end else if (x == y) then do
    return 0;
  end else do
    return -1;
  end end  end 
end end

function add(x, t) do
  if (t) then do
    r = t[2];
    v = t[1];
    l = t[0];
    c = compare_int(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      return bal(add(x, l), v, r);
    end else do
      return bal(l, v, add(x, r));
    end end  end 
  end else do
    return --[[ Node ]][
            --[[ Empty ]]0,
            x,
            --[[ Empty ]]0,
            1
          ];
  end end 
end end

function min_elt(_def, _param) do
  while(true) do
    param = _param;
    def = _def;
    if (param) then do
      l = param[0];
      if (l) then do
        _param = l;
        _def = param[1];
        continue ;
      end else do
        return param[1];
      end end 
    end else do
      return def;
    end end 
  end;
end end

function remove_min_elt(l, v, r) do
  if (l) then do
    return bal(remove_min_elt(l[0], l[1], l[2]), v, r);
  end else do
    return r;
  end end 
end end

function internal_merge(l, r) do
  if (l) then do
    if (r) then do
      rv = r[1];
      return bal(l, min_elt(rv, r), remove_min_elt(r[0], rv, r[2]));
    end else do
      return l;
    end end 
  end else do
    return r;
  end end 
end end

function remove(x, tree) do
  if (tree) then do
    r = tree[2];
    v = tree[1];
    l = tree[0];
    c = compare_int(x, v);
    if (c == 0) then do
      return internal_merge(l, r);
    end else if (c < 0) then do
      return bal(remove(x, l), v, r);
    end else do
      return bal(l, v, remove(x, r));
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = compare_int(x, param[1]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[0] or param[2];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

v = --[[ Empty ]]0;

for i = 0 , 100000 , 1 do
  v = add(i, v);
end

for i$1 = 0 , 100000 , 1 do
  if (not mem(i$1, v)) then do
    console.log("impossible");
  end
   end 
end

for i$2 = 0 , 100000 , 1 do
  v = remove(i$2, v);
end

match = v;

if (match) then do
  console.log("impossible");
end
 end 

exports.height = height;
exports.create = create;
exports.bal = bal;
exports.compare_int = compare_int;
exports.add = add;
exports.min_elt = min_elt;
exports.remove_min_elt = remove_min_elt;
exports.internal_merge = internal_merge;
exports.remove = remove;
exports.mem = mem;
--[[  Not a pure module ]]
