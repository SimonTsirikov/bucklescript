'use strict';

var Curry = require("./curry.js");
var Belt_Array = require("./belt_Array.js");

function sortedLengthAuxMore(xs, _prec, _acc, len, lt) do
  while(true) do
    var acc = _acc;
    var prec = _prec;
    if (acc >= len) then do
      return acc;
    end else do
      var v = xs[acc];
      if (lt(v, prec)) then do
        _acc = acc + 1 | 0;
        _prec = v;
        continue ;
      end else do
        return acc;
      end end 
    end end 
  end;
end

function strictlySortedLengthU(xs, lt) do
  var len = #xs;
  if (len == 0 or len == 1) then do
    return len;
  end else do
    var x0 = xs[0];
    var x1 = xs[1];
    if (lt(x0, x1)) then do
      var xs$1 = xs;
      var _prec = x1;
      var _acc = 2;
      var len$1 = len;
      var lt$1 = lt;
      while(true) do
        var acc = _acc;
        var prec = _prec;
        if (acc >= len$1) then do
          return acc;
        end else do
          var v = xs$1[acc];
          if (lt$1(prec, v)) then do
            _acc = acc + 1 | 0;
            _prec = v;
            continue ;
          end else do
            return acc;
          end end 
        end end 
      end;
    end else if (lt(x1, x0)) then do
      return -sortedLengthAuxMore(xs, x1, 2, len, lt) | 0;
    end else do
      return 1;
    end end  end 
  end end 
end

function strictlySortedLength(xs, lt) do
  return strictlySortedLengthU(xs, Curry.__2(lt));
end

function isSortedU(a, cmp) do
  var len = #a;
  if (len == 0) then do
    return true;
  end else do
    var a$1 = a;
    var _i = 0;
    var cmp$1 = cmp;
    var last_bound = len - 1 | 0;
    while(true) do
      var i = _i;
      if (i == last_bound) then do
        return true;
      end else if (cmp$1(a$1[i], a$1[i + 1 | 0]) <= 0) then do
        _i = i + 1 | 0;
        continue ;
      end else do
        return false;
      end end  end 
    end;
  end end 
end

function isSorted(a, cmp) do
  return isSortedU(a, Curry.__2(cmp));
end

