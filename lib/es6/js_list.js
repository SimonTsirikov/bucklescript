

import * as Js_vector from "./js_vector.js";
import * as Caml_option from "./caml_option.js";

function length(l) do
  var _len = 0;
  var _param = l;
  while(true) do
    var param = _param;
    var len = _len;
    if (param) then do
      _param = param[1];
      _len = len + 1 | 0;
      continue ;
    end else do
      return len;
    end end 
  end;
end

function cons(x, xs) do
  return --[ :: ]--[
          x,
          xs
        ];
end

function isEmpty(x) do
  return x == --[ [] ]--0;
end

function hd(param) do
  if (param) then do
    return Caml_option.some(param[0]);
  end
   end 
end

function tl(param) do
  if (param) then do
    return param[1];
  end
   end 
end

function nth(l, n) do
  if (n < 0) then do
    return ;
  end else do
    var _l = l;
    var _n = n;
    while(true) do
      var n$1 = _n;
      var l$1 = _l;
      if (l$1) then do
        if (n$1 == 0) then do
          return Caml_option.some(l$1[0]);
        end else do
          _n = n$1 - 1 | 0;
          _l = l$1[1];
          continue ;
        end end 
      end else do
        return ;
      end end 
    end;
  end end 
end

function revAppend(_l1, _l2) do
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

function rev(l) do
  return revAppend(l, --[ [] ]--0);
end

function mapRevAux(f, _acc, _ls) do
  while(true) do
    var ls = _ls;
    var acc = _acc;
    if (ls) then do
      _ls = ls[1];
      _acc = --[ :: ]--[
        f(ls[0]),
        acc
      ];
      continue ;
    end else do
      return acc;
    end end 
  end;
end

function mapRev(f, ls) do
  return mapRevAux(f, --[ [] ]--0, ls);
end

function map(f, ls) do
  return revAppend(mapRevAux(f, --[ [] ]--0, ls), --[ [] ]--0);
end

function iter(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      f(param[0]);
      _param = param[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function iteri(f, l) do
  var _i = 0;
  var f$1 = f;
  var _param = l;
  while(true) do
    var param = _param;
    var i = _i;
    if (param) then do
      f$1(i, param[0]);
      _param = param[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function foldLeft(f, _accu, _l) do
  while(true) do
    var l = _l;
    var accu = _accu;
    if (l) then do
      _l = l[1];
      _accu = f(accu, l[0]);
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function tailLoop(f, _acc, _param) do
  while(true) do
    var param = _param;
    var acc = _acc;
    if (param) then do
      _param = param[1];
      _acc = f(param[0], acc);
      continue ;
    end else do
      return acc;
    end end 
  end;
end

function foldRight(f, l, init) do
  var loop = function (n, param) do
    if (param) then do
      var t = param[1];
      var h = param[0];
      if (n < 1000) then do
        return f(h, loop(n + 1 | 0, t));
      end else do
        return f(h, tailLoop(f, init, revAppend(t, --[ [] ]--0)));
      end end 
    end else do
      return init;
    end end 
  end;
  return loop(0, l);
end

function flatten(lx) do
  var _acc = --[ [] ]--0;
  var _lx = lx;
  while(true) do
    var lx$1 = _lx;
    var acc = _acc;
    if (lx$1) then do
      _lx = lx$1[1];
      _acc = revAppend(lx$1[0], acc);
      continue ;
    end else do
      return revAppend(acc, --[ [] ]--0);
    end end 
  end;
end

function filterRevAux(f, _acc, _xs) do
  while(true) do
    var xs = _xs;
    var acc = _acc;
    if (xs) then do
      var ys = xs[1];
      var y = xs[0];
      if (f(y)) then do
        _xs = ys;
        _acc = --[ :: ]--[
          y,
          acc
        ];
        continue ;
      end else do
        _xs = ys;
        continue ;
      end end 
    end else do
      return acc;
    end end 
  end;
end

function filter(f, xs) do
  return revAppend(filterRevAux(f, --[ [] ]--0, xs), --[ [] ]--0);
end

function filterMapRevAux(f, _acc, _xs) do
  while(true) do
    var xs = _xs;
    var acc = _acc;
    if (xs) then do
      var ys = xs[1];
      var match = f(xs[0]);
      _xs = ys;
      if (match ~= undefined) then do
        _acc = --[ :: ]--[
          Caml_option.valFromOption(match),
          acc
        ];
        continue ;
      end else do
        continue ;
      end end 
    end else do
      return acc;
    end end 
  end;
end

function filterMap(f, xs) do
  return revAppend(filterMapRevAux(f, --[ [] ]--0, xs), --[ [] ]--0);
end

function countBy(f, xs) do
  var f$1 = f;
  var _acc = 0;
  var _xs = xs;
  while(true) do
    var xs$1 = _xs;
    var acc = _acc;
    if (xs$1) then do
      _xs = xs$1[1];
      _acc = f$1(xs$1[0]) and acc + 1 | 0 or acc;
      continue ;
    end else do
      return acc;
    end end 
  end;
end

function init(n, f) do
  return Js_vector.toList(Js_vector.init(n, f));
end

function toVector(xs) do
  if (xs) then do
    var a = new Array(length(xs));
    var _i = 0;
    var _param = xs;
    while(true) do
      var param = _param;
      var i = _i;
      if (param) then do
        a[i] = param[0];
        _param = param[1];
        _i = i + 1 | 0;
        continue ;
      end else do
        return a;
      end end 
    end;
  end else do
    return [];
  end end 
end

function equal(cmp, _xs, _ys) do
  while(true) do
    var ys = _ys;
    var xs = _xs;
    if (xs) then do
      if (ys and cmp(xs[0], ys[0])) then do
        _ys = ys[1];
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (ys) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

export do
  length ,
  cons ,
  isEmpty ,
  hd ,
  tl ,
  nth ,
  revAppend ,
  rev ,
  mapRev ,
  map ,
  iter ,
  iteri ,
  foldLeft ,
  foldRight ,
  flatten ,
  filter ,
  filterMap ,
  countBy ,
  init ,
  toVector ,
  equal ,
  
end
--[ No side effect ]--
