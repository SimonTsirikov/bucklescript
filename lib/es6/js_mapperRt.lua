


function binarySearch(upper, id, array) do
  _lower = 0;
  _upper = upper;
  xs = array;
  k = id;
  while(true) do
    upper_1 = _upper;
    lower = _lower;
    if (lower >= upper_1) then do
      error(new Error("binarySearchAux"))
    end
     end 
    mid = (lower + upper_1 | 0) / 2 | 0;
    match = xs[mid];
    i = match[0];
    if (i == k) then do
      return match[1];
    end else if (i < k) then do
      _lower = mid + 1 | 0;
      ::continue:: ;
    end else do
      _upper = mid;
      ::continue:: ;
    end end  end 
  end;
end end

function revSearch(len, array, x) do
  _i = 0;
  len_1 = len;
  xs = array;
  k = x;
  while(true) do
    i = _i;
    if (i == len_1) then do
      return ;
    end else do
      match = xs[i];
      if (match[1] == k) then do
        return match[0];
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end 
    end end 
  end;
end end

function revSearchAssert(len, array, x) do
  len_1 = len;
  _i = 0;
  xs = array;
  k = x;
  while(true) do
    i = _i;
    if (i >= len_1) then do
      error(new Error("File \"js_mapperRt.ml\", line 63, characters 4-10"))
    end
     end 
    match = xs[i];
    if (match[1] == k) then do
      return match[0];
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function toInt(i, xs) do
  return xs[i];
end end

function fromInt(len, xs, __enum) do
  __enum_1 = __enum;
  _i = 0;
  len_1 = len;
  xs_1 = xs;
  while(true) do
    i = _i;
    if (i == len_1) then do
      return ;
    end else do
      k = xs_1[i];
      if (k == __enum_1) then do
        return i;
      end else do
        _i = i + 1 | 0;
        ::continue:: ;
      end end 
    end end 
  end;
end end

function fromIntAssert(len, xs, __enum) do
  len_1 = len;
  __enum_1 = __enum;
  _i = 0;
  xs_1 = xs;
  while(true) do
    i = _i;
    if (i >= len_1) then do
      error(new Error("File \"js_mapperRt.ml\", line 87, characters 4-10"))
    end
     end 
    k = xs_1[i];
    if (k == __enum_1) then do
      return i;
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

export do
  binarySearch ,
  revSearch ,
  revSearchAssert ,
  toInt ,
  fromInt ,
  fromIntAssert ,
  
end
--[[ No side effect ]]
