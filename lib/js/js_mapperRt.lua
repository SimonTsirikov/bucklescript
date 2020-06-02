--[['use strict';]]


function binarySearch(upper, id, array) do
  _lower = 0;
  _upper = upper;
  xs = array;
  k = id;
  while(true) do
    upper$1 = _upper;
    lower = _lower;
    if (lower >= upper$1) then do
      throw new Error("binarySearchAux");
    end
     end 
    mid = (lower + upper$1 | 0) / 2 | 0;
    match = xs[mid];
    i = match[0];
    if (i == k) then do
      return match[1];
    end else if (i < k) then do
      _lower = mid + 1 | 0;
      continue ;
    end else do
      _upper = mid;
      continue ;
    end end  end 
  end;
end end

function revSearch(len, array, x) do
  _i = 0;
  len$1 = len;
  xs = array;
  k = x;
  while(true) do
    i = _i;
    if (i == len$1) then do
      return ;
    end else do
      match = xs[i];
      if (match[1] == k) then do
        return match[0];
      end else do
        _i = i + 1 | 0;
        continue ;
      end end 
    end end 
  end;
end end

function revSearchAssert(len, array, x) do
  len$1 = len;
  _i = 0;
  xs = array;
  k = x;
  while(true) do
    i = _i;
    if (i >= len$1) then do
      throw new Error("File \"js_mapperRt.ml\", line 63, characters 4-10");
    end
     end 
    match = xs[i];
    if (match[1] == k) then do
      return match[0];
    end else do
      _i = i + 1 | 0;
      continue ;
    end end 
  end;
end end

function toInt(i, xs) do
  return xs[i];
end end

function fromInt(len, xs, __enum) do
  __enum$1 = __enum;
  _i = 0;
  len$1 = len;
  xs$1 = xs;
  while(true) do
    i = _i;
    if (i == len$1) then do
      return ;
    end else do
      k = xs$1[i];
      if (k == __enum$1) then do
        return i;
      end else do
        _i = i + 1 | 0;
        continue ;
      end end 
    end end 
  end;
end end

function fromIntAssert(len, xs, __enum) do
  len$1 = len;
  __enum$1 = __enum;
  _i = 0;
  xs$1 = xs;
  while(true) do
    i = _i;
    if (i >= len$1) then do
      throw new Error("File \"js_mapperRt.ml\", line 87, characters 4-10");
    end
     end 
    k = xs$1[i];
    if (k == __enum$1) then do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end 
  end;
end end

exports.binarySearch = binarySearch;
exports.revSearch = revSearch;
exports.revSearchAssert = revSearchAssert;
exports.toInt = toInt;
exports.fromInt = fromInt;
exports.fromIntAssert = fromIntAssert;
--[[ No side effect ]]
