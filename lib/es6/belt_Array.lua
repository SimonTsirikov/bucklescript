

import * as Curry from "./curry.lua";
import * as Js_math from "./js_math.lua";
import * as Caml_option from "./caml_option.lua";
import * as Caml_primitive from "./caml_primitive.lua";

function get(arr, i) do
  if (i >= 0 and i < #arr) then do
    return Caml_option.some(arr[i]);
  end
   end 
end end

function getExn(arr, i) do
  if (not (i >= 0 and i < #arr)) then do
    error(new Error("File \"belt_Array.ml\", line 25, characters 6-12"))
  end
   end 
  return arr[i];
end end

function set(arr, i, v) do
  if (i >= 0 and i < #arr) then do
    arr[i] = v;
    return true;
  end else do
    return false;
  end end 
end end

function setExn(arr, i, v) do
  if (not (i >= 0 and i < #arr)) then do
    error(new Error("File \"belt_Array.ml\", line 31, characters 4-10"))
  end
   end 
  arr[i] = v;
  return --[[ () ]]0;
end end

function swapUnsafe(xs, i, j) do
  tmp = xs[i];
  xs[i] = xs[j];
  xs[j] = tmp;
  return --[[ () ]]0;
end end

function shuffleInPlace(xs) do
  len = #xs;
  for i = 0 , len - 1 | 0 , 1 do
    swapUnsafe(xs, i, Js_math.random_int(i, len));
  end
  return --[[ () ]]0;
end end

function shuffle(xs) do
  result = xs.slice(0);
  shuffleInPlace(result);
  return result;
end end

function reverseInPlace(xs) do
  len = #xs;
  xs_1 = xs;
  ofs = 0;
  len_1 = len;
  for i = 0 , (len_1 / 2 | 0) - 1 | 0 , 1 do
    swapUnsafe(xs_1, ofs + i | 0, ((ofs + len_1 | 0) - i | 0) - 1 | 0);
  end
  return --[[ () ]]0;
end end

function reverse(xs) do
  len = #xs;
  result = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    result[i] = xs[(len - 1 | 0) - i | 0];
  end
  return result;
end end

function make(l, f) do
  if (l <= 0) then do
    return {};
  end else do
    res = new Array(l);
    for i = 0 , l - 1 | 0 , 1 do
      res[i] = f;
    end
    return res;
  end end 
end end

function makeByU(l, f) do
  if (l <= 0) then do
    return {};
  end else do
    res = new Array(l);
    for i = 0 , l - 1 | 0 , 1 do
      res[i] = f(i);
    end
    return res;
  end end 
end end

function makeBy(l, f) do
  return makeByU(l, Curry.__1(f));
end end

function makeByAndShuffleU(l, f) do
  u = makeByU(l, f);
  shuffleInPlace(u);
  return u;
end end

function makeByAndShuffle(l, f) do
  return makeByAndShuffleU(l, Curry.__1(f));
end end

function range(start, finish) do
  cut = finish - start | 0;
  if (cut < 0) then do
    return {};
  end else do
    arr = new Array(cut + 1 | 0);
    for i = 0 , cut , 1 do
      arr[i] = start + i | 0;
    end
    return arr;
  end end 
end end

function rangeBy(start, finish, step) do
  cut = finish - start | 0;
  if (cut < 0 or step <= 0) then do
    return {};
  end else do
    nb = (cut / step | 0) + 1 | 0;
    arr = new Array(nb);
    cur = start;
    for i = 0 , nb - 1 | 0 , 1 do
      arr[i] = cur;
      cur = cur + step | 0;
    end
    return arr;
  end end 
end end

function zip(xs, ys) do
  lenx = #xs;
  leny = #ys;
  len = lenx < leny and lenx or leny;
  s = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    s[i] = --[[ tuple ]]{
      xs[i],
      ys[i]
    };
  end
  return s;
end end

function zipByU(xs, ys, f) do
  lenx = #xs;
  leny = #ys;
  len = lenx < leny and lenx or leny;
  s = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    s[i] = f(xs[i], ys[i]);
  end
  return s;
end end

function zipBy(xs, ys, f) do
  return zipByU(xs, ys, Curry.__2(f));
end end

function concat(a1, a2) do
  l1 = #a1;
  l2 = #a2;
  a1a2 = new Array(l1 + l2 | 0);
  for i = 0 , l1 - 1 | 0 , 1 do
    a1a2[i] = a1[i];
  end
  for i_1 = 0 , l2 - 1 | 0 , 1 do
    a1a2[l1 + i_1 | 0] = a2[i_1];
  end
  return a1a2;
end end

function concatMany(arrs) do
  lenArrs = #arrs;
  totalLen = 0;
  for i = 0 , lenArrs - 1 | 0 , 1 do
    totalLen = totalLen + #arrs[i] | 0;
  end
  result = new Array(totalLen);
  totalLen = 0;
  for j = 0 , lenArrs - 1 | 0 , 1 do
    cur = arrs[j];
    for k = 0 , #cur - 1 | 0 , 1 do
      result[totalLen] = cur[k];
      totalLen = totalLen + 1 | 0;
    end
  end
  return result;
end end

function slice(a, offset, len) do
  if (len <= 0) then do
    return {};
  end else do
    lena = #a;
    ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
    hasLen = lena - ofs | 0;
    copyLength = hasLen < len and hasLen or len;
    if (copyLength <= 0) then do
      return {};
    end else do
      result = new Array(copyLength);
      for i = 0 , copyLength - 1 | 0 , 1 do
        result[i] = a[ofs + i | 0];
      end
      return result;
    end end 
  end end 
end end

function sliceToEnd(a, offset) do
  lena = #a;
  ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
  len = lena - ofs | 0;
  result = new Array(len);
  for i = 0 , len - 1 | 0 , 1 do
    result[i] = a[ofs + i | 0];
  end
  return result;
end end

function fill(a, offset, len, v) do
  if (len > 0) then do
    lena = #a;
    ofs = offset < 0 and Caml_primitive.caml_int_max(lena + offset | 0, 0) or offset;
    hasLen = lena - ofs | 0;
    fillLength = hasLen < len and hasLen or len;
    if (fillLength > 0) then do
      for i = ofs , (ofs + fillLength | 0) - 1 | 0 , 1 do
        a[i] = v;
      end
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end end

function blitUnsafe(a1, srcofs1, a2, srcofs2, blitLength) do
  if (srcofs2 <= srcofs1) then do
    for j = 0 , blitLength - 1 | 0 , 1 do
      a2[j + srcofs2 | 0] = a1[j + srcofs1 | 0];
    end
    return --[[ () ]]0;
  end else do
    for j_1 = blitLength - 1 | 0 , 0 , -1 do
      a2[j_1 + srcofs2 | 0] = a1[j_1 + srcofs1 | 0];
    end
    return --[[ () ]]0;
  end end 
end end

function blit(a1, ofs1, a2, ofs2, len) do
  lena1 = #a1;
  lena2 = #a2;
  srcofs1 = ofs1 < 0 and Caml_primitive.caml_int_max(lena1 + ofs1 | 0, 0) or ofs1;
  srcofs2 = ofs2 < 0 and Caml_primitive.caml_int_max(lena2 + ofs2 | 0, 0) or ofs2;
  blitLength = Caml_primitive.caml_int_min(len, Caml_primitive.caml_int_min(lena1 - srcofs1 | 0, lena2 - srcofs2 | 0));
  if (srcofs2 <= srcofs1) then do
    for j = 0 , blitLength - 1 | 0 , 1 do
      a2[j + srcofs2 | 0] = a1[j + srcofs1 | 0];
    end
    return --[[ () ]]0;
  end else do
    for j_1 = blitLength - 1 | 0 , 0 , -1 do
      a2[j_1 + srcofs2 | 0] = a1[j_1 + srcofs1 | 0];
    end
    return --[[ () ]]0;
  end end 
end end

function forEachU(a, f) do
  for i = 0 , #a - 1 | 0 , 1 do
    f(a[i]);
  end
  return --[[ () ]]0;
end end

function forEach(a, f) do
  return forEachU(a, Curry.__1(f));
end end

function mapU(a, f) do
  l = #a;
  r = new Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    r[i] = f(a[i]);
  end
  return r;
end end

function map(a, f) do
  return mapU(a, Curry.__1(f));
end end

function getByU(a, p) do
  l = #a;
  i = 0;
  r = undefined;
  while(r == undefined and i < l) do
    v = a[i];
    if (p(v)) then do
      r = Caml_option.some(v);
    end
     end 
    i = i + 1 | 0;
  end;
  return r;
end end

function getBy(a, p) do
  return getByU(a, Curry.__1(p));
end end

function getIndexByU(a, p) do
  l = #a;
  i = 0;
  r = undefined;
  while(r == undefined and i < l) do
    v = a[i];
    if (p(v)) then do
      r = i;
    end
     end 
    i = i + 1 | 0;
  end;
  return r;
end end

function getIndexBy(a, p) do
  return getIndexByU(a, Curry.__1(p));
end end

function keepU(a, f) do
  l = #a;
  r = new Array(l);
  j = 0;
  for i = 0 , l - 1 | 0 , 1 do
    v = a[i];
    if (f(v)) then do
      r[j] = v;
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end end

function keep(a, f) do
  return keepU(a, Curry.__1(f));
end end

function keepWithIndexU(a, f) do
  l = #a;
  r = new Array(l);
  j = 0;
  for i = 0 , l - 1 | 0 , 1 do
    v = a[i];
    if (f(v, i)) then do
      r[j] = v;
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end end

function keepWithIndex(a, f) do
  return keepWithIndexU(a, Curry.__2(f));
end end

function keepMapU(a, f) do
  l = #a;
  r = new Array(l);
  j = 0;
  for i = 0 , l - 1 | 0 , 1 do
    v = a[i];
    match = f(v);
    if (match ~= undefined) then do
      r[j] = Caml_option.valFromOption(match);
      j = j + 1 | 0;
    end
     end 
  end
  r.length = j;
  return r;
end end

function keepMap(a, f) do
  return keepMapU(a, Curry.__1(f));
end end

function forEachWithIndexU(a, f) do
  for i = 0 , #a - 1 | 0 , 1 do
    f(i, a[i]);
  end
  return --[[ () ]]0;
end end

function forEachWithIndex(a, f) do
  return forEachWithIndexU(a, Curry.__2(f));
end end

function mapWithIndexU(a, f) do
  l = #a;
  r = new Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    r[i] = f(i, a[i]);
  end
  return r;
end end

function mapWithIndex(a, f) do
  return mapWithIndexU(a, Curry.__2(f));
end end

function reduceU(a, x, f) do
  r = x;
  for i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i]);
  end
  return r;
end end

function reduce(a, x, f) do
  return reduceU(a, x, Curry.__2(f));
end end

function reduceReverseU(a, x, f) do
  r = x;
  for i = #a - 1 | 0 , 0 , -1 do
    r = f(r, a[i]);
  end
  return r;
end end

function reduceReverse(a, x, f) do
  return reduceReverseU(a, x, Curry.__2(f));
end end

function reduceReverse2U(a, b, x, f) do
  r = x;
  len = Caml_primitive.caml_int_min(#a, #b);
  for i = len - 1 | 0 , 0 , -1 do
    r = f(r, a[i], b[i]);
  end
  return r;
end end

function reduceReverse2(a, b, x, f) do
  return reduceReverse2U(a, b, x, Curry.__3(f));
end end

function reduceWithIndexU(a, x, f) do
  r = x;
  for i = 0 , #a - 1 | 0 , 1 do
    r = f(r, a[i], i);
  end
  return r;
end end

function reduceWithIndex(a, x, f) do
  return reduceWithIndexU(a, x, Curry.__3(f));
end end

function everyU(arr, b) do
  len = #arr;
  arr_1 = arr;
  _i = 0;
  b_1 = b;
  len_1 = len;
  while(true) do
    i = _i;
    if (i == len_1) then do
      return true;
    end else if (b_1(arr_1[i])) then do
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return false;
    end end  end 
  end;
end end

function every(arr, f) do
  return everyU(arr, Curry.__1(f));
end end

function someU(arr, b) do
  len = #arr;
  arr_1 = arr;
  _i = 0;
  b_1 = b;
  len_1 = len;
  while(true) do
    i = _i;
    if (i == len_1) then do
      return false;
    end else if (b_1(arr_1[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function some(arr, f) do
  return someU(arr, Curry.__1(f));
end end

function everyAux2(arr1, arr2, _i, b, len) do
  while(true) do
    i = _i;
    if (i == len) then do
      return true;
    end else if (b(arr1[i], arr2[i])) then do
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return false;
    end end  end 
  end;
end end

function every2U(a, b, p) do
  return everyAux2(a, b, 0, p, Caml_primitive.caml_int_min(#a, #b));
end end

function every2(a, b, p) do
  return every2U(a, b, Curry.__2(p));
end end

function some2U(a, b, p) do
  arr1 = a;
  arr2 = b;
  _i = 0;
  b_1 = p;
  len = Caml_primitive.caml_int_min(#a, #b);
  while(true) do
    i = _i;
    if (i == len) then do
      return false;
    end else if (b_1(arr1[i], arr2[i])) then do
      return true;
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function some2(a, b, p) do
  return some2U(a, b, Curry.__2(p));
end end

function eqU(a, b, p) do
  lena = #a;
  lenb = #b;
  if (lena == lenb) then do
    return everyAux2(a, b, 0, p, lena);
  end else do
    return false;
  end end 
end end

function eq(a, b, p) do
  return eqU(a, b, Curry.__2(p));
end end

function cmpU(a, b, p) do
  lena = #a;
  lenb = #b;
  if (lena > lenb) then do
    return 1;
  end else if (lena < lenb) then do
    return -1;
  end else do
    arr1 = a;
    arr2 = b;
    _i = 0;
    b_1 = p;
    len = lena;
    while(true) do
      i = _i;
      if (i == len) then do
        return 0;
      end else do
        c = b_1(arr1[i], arr2[i]);
        if (c == 0) then do
          _i = i + 1 | 0;
          ::continue:: ;
        end else do
          return c;
        end end 
      end end 
    end;
  end end  end 
end end

function cmp(a, b, p) do
  return cmpU(a, b, Curry.__2(p));
end end

function partitionU(a, f) do
  l = #a;
  i = 0;
  j = 0;
  a1 = new Array(l);
  a2 = new Array(l);
  for ii = 0 , l - 1 | 0 , 1 do
    v = a[ii];
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
  return --[[ tuple ]]{
          a1,
          a2
        };
end end

function partition(a, f) do
  return partitionU(a, Curry.__1(f));
end end

function unzip(a) do
  l = #a;
  a1 = new Array(l);
  a2 = new Array(l);
  for i = 0 , l - 1 | 0 , 1 do
    match = a[i];
    a1[i] = match[0];
    a2[i] = match[1];
  end
  return --[[ tuple ]]{
          a1,
          a2
        };
end end

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
--[[ No side effect ]]
