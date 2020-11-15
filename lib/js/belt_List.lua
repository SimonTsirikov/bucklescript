__console = {log = print};

Curry = require "..curry";
Belt_Array = require "..belt_Array";
Caml_option = require "..caml_option";
Belt_SortArray = require "..belt_SortArray";

function head(x) do
  if (x) then do
    return Caml_option.some(x[1]);
  end
   end 
end end

function headExn(x) do
  if (x) then do
    return x[1];
  end else do
    error(new __Error("headExn"))
  end end 
end end

function tail(x) do
  if (x) then do
    return x[2];
  end
   end 
end end

function tailExn(x) do
  if (x) then do
    return x[2];
  end else do
    error(new __Error("tailExn"))
  end end 
end end

function add(xs, x) do
  return --[[ :: ]]{
          x,
          xs
        };
end end

function get(x, n) do
  if (n < 0) then do
    return ;
  end else do
    _x = x;
    _n = n;
    while(true) do
      n_1 = _n;
      x_1 = _x;
      if (x_1) then do
        if (n_1 == 0) then do
          return Caml_option.some(x_1[1]);
        end else do
          _n = n_1 - 1 | 0;
          _x = x_1[2];
          ::continue:: ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end 
end end

function getExn(x, n) do
  if (n < 0) then do
    error(new __Error("getExn"))
  end
   end 
  _x = x;
  _n = n;
  while(true) do
    n_1 = _n;
    x_1 = _x;
    if (x_1) then do
      if (n_1 == 0) then do
        return x_1[1];
      end else do
        _n = n_1 - 1 | 0;
        _x = x_1[2];
        ::continue:: ;
      end end 
    end else do
      error(new __Error("getExn"))
    end end 
  end;
end end

