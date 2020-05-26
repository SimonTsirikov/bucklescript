


function filterInPlace(p, a) do
  i = 0;
  j = 0;
  while(i < a.length) do
    v = a[i];
    if (p(v)) then do
      a[j] = v;
      j = j + 1 | 0;
    end
     end 
    i = i + 1 | 0;
  end;
  a.splice(j);
  return --[ () ]--0;
end end

function empty(a) do
  a.splice(0);
  return --[ () ]--0;
end end

function pushBack(x, xs) do
  xs.push(x);
  return --[ () ]--0;
end end

function memByRef(x, xs) do
  return xs.indexOf(x) >= 0;
end end

function iter(f, xs) do
  for i = 0 , xs.length - 1 | 0 , 1 do
    f(xs[i]);
  end
  return --[ () ]--0;
end end

function iteri(f, a) do
  for i = 0 , #a - 1 | 0 , 1 do
    f(i, a[i]);
  end
  return --[ () ]--0;
end end

function toList(a) do
  _i = #a - 1 | 0;
  _res = --[ [] ]--0;
  while(true) do
    res = _res;
    i = _i;
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
end end

function init(n, f) do
  v = new Array(n);
  for i = 0 , n - 1 | 0 , 1 do
    v[i] = f(i);
  end
  return v;
end end

function copy(x) do
  len = #x;
  b = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    b[i] = x[i];
  end
  return b;
end end

function map(f, a) do
  l = a.length;
  r = new Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    r[i] = f(a[i]);
  end
  return r;
end end

function foldLeft(f, x, a) do
  r = x;
  for i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i]);
  end
  return r;
end end

function foldRight(f, a, x) do
  r = x;
  for i = #a - 1 | 0 , 0 , -1 do
    r = f(a[i], r);
  end
  return r;
end end

function mapi(f, a) do
  l = #a;
  if (l == 0) then do
    return [];
  end else do
    r = new Array(l);
    for i = 0 , l - 1 | 0 , 1 do
      r[i] = f(i, a[i]);
    end
    return r;
  end end 
end end

function append(x, a) do
  return a.concat([x]);
end end

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
