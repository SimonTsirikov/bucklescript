'use strict';


function height(param) do
  if (param) do
    return param[3];
  end else do
    return 0;
  end
end

function create(l, v, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          l,
          v,
          r,
          hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, v, r) do
  var hl = height(l);
  var hr = height(r);
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[2];
      var lv = l[1];
      var ll = l[0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) do
        return create(create(ll, lv, lr[0]), lr[1], create(lr[2], v, r));
      end else do
        return --[ Empty ]--0;
      end
    end else do
      return --[ Empty ]--0;
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[2];
      var rv = r[1];
      var rl = r[0];
      if (height(rr) >= height(rl)) do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) do
        return create(create(l, v, rl[0]), rl[1], create(rl[2], rv, rr));
      end else do
        return --[ Empty ]--0;
      end
    end else do
      return --[ Empty ]--0;
    end
  end else do
    return --[ Node ]--[
            l,
            v,
            r,
            hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function compare_int(x, y) do
  if (x > y) do
    return 1;
  end else if (x == y) do
    return 0;
  end else do
    return -1;
  end
end

function add(x, t) do
  if (t) do
    var r = t[2];
    var v = t[1];
    var l = t[0];
    var c = compare_int(x, v);
    if (c == 0) do
      return t;
    end else if (c < 0) do
      return bal(add(x, l), v, r);
    end else do
      return bal(l, v, add(x, r));
    end
  end else do
    return --[ Node ]--[
            --[ Empty ]--0,
            x,
            --[ Empty ]--0,
            1
          ];
  end
end

function min_elt(_def, _param) do
  while(true) do
    var param = _param;
    var def = _def;
    if (param) do
      var l = param[0];
      if (l) do
        _param = l;
        _def = param[1];
        continue ;
      end else do
        return param[1];
      end
    end else do
      return def;
    end
  end;
end

function remove_min_elt(l, v, r) do
  if (l) do
    return bal(remove_min_elt(l[0], l[1], l[2]), v, r);
  end else do
    return r;
  end
end

function internal_merge(l, r) do
  if (l) do
    if (r) do
      var rv = r[1];
      return bal(l, min_elt(rv, r), remove_min_elt(r[0], rv, r[2]));
    end else do
      return l;
    end
  end else do
    return r;
  end
end

function remove(x, tree) do
  if (tree) do
    var r = tree[2];
    var v = tree[1];
    var l = tree[0];
    var c = compare_int(x, v);
    if (c == 0) do
      return internal_merge(l, r);
    end else if (c < 0) do
      return bal(remove(x, l), v, r);
    end else do
      return bal(l, v, remove(x, r));
    end
  end else do
    return --[ Empty ]--0;
  end
end

function mem(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = compare_int(x, param[1]);
      if (c == 0) do
        return true;
      end else do
        _param = c < 0 ? param[0] : param[2];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

var v = --[ Empty ]--0;

for(var i = 0; i <= 100000; ++i)do
  v = add(i, v);
end

for(var i$1 = 0; i$1 <= 100000; ++i$1)do
  if (!mem(i$1, v)) do
    console.log("impossible");
  end
  
end

for(var i$2 = 0; i$2 <= 100000; ++i$2)do
  v = remove(i$2, v);
end

var match = v;

if (match) do
  console.log("impossible");
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
--[  Not a pure module ]--
