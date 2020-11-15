__console = {log = print};

Belt_Array = require "..belt_Array";

function sortedLengthAuxMore(xs, _prec, _acc, len) do
  while(true) do
    acc = _acc;
    prec = _prec;
    if (acc >= len) then do
      return acc;
    end else do
      v = xs[acc];
      if (prec > v) then do
        _acc = acc + 1 | 0;
        _prec = v;
        ::continue:: ;
      end else do
        return acc;
      end end 
    end end 
  end;
end end

function strictlySortedLength(xs) do
  len = #xs;
  if (len == 0 or len == 1) then do
    return len;
  end else do
    x0 = xs[0];
    x1 = xs[1];
    if (x0 < x1) then do
      xs_1 = xs;
      _prec = x1;
      _acc = 2;
      len_1 = len;
      while(true) do
        acc = _acc;
        prec = _prec;
        if (acc >= len_1) then do
          return acc;
        end else do
          v = xs_1[acc];
          if (prec < v) then do
            _acc = acc + 1 | 0;
            _prec = v;
            ::continue:: ;
          end else do
            return acc;
          end end 
        end end 
      end;
    end else if (x0 > x1) then do
      return -sortedLengthAuxMore(xs, x1, 2, len) | 0;
    end else do
      return 1;
    end end  end 
  end end 
end end

function isSorted(a) do
  len = #a;
  if (len == 0) then do
    return true;
  end else do
    a_1 = a;
    _i = 0;
    last_bound = len - 1 | 0;
    while(true) do
      i = _i;
      if (i == last_bound) then do
        return true;
      end else if (a_1[i] <= a_1[i + 1 | 0]) then do
        _i = i + 1 | 0;
        ::continue:: ;
      end else do
        return false;
      end end  end 
    end;
  end end 
end end

function merge(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs) do
  src1r = src1ofs + src1len | 0;
  src2r = src2ofs + src2len | 0;
  _i1 = src1ofs;
  _s1 = src[src1ofs];
  _i2 = src2ofs;
  _s2 = src2[src2ofs];
  _d = dstofs;
  while(true) do
    d = _d;
    s2 = _s2;
    i2 = _i2;
    s1 = _s1;
    i1 = _i1;
    if (s1 <= s2) then do
      dst[d] = s1;
      i1_1 = i1 + 1 | 0;
      if (i1_1 < src1r) then do
        _d = d + 1 | 0;
        _s1 = src[i1_1];
        _i1 = i1_1;
        ::continue:: ;
      end else do
        return Belt_Array.blitUnsafe(src2, i2, dst, d + 1 | 0, src2r - i2 | 0);
      end end 
    end else do
      dst[d] = s2;
      i2_1 = i2 + 1 | 0;
      if (i2_1 < src2r) then do
        _d = d + 1 | 0;
        _s2 = src2[i2_1];
        _i2 = i2_1;
        ::continue:: ;
      end else do
        return Belt_Array.blitUnsafe(src, i1, dst, d + 1 | 0, src1r - i1 | 0);
      end end 
    end end 
  end;
end end

