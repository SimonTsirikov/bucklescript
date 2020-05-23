'use strict';

var Curry = require("./curry.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function merge(order, l1, l2) do
  if (l1) do
    if (l2) do
      var h2 = l2[0];
      var h1 = l1[0];
      if (Curry._2(order, h1, h2)) do
        return --[ :: ]--[
                h1,
                merge(order, l1[1], l2)
              ];
      end else do
        return --[ :: ]--[
                h2,
                merge(order, l1, l2[1])
              ];
      end
    end else do
      return l1;
    end
  end else do
    return l2;
  end
end

function list(order, l) do
  var initlist = function (param) do
    if (param) do
      var match = param[1];
      var e = param[0];
      if (match) do
        var e2 = match[0];
        return --[ :: ]--[
                Curry._2(order, e, e2) ? --[ :: ]--[
                    e,
                    --[ :: ]--[
                      e2,
                      --[ [] ]--0
                    ]
                  ] : --[ :: ]--[
                    e2,
                    --[ :: ]--[
                      e,
                      --[ [] ]--0
                    ]
                  ],
                initlist(match[1])
              ];
      end else do
        return --[ :: ]--[
                --[ :: ]--[
                  e,
                  --[ [] ]--0
                ],
                --[ [] ]--0
              ];
      end
    end else do
      return --[ [] ]--0;
    end
  end;
  var merge2 = function (x) do
    if (x) do
      var match = x[1];
      if (match) do
        return --[ :: ]--[
                merge(order, x[0], match[0]),
                merge2(match[1])
              ];
      end else do
        return x;
      end
    end else do
      return x;
    end
  end;
  var _llist = initlist(l);
  while(true) do
    var llist = _llist;
    if (llist) do
      if (llist[1]) do
        _llist = merge2(llist);
        continue ;
      end else do
        return llist[0];
      end
    end else do
      return --[ [] ]--0;
    end
  end;
end

function swap(arr, i, j) do
  var tmp = arr[i];
  arr[i] = arr[j];
  arr[j] = tmp;
  return --[ () ]--0;
end

function array(cmp, arr) do
  var qsort = function (_lo, _hi) do
    while(true) do
      var hi = _hi;
      var lo = _lo;
      if ((hi - lo | 0) >= 6) do
        var mid = ((lo + hi | 0) >>> 1);
        if (Curry._2(cmp, arr[mid], arr[lo])) do
          swap(arr, mid, lo);
        end
        if (Curry._2(cmp, arr[hi], arr[mid])) do
          swap(arr, mid, hi);
          if (Curry._2(cmp, arr[mid], arr[lo])) do
            swap(arr, mid, lo);
          end
          
        end
        var pivot = arr[mid];
        var i = lo + 1 | 0;
        var j = hi - 1 | 0;
        if (!Curry._2(cmp, pivot, arr[hi]) or !Curry._2(cmp, arr[lo], pivot)) do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Sort.array"
              ];
        end
        while(i < j) do
          while(!Curry._2(cmp, pivot, arr[i])) do
            i = i + 1 | 0;
          end;
          while(!Curry._2(cmp, arr[j], pivot)) do
            j = j - 1 | 0;
          end;
          if (i < j) do
            swap(arr, i, j);
          end
          i = i + 1 | 0;
          j = j - 1 | 0;
        end;
        if ((j - lo | 0) <= (hi - i | 0)) do
          qsort(lo, j);
          _lo = i;
          continue ;
        end else do
          qsort(i, hi);
          _hi = j;
          continue ;
        end
      end else do
        return 0;
      end
    end;
  end;
  qsort(0, #arr - 1 | 0);
  for(var i = 1 ,i_finish = #arr - 1 | 0; i <= i_finish; ++i)do
    var val_i = arr[i];
    if (!Curry._2(cmp, arr[i - 1 | 0], val_i)) do
      arr[i] = arr[i - 1 | 0];
      var j = i - 1 | 0;
      while(j >= 1 and !Curry._2(cmp, arr[j - 1 | 0], val_i)) do
        arr[j] = arr[j - 1 | 0];
        j = j - 1 | 0;
      end;
      arr[j] = val_i;
    end
    
  end
  return --[ () ]--0;
end

exports.list = list;
exports.array = array;
exports.merge = merge;
--[ No side effect ]--
