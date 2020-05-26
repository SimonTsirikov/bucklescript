


function filterInPlace(p, a) do
  var i = 0;
  var j = 0;
  while(i < a.length) do
    var v = a[i];
    if (p(v)) then do
      a[j] = v;
      j = j + 1 | 0;
    end
     end 
    i = i + 1 | 0;
  end;
  a.splice(j);
  return --[ () ]--0;
end

function empty(a) do
  a.splice(0);
  return --[ () ]--0;
end

function pushBack(x, xs) do
  xs.push(x);
  return --[ () ]--0;
end

function memByRef(x, xs) do
  return xs.indexOf(x) >= 0;
end

function iter(f, xs) do
  for var i = 0 , xs.length - 1 | 0 , 1 do
    f(xs[i]);
  end
  return --[ () ]--0;
end

function iteri(f, a) do
  for var i = 0 , #a - 1 | 0 , 1 do
    f(i, a[i]);
  end
  return --[ () ]--0;
end

function toList(a) do
  var _i = #a - 1 | 0;
  var _res = --[ [] ]--0;
  while(true) do
    var res = _res;
    var i = _i;
    if (i < 0) then do
      return res;
    end else do
      _res = --[ :: ]--[
        a[i],
        res
      ];
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end

function init(n, f) do
  var v = new Array(n);
  for var i = 0 , n - 1 | 0 , 1 do
    v[i] = f(i);
  end
  return v;
end

function copy(x) do
  var len = #x;
  var b = new Array(len);
  for var i = 0 , len - 1 | 0 , 1 do
    b[i] = x[i];
  end
  return b;
end

function map(f, a) do
  var l = a.length;
  var r = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    r[i] = f(a[i]);
  end
  return r;
end

function foldLeft(f, x, a) do
  var r = x;
  for var i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i]);
  end
  return r;
end

function foldRight(f, a, x) do
  var r = x;
  for var i = #a - 1 | 0 , 0 , -1 do
    r = f(a[i], r);
  end
  return r;
end

function mapi(f, a) do
  var l = #a;
  if (l == 0) then do
    return [];
  end else do
    var r = new Array(l);
    for var i = 0 , l - 1 | 0 , 1 do
      r[i] = f(i, a[i]);
    end
    return r;
  end end 
end

function append(x, a) do
  return a.concat([x]);
end

export do
  filterInPlace ,
  empty ,
  pushBack ,
  copy ,
  memByRef ,
  iter ,
  iteri ,
  toList ,
  map ,
  mapi ,
  foldLeft ,
  foldRight ,
  init ,
  append ,
  
end
--[ No side effect ]--