function union(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs) do
  src1r = src1ofs + src1len | 0;
  src2r = src2ofs + src2len | 0;
  _i1 = src1ofs;
  _s1 = src[src1ofs];
  _i2 = src2ofs;
  _s2 = src2[src2ofs];
  _d = dstofs;
  while(true) do
    d = _d;
    s2 = _s2;
    i2 = _i2;
    s1 = _s1;
    i1 = _i1;
    if (s1 < s2) then do
      dst[d] = s1;
      i1_1 = i1 + 1 | 0;
      d_1 = d + 1 | 0;
      if (i1_1 < src1r) then do
        _d = d_1;
        _s1 = src[i1_1];
        _i1 = i1_1;
        ::continue:: ;
      end else do
        Belt_Array.blitUnsafe(src2, i2, dst, d_1, src2r - i2 | 0);
        return (d_1 + src2r | 0) - i2 | 0;
      end end 
    end else if (s1 == s2) then do
      dst[d] = s1;
      i1_2 = i1 + 1 | 0;
      i2_1 = i2 + 1 | 0;
      d_2 = d + 1 | 0;
      if (i1_2 < src1r and i2_1 < src2r) then do
        _d = d_2;
        _s2 = src2[i2_1];
        _i2 = i2_1;
        _s1 = src[i1_2];
        _i1 = i1_2;
        ::continue:: ;
      end else if (i1_2 == src1r) then do
        Belt_Array.blitUnsafe(src2, i2_1, dst, d_2, src2r - i2_1 | 0);
        return (d_2 + src2r | 0) - i2_1 | 0;
      end else do
        Belt_Array.blitUnsafe(src, i1_2, dst, d_2, src1r - i1_2 | 0);
        return (d_2 + src1r | 0) - i1_2 | 0;
      end end  end 
    end else do
      dst[d] = s2;
      i2_2 = i2 + 1 | 0;
      d_3 = d + 1 | 0;
      if (i2_2 < src2r) then do
        _d = d_3;
        _s2 = src2[i2_2];
        _i2 = i2_2;
        ::continue:: ;
      end else do
        Belt_Array.blitUnsafe(src, i1, dst, d_3, src1r - i1 | 0);
        return (d_3 + src1r | 0) - i1 | 0;
      end end 
    end end  end 
  end;
end end

function intersect(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs) do
  src1r = src1ofs + src1len | 0;
  src2r = src2ofs + src2len | 0;
  _i1 = src1ofs;
  _s1 = src[src1ofs];
  _i2 = src2ofs;
  _s2 = src2[src2ofs];
  _d = dstofs;
  while(true) do
    d = _d;
    s2 = _s2;
    i2 = _i2;
    s1 = _s1;
    i1 = _i1;
    if (s1 < s2) then do
      i1_1 = i1 + 1 | 0;
      if (i1_1 < src1r) then do
        _s1 = src[i1_1];
        _i1 = i1_1;
        ::continue:: ;
      end else do
        return d;
      end end 
    end else if (s1 == s2) then do
      dst[d] = s1;
      i1_2 = i1 + 1 | 0;
      i2_1 = i2 + 1 | 0;
      d_1 = d + 1 | 0;
      if (i1_2 < src1r and i2_1 < src2r) then do
        _d = d_1;
        _s2 = src2[i2_1];
        _i2 = i2_1;
        _s1 = src[i1_2];
        _i1 = i1_2;
        ::continue:: ;
      end else do
        return d_1;
      end end 
    end else do
      i2_2 = i2 + 1 | 0;
      if (i2_2 < src2r) then do
        _s2 = src2[i2_2];
        _i2 = i2_2;
        ::continue:: ;
      end else do
        return d;
      end end 
    end end  end 
  end;
end end

function diff(src, src1ofs, src1len, src2, src2ofs, src2len, dst, dstofs) do
  src1r = src1ofs + src1len | 0;
  src2r = src2ofs + src2len | 0;
  _i1 = src1ofs;
  _s1 = src[src1ofs];
  _i2 = src2ofs;
  _s2 = src2[src2ofs];
  _d = dstofs;
  while(true) do
    d = _d;
    s2 = _s2;
    i2 = _i2;
    s1 = _s1;
    i1 = _i1;
    if (s1 < s2) then do
      dst[d] = s1;
      d_1 = d + 1 | 0;
      i1_1 = i1 + 1 | 0;
      if (i1_1 < src1r) then do
        _d = d_1;
        _s1 = src[i1_1];
        _i1 = i1_1;
        ::continue:: ;
      end else do
        return d_1;
      end end 
    end else if (s1 == s2) then do
      i1_2 = i1 + 1 | 0;
      i2_1 = i2 + 1 | 0;
      if (i1_2 < src1r and i2_1 < src2r) then do
        _s2 = src2[i2_1];
        _i2 = i2_1;
        _s1 = src[i1_2];
        _i1 = i1_2;
        ::continue:: ;
      end else if (i1_2 == src1r) then do
        return d;
      end else do
        Belt_Array.blitUnsafe(src, i1_2, dst, d, src1r - i1_2 | 0);
        return (d + src1r | 0) - i1_2 | 0;
      end end  end 
    end else do
      i2_2 = i2 + 1 | 0;
      if (i2_2 < src2r) then do
        _s2 = src2[i2_2];
        _i2 = i2_2;
        ::continue:: ;
      end else do
        Belt_Array.blitUnsafe(src, i1, dst, d, src1r - i1 | 0);
        return (d + src1r | 0) - i1 | 0;
      end end 
    end end  end 
  end;
