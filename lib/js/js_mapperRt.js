'use strict';


function binarySearch(upper, id, array) do
  var _lower = 0;
  var _upper = upper;
  var xs = array;
  var k = id;
  while(true) do
    var upper$1 = _upper;
    var lower = _lower;
    if (lower >= upper$1) do
      throw new Error("binarySearchAux");
    end
    var mid = (lower + upper$1 | 0) / 2 | 0;
    var match = xs[mid];
    var i = match[0];
    if (i == k) do
      return match[1];
    end else if (i < k) do
      _lower = mid + 1 | 0;
      continue ;
    end else do
      _upper = mid;
      continue ;
    end
  end;
end

function revSearch(len, array, x) do
  var _i = 0;
  var len$1 = len;
  var xs = array;
  var k = x;
  while(true) do
    var i = _i;
    if (i == len$1) do
      return ;
    end else do
      var match = xs[i];
      if (match[1] == k) do
        return match[0];
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end
  end;
end

function revSearchAssert(len, array, x) do
  var len$1 = len;
  var _i = 0;
  var xs = array;
  var k = x;
  while(true) do
    var i = _i;
    if (i >= len$1) do
      throw new Error("File \"js_mapperRt.ml\", line 63, characters 4-10");
    end
    var match = xs[i];
    if (match[1] == k) do
      return match[0];
    end else do
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

function toInt(i, xs) do
  return xs[i];
end

function fromInt(len, xs, $$enum) do
  var $$enum$1 = $$enum;
  var _i = 0;
  var len$1 = len;
  var xs$1 = xs;
  while(true) do
    var i = _i;
    if (i == len$1) do
      return ;
    end else do
      var k = xs$1[i];
      if (k == $$enum$1) do
        return i;
      end else do
        _i = i + 1 | 0;
        continue ;
      end
    end
  end;
end

function fromIntAssert(len, xs, $$enum) do
  var len$1 = len;
  var $$enum$1 = $$enum;
  var _i = 0;
  var xs$1 = xs;
  while(true) do
    var i = _i;
    if (i >= len$1) do
      throw new Error("File \"js_mapperRt.ml\", line 87, characters 4-10");
    end
    var k = xs$1[i];
    if (k == $$enum$1) do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

exports.binarySearch = binarySearch;
exports.revSearch = revSearch;
exports.revSearchAssert = revSearchAssert;
exports.toInt = toInt;
exports.fromInt = fromInt;
exports.fromIntAssert = fromIntAssert;
--[ No side effect ]--
