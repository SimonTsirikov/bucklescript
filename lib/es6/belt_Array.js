

import * as Curry from "./curry.js";
import * as Js_math from "./js_math.js";
import * as Caml_option from "./caml_option.js";
import * as Caml_primitive from "./caml_primitive.js";

function get(arr, i) do
  if (i >= 0 and i < #arr) then do
    return Caml_option.some(arr[i]);
  end
   end 
end

function getExn(arr, i) do
  if (!(i >= 0 and i < #arr)) then do
    throw new Error("File \"belt_Array.ml\", line 25, characters 6-12");
  end
   end 
  return arr[i];
end

function set(arr, i, v) do
  if (i >= 0 and i < #arr) then do
    arr[i] = v;
    return true;
  end else do
    return false;
  end end 
end

function setExn(arr, i, v) do
  if (!(i >= 0 and i < #arr)) then do
    throw new Error("File \"belt_Array.ml\", line 31, characters 4-10");
  end
   end 
  arr[i] = v;
  return --[ () ]--0;
end

function swapUnsafe(xs, i, j) do
  var tmp = xs[i];
  xs[i] = xs[j];
  xs[j] = tmp;
  return --[ () ]--0;
end

function shuffleInPlace(xs) do
  var len = #xs;
  for var i = 0 , len - 1 | 0 , 1 do
    swapUnsafe(xs, i, Js_math.random_int(i, len));
  end
  return --[ () ]--0;
end

function shuffle(xs) do
  var result = xs.slice(0);
  shuffleInPlace(result);
  return result;
end

function reverseInPlace(xs) do
  var len = #xs;
  var xs$1 = xs;
  var ofs = 0;
  var len$1 = len;
  for var i = 0 , (len$1 / 2 | 0) - 1 | 0 , 1 do
    swapUnsafe(xs$1, ofs + i | 0, ((ofs + len$1 | 0) - i | 0) - 1 | 0);
  end
  return --[ () ]--0;
end

function reverse(xs) do
  var len = #xs;
  var result = new Array(len);
  for var i = 0 , len - 1 | 0 , 1 do
    result[i] = xs[(len - 1 | 0) - i | 0];
  end
  return result;
end

function make(l, f) do
  if (l <= 0) then do
    return [];
  end else do
    var res = new Array(l);
    for var i = 0 , l - 1 | 0 , 1 do
      res[i] = f;
    end
    return res;
  end end 
end

function makeByU(l, f) do
  if (l <= 0) then do
    return [];
  end else do
    var res = new Array(l);
    for var i = 0 , l - 1 | 0 , 1 do
      res[i] = f(i);
    end
    return res;
  end end 
end

function makeBy(l, f) do
  return makeByU(l, Curry.__1(f));
end

function makeByAndShuffleU(l, f) do
  var u = makeByU(l, f);
  shuffleInPlace(u);
  return u;
end

function makeByAndShuffle(l, f) do
  return makeByAndShuffleU(l, Curry.__1(f));
end

function range(start, finish) do
  var cut = finish - start | 0;
  if (cut < 0) then do
    return [];
  end else do
    var arr = new Array(cut + 1 | 0);
    for var i = 0 , cut , 1 do
      arr[i] = start + i | 0;
    end
    return arr;
  end end 
end

function rangeBy(start, finish, step) do
  var cut = finish - start | 0;
  if (cut < 0 or step <= 0) then do
    return [];
  end else do
    var nb = (cut / step | 0) + 1 | 0;
    var arr = new Array(nb);
    var cur = start;
    for var i = 0 , nb - 1 | 0 , 1 do
      arr[i] = cur;
      cur = cur + step | 0;
    end
    return arr;
  end end 
end

function zip(xs, ys) do
  var lenx = #xs;
  var leny = #ys;
  var len = lenx < leny and lenx or leny;
  var s = new Array(len);
  for var i = 0 , len - 1 | 0 , 1 do
    s[i] = --[ tuple ]--[
      xs[i],
      ys[i]
    ];
  end
  return s;
end

function zipByU(xs, ys, f) do
  var lenx = #xs;
  var leny = #ys;
  var len = lenx < leny and lenx or leny;
  var s = new Array(len);
  for var i = 0 , len - 1 | 0 , 1 do
    s[i] = f(xs[i], ys[i]);
  end
  return s;
end

function zipBy(xs, ys, f) do
  return zipByU(xs, ys, Curry.__2(f));
end

function concat(a1, a2) do
  var l1 = #a1;
  var l2 = #a2;
  var a1a2 = new Array(l1 + l2 | 0);
  for var i = 0 , l1 - 1 | 0 , 1 do
    a1a2[i] = a1[i];
  end
  for var i$1 = 0 , l2 - 1 | 0 , 1 do
    a1a2[l1 + i$1 | 0] = a2[i$1];
  end
  return a1a2;
end

function concatMany(arrs) do
  var lenArrs = #arrs;
  var totalLen = 0;
  for var i = 0 , lenArrs - 1 | 0 , 1 do
    totalLen = totalLen + #arrs[i] | 0;
  end
  var result = new Array(totalLen);
  totalLen = 0;
  for var j = 0 , lenArrs - 1 | 0 , 1 do
    var cur = arrs[j];
    for var k = 0 , #cur - 1 | 0 , 1 do
      result[totalLen] = cur[k];
      totalLen = totalLen + 1 | 0;
    end
  end
  return result;
end

function slice(a, offset, len) do
  if (len <= 0) then do
    return [];
  end else do
    var lena = #a;
    var ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
    var hasLen = lena - ofs | 0;
    var copyLength = hasLen < len and hasLen or len;
    if (copyLength <= 0) then do
      return [];
    end else do
      var result = new Array(copyLength);
      for var i = 0 , copyLength - 1 | 0 , 1 do
        result[i] = a[ofs + i | 0];
      end
      return result;
    end end 
  end end 
end

function sliceToEnd(a, offset) do
  var lena = #a;
  var ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
  var len = lena - ofs | 0;
  var result = new Array(len);
  for var i = 0 , len - 1 | 0 , 1 do
    result[i] = a[ofs + i | 0];
  end
  return result;
end

function fill(a, offset, len, v) do
  if (len > 0) then do
    var lena = #a;
    var ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
    var hasLen = lena - ofs | 0;
    var fillLength = hasLen < len and hasLen or len;
    if (fillLength > 0) then do
      for var i = ofs , (ofs + fillLength | 0) - 1 | 0 , 1 do
        a[i] = v;
      end
      return --[ () ]--0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end

function blitUnsafe(a1, srcofs1, a2, srcofs2, blitLength) do
  if (srcofs2 <= srcofs1) then do
    for var j = 0 , blitLength - 1 | 0 , 1 do
      a2[j + srcofs2 | 0] = a1[j + srcofs1 | 0];
    end
    return --[ () ]--0;
  end else do
    for var j$1 = blitLength - 1 | 0 , 0 , -1 do
      a2[j$1 + srcofs2 | 0] = a1[j$1 + srcofs1 | 0];
    end
    return --[ () ]--0;
  end end 
end

function blit(a1, ofs1, a2, ofs2, len) do
  var lena1 = #a1;
  var lena2 = #a2;
  var srcofs1 = ofs1 < 0 and Caml_primitive.caml_int_max(lena1 + ofs1 | 0, 0) or ofs1;
  var srcofs2 = ofs2 < 0 and Caml_primitive.caml_int_max(lena2 + ofs2 | 0, 0) or ofs2;
  var blitLength = Caml_primitive.caml_int_min(len, Caml_primitive.caml_int_min(lena1 - srcofs1 | 0, lena2 - srcofs2 | 0));
  if (srcofs2 <= srcofs1) then do
    for var j = 0 , blitLength - 1 | 0 , 1 do
      a2[j + srcofs2 | 0] = a1[j + srcofs1 | 0];
    end
    return --[ () ]--0;
  end else do
    for var j$1 = blitLength - 1 | 0 , 0 , -1 do
      a2[j$1 + srcofs2 | 0] = a1[j$1 + srcofs1 | 0];
    end
    return --[ () ]--0;
  end end 
end

function forEachU(a, f) do
  for var i = 0 , #a - 1 | 0 , 1 do
    f(a[i]);
  end
  return --[ () ]--0;
end

function forEach(a, f) do
  return forEachU(a, Curry.__1(f));
end

function mapU(a, f) do
  var l = #a;
  var r = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    r[i] = f(a[i]);
  end
  return r;
end

function map(a, f) do
  return mapU(a, Curry.__1(f));
end

function getByU(a, p) do
  var l = #a;
  var i = 0;
  var r = undefined;
  while(r == undefined and i < l) do
    var v = a[i];
    if (p(v)) then do
      r = Caml_option.some(v);
    end
     end 
    i = i + 1 | 0;
  end;
  return r;
end

function getBy(a, p) do
  return getByU(a, Curry.__1(p));
end

function getIndexByU(a, p) do
  var l = #a;
  var i = 0;
  var r = undefined;
  while(r == undefined and i < l) do
    var v = a[i];
    if (p(v)) then do
      r = i;
    end
     end 
    i = i + 1 | 0;
  end;
  return r;
end

function getIndexBy(a, p) do
  return getIndexByU(a, Curry.__1(p));
end

function keepU(a, f) do
  var l = #a;
  var r = new Array(l);
  var j = 0;
  for var i = 0 , l - 1 | 0 , 1 do
    var v = a[i];
    if (f(v)) then do
      r[j] = v;
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end

function keep(a, f) do
  return keepU(a, Curry.__1(f));
end

function keepWithIndexU(a, f) do
  var l = #a;
  var r = new Array(l);
  var j = 0;
  for var i = 0 , l - 1 | 0 , 1 do
    var v = a[i];
    if (f(v, i)) then do
      r[j] = v;
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end

function keepWithIndex(a, f) do
  return keepWithIndexU(a, Curry.__2(f));
end

function keepMapU(a, f) do
  var l = #a;
  var r = new Array(l);
  var j = 0;
  for var i = 0 , l - 1 | 0 , 1 do
    var v = a[i];
    var match = f(v);
    if (match ~= undefined) then do
      r[j] = Caml_option.valFromOption(match);
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end

function keepMap(a, f) do
  return keepMapU(a, Curry.__1(f));
end

function forEachWithIndexU(a, f) do
  for var i = 0 , #a - 1 | 0 , 1 do
    f(i, a[i]);
  end
  return --[ () ]--0;
end

function forEachWithIndex(a, f) do
  return forEachWithIndexU(a, Curry.__2(f));
end

function mapWithIndexU(a, f) do
  var l = #a;
  var r = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    r[i] = f(i, a[i]);
  end
  return r;
end

function mapWithIndex(a, f) do
  return mapWithIndexU(a, Curry.__2(f));
end

function reduceU(a, x, f) do
  var r = x;
  for var i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i]);
  end
  return r;
end

function reduce(a, x, f) do
  return reduceU(a, x, Curry.__2(f));
end

function reduceReverseU(a, x, f) do
  var r = x;
  for var i = #a - 1 | 0 , 0 , -1 do
    r = f(r, a[i]);
  end
  return r;
end

function reduceReverse(a, x, f) do
  return reduceReverseU(a, x, Curry.__2(f));
end

function reduceReverse2U(a, b, x, f) do
  var r = x;
  var len = Caml_primitive.caml_int_min(#a, #b);
  for var i = len - 1 | 0 , 0 , -1 do
    r = f(r, a[i], b[i]);
  end
  return r;
end

function reduceReverse2(a, b, x, f) do
  return reduceReverse2U(a, b, x, Curry.__3(f));
end

function reduceWithIndexU(a, x, f) do
  var r = x;
  for var i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i], i);
  end
  return r;
end

function reduceWithIndex(a, x, f) do
  return reduceWithIndexU(a, x, Curry.__3(f));
end

function everyU(arr, b) do
  var len = #arr;
  var arr$1 = arr;
  var _i = 0;
  var b$1 = b;
  var len$1 = len;
  while(true) do
    var i = _i;
    if (i == len$1) then do
      return true;
    end else if (b$1(arr$1[i])) then do
      _i = i + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end

function every(arr, f) do
  return everyU(arr, Curry.__1(f));
end

function someU(arr, b) do
  var len = #arr;
  var arr$1 = arr;
  var _i = 0;
  var b$1 = b;
  var len$1 = len;
  while(true) do
    var i = _i;
    if (i == len$1) then do
      return false;
    end else if (b$1(arr$1[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end

function some(arr, f) do
  return someU(arr, Curry.__1(f));
end

function everyAux2(arr1, arr2, _i, b, len) do
  while(true) do
    var i = _i;
    if (i == len) then do
      return true;
    end else if (b(arr1[i], arr2[i])) then do
      _i = i + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end

function every2U(a, b, p) do
  return everyAux2(a, b, 0, p, Caml_primitive.caml_int_min(#a, #b));
end

function every2(a, b, p) do
  return every2U(a, b, Curry.__2(p));
end

function some2U(a, b, p) do
  var arr1 = a;
  var arr2 = b;
  var _i = 0;
  var b$1 = p;
  var len = Caml_primitive.caml_int_min(#a, #b);
  while(true) do
    var i = _i;
    if (i == len) then do
      return false;
    end else if (b$1(arr1[i], arr2[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end

function some2(a, b, p) do
  return some2U(a, b, Curry.__2(p));
end

function eqU(a, b, p) do
  var lena = #a;
  var lenb = #b;
  if (lena == lenb) then do
    return everyAux2(a, b, 0, p, lena);
  end else do
    return false;
  end end 
end

function eq(a, b, p) do
  return eqU(a, b, Curry.__2(p));
end

function cmpU(a, b, p) do
  var lena = #a;
  var lenb = #b;
  if (lena > lenb) then do
    return 1;
  end else if (lena < lenb) then do
    return -1;
  end else do
    var arr1 = a;
    var arr2 = b;
    var _i = 0;
    var b$1 = p;
    var len = lena;
    while(true) do
      var i = _i;
      if (i == len) then do
        return 0;
      end else do
        var c = b$1(arr1[i], arr2[i]);
        if (c == 0) then do
          _i = i + 1 | 0;
          continue ;
        end else do
          return c;
        end end 
      end end 
    end;
  end end  end 
end

function cmp(a, b, p) do
  return cmpU(a, b, Curry.__2(p));
end

function partitionU(a, f) do
  var l = #a;
  var i = 0;
  var j = 0;
  var a1 = new Array(l);
  var a2 = new Array(l);
  for var ii = 0 , l - 1 | 0 , 1 do
    var v = a[ii];
    if (f(v)) then do
      a1[i] = v;
      i = i + 1 | 0;
    end else do
      a2[j] = v;
      j = j + 1 | 0;
    end end 
  end
  a1.length = i;
  a2.length = j;
  return --[ tuple ]--[
          a1,
          a2
        ];
end

function partition(a, f) do
  return partitionU(a, Curry.__1(f));
end

function unzip(a) do
  var l = #a;
  var a1 = new Array(l);
  var a2 = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    var match = a[i];
    a1[i] = match[0];
    a2[i] = match[1];
  end
  return --[ tuple ]--[
          a1,
          a2
        ];
end

export do
  get ,
  getExn ,
  set ,
  setExn ,
  shuffleInPlace ,
  shuffle ,
  reverseInPlace ,
  reverse ,
  make ,
  range ,
  rangeBy ,
  makeByU ,
  makeBy ,
  makeByAndShuffleU ,
  makeByAndShuffle ,
  zip ,
  zipByU ,
  zipBy ,
  unzip ,
  concat ,
  concatMany ,
  slice ,
  sliceToEnd ,
  fill ,
  blit ,
  blitUnsafe ,
  forEachU ,
  forEach ,
  mapU ,
  map ,
  getByU ,
  getBy ,
  getIndexByU ,
  getIndexBy ,
  keepU ,
  keep ,
  keepWithIndexU ,
  keepWithIndex ,
  keepMapU ,
  keepMap ,
  forEachWithIndexU ,
  forEachWithIndex ,
  mapWithIndexU ,
  mapWithIndex ,
  partitionU ,
  partition ,
  reduceU ,
  reduce ,
  reduceReverseU ,
  reduceReverse ,
  reduceReverse2U ,
  reduceReverse2 ,
  reduceWithIndexU ,
  reduceWithIndex ,
  someU ,
  some ,
  everyU ,
  every ,
  every2U ,
  every2 ,
  some2U ,
  some2 ,
  cmpU ,
  cmp ,
  eqU ,
  eq ,
  
end
--[ No side effect ]--
