'use strict';

var Curry = require("./curry.js");
var Belt_Array = require("./belt_Array.js");
var Caml_option = require("./caml_option.js");
var Belt_SortArray = require("./belt_SortArray.js");

function head(x) do
  if (x) then do
    return Caml_option.some(x[0]);
  end
   end 
end

function headExn(x) do
  if (x) then do
    return x[0];
  end else do
    throw new Error("headExn");
  end end 
end

function tail(x) do
  if (x) then do
    return x[1];
  end
   end 
end

function tailExn(x) do
  if (x) then do
    return x[1];
  end else do
    throw new Error("tailExn");
  end end 
end

function add(xs, x) do
  return --[ :: ]--[
          x,
          xs
        ];
end

function get(x, n) do
  if (n < 0) then do
    return ;
  end else do
    var _x = x;
    var _n = n;
    while(true) do
      var n$1 = _n;
      var x$1 = _x;
      if (x$1) then do
        if (n$1 == 0) then do
          return Caml_option.some(x$1[0]);
        end else do
          _n = n$1 - 1 | 0;
          _x = x$1[1];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end 
end

function getExn(x, n) do
  if (n < 0) then do
    throw new Error("getExn");
  end
   end 
  var _x = x;
  var _n = n;
  while(true) do
    var n$1 = _n;
    var x$1 = _x;
    if (x$1) then do
      if (n$1 == 0) then do
        return x$1[0];
      end else do
        _n = n$1 - 1 | 0;
        _x = x$1[1];
        continue ;
      end end 
    end else do
      throw new Error("getExn");
    end end 
  end;
end

