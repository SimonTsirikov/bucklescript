

import * as Curry from "./curry.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function merge(order, l1, l2) do
  if (l1) then do
    if (l2) then do
      h2 = l2[0];
      h1 = l1[0];
      if (Curry._2(order, h1, h2)) then do
        return --[[ :: ]]{
                h1,
                merge(order, l1[1], l2)
              };
      end else do
        return --[[ :: ]]{
                h2,
                merge(order, l1, l2[1])
              };
      end end 
    end else do
      return l1;
    end end 
  end else do
    return l2;
  end end 
end end

function list(order, l) do
  initlist = function (param) do
    if (param) then do
      match = param[1];
      e = param[0];
      if (match) then do
        e2 = match[0];
        return --[[ :: ]]{
                Curry._2(order, e, e2) and --[[ :: ]]{
                    e,
                    --[[ :: ]]{
                      e2,
                      --[[ [] ]]0
                    }
                  } or --[[ :: ]]{
                    e2,
                    --[[ :: ]]{
                      e,
                      --[[ [] ]]0
                    }
                  },
                initlist(match[1])
              };
      end else do
        return --[[ :: ]]{
                --[[ :: ]]{
                  e,
                  --[[ [] ]]0
                },
                --[[ [] ]]0
              };
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end end;
  merge2 = function (x) do
    if (x) then do
      match = x[1];
      if (match) then do
        return --[[ :: ]]{
                merge(order, x[0], match[0]),
                merge2(match[1])
              };
      end else do
        return x;
      end end 
    end else do
      return x;
    end end 
  end end;
  _llist = initlist(l);
  while(true) do
    llist = _llist;
    if (llist) then do
      if (llist[1]) then do
        _llist = merge2(llist);
        ::continue:: ;
      end else do
        return llist[0];
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function swap(arr, i, j) do
  tmp = arr[i];
  arr[i] = arr[j];
  arr[j] = tmp;
  return --[[ () ]]0;
end end

function array(cmp, arr) do
  qsort = function (_lo, _hi) do
    while(true) do
      hi = _hi;
      lo = _lo;
      if ((hi - lo | 0) >= 6) then do
        mid = ((lo + hi | 0) >>> 1);
        if (Curry._2(cmp, arr[mid], arr[lo])) then do
          swap(arr, mid, lo);
        end
         end 
        if (Curry._2(cmp, arr[hi], arr[mid])) then do
          swap(arr, mid, hi);
          if (Curry._2(cmp, arr[mid], arr[lo])) then do
            swap(arr, mid, lo);
          end
           end 
        end
         end 
        pivot = arr[mid];
        i = lo + 1 | 0;
        j = hi - 1 | 0;
        if (not Curry._2(cmp, pivot, arr[hi]) or not Curry._2(cmp, arr[lo], pivot)) then do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "Sort.array"
          })
        end
         end 
        while(i < j) do
          while(not Curry._2(cmp, pivot, arr[i])) do
            i = i + 1 | 0;
          end;
          while(not Curry._2(cmp, arr[j], pivot)) do
            j = j - 1 | 0;
          end;
          if (i < j) then do
            swap(arr, i, j);
          end
           end 
          i = i + 1 | 0;
          j = j - 1 | 0;
        end;
        if ((j - lo | 0) <= (hi - i | 0)) then do
          qsort(lo, j);
          _lo = i;
          ::continue:: ;
        end else do
          qsort(i, hi);
          _hi = j;
          ::continue:: ;
        end end 
      end else do
        return 0;
      end end 
    end;
  end end;
  qsort(0, #arr - 1 | 0);
  for i = 1 , #arr - 1 | 0 , 1 do
    val_i = arr[i];
    if (not Curry._2(cmp, arr[i - 1 | 0], val_i)) then do
      arr[i] = arr[i - 1 | 0];
      j = i - 1 | 0;
      while(j >= 1 and not Curry._2(cmp, arr[j - 1 | 0], val_i)) do
        arr[j] = arr[j - 1 | 0];
        j = j - 1 | 0;
      end;
      arr[j] = val_i;
    end
     end 
  end
  return --[[ () ]]0;
end end

export do
  list ,
  array ,
  merge ,
  
end
--[[ No side effect ]]