end end

function insertionSort(src, srcofs, dst, dstofs, len) do
  for i = 0 , len - 1 | 0 , 1 do
    e = src[srcofs + i | 0];
    j = (dstofs + i | 0) - 1 | 0;
    while(j >= dstofs and dst[j] > e) do
      dst[j + 1 | 0] = dst[j];
      j = j - 1 | 0;
    end;
    dst[j + 1 | 0] = e;
  end
  return --[[ () ]]0;
end end

function sortTo(src, srcofs, dst, dstofs, len) do
  if (len <= 5) then do
    return insertionSort(src, srcofs, dst, dstofs, len);
  end else do
    l1 = len / 2 | 0;
    l2 = len - l1 | 0;
    sortTo(src, srcofs + l1 | 0, dst, dstofs + l1 | 0, l2);
    sortTo(src, srcofs, src, srcofs + l2 | 0, l1);
    return merge(src, srcofs + l2 | 0, l1, dst, dstofs + l1 | 0, l2, dst, dstofs);
  end end 
end end

function stableSortInPlace(a) do
  l = #a;
  if (l <= 5) then do
    return insertionSort(a, 0, a, 0, l);
  end else do
    l1 = l / 2 | 0;
    l2 = l - l1 | 0;
    t = new __Array(l2);
    sortTo(a, l1, t, 0, l2);
    sortTo(a, 0, a, l2, l1);
    return merge(a, l2, l1, t, 0, l2, a, 0);
  end end 
end end

function stableSort(a) do
  b = a.slice(0);
  stableSortInPlace(b);
  return b;
end end

function binarySearch(sorted, key) do
  len = #sorted;
  if (len == 0) then do
    return -1;
  end else do
    lo = sorted[0];
    if (key < lo) then do
      return -1;
    end else do
      hi = sorted[len - 1 | 0];
      if (key > hi) then do
        return -(len + 1 | 0) | 0;
      end else do
        arr = sorted;
        _lo = 0;
        _hi = len - 1 | 0;
        key_1 = key;
        while(true) do
          hi_1 = _hi;
          lo_1 = _lo;
          mid = (lo_1 + hi_1 | 0) / 2 | 0;
          midVal = arr[mid];
          if (key_1 == midVal) then do
            return mid;
          end else if (key_1 < midVal) then do
            if (hi_1 == mid) then do
              if (arr[lo_1] == key_1) then do
                return lo_1;
              end else do
                return -(hi_1 + 1 | 0) | 0;
              end end 
            end else do
              _hi = mid;
              ::continue:: ;
            end end 
          end else if (lo_1 == mid) then do
            if (arr[hi_1] == key_1) then do
              return hi_1;
            end else do
              return -(hi_1 + 1 | 0) | 0;
            end end 
          end else do
            _lo = mid;
            ::continue:: ;
          end end  end  end 
        end;
      end end 
    end end 
  end end 
end end

exports = {};
exports.strictlySortedLength = strictlySortedLength;
exports.isSorted = isSorted;
exports.stableSortInPlace = stableSortInPlace;
exports.stableSort = stableSort;
exports.binarySearch = binarySearch;
exports.union = union;
exports.intersect = intersect;
exports.diff = diff;
return exports;
--[[ No side effect ]]