function partitionAux(p, _cell, _precX, _precY) do
  while(true) do
    var precY = _precY;
    var precX = _precX;
    var cell = _cell;
    if (cell) then do
      var t = cell[1];
      var h = cell[0];
      var next = --[ :: ]--[
        h,
        --[ [] ]--0
      ];
      if (p(h)) then do
        precX[1] = next;
        _precX = next;
        _cell = t;
        continue ;
      end else do
        precY[1] = next;
        _precY = next;
        _cell = t;
        continue ;
      end end 
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function splitAux(_cell, _precX, _precY) do
  while(true) do
    var precY = _precY;
    var precX = _precX;
    var cell = _cell;
    if (cell) then do
      var match = cell[0];
      var nextA = --[ :: ]--[
        match[0],
        --[ [] ]--0
      ];
      var nextB = --[ :: ]--[
        match[1],
        --[ [] ]--0
      ];
      precX[1] = nextA;
      precY[1] = nextB;
      _precY = nextB;
      _precX = nextA;
      _cell = cell[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyAuxCont(_cellX, _prec) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var next = --[ :: ]--[
        cellX[0],
        --[ [] ]--0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      continue ;
    end else do
      return prec;
    end end 
  end;
end

function copyAuxWitFilter(f, _cellX, _prec) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var t = cellX[1];
      var h = cellX[0];
      if (f(h)) then do
        var next = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyAuxWithFilterIndex(f, _cellX, _prec, _i) do
  while(true) do
    var i = _i;
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var t = cellX[1];
      var h = cellX[0];
      if (f(h, i)) then do
        var next = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        prec[1] = next;
        _i = i + 1 | 0;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _i = i + 1 | 0;
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyAuxWitFilterMap(f, _cellX, _prec) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var t = cellX[1];
      var match = f(cellX[0]);
      if (match ~= undefined) then do
        var next = --[ :: ]--[
          Caml_option.valFromOption(match),
          --[ [] ]--0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end else do
        _cellX = t;
        continue ;
      end end 
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function removeAssocAuxWithMap(_cellX, x, _prec, f) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var t = cellX[1];
      var h = cellX[0];
      if (f(h[0], x)) then do
        prec[1] = t;
        return true;
      end else do
        var next = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function setAssocAuxWithMap(_cellX, x, k, _prec, eq) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var t = cellX[1];
      var h = cellX[0];
      if (eq(h[0], x)) then do
        prec[1] = --[ :: ]--[
          --[ tuple ]--[
            x,
            k
          ],
          t
        ];
        return true;
      end else do
        var next = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        prec[1] = next;
        _prec = next;
        _cellX = t;
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function copyAuxWithMap(_cellX, _prec, f) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    if (cellX) then do
      var next = --[ :: ]--[
        f(cellX[0]),
        --[ [] ]--0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function zipAux(_cellX, _cellY, _prec) do
  while(true) do
    var prec = _prec;
    var cellY = _cellY;
    var cellX = _cellX;
    if (cellX and cellY) then do
      var next = --[ :: ]--[
        --[ tuple ]--[
          cellX[0],
          cellY[0]
        ],
        --[ [] ]--0
      ];
      prec[1] = next;
      _prec = next;
      _cellY = cellY[1];
      _cellX = cellX[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyAuxWithMap2(f, _cellX, _cellY, _prec) do
  while(true) do
    var prec = _prec;
    var cellY = _cellY;
    var cellX = _cellX;
    if (cellX and cellY) then do
      var next = --[ :: ]--[
        f(cellX[0], cellY[0]),
        --[ [] ]--0
      ];
      prec[1] = next;
      _prec = next;
      _cellY = cellY[1];
      _cellX = cellX[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function copyAuxWithMapI(f, _i, _cellX, _prec) do
  while(true) do
    var prec = _prec;
    var cellX = _cellX;
    var i = _i;
    if (cellX) then do
      var next = --[ :: ]--[
        f(i, cellX[0]),
        --[ [] ]--0
      ];
      prec[1] = next;
      _prec = next;
      _cellX = cellX[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function takeAux(_n, _cell, _prec) do
  while(true) do
    var prec = _prec;
    var cell = _cell;
    var n = _n;
    if (n == 0) then do
      return true;
    end else if (cell) then do
      var cell$1 = --[ :: ]--[
        cell[0],
        --[ [] ]--0
      ];
      prec[1] = cell$1;
      _prec = cell$1;
      _cell = cell[1];
      _n = n - 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end

function splitAtAux(_n, _cell, _prec) do
  while(true) do
    var prec = _prec;
    var cell = _cell;
    var n = _n;
    if (n == 0) then do
      return cell;
    end else if (cell) then do
      var cell$1 = --[ :: ]--[
        cell[0],
        --[ [] ]--0
      ];
      prec[1] = cell$1;
      _prec = cell$1;
      _cell = cell[1];
      _n = n - 1 | 0;
      continue ;
    end else do
      return ;
    end end  end 
  end;
end

function take(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[ [] ]--0;
  end else if (lst) then do
    var cell = --[ :: ]--[
      lst[0],
      --[ [] ]--0
    ];
    var has = takeAux(n - 1 | 0, lst[1], cell);
    if (has) then do
      return cell;
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end

function drop(lst, n) do
  if (n < 0) then do
    return ;
  end else do
    var _l = lst;
    var _n = n;
    while(true) do
      var n$1 = _n;
      var l = _l;
      if (n$1 == 0) then do
        return l;
      end else if (l) then do
        _n = n$1 - 1 | 0;
        _l = l[1];
        continue ;
      end else do
        return ;
      end end  end 
    end;
  end end 
end

function splitAt(lst, n) do
  if (n < 0) then do
    return ;
  end else if (n == 0) then do
    return --[ tuple ]--[
            --[ [] ]--0,
            lst
          ];
  end else if (lst) then do
    var cell = --[ :: ]--[
      lst[0],
      --[ [] ]--0
    ];
    var rest = splitAtAux(n - 1 | 0, lst[1], cell);
    if (rest ~= undefined) then do
      return --[ tuple ]--[
              cell,
              rest
            ];
    end else do
      return ;
    end end 
  end else do
    return ;
  end end  end  end 
end

function concat(xs, ys) do
  if (xs) then do
    var cell = --[ :: ]--[
      xs[0],
      --[ [] ]--0
    ];
    copyAuxCont(xs[1], cell)[1] = ys;
    return cell;
  end else do
    return ys;
  end end 
end

function mapU(xs, f) do
  if (xs) then do
    var cell = --[ :: ]--[
      f(xs[0]),
      --[ [] ]--0
    ];
    copyAuxWithMap(xs[1], cell, f);
    return cell;
  end else do
    return --[ [] ]--0;
  end end 
end

function map(xs, f) do
  return mapU(xs, Curry.__1(f));
end

function zipByU(l1, l2, f) do
  if (l1 and l2) then do
    var cell = --[ :: ]--[
      f(l1[0], l2[0]),
      --[ [] ]--0
    ];
    copyAuxWithMap2(f, l1[1], l2[1], cell);
    return cell;
  end else do
    return --[ [] ]--0;
  end end 
end

function zipBy(l1, l2, f) do
  return zipByU(l1, l2, Curry.__2(f));
end

function mapWithIndexU(xs, f) do
  if (xs) then do
    var cell = --[ :: ]--[
      f(0, xs[0]),
      --[ [] ]--0
    ];
    copyAuxWithMapI(f, 1, xs[1], cell);
    return cell;
  end else do
    return --[ [] ]--0;
  end end 
end

function mapWithIndex(xs, f) do
  return mapWithIndexU(xs, Curry.__2(f));
end

function makeByU(n, f) do
  if (n <= 0) then do
    return --[ [] ]--0;
  end else do
    var headX = --[ :: ]--[
      f(0),
      --[ [] ]--0
    ];
    var cur = headX;
    var i = 1;
    while(i < n) do
      var v = --[ :: ]--[
        f(i),
        --[ [] ]--0
      ];
      cur[1] = v;
      cur = v;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end

function makeBy(n, f) do
  return makeByU(n, Curry.__1(f));
end

function make(n, v) do
  if (n <= 0) then do
    return --[ [] ]--0;
  end else do
    var headX = --[ :: ]--[
      v,
      --[ [] ]--0
    ];
    var cur = headX;
    var i = 1;
    while(i < n) do
      var v$1 = --[ :: ]--[
        v,
        --[ [] ]--0
      ];
      cur[1] = v$1;
      cur = v$1;
      i = i + 1 | 0;
    end;
    return headX;
  end end 
end

function length(xs) do
  var _x = xs;
  var _acc = 0;
  while(true) do
    var acc = _acc;
    var x = _x;
    if (x) then do
      _acc = acc + 1 | 0;
      _x = x[1];
      continue ;
    end else do
      return acc;
    end end 
  end;
end

function fillAux(arr, _i, _x) do
  while(true) do
    var x = _x;
    var i = _i;
    if (x) then do
      arr[i] = x[0];
      _x = x[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function fromArray(a) do
  var a$1 = a;
  var _i = #a - 1 | 0;
  var _res = --[ [] ]--0;
  while(true) do
    var res = _res;
    var i = _i;
    if (i < 0) then do
      return res;
    end else do
      _res = --[ :: ]--[
        a$1[i],
        res
      ];
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end

function toArray(x) do
  var len = length(x);
  var arr = new Array(len);
  fillAux(arr, 0, x);
  return arr;
end

function shuffle(xs) do
  var v = toArray(xs);
  Belt_Array.shuffleInPlace(v);
  return fromArray(v);
end

function reverseConcat(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      _l2 = --[ :: ]--[
        l1[0],
        l2
      ];
      _l1 = l1[1];
      continue ;
    end else do
      return l2;
    end end 
  end;
end

function reverse(l) do
  return reverseConcat(l, --[ [] ]--0);
end

function flattenAux(_prec, _xs) do
  while(true) do
    var xs = _xs;
    var prec = _prec;
    if (xs) then do
      _xs = xs[1];
      _prec = copyAuxCont(xs[0], prec);
      continue ;
    end else do
      prec[1] = --[ [] ]--0;
      return --[ () ]--0;
    end end 
  end;
end

function flatten(_xs) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var match = xs[0];
      if (match) then do
        var cell = --[ :: ]--[
          match[0],
          --[ [] ]--0
        ];
        flattenAux(copyAuxCont(match[1], cell), xs[1]);
        return cell;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function concatMany(xs) do
  var len = #xs;
  if (len ~= 1) then do
    if (len ~= 0) then do
      var len$1 = #xs;
      var v = xs[len$1 - 1 | 0];
      for var i = len$1 - 2 | 0 , 0 , -1 do
        v = concat(xs[i], v);
      end
      return v;
    end else do
      return --[ [] ]--0;
    end end 
  end else do
    return xs[0];
  end end 
end

function mapReverseU(l, f) do
  var f$1 = f;
  var _accu = --[ [] ]--0;
  var _xs = l;
  while(true) do
    var xs = _xs;
    var accu = _accu;
    if (xs) then do
      _xs = xs[1];
      _accu = --[ :: ]--[
        f$1(xs[0]),
        accu
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function mapReverse(l, f) do
  return mapReverseU(l, Curry.__1(f));
end

function forEachU(_xs, f) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      f(xs[0]);
      _xs = xs[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEach(xs, f) do
  return forEachU(xs, Curry.__1(f));
end

function forEachWithIndexU(l, f) do
  var _xs = l;
  var _i = 0;
  var f$1 = f;
  while(true) do
    var i = _i;
    var xs = _xs;
    if (xs) then do
      f$1(i, xs[0]);
      _i = i + 1 | 0;
      _xs = xs[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEachWithIndex(l, f) do
  return forEachWithIndexU(l, Curry.__2(f));
end

function reduceU(_l, _accu, f) do
  while(true) do
    var accu = _accu;
    var l = _l;
    if (l) then do
      _accu = f(accu, l[0]);
      _l = l[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function reduce(l, accu, f) do
  return reduceU(l, accu, Curry.__2(f));
end

function reduceReverseUnsafeU(l, accu, f) do
  if (l) then do
    return f(reduceReverseUnsafeU(l[1], accu, f), l[0]);
  end else do
    return accu;
  end end 
end

function reduceReverseU(l, acc, f) do
  var len = length(l);
  if (len < 1000) then do
    return reduceReverseUnsafeU(l, acc, f);
  end else do
    return Belt_Array.reduceReverseU(toArray(l), acc, f);
  end end 
end

function reduceReverse(l, accu, f) do
  return reduceReverseU(l, accu, Curry.__2(f));
end

function reduceWithIndexU(l, acc, f) do
  var _l = l;
  var _acc = acc;
  var f$1 = f;
  var _i = 0;
  while(true) do
    var i = _i;
    var acc$1 = _acc;
    var l$1 = _l;
    if (l$1) then do
      _i = i + 1 | 0;
      _acc = f$1(acc$1, l$1[0], i);
      _l = l$1[1];
      continue ;
    end else do
      return acc$1;
    end end 
  end;
end

function reduceWithIndex(l, acc, f) do
  return reduceWithIndexU(l, acc, Curry.__3(f));
end

function mapReverse2U(l1, l2, f) do
  var _l1 = l1;
  var _l2 = l2;
  var _accu = --[ [] ]--0;
  var f$1 = f;
  while(true) do
    var accu = _accu;
    var l2$1 = _l2;
    var l1$1 = _l1;
    if (l1$1 and l2$1) then do
      _accu = --[ :: ]--[
        f$1(l1$1[0], l2$1[0]),
        accu
      ];
      _l2 = l2$1[1];
      _l1 = l1$1[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function mapReverse2(l1, l2, f) do
  return mapReverse2U(l1, l2, Curry.__2(f));
end

function forEach2U(_l1, _l2, f) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1 and l2) then do
      f(l1[0], l2[0]);
      _l2 = l2[1];
      _l1 = l1[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function forEach2(l1, l2, f) do
  return forEach2U(l1, l2, Curry.__2(f));
end

function reduce2U(_l1, _l2, _accu, f) do
  while(true) do
    var accu = _accu;
    var l2 = _l2;
    var l1 = _l1;
    if (l1 and l2) then do
      _accu = f(accu, l1[0], l2[0]);
      _l2 = l2[1];
      _l1 = l1[1];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function reduce2(l1, l2, acc, f) do
  return reduce2U(l1, l2, acc, Curry.__3(f));
end

function reduceReverse2UnsafeU(l1, l2, accu, f) do
  if (l1 and l2) then do
    return f(reduceReverse2UnsafeU(l1[1], l2[1], accu, f), l1[0], l2[0]);
  end else do
    return accu;
  end end 
end

function reduceReverse2U(l1, l2, acc, f) do
  var len = length(l1);
  if (len < 1000) then do
    return reduceReverse2UnsafeU(l1, l2, acc, f);
  end else do
    return Belt_Array.reduceReverse2U(toArray(l1), toArray(l2), acc, f);
  end end 
end

function reduceReverse2(l1, l2, acc, f) do
  return reduceReverse2U(l1, l2, acc, Curry.__3(f));
end

function everyU(_xs, p) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      if (p(xs[0])) then do
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function every(xs, p) do
  return everyU(xs, Curry.__1(p));
end

function someU(_xs, p) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      if (p(xs[0])) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function some(xs, p) do
  return someU(xs, Curry.__1(p));
end

function every2U(_l1, _l2, p) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function every2(l1, l2, p) do
  return every2U(l1, l2, Curry.__2(p));
end

function cmpByLength(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      if (l2) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end

function cmpU(_l1, _l2, p) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      if (l2) then do
        var c = p(l1[0], l2[0]);
        if (c == 0) then do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
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
end

function cmp(l1, l2, f) do
  return cmpU(l1, l2, Curry.__2(f));
end

function eqU(_l1, _l2, p) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      if (l2 and p(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function eq(l1, l2, f) do
  return eqU(l1, l2, Curry.__2(f));
end

function some2U(_l1, _l2, p) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1 and l2) then do
      if (p(l1[0], l2[0])) then do
        return true;
      end else do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function some2(l1, l2, p) do
  return some2U(l1, l2, Curry.__2(p));
end

function hasU(_xs, x, eq) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      if (eq(xs[0], x)) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function has(xs, x, eq) do
  return hasU(xs, x, Curry.__2(eq));
end

function getAssocU(_xs, x, eq) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var match = xs[0];
      if (eq(match[0], x)) then do
        return Caml_option.some(match[1]);
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getAssoc(xs, x, eq) do
  return getAssocU(xs, x, Curry.__2(eq));
end

function hasAssocU(_xs, x, eq) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      if (eq(xs[0][0], x)) then do
        return true;
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function hasAssoc(xs, x, eq) do
  return hasAssocU(xs, x, Curry.__2(eq));
end

function removeAssocU(xs, x, eq) do
  if (xs) then do
    var l = xs[1];
    var pair = xs[0];
    if (eq(pair[0], x)) then do
      return l;
    end else do
      var cell = --[ :: ]--[
        pair,
        --[ [] ]--0
      ];
      var removed = removeAssocAuxWithMap(l, x, cell, eq);
      if (removed) then do
        return cell;
      end else do
        return xs;
      end end 
    end end 
  end else do
    return --[ [] ]--0;
  end end 
end

function removeAssoc(xs, x, eq) do
  return removeAssocU(xs, x, Curry.__2(eq));
end

function setAssocU(xs, x, k, eq) do
  if (xs) then do
    var l = xs[1];
    var pair = xs[0];
    if (eq(pair[0], x)) then do
      return --[ :: ]--[
              --[ tuple ]--[
                x,
                k
              ],
              l
            ];
    end else do
      var cell = --[ :: ]--[
        pair,
        --[ [] ]--0
      ];
      var replaced = setAssocAuxWithMap(l, x, k, cell, eq);
      if (replaced) then do
        return cell;
      end else do
        return --[ :: ]--[
                --[ tuple ]--[
                  x,
                  k
                ],
                xs
              ];
      end end 
    end end 
  end else do
    return --[ :: ]--[
            --[ tuple ]--[
              x,
              k
            ],
            --[ [] ]--0
          ];
  end end 
end

function setAssoc(xs, x, k, eq) do
  return setAssocU(xs, x, k, Curry.__2(eq));
end

function sortU(xs, cmp) do
  var arr = toArray(xs);
  Belt_SortArray.stableSortInPlaceByU(arr, cmp);
  return fromArray(arr);
end

function sort(xs, cmp) do
  return sortU(xs, Curry.__2(cmp));
end

function getByU(_xs, p) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var x = xs[0];
      if (p(x)) then do
        return Caml_option.some(x);
      end else do
        _xs = xs[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

function getBy(xs, p) do
  return getByU(xs, Curry.__1(p));
end

function keepU(_xs, p) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var t = xs[1];
      var h = xs[0];
      if (p(h)) then do
        var cell = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        copyAuxWitFilter(p, t, cell);
        return cell;
      end else do
        _xs = t;
        continue ;
      end end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function keep(xs, p) do
  return keepU(xs, Curry.__1(p));
end

function keepWithIndexU(xs, p) do
  var _xs = xs;
  var p$1 = p;
  var _i = 0;
  while(true) do
    var i = _i;
    var xs$1 = _xs;
    if (xs$1) then do
      var t = xs$1[1];
      var h = xs$1[0];
      if (p$1(h, i)) then do
        var cell = --[ :: ]--[
          h,
          --[ [] ]--0
        ];
        copyAuxWithFilterIndex(p$1, t, cell, i + 1 | 0);
        return cell;
      end else do
        _i = i + 1 | 0;
        _xs = t;
        continue ;
      end end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function keepWithIndex(xs, p) do
  return keepWithIndexU(xs, Curry.__2(p));
end

function keepMapU(_xs, p) do
  while(true) do
    var xs = _xs;
    if (xs) then do
      var t = xs[1];
      var match = p(xs[0]);
      if (match ~= undefined) then do
        var cell = --[ :: ]--[
          Caml_option.valFromOption(match),
          --[ [] ]--0
        ];
        copyAuxWitFilterMap(p, t, cell);
        return cell;
      end else do
        _xs = t;
        continue ;
      end end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function keepMap(xs, p) do
  return keepMapU(xs, Curry.__1(p));
end

function partitionU(l, p) do
  if (l) then do
    var h = l[0];
    var nextX = --[ :: ]--[
      h,
      --[ [] ]--0
    ];
    var nextY = --[ :: ]--[
      h,
      --[ [] ]--0
    ];
    var b = p(h);
    partitionAux(p, l[1], nextX, nextY);
    if (b) then do
      return --[ tuple ]--[
              nextX,
              nextY[1]
            ];
    end else do
      return --[ tuple ]--[
              nextX[1],
              nextY
            ];
    end end 
  end else do
    return --[ tuple ]--[
            --[ [] ]--0,
            --[ [] ]--0
          ];
  end end 
end

function partition(l, p) do
  return partitionU(l, Curry.__1(p));
end

function unzip(xs) do
  if (xs) then do
    var match = xs[0];
    var cellX = --[ :: ]--[
      match[0],
      --[ [] ]--0
    ];
    var cellY = --[ :: ]--[
      match[1],
      --[ [] ]--0
    ];
    splitAux(xs[1], cellX, cellY);
    return --[ tuple ]--[
            cellX,
            cellY
          ];
  end else do
    return --[ tuple ]--[
            --[ [] ]--0,
            --[ [] ]--0
          ];
  end end 
end

function zip(l1, l2) do
  if (l1 and l2) then do
    var cell = --[ :: ]--[
      --[ tuple ]--[
        l1[0],
        l2[0]
      ],
      --[ [] ]--0
    ];
    zipAux(l1[1], l2[1], cell);
    return cell;
  end else do
    return --[ [] ]--0;
  end end 
end

var size = length;

var filter = keep;

var filterWithIndex = keepWithIndex;

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
--[ No side effect ]--