function merge(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  var src1r = src1ofs + src1len | 0;
  var src2r = src2ofs + src2len | 0;
  var _i1 = src1ofs;
  var _s1 = src[src1ofs];
  var _i2 = src2ofs;
  var _s2 = src2[src2ofs];
  var _d = dstofs;
  while(true) do
    var d = _d;
    var s2 = _s2;
    var i2 = _i2;
    var s1 = _s1;
    var i1 = _i1;
    if (cmp(s1, s2) <= 0) then do
      dst[d] = s1;
      var i1$1 = i1 + 1 | 0;
      if (i1$1 < src1r) then do
        _d = d + 1 | 0;
        _s1 = src[i1$1];
        _i1 = i1$1;
        continue ;
      end else do
        return Belt_Array.blitUnsafe(src2, i2, dst, d + 1 | 0, src2r - i2 | 0);
      end end 
    end else do
      dst[d] = s2;
      var i2$1 = i2 + 1 | 0;
      if (i2$1 < src2r) then do
        _d = d + 1 | 0;
        _s2 = src2[i2$1];
        _i2 = i2$1;
        continue ;
      end else do
        return Belt_Array.blitUnsafe(src, i1, dst, d + 1 | 0, src1r - i1 | 0);
      end end 
    end end 
  end;
end

function unionU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  var src1r = src1ofs + src1len | 0;
  var src2r = src2ofs + src2len | 0;
  var _i1 = src1ofs;
  var _s1 = src[src1ofs];
  var _i2 = src2ofs;
  var _s2 = src2[src2ofs];
  var _d = dstofs;
  while(true) do
    var d = _d;
    var s2 = _s2;
    var i2 = _i2;
    var s1 = _s1;
    var i1 = _i1;
    var c = cmp(s1, s2);
    if (c < 0) then do
      dst[d] = s1;
      var i1$1 = i1 + 1 | 0;
      var d$1 = d + 1 | 0;
      if (i1$1 < src1r) then do
        _d = d$1;
        _s1 = src[i1$1];
        _i1 = i1$1;
        continue ;
      end else do
        Belt_Array.blitUnsafe(src2, i2, dst, d$1, src2r - i2 | 0);
        return (d$1 + src2r | 0) - i2 | 0;
      end end 
    end else if (c == 0) then do
      dst[d] = s1;
      var i1$2 = i1 + 1 | 0;
      var i2$1 = i2 + 1 | 0;
      var d$2 = d + 1 | 0;
      if (i1$2 < src1r and i2$1 < src2r) then do
        _d = d$2;
        _s2 = src2[i2$1];
        _i2 = i2$1;
        _s1 = src[i1$2];
        _i1 = i1$2;
        continue ;
      end else if (i1$2 == src1r) then do
        Belt_Array.blitUnsafe(src2, i2$1, dst, d$2, src2r - i2$1 | 0);
        return (d$2 + src2r | 0) - i2$1 | 0;
      end else do
        Belt_Array.blitUnsafe(src, i1$2, dst, d$2, src1r - i1$2 | 0);
        return (d$2 + src1r | 0) - i1$2 | 0;
      end end  end 
    end else do
      dst[d] = s2;
      var i2$2 = i2 + 1 | 0;
      var d$3 = d + 1 | 0;
      if (i2$2 < src2r) then do
        _d = d$3;
        _s2 = src2[i2$2];
        _i2 = i2$2;
        continue ;
      end else do
        Belt_Array.blitUnsafe(src, i1, dst, d$3, src1r - i1 | 0);
        return (d$3 + src1r | 0) - i1 | 0;
      end end 
    end end  end 
  end;
end

function union(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  return unionU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, Curry.__2(cmp));
end

function intersectU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  var src1r = src1ofs + src1len | 0;
  var src2r = src2ofs + src2len | 0;
  var _i1 = src1ofs;
  var _s1 = src[src1ofs];
  var _i2 = src2ofs;
  var _s2 = src2[src2ofs];
  var _d = dstofs;
  while(true) do
    var d = _d;
    var s2 = _s2;
    var i2 = _i2;
    var s1 = _s1;
    var i1 = _i1;
    var c = cmp(s1, s2);
    if (c < 0) then do
      var i1$1 = i1 + 1 | 0;
      if (i1$1 < src1r) then do
        _s1 = src[i1$1];
        _i1 = i1$1;
        continue ;
      end else do
        return d;
      end end 
    end else if (c == 0) then do
      dst[d] = s1;
      var i1$2 = i1 + 1 | 0;
      var i2$1 = i2 + 1 | 0;
      var d$1 = d + 1 | 0;
      if (i1$2 < src1r and i2$1 < src2r) then do
        _d = d$1;
        _s2 = src2[i2$1];
        _i2 = i2$1;
        _s1 = src[i1$2];
        _i1 = i1$2;
        continue ;
      end else do
        return d$1;
      end end 
    end else do
      var i2$2 = i2 + 1 | 0;
      if (i2$2 < src2r) then do
        _s2 = src2[i2$2];
        _i2 = i2$2;
        continue ;
      end else do
        return d;
      end end 
    end end  end 
  end;
end

function intersect(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  return intersectU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, Curry.__2(cmp));
end

function diffU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  var src1r = src1ofs + src1len | 0;
  var src2r = src2ofs + src2len | 0;
  var _i1 = src1ofs;
  var _s1 = src[src1ofs];
  var _i2 = src2ofs;
  var _s2 = src2[src2ofs];
  var _d = dstofs;
  while(true) do
    var d = _d;
    var s2 = _s2;
    var i2 = _i2;
    var s1 = _s1;
    var i1 = _i1;
    var c = cmp(s1, s2);
    if (c < 0) then do
      dst[d] = s1;
      var d$1 = d + 1 | 0;
      var i1$1 = i1 + 1 | 0;
      if (i1$1 < src1r) then do
        _d = d$1;
        _s1 = src[i1$1];
        _i1 = i1$1;
        continue ;
      end else do
        return d$1;
      end end 
    end else if (c == 0) then do
      var i1$2 = i1 + 1 | 0;
      var i2$1 = i2 + 1 | 0;
      if (i1$2 < src1r and i2$1 < src2r) then do
        _s2 = src2[i2$1];
        _i2 = i2$1;
        _s1 = src[i1$2];
        _i1 = i1$2;
        continue ;
      end else if (i1$2 == src1r) then do
        return d;
      end else do
        Belt_Array.blitUnsafe(src, i1$2, dst, d, src1r - i1$2 | 0);
        return (d + src1r | 0) - i1$2 | 0;
      end end  end 
    end else do
      var i2$2 = i2 + 1 | 0;
      if (i2$2 < src2r) then do
        _s2 = src2[i2$2];
        _i2 = i2$2;
        continue ;
      end else do
        Belt_Array.blitUnsafe(src, i1, dst, d, src1r - i1 | 0);
        return (d + src1r | 0) - i1 | 0;
      end end 
    end end  end 
  end;
end

function diff(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, cmp) do
  return diffU(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs, Curry.__2(cmp));
end

function insertionSort(src, srcofs, dst, dstofs, len, cmp) do
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    var e = src[srcofs + i | 0];
    var j = (dstofs + i | 0) - 1 | 0;
    while(j >= dstofs and cmp(dst[j], e) > 0) do
      dst[j + 1 | 0] = dst[j];
      j = j - 1 | 0;
    end;
    dst[j + 1 | 0] = e;
  end
  return --[ () ]--0;
end

function sortTo(src, srcofs, dst, dstofs, len, cmp) do
  if (len <= 5) then do
    return insertionSort(src, srcofs, dst, dstofs, len, cmp);
  end else do
    var l1 = len / 2 | 0;
    var l2 = len - l1 | 0;
    sortTo(src, srcofs + l1 | 0, dst, dstofs + l1 | 0, l2, cmp);
    sortTo(src, srcofs, src, srcofs + l2 | 0, l1, cmp);
    return merge(src, srcofs + l2 | 0, l1, dst, dstofs + l1 | 0, l2, dst, dstofs, cmp);
  end end 
end

function stableSortInPlaceByU(a, cmp) do
  var l = #a;
  if (l <= 5) then do
    return insertionSort(a, 0, a, 0, l, cmp);
  end else do
    var l1 = l / 2 | 0;
    var l2 = l - l1 | 0;
    var t = new Array(l2);
    sortTo(a, l1, t, 0, l2, cmp);
    sortTo(a, 0, a, l2, l1, cmp);
    return merge(a, l2, l1, t, 0, l2, a, 0, cmp);
  end end 
end

function stableSortInPlaceBy(a, cmp) do
  return stableSortInPlaceByU(a, Curry.__2(cmp));
end

function stableSortByU(a, cmp) do
  var b = a.slice(0);
  stableSortInPlaceByU(b, cmp);
  return b;
end

function stableSortBy(a, cmp) do
  return stableSortByU(a, Curry.__2(cmp));
end

function binarySearchByU(sorted, key, cmp) do
  var len = #sorted;
  if (len == 0) then do
    return -1;
  end else do
    var lo = sorted[0];
    var c = cmp(key, lo);
    if (c < 0) then do
      return -1;
    end else do
      var hi = sorted[len - 1 | 0];
      var c2 = cmp(key, hi);
      if (c2 > 0) then do
        return -(len + 1 | 0) | 0;
      end else do
        var arr = sorted;
        var _lo = 0;
        var _hi = len - 1 | 0;
        var key$1 = key;
        var cmp$1 = cmp;
        while(true) do
          var hi$1 = _hi;
          var lo$1 = _lo;
          var mid = (lo$1 + hi$1 | 0) / 2 | 0;
          var midVal = arr[mid];
          var c$1 = cmp$1(key$1, midVal);
          if (c$1 == 0) then do
            return mid;
          end else if (c$1 < 0) then do
            if (hi$1 == mid) then do
              if (cmp$1(arr[lo$1], key$1) == 0) then do
                return lo$1;
              end else do
                return -(hi$1 + 1 | 0) | 0;
              end end 
            end else do
              _hi = mid;
              continue ;
            end end 
          end else if (lo$1 == mid) then do
            if (cmp$1(arr[hi$1], key$1) == 0) then do
              return hi$1;
            end else do
              return -(hi$1 + 1 | 0) | 0;
            end end 
          end else do
            _lo = mid;
            continue ;
          end end  end  end 
        end;
      end end 
    end end 
  end end 
end

function binarySearchBy(sorted, key, cmp) do
  return binarySearchByU(sorted, key, Curry.__2(cmp));
end

var Int = --[ alias ]--0;

var $$String = --[ alias ]--0;

exports.Int = Int;
exports.$$String = $$String;
exports.strictlySortedLengthU = strictlySortedLengthU;
exports.strictlySortedLength = strictlySortedLength;
exports.isSortedU = isSortedU;
exports.isSorted = isSorted;
exports.stableSortInPlaceByU = stableSortInPlaceByU;
exports.stableSortInPlaceBy = stableSortInPlaceBy;
exports.stableSortByU = stableSortByU;
exports.stableSortBy = stableSortBy;
exports.binarySearchByU = binarySearchByU;
exports.binarySearchBy = binarySearchBy;
exports.unionU = unionU;
exports.union = union;
exports.intersectU = intersectU;
exports.intersect = intersect;
exports.diffU = diffU;
exports.diff = diff;
--[ No side effect ]--