function partitionAux(p, _cell, _precX, _precY) do
  while(true) do
    precY = _precY;
    precX = _precX;
    cell = _cell;
    if (cell) then do
      t = cell[2];
      h = cell[1];
      next = --[[ :: ]]{
        h,
        --[[ [] ]]0
      };
      if (p(h)) then do
        precX[1] = next;
        _precX = next;
        _cell = t;
        ::continue:: ;
      end else do
        precY[1] = next;
        _precY = next;
        _cell = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function splitAux(_cell, _precX, _precY) do
  while(true) do
    precY = _precY;
    precX = _precX;
    cell = _cell;
    if (cell) then do
      match = cell[1];
      nextA = --[[ :: ]]{
        match[1],
        --[[ [] ]]0
      };
      nextB = --[[ :: ]]{
        match[2],
        --[[ [] ]]0
      };
      precX[1] = nextA;
      precY[1] = nextB;
      _precY = nextB;
      _precX = nextA;
      _cell = cell[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxCont(_cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      next = --[[ :: ]]{
        cellX[1],
        --[[ [] ]]0
      };
      prec[1] = next;
      _prec = next;
      _cellX = cellX[2];
      ::continue:: ;
    end else do
      return prec;
    end end 
  end;
end end

function copyAuxWitFilter(f, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[2];
      h = cellX[1];
      if (f(h)) then do
        next = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        prec[1] = next;
        _prec = next;
        _cellX = t;
        ::continue:: ;
      end else do
        _cellX = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithFilterIndex(f, _cellX, _prec, _i) do
  while(true) do
    i = _i;
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[2];
      h = cellX[1];
      if (f(h, i)) then do
        next = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        prec[1] = next;
        _i = i + 1 | 0;
        _prec = next;
        _cellX = t;
        ::continue:: ;
      end else do
        _i = i + 1 | 0;
        _cellX = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWitFilterMap(f, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[2];
      match = f(cellX[1]);
      if (match ~= nil) then do
        next = --[[ :: ]]{
          Caml_option.valFromOption(match),
          --[[ [] ]]0
        };
        prec[1] = next;
        _prec = next;
        _cellX = t;
        ::continue:: ;
      end else do
        _cellX = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function removeAssocAuxWithMap(_cellX, x, _prec, f) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[2];
      h = cellX[1];
      if (f(h[1], x)) then do
        prec[1] = t;
        return true;
      end else do
        next = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        prec[1] = next;
        _prec = next;
        _cellX = t;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function setAssocAuxWithMap(_cellX, x, k, _prec, eq) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      t = cellX[2];
      h = cellX[1];
      if (eq(h[1], x)) then do
        prec[1] = --[[ :: ]]{
          --[[ tuple ]]{
            x,
            k
          },
          t
        };
        return true;
      end else do
        next = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        prec[1] = next;
        _prec = next;
        _cellX = t;
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function copyAuxWithMap(_cellX, _prec, f) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    if (cellX) then do
      next = --[[ :: ]]{
        f(cellX[1]),
        --[[ [] ]]0
      };
      prec[1] = next;
      _prec = next;
      _cellX = cellX[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function zipAux(_cellX, _cellY, _prec) do
  while(true) do
    prec = _prec;
    cellY = _cellY;
    cellX = _cellX;
    if (cellX and cellY) then do
      next = --[[ :: ]]{
        --[[ tuple ]]{
          cellX[1],
          cellY[1]
        },
        --[[ [] ]]0
      };
      prec[1] = next;
      _prec = next;
      _cellY = cellY[2];
      _cellX = cellX[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithMap2(f, _cellX, _cellY, _prec) do
  while(true) do
    prec = _prec;
    cellY = _cellY;
    cellX = _cellX;
    if (cellX and cellY) then do
      next = --[[ :: ]]{
        f(cellX[1], cellY[1]),
        --[[ [] ]]0
      };
      prec[1] = next;
      _prec = next;
      _cellY = cellY[2];
      _cellX = cellX[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function copyAuxWithMapI(f, _i, _cellX, _prec) do
  while(true) do
    prec = _prec;
    cellX = _cellX;
    i = _i;
    if (cellX) then do
      next = --[[ :: ]]{
        f(i, cellX[1]),
        --[[ [] ]]0
      };
      prec[1] = next;
      _prec = next;
      _cellX = cellX[2];
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function takeAux(_n, _cell, _prec) do
  while(true) do
    prec = _prec;
    cell = _cell;
    n = _n;
    if (n == 0) then do
      return true;
    end else if (cell) then do
      cell_1 = --[[ :: ]]{
        cell[1],
        --[[ [] ]]0
      };
      prec[1] = cell_1;
      _prec = cell_1;
      _cell = cell[2];
      _n = n - 1 | 0;
      ::continue:: ;
    end else do
      return false;
    end end  end 
  end;
end end

function splitAtAux(_n, _cell, _prec) do
  while(true) do
    prec = _prec;
    cell = _cell;
    n = _n;
    if (n == 0) then do
      return cell;
    end else if (cell) then do
      cell_1 = --[[ :: ]]{
        cell[1],
        --[[ [] ]]0
      };
      prec[1] = cell_1;
      _prec = cell_1;
      _cell = cell[2];
      _n = n - 1 | 0;
      ::continue:: ;
    end else do
      return ;
    end end  end 
  end;
end end

function take(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[[ [] ]]0;
  end else if (lst) then do
    cell = --[[ :: ]]{
      lst[1],
      --[[ [] ]]0
    };
    has = takeAux(n - 1 | 0, lst[2], cell);
    if (has) then do
      return cell;
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end end

function drop(lst, n) do
  if (n < 0) then do
    return ;
  end else do
    _l = lst;
    _n = n;
    while(true) do
      n_1 = _n;
      l = _l;
      if (n_1 == 0) then do
        return l;
      end else if (l) then do
        _n = n_1 - 1 | 0;
        _l = l[2];
        ::continue:: ;
      end else do
        return ;
      end end  end 
    end;
  end end 
end end

function splitAt(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[[ tuple ]]{
            --[[ [] ]]0,
            lst
          };
  end else if (lst) then do
    cell = --[[ :: ]]{
      lst[1],
      --[[ [] ]]0
    };
    rest = splitAtAux(n - 1 | 0, lst[2], cell);
    if (rest ~= nil) then do
      return --[[ tuple ]]{
              cell,
              rest
            };
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end end

function concat(xs, ys) do
  if (xs) then do
    cell = --[[ :: ]]{
      xs[1],
      --[[ [] ]]0
    };
    copyAuxCont(xs[2], cell)[1] = ys;
    return cell;
  end else do
    return ys;
  end end 
end end

function mapU(xs, f) do
  if (xs) then do
    cell = --[[ :: ]]{
      f(xs[1]),
      --[[ [] ]]0
    };
    copyAuxWithMap(xs[2], cell, f);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function map(xs, f) do
  return mapU(xs, Curry.__1(f));
end end

function zipByU(l1, l2, f) do
  if (l1 and l2) then do
    cell = --[[ :: ]]{
      f(l1[1], l2[1]),
      --[[ [] ]]0
    };
    copyAuxWithMap2(f, l1[2], l2[2], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function zipBy(l1, l2, f) do
  return zipByU(l1, l2, Curry.__2(f));
end end

function mapWithIndexU(xs, f) do
  if (xs) then do
    cell = --[[ :: ]]{
      f(0, xs[1]),
      --[[ [] ]]0
    };
    copyAuxWithMapI(f, 1, xs[2], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function mapWithIndex(xs, f) do
  return mapWithIndexU(xs, Curry.__2(f));
end end

function makeByU(n, f) do
  if (n <= 0) then do
    return --[[ [] ]]0;
  end else do
    headX = --[[ :: ]]{
      f(0),
      --[[ [] ]]0
    };
    cur = headX;
    i = 1;
    while(i < n) do
      v = --[[ :: ]]{
        f(i),
        --[[ [] ]]0
      };
      cur[1] = v;
      cur = v;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end end

function makeBy(n, f) do
  return makeByU(n, Curry.__1(f));
end end

function make(n, v) do
  if (n <= 0) then do
    return --[[ [] ]]0;
  end else do
    headX = --[[ :: ]]{
      v,
      --[[ [] ]]0
    };
    cur = headX;
    i = 1;
    while(i < n) do
      v_1 = --[[ :: ]]{
        v,
        --[[ [] ]]0
      };
      cur[1] = v_1;
      cur = v_1;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end end

function length(xs) do
  _x = xs;
  _acc = 0;
  while(true) do
    acc = _acc;
    x = _x;
    if (x) then do
      _acc = acc + 1 | 0;
      _x = x[2];
      ::continue:: ;
    end else do
      return acc;
    end end 
  end;
end end

function fillAux(arr, _i, _x) do
  while(true) do
    x = _x;
    i = _i;
    if (x) then do
      arr[i] = x[1];
      _x = x[2];
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fromArray(a) do
  a_1 = a;
  _i = #a - 1 | 0;
  _res = --[[ [] ]]0;
  while(true) do
    res = _res;
    i = _i;
    if (i < 0) then do
      return res;
    end else do
      _res = --[[ :: ]]{
        a_1[i],
        res
      };
      _i = i - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function toArray(x) do
  len = length(x);
  arr = new __Array(len);
  fillAux(arr, 0, x);
  return arr;
end end

function shuffle(xs) do
  v = toArray(xs);
  Belt_Array.shuffleInPlace(v);
  return fromArray(v);
end end

function reverseConcat(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      _l2 = --[[ :: ]]{
        l1[1],
        l2
      };
      _l1 = l1[2];
      ::continue:: ;
    end else do
      return l2;
    end end 
  end;
end end

function reverse(l) do
  return reverseConcat(l, --[[ [] ]]0);
end end

function flattenAux(_prec, _xs) do
  while(true) do
    xs = _xs;
    prec = _prec;
    if (xs) then do
      _xs = xs[2];
      _prec = copyAuxCont(xs[1], prec);
      ::continue:: ;
    end else do
      prec[1] = --[[ [] ]]0;
      return --[[ () ]]0;
    end end 
  end;
end end

function flatten(_xs) do
  while(true) do
    xs = _xs;
    if (xs) then do
      match = xs[1];
      if (match) then do
        cell = --[[ :: ]]{
          match[1],
          --[[ [] ]]0
        };
        flattenAux(copyAuxCont(match[2], cell), xs[2]);
        return cell;
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function concatMany(xs) do
  len = #xs;
  if (len ~= 1) then do
    if (len ~= 0) then do
      len_1 = #xs;
      v = xs[len_1 - 1 | 0];
      for i = len_1 - 2 | 0 , 0 , -1 do
        v = concat(xs[i], v);
      end
      return v;
    end else do
      return --[[ [] ]]0;
    end end 
  end else do
    return xs[0];
  end end 
end end

function mapReverseU(l, f) do
  f_1 = f;
  _accu = --[[ [] ]]0;
  _xs = l;
  while(true) do
    xs = _xs;
    accu = _accu;
    if (xs) then do
      _xs = xs[2];
      _accu = --[[ :: ]]{
        f_1(xs[1]),
        accu
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function mapReverse(l, f) do
  return mapReverseU(l, Curry.__1(f));
end end

function forEachU(_xs, f) do
  while(true) do
    xs = _xs;
    if (xs) then do
      f(xs[1]);
      _xs = xs[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach(xs, f) do
  return forEachU(xs, Curry.__1(f));
end end

function forEachWithIndexU(l, f) do
  _xs = l;
  _i = 0;
  f_1 = f;
  while(true) do
    i = _i;
    xs = _xs;
    if (xs) then do
      f_1(i, xs[1]);
      _i = i + 1 | 0;
      _xs = xs[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEachWithIndex(l, f) do
  return forEachWithIndexU(l, Curry.__2(f));
end end

function reduceU(_l, _accu, f) do
  while(true) do
    accu = _accu;
    l = _l;
    if (l) then do
      _accu = f(accu, l[1]);
      _l = l[2];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce(l, accu, f) do
  return reduceU(l, accu, Curry.__2(f));
end end

function reduceReverseUnsafeU(l, accu, f) do
  if (l) then do
    return f(reduceReverseUnsafeU(l[2], accu, f), l[1]);
  end else do
    return accu;
  end end 
end end

function reduceReverseU(l, acc, f) do
  len = length(l);
  if (len < 1000) then do
    return reduceReverseUnsafeU(l, acc, f);
  end else do
    return Belt_Array.reduceReverseU(toArray(l), acc, f);
  end end 
end end

function reduceReverse(l, accu, f) do
  return reduceReverseU(l, accu, Curry.__2(f));
end end

function reduceWithIndexU(l, acc, f) do
  _l = l;
  _acc = acc;
  f_1 = f;
  _i = 0;
  while(true) do
    i = _i;
    acc_1 = _acc;
    l_1 = _l;
    if (l_1) then do
      _i = i + 1 | 0;
      _acc = f_1(acc_1, l_1[1], i);
      _l = l_1[2];
      ::continue:: ;
    end else do
      return acc_1;
    end end 
  end;
end end

function reduceWithIndex(l, acc, f) do
  return reduceWithIndexU(l, acc, Curry.__3(f));
end end

function mapReverse2U(l1, l2, f) do
  _l1 = l1;
  _l2 = l2;
  _accu = --[[ [] ]]0;
  f_1 = f;
  while(true) do
    accu = _accu;
    l2_1 = _l2;
    l1_1 = _l1;
    if (l1_1 and l2_1) then do
      _accu = --[[ :: ]]{
        f_1(l1_1[1], l2_1[1]),
        accu
      };
      _l2 = l2_1[2];
      _l1 = l1_1[2];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function mapReverse2(l1, l2, f) do
  return mapReverse2U(l1, l2, Curry.__2(f));
end end

function forEach2U(_l1, _l2, f) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      f(l1[1], l2[1]);
      _l2 = l2[2];
      _l1 = l1[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function forEach2(l1, l2, f) do
  return forEach2U(l1, l2, Curry.__2(f));
end end

function reduce2U(_l1, _l2, _accu, f) do
  while(true) do
    accu = _accu;
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      _accu = f(accu, l1[1], l2[1]);
      _l2 = l2[2];
      _l1 = l1[2];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function reduce2(l1, l2, acc, f) do
  return reduce2U(l1, l2, acc, Curry.__3(f));
end end

function reduceReverse2UnsafeU(l1, l2, accu, f) do
  if (l1 and l2) then do
    return f(reduceReverse2UnsafeU(l1[2], l2[2], accu, f), l1[1], l2[1]);
  end else do
    return accu;
  end end 
end end

function reduceReverse2U(l1, l2, acc, f) do
  len = length(l1);
  if (len < 1000) then do
    return reduceReverse2UnsafeU(l1, l2, acc, f);
  end else do
    return Belt_Array.reduceReverse2U(toArray(l1), toArray(l2), acc, f);
  end end 
end end

function reduceReverse2(l1, l2, acc, f) do
  return reduceReverse2U(l1, l2, acc, Curry.__3(f));
end end

function everyU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (p(xs[1])) then do
        _xs = xs[2];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every(xs, p) do
  return everyU(xs, Curry.__1(p));
end end

function someU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (p(xs[1])) then do
        return true;
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some(xs, p) do
  return someU(xs, Curry.__1(p));
end end

function every2U(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[1], l2[1])) then do
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function every2(l1, l2, p) do
  return every2U(l1, l2, Curry.__2(p));
end end

function cmpByLength(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function cmpU(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        c = p(l1[1], l2[1]);
        if (c == 0) then do
          _l2 = l2[2];
          _l1 = l1[2];
          ::continue:: ;
        end else do
          return c;
        end end 
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function cmp(l1, l2, f) do
  return cmpU(l1, l2, Curry.__2(f));
end end

function eqU(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2 and p(l1[1], l2[1])) then do
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function eq(l1, l2, f) do
  return eqU(l1, l2, Curry.__2(f));
end end

function some2U(_l1, _l2, p) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[1], l2[1])) then do
        return true;
      end else do
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function some2(l1, l2, p) do
  return some2U(l1, l2, Curry.__2(p));
end end

function hasU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (eq(xs[1], x)) then do
        return true;
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function has(xs, x, eq) do
  return hasU(xs, x, Curry.__2(eq));
end end

function getAssocU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      match = xs[1];
      if (eq(match[1], x)) then do
        return Caml_option.some(match[2]);
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getAssoc(xs, x, eq) do
  return getAssocU(xs, x, Curry.__2(eq));
end end

function hasAssocU(_xs, x, eq) do
  while(true) do
    xs = _xs;
    if (xs) then do
      if (eq(xs[1][1], x)) then do
        return true;
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function hasAssoc(xs, x, eq) do
  return hasAssocU(xs, x, Curry.__2(eq));
end end

function removeAssocU(xs, x, eq) do
  if (xs) then do
    l = xs[2];
    pair = xs[1];
    if (eq(pair[1], x)) then do
      return l;
    end else do
      cell = --[[ :: ]]{
        pair,
        --[[ [] ]]0
      };
      removed = removeAssocAuxWithMap(l, x, cell, eq);
      if (removed) then do
        return cell;
      end else do
        return xs;
      end end 
    end end 
  end else do
    return --[[ [] ]]0;
  end end 
end end

function removeAssoc(xs, x, eq) do
  return removeAssocU(xs, x, Curry.__2(eq));
end end

function setAssocU(xs, x, k, eq) do
  if (xs) then do
    l = xs[2];
    pair = xs[1];
    if (eq(pair[1], x)) then do
      return --[[ :: ]]{
              --[[ tuple ]]{
                x,
                k
              },
              l
            };
    end else do
      cell = --[[ :: ]]{
        pair,
        --[[ [] ]]0
      };
      replaced = setAssocAuxWithMap(l, x, k, cell, eq);
      if (replaced) then do
        return cell;
      end else do
        return --[[ :: ]]{
                --[[ tuple ]]{
                  x,
                  k
                },
                xs
              };
      end end 
    end end 
  end else do
    return --[[ :: ]]{
            --[[ tuple ]]{
              x,
              k
            },
            --[[ [] ]]0
          };
  end end 
end end

function setAssoc(xs, x, k, eq) do
  return setAssocU(xs, x, k, Curry.__2(eq));
end end

function sortU(xs, cmp) do
  arr = toArray(xs);
  Belt_SortArray.stableSortInPlaceByU(arr, cmp);
  return fromArray(arr);
end end

function sort(xs, cmp) do
  return sortU(xs, Curry.__2(cmp));
end end

function getByU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      x = xs[1];
      if (p(x)) then do
        return Caml_option.some(x);
      end else do
        _xs = xs[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function getBy(xs, p) do
  return getByU(xs, Curry.__1(p));
end end

function keepU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      t = xs[2];
      h = xs[1];
      if (p(h)) then do
        cell = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        copyAuxWitFilter(p, t, cell);
        return cell;
      end else do
        _xs = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keep(xs, p) do
  return keepU(xs, Curry.__1(p));
end end

function keepWithIndexU(xs, p) do
  _xs = xs;
  p_1 = p;
  _i = 0;
  while(true) do
    i = _i;
    xs_1 = _xs;
    if (xs_1) then do
      t = xs_1[2];
      h = xs_1[1];
      if (p_1(h, i)) then do
        cell = --[[ :: ]]{
          h,
          --[[ [] ]]0
        };
        copyAuxWithFilterIndex(p_1, t, cell, i + 1 | 0);
        return cell;
      end else do
        _i = i + 1 | 0;
        _xs = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keepWithIndex(xs, p) do
  return keepWithIndexU(xs, Curry.__2(p));
end end

function keepMapU(_xs, p) do
  while(true) do
    xs = _xs;
    if (xs) then do
      t = xs[2];
      match = p(xs[1]);
      if (match ~= nil) then do
        cell = --[[ :: ]]{
          Caml_option.valFromOption(match),
          --[[ [] ]]0
        };
        copyAuxWitFilterMap(p, t, cell);
        return cell;
      end else do
        _xs = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function keepMap(xs, p) do
  return keepMapU(xs, Curry.__1(p));
end end

function partitionU(l, p) do
  if (l) then do
    h = l[1];
    nextX = --[[ :: ]]{
      h,
      --[[ [] ]]0
    };
    nextY = --[[ :: ]]{
      h,
      --[[ [] ]]0
    };
    b = p(h);
    partitionAux(p, l[2], nextX, nextY);
    if (b) then do
      return --[[ tuple ]]{
              nextX,
              nextY[2]
            };
    end else do
      return --[[ tuple ]]{
              nextX[2],
              nextY
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ [] ]]0,
            --[[ [] ]]0
          };
  end end 
end end

function partition(l, p) do
  return partitionU(l, Curry.__1(p));
end end

function unzip(xs) do
  if (xs) then do
    match = xs[1];
    cellX = --[[ :: ]]{
      match[1],
      --[[ [] ]]0
    };
    cellY = --[[ :: ]]{
      match[2],
      --[[ [] ]]0
    };
    splitAux(xs[2], cellX, cellY);
    return --[[ tuple ]]{
            cellX,
            cellY
          };
  end else do
    return --[[ tuple ]]{
            --[[ [] ]]0,
            --[[ [] ]]0
          };
  end end 
end end

function zip(l1, l2) do
  if (l1 and l2) then do
    cell = --[[ :: ]]{
      --[[ tuple ]]{
        l1[1],
        l2[1]
      },
      --[[ [] ]]0
    };
    zipAux(l1[2], l2[2], cell);
    return cell;
  end else do
    return --[[ [] ]]0;
  end end 
end end

size = length;

filter = keep;

filterWithIndex = keepWithIndex;

exports = {};
exports.length = length;
exports.size = size;
exports.head = head;
exports.headExn = headExn;
exports.tail = tail;
exports.tailExn = tailExn;
exports.add = add;
exports.get = get;
exports.getExn = getExn;
exports.make = make;
exports.makeByU = makeByU;
exports.makeBy = makeBy;
exports.shuffle = shuffle;
exports.drop = drop;
exports.take = take;
exports.splitAt = splitAt;
exports.concat = concat;
exports.concatMany = concatMany;
exports.reverseConcat = reverseConcat;
exports.flatten = flatten;
exports.mapU = mapU;
exports.map = map;
exports.zip = zip;
exports.zipByU = zipByU;
exports.zipBy = zipBy;
exports.mapWithIndexU = mapWithIndexU;
exports.mapWithIndex = mapWithIndex;
exports.fromArray = fromArray;
exports.toArray = toArray;
exports.reverse = reverse;
exports.mapReverseU = mapReverseU;
exports.mapReverse = mapReverse;
exports.forEachU = forEachU;
exports.forEach = forEach;
exports.forEachWithIndexU = forEachWithIndexU;
exports.forEachWithIndex = forEachWithIndex;
exports.reduceU = reduceU;
exports.reduce = reduce;
exports.reduceWithIndexU = reduceWithIndexU;
exports.reduceWithIndex = reduceWithIndex;
exports.reduceReverseU = reduceReverseU;
exports.reduceReverse = reduceReverse;
exports.mapReverse2U = mapReverse2U;
exports.mapReverse2 = mapReverse2;
exports.forEach2U = forEach2U;
exports.forEach2 = forEach2;
exports.reduce2U = reduce2U;
exports.reduce2 = reduce2;
exports.reduceReverse2U = reduceReverse2U;
exports.reduceReverse2 = reduceReverse2;
exports.everyU = everyU;
exports.every = every;
exports.someU = someU;
exports.some = some;
exports.every2U = every2U;
exports.every2 = every2;
exports.some2U = some2U;
exports.some2 = some2;
exports.cmpByLength = cmpByLength;
exports.cmpU = cmpU;
exports.cmp = cmp;
exports.eqU = eqU;
exports.eq = eq;
exports.hasU = hasU;
exports.has = has;
exports.getByU = getByU;
exports.getBy = getBy;
exports.keepU = keepU;
exports.keep = keep;
exports.filter = filter;
exports.keepWithIndexU = keepWithIndexU;
exports.keepWithIndex = keepWithIndex;
exports.filterWithIndex = filterWithIndex;
exports.keepMapU = keepMapU;
exports.keepMap = keepMap;
exports.partitionU = partitionU;
exports.partition = partition;
exports.unzip = unzip;
exports.getAssocU = getAssocU;
exports.getAssoc = getAssoc;
exports.hasAssocU = hasAssocU;
exports.hasAssoc = hasAssoc;
exports.removeAssocU = removeAssocU;
exports.removeAssoc = removeAssoc;
exports.setAssocU = setAssocU;
exports.setAssoc = setAssoc;
exports.sortU = sortU;
exports.sort = sort;
return exports;
--[[ No side effect ]]
