

local Curry = require "..curry.lua";
local Caml_obj = require "..caml_obj.lua";
local Pervasives = require "..pervasives.lua";
local Caml_option = require "..caml_option.lua";
local Caml_builtin_exceptions = require "..caml_builtin_exceptions.lua";

function length(l) do
  _len = 0;
  _param = l;
  while(true) do
    param = _param;
    len = _len;
    if (param) then do
      _param = param[2];
      _len = len + 1 | 0;
      ::continue:: ;
    end else do
      return len;
    end end 
  end;
end end

function cons(a, l) do
  return --[[ :: ]]{
          a,
          l
        };
end end

function hd(param) do
  if (param) then do
    return param[1];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "hd"
    })
  end end 
end end

function tl(param) do
  if (param) then do
    return param[2];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "tl"
    })
  end end 
end end

function nth(l, n) do
  if (n < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "List.nth"
    })
  end
   end 
  _l = l;
  _n = n;
  while(true) do
    n_1 = _n;
    l_1 = _l;
    if (l_1) then do
      if (n_1 == 0) then do
        return l_1[1];
      end else do
        _n = n_1 - 1 | 0;
        _l = l_1[2];
        ::continue:: ;
      end end 
    end else do
      error({
        Caml_builtin_exceptions.failure,
        "nth"
      })
    end end 
  end;
end end

function nth_opt(l, n) do
  if (n < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "List.nth"
    })
  end
   end 
  _l = l;
  _n = n;
  while(true) do
    n_1 = _n;
    l_1 = _l;
    if (l_1) then do
      if (n_1 == 0) then do
        return Caml_option.some(l_1[1]);
      end else do
        _n = n_1 - 1 | 0;
        _l = l_1[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function rev_append(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      _l2 = --[[ :: ]]{
        l1[1],
        l2
      };
      _l1 = l1[2];
      ::continue:: ;
    end else do
      return l2;
    end end 
  end;
end end

function rev(l) do
  return rev_append(l, --[[ [] ]]0);
end end

function init_tailrec_aux(_acc, _i, n, f) do
  while(true) do
    i = _i;
    acc = _acc;
    if (i >= n) then do
      return acc;
    end else do
      _i = i + 1 | 0;
      _acc = --[[ :: ]]{
        Curry._1(f, i),
        acc
      };
      ::continue:: ;
    end end 
  end;
end end

function init_aux(i, n, f) do
  if (i >= n) then do
    return --[[ [] ]]0;
  end else do
    r = Curry._1(f, i);
    return --[[ :: ]]{
            r,
            init_aux(i + 1 | 0, n, f)
          };
  end end 
end end

function init(len, f) do
  if (len < 0) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "List.init"
    })
  end
   end 
  if (len > 10000) then do
    return rev_append(init_tailrec_aux(--[[ [] ]]0, 0, len, f), --[[ [] ]]0);
  end else do
    return init_aux(0, len, f);
  end end 
end end

function flatten(param) do
  if (param) then do
    return Pervasives._at(param[1], flatten(param[2]));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function map(f, param) do
  if (param) then do
    r = Curry._1(f, param[1]);
    return --[[ :: ]]{
            r,
            map(f, param[2])
          };
  end else do
    return --[[ [] ]]0;
  end end 
end end

function mapi(i, f, param) do
  if (param) then do
    r = Curry._2(f, i, param[1]);
    return --[[ :: ]]{
            r,
            mapi(i + 1 | 0, f, param[2])
          };
  end else do
    return --[[ [] ]]0;
  end end 
end end

function mapi_1(f, l) do
  return mapi(0, f, l);
end end

function rev_map(f, l) do
  _accu = --[[ [] ]]0;
  _param = l;
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[2];
      _accu = --[[ :: ]]{
        Curry._1(f, param[1]),
        accu
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      Curry._1(f, param[1]);
      _param = param[2];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function iteri(f, l) do
  _i = 0;
  f_1 = f;
  _param = l;
  while(true) do
    param = _param;
    i = _i;
    if (param) then do
      Curry._2(f_1, i, param[1]);
      _param = param[2];
      _i = i + 1 | 0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fold_left(f, _accu, _l) do
  while(true) do
    l = _l;
    accu = _accu;
    if (l) then do
      _l = l[2];
      _accu = Curry._2(f, accu, l[1]);
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function fold_right(f, l, accu) do
  if (l) then do
    return Curry._2(f, l[1], fold_right(f, l[2], accu));
  end else do
    return accu;
  end end 
end end

function map2(f, l1, l2) do
  if (l1) then do
    if (l2) then do
      r = Curry._2(f, l1[1], l2[1]);
      return --[[ :: ]]{
              r,
              map2(f, l1[2], l2[2])
            };
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.map2"
      })
    end end 
  end else if (l2) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "List.map2"
    })
  end else do
    return --[[ [] ]]0;
  end end  end 
end end

function rev_map2(f, l1, l2) do
  _accu = --[[ [] ]]0;
  _l1 = l1;
  _l2 = l2;
  while(true) do
    l2_1 = _l2;
    l1_1 = _l1;
    accu = _accu;
    if (l1_1) then do
      if (l2_1) then do
        _l2 = l2_1[2];
        _l1 = l1_1[2];
        _accu = --[[ :: ]]{
          Curry._2(f, l1_1[1], l2_1[1]),
          accu
        };
        ::continue:: ;
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.rev_map2"
        })
      end end 
    end else do
      if (l2_1) then do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.rev_map2"
        })
      end
       end 
      return accu;
    end end 
  end;
end end

function iter2(f, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        Curry._2(f, l1[1], l2[1]);
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.iter2"
        })
      end end 
    end else if (l2) then do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.iter2"
      })
    end else do
      return --[[ () ]]0;
    end end  end 
  end;
end end

function fold_left2(f, _accu, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    accu = _accu;
    if (l1) then do
      if (l2) then do
        _l2 = l2[2];
        _l1 = l1[2];
        _accu = Curry._3(f, accu, l1[1], l2[1]);
        ::continue:: ;
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.fold_left2"
        })
      end end 
    end else do
      if (l2) then do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.fold_left2"
        })
      end
       end 
      return accu;
    end end 
  end;
end end

function fold_right2(f, l1, l2, accu) do
  if (l1) then do
    if (l2) then do
      return Curry._3(f, l1[1], l2[1], fold_right2(f, l1[2], l2[2], accu));
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.fold_right2"
      })
    end end 
  end else do
    if (l2) then do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.fold_right2"
      })
    end
     end 
    return accu;
  end end 
end end

function for_all(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[1])) then do
        _param = param[2];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[1])) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function for_all2(p, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        if (Curry._2(p, l1[1], l2[1])) then do
          _l2 = l2[2];
          _l1 = l1[2];
          ::continue:: ;
        end else do
          return false;
        end end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.for_all2"
        })
      end end 
    end else if (l2) then do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.for_all2"
      })
    end else do
      return true;
    end end  end 
  end;
end end

function exists2(p, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        if (Curry._2(p, l1[1], l2[1])) then do
          return true;
        end else do
          _l2 = l2[2];
          _l1 = l1[2];
          ::continue:: ;
        end end 
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "List.exists2"
        })
      end end 
    end else if (l2) then do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.exists2"
      })
    end else do
      return false;
    end end  end 
  end;
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Caml_obj.caml_equal(param[1], x)) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function memq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (param[1] == x) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function assoc(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      if (Caml_obj.caml_equal(match[1], x)) then do
        return match[2];
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function assoc_opt(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      if (Caml_obj.caml_equal(match[1], x)) then do
        return Caml_option.some(match[2]);
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function assq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      if (match[1] == x) then do
        return match[2];
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function assq_opt(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      if (match[1] == x) then do
        return Caml_option.some(match[2]);
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function mem_assoc(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Caml_obj.caml_equal(param[1][1], x)) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function mem_assq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (param[1][1] == x) then do
        return true;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function remove_assoc(x, param) do
  if (param) then do
    l = param[2];
    pair = param[1];
    if (Caml_obj.caml_equal(pair[1], x)) then do
      return l;
    end else do
      return --[[ :: ]]{
              pair,
              remove_assoc(x, l)
            };
    end end 
  end else do
    return --[[ [] ]]0;
  end end 
end end

function remove_assq(x, param) do
  if (param) then do
    l = param[2];
    pair = param[1];
    if (pair[1] == x) then do
      return l;
    end else do
      return --[[ :: ]]{
              pair,
              remove_assq(x, l)
            };
    end end 
  end else do
    return --[[ [] ]]0;
  end end 
end end

function find(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      x = param[1];
      if (Curry._1(p, x)) then do
        return x;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_opt(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      x = param[1];
      if (Curry._1(p, x)) then do
        return Caml_option.some(x);
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_all(p) do
  return (function(param) do
      _accu = --[[ [] ]]0;
      _param = param;
      while(true) do
        param_1 = _param;
        accu = _accu;
        if (param_1) then do
          l = param_1[2];
          x = param_1[1];
          if (Curry._1(p, x)) then do
            _param = l;
            _accu = --[[ :: ]]{
              x,
              accu
            };
            ::continue:: ;
          end else do
            _param = l;
            ::continue:: ;
          end end 
        end else do
          return rev_append(accu, --[[ [] ]]0);
        end end 
      end;
    end end);
end end

function partition(p, l) do
  _yes = --[[ [] ]]0;
  _no = --[[ [] ]]0;
  _param = l;
  while(true) do
    param = _param;
    no = _no;
    yes = _yes;
    if (param) then do
      l_1 = param[2];
      x = param[1];
      if (Curry._1(p, x)) then do
        _param = l_1;
        _yes = --[[ :: ]]{
          x,
          yes
        };
        ::continue:: ;
      end else do
        _param = l_1;
        _no = --[[ :: ]]{
          x,
          no
        };
        ::continue:: ;
      end end 
    end else do
      return --[[ tuple ]]{
              rev_append(yes, --[[ [] ]]0),
              rev_append(no, --[[ [] ]]0)
            };
    end end 
  end;
end end

function split(param) do
  if (param) then do
    match = param[1];
    match_1 = split(param[2]);
    return --[[ tuple ]]{
            --[[ :: ]]{
              match[1],
              match_1[1]
            },
            --[[ :: ]]{
              match[2],
              match_1[2]
            }
          };
  end else do
    return --[[ tuple ]]{
            --[[ [] ]]0,
            --[[ [] ]]0
          };
  end end 
end end

function combine(l1, l2) do
  if (l1) then do
    if (l2) then do
      return --[[ :: ]]{
              --[[ tuple ]]{
                l1[1],
                l2[1]
              },
              combine(l1[2], l2[2])
            };
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "List.combine"
      })
    end end 
  end else if (l2) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "List.combine"
    })
  end else do
    return --[[ [] ]]0;
  end end  end 
end end

function merge(cmp, l1, l2) do
  if (l1) then do
    if (l2) then do
      h2 = l2[1];
      h1 = l1[1];
      if (Curry._2(cmp, h1, h2) <= 0) then do
        return --[[ :: ]]{
                h1,
                merge(cmp, l1[2], l2)
              };
      end else do
        return --[[ :: ]]{
                h2,
                merge(cmp, l1, l2[2])
              };
      end end 
    end else do
      return l1;
    end end 
  end else do
    return l2;
  end end 
end end

function chop(_k, _l) do
  while(true) do
    l = _l;
    k = _k;
    if (k == 0) then do
      return l;
    end else if (l) then do
      _l = l[2];
      _k = k - 1 | 0;
      ::continue:: ;
    end else do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "list.ml",
          262,
          11
        }
      })
    end end  end 
  end;
end end

function stable_sort(cmp, l) do
  sort = function(n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[2];
        if (match) then do
          match_1 = match[2];
          if (match_1) then do
            x3 = match_1[1];
            x2 = match[1];
            x1 = l[1];
            if (Curry._2(cmp, x1, x2) <= 0) then do
              if (Curry._2(cmp, x2, x3) <= 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else if (Curry._2(cmp, x1, x3) <= 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                return --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        }
                      };
              end end  end 
            end else if (Curry._2(cmp, x1, x3) <= 0) then do
              return --[[ :: ]]{
                      x2,
                      --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x3,
                          --[[ [] ]]0
                        }
                      }
                    };
            end else if (Curry._2(cmp, x2, x3) <= 0) then do
              return --[[ :: ]]{
                      x2,
                      --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      }
                    };
            end else do
              return --[[ :: ]]{
                      x3,
                      --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      }
                    };
            end end  end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match_2 = l[2];
      if (match_2) then do
        x2_1 = match_2[1];
        x1_1 = l[1];
        if (Curry._2(cmp, x1_1, x2_1) <= 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ :: ]]{
                    x2_1,
                    --[[ [] ]]0
                  }
                };
        end else do
          return --[[ :: ]]{
                  x2_1,
                  --[[ :: ]]{
                    x1_1,
                    --[[ [] ]]0
                  }
                };
        end end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = rev_sort(n1, l);
    s2 = rev_sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[[ [] ]]0;
    while(true) do
      accu = _accu;
      l2_1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2_1) then do
          h2 = l2_1[1];
          h1 = l1[1];
          if (Curry._2(cmp, h1, h2) > 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l1 = l1[2];
            ::continue:: ;
          end else do
            _accu = --[[ :: ]]{
              h2,
              accu
            };
            _l2 = l2_1[2];
            ::continue:: ;
          end end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2_1, accu);
      end end 
    end;
  end end;
  rev_sort = function(n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[2];
        if (match) then do
          match_1 = match[2];
          if (match_1) then do
            x3 = match_1[1];
            x2 = match[1];
            x1 = l[1];
            if (Curry._2(cmp, x1, x2) > 0) then do
              if (Curry._2(cmp, x2, x3) > 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else if (Curry._2(cmp, x1, x3) > 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                return --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        }
                      };
              end end  end 
            end else if (Curry._2(cmp, x1, x3) > 0) then do
              return --[[ :: ]]{
                      x2,
                      --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x3,
                          --[[ [] ]]0
                        }
                      }
                    };
            end else if (Curry._2(cmp, x2, x3) > 0) then do
              return --[[ :: ]]{
                      x2,
                      --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      }
                    };
            end else do
              return --[[ :: ]]{
                      x3,
                      --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      }
                    };
            end end  end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match_2 = l[2];
      if (match_2) then do
        x2_1 = match_2[1];
        x1_1 = l[1];
        if (Curry._2(cmp, x1_1, x2_1) > 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ :: ]]{
                    x2_1,
                    --[[ [] ]]0
                  }
                };
        end else do
          return --[[ :: ]]{
                  x2_1,
                  --[[ :: ]]{
                    x1_1,
                    --[[ [] ]]0
                  }
                };
        end end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = sort(n1, l);
    s2 = sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[[ [] ]]0;
    while(true) do
      accu = _accu;
      l2_1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2_1) then do
          h2 = l2_1[1];
          h1 = l1[1];
          if (Curry._2(cmp, h1, h2) <= 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l1 = l1[2];
            ::continue:: ;
          end else do
            _accu = --[[ :: ]]{
              h2,
              accu
            };
            _l2 = l2_1[2];
            ::continue:: ;
          end end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2_1, accu);
      end end 
    end;
  end end;
  len = length(l);
  if (len < 2) then do
    return l;
  end else do
    return sort(len, l);
  end end 
end end

function sort_uniq(cmp, l) do
  sort = function(n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[2];
        if (match) then do
          match_1 = match[2];
          if (match_1) then do
            x3 = match_1[1];
            x2 = match[1];
            x1 = l[1];
            c = Curry._2(cmp, x1, x2);
            if (c == 0) then do
              c_1 = Curry._2(cmp, x2, x3);
              if (c_1 == 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ [] ]]0
                      };
              end else if (c_1 < 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x3,
                          --[[ [] ]]0
                        }
                      };
              end else do
                return --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x2,
                          --[[ [] ]]0
                        }
                      };
              end end  end 
            end else if (c < 0) then do
              c_2 = Curry._2(cmp, x2, x3);
              if (c_2 == 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ [] ]]0
                        }
                      };
              end else if (c_2 < 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                c_3 = Curry._2(cmp, x1, x3);
                if (c_3 == 0) then do
                  return --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        };
                end else if (c_3 < 0) then do
                  return --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x3,
                            --[[ :: ]]{
                              x2,
                              --[[ [] ]]0
                            }
                          }
                        };
                end else do
                  return --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x1,
                            --[[ :: ]]{
                              x2,
                              --[[ [] ]]0
                            }
                          }
                        };
                end end  end 
              end end  end 
            end else do
              c_4 = Curry._2(cmp, x1, x3);
              if (c_4 == 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      };
              end else if (c_4 < 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                c_5 = Curry._2(cmp, x2, x3);
                if (c_5 == 0) then do
                  return --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x1,
                            --[[ [] ]]0
                          }
                        };
                end else if (c_5 < 0) then do
                  return --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ :: ]]{
                              x1,
                              --[[ [] ]]0
                            }
                          }
                        };
                end else do
                  return --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x2,
                            --[[ :: ]]{
                              x1,
                              --[[ [] ]]0
                            }
                          }
                        };
                end end  end 
              end end  end 
            end end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match_2 = l[2];
      if (match_2) then do
        x2_1 = match_2[1];
        x1_1 = l[1];
        c_6 = Curry._2(cmp, x1_1, x2_1);
        if (c_6 == 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ [] ]]0
                };
        end else if (c_6 < 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ :: ]]{
                    x2_1,
                    --[[ [] ]]0
                  }
                };
        end else do
          return --[[ :: ]]{
                  x2_1,
                  --[[ :: ]]{
                    x1_1,
                    --[[ [] ]]0
                  }
                };
        end end  end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = rev_sort(n1, l);
    s2 = rev_sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[[ [] ]]0;
    while(true) do
      accu = _accu;
      l2_1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2_1) then do
          t2 = l2_1[2];
          h2 = l2_1[1];
          t1 = l1[2];
          h1 = l1[1];
          c_7 = Curry._2(cmp, h1, h2);
          if (c_7 == 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l2 = t2;
            _l1 = t1;
            ::continue:: ;
          end else if (c_7 > 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l1 = t1;
            ::continue:: ;
          end else do
            _accu = --[[ :: ]]{
              h2,
              accu
            };
            _l2 = t2;
            ::continue:: ;
          end end  end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2_1, accu);
      end end 
    end;
  end end;
  rev_sort = function(n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[2];
        if (match) then do
          match_1 = match[2];
          if (match_1) then do
            x3 = match_1[1];
            x2 = match[1];
            x1 = l[1];
            c = Curry._2(cmp, x1, x2);
            if (c == 0) then do
              c_1 = Curry._2(cmp, x2, x3);
              if (c_1 == 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ [] ]]0
                      };
              end else if (c_1 > 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x3,
                          --[[ [] ]]0
                        }
                      };
              end else do
                return --[[ :: ]]{
                        x3,
                        --[[ :: ]]{
                          x2,
                          --[[ [] ]]0
                        }
                      };
              end end  end 
            end else if (c > 0) then do
              c_2 = Curry._2(cmp, x2, x3);
              if (c_2 == 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ [] ]]0
                        }
                      };
              end else if (c_2 > 0) then do
                return --[[ :: ]]{
                        x1,
                        --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                c_3 = Curry._2(cmp, x1, x3);
                if (c_3 == 0) then do
                  return --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x2,
                            --[[ [] ]]0
                          }
                        };
                end else if (c_3 > 0) then do
                  return --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x3,
                            --[[ :: ]]{
                              x2,
                              --[[ [] ]]0
                            }
                          }
                        };
                end else do
                  return --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x1,
                            --[[ :: ]]{
                              x2,
                              --[[ [] ]]0
                            }
                          }
                        };
                end end  end 
              end end  end 
            end else do
              c_4 = Curry._2(cmp, x1, x3);
              if (c_4 == 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ [] ]]0
                        }
                      };
              end else if (c_4 > 0) then do
                return --[[ :: ]]{
                        x2,
                        --[[ :: ]]{
                          x1,
                          --[[ :: ]]{
                            x3,
                            --[[ [] ]]0
                          }
                        }
                      };
              end else do
                c_5 = Curry._2(cmp, x2, x3);
                if (c_5 == 0) then do
                  return --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x1,
                            --[[ [] ]]0
                          }
                        };
                end else if (c_5 > 0) then do
                  return --[[ :: ]]{
                          x2,
                          --[[ :: ]]{
                            x3,
                            --[[ :: ]]{
                              x1,
                              --[[ [] ]]0
                            }
                          }
                        };
                end else do
                  return --[[ :: ]]{
                          x3,
                          --[[ :: ]]{
                            x2,
                            --[[ :: ]]{
                              x1,
                              --[[ [] ]]0
                            }
                          }
                        };
                end end  end 
              end end  end 
            end end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match_2 = l[2];
      if (match_2) then do
        x2_1 = match_2[1];
        x1_1 = l[1];
        c_6 = Curry._2(cmp, x1_1, x2_1);
        if (c_6 == 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ [] ]]0
                };
        end else if (c_6 > 0) then do
          return --[[ :: ]]{
                  x1_1,
                  --[[ :: ]]{
                    x2_1,
                    --[[ [] ]]0
                  }
                };
        end else do
          return --[[ :: ]]{
                  x2_1,
                  --[[ :: ]]{
                    x1_1,
                    --[[ [] ]]0
                  }
                };
        end end  end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = sort(n1, l);
    s2 = sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[[ [] ]]0;
    while(true) do
      accu = _accu;
      l2_1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2_1) then do
          t2 = l2_1[2];
          h2 = l2_1[1];
          t1 = l1[2];
          h1 = l1[1];
          c_7 = Curry._2(cmp, h1, h2);
          if (c_7 == 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l2 = t2;
            _l1 = t1;
            ::continue:: ;
          end else if (c_7 < 0) then do
            _accu = --[[ :: ]]{
              h1,
              accu
            };
            _l1 = t1;
            ::continue:: ;
          end else do
            _accu = --[[ :: ]]{
              h2,
              accu
            };
            _l2 = t2;
            ::continue:: ;
          end end  end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2_1, accu);
      end end 
    end;
  end end;
  len = length(l);
  if (len < 2) then do
    return l;
  end else do
    return sort(len, l);
  end end 
end end

function compare_lengths(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        _l2 = l2[2];
        _l1 = l1[2];
        ::continue:: ;
      end else do
        return 1;
      end end 
    end else if (l2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function compare_length_with(_l, _n) do
  while(true) do
    n = _n;
    l = _l;
    if (l) then do
      if (n <= 0) then do
        return 1;
      end else do
        _n = n - 1 | 0;
        _l = l[2];
        ::continue:: ;
      end end 
    end else if (n == 0) then do
      return 0;
    end else if (n > 0) then do
      return -1;
    end else do
      return 1;
    end end  end  end 
  end;
end end

append = Pervasives._at;

concat = flatten;

filter = find_all;

sort = stable_sort;

fast_sort = stable_sort;

export do
  length ,
  compare_lengths ,
  compare_length_with ,
  cons ,
  hd ,
  tl ,
  nth ,
  nth_opt ,
  rev ,
  init ,
  append ,
  rev_append ,
  concat ,
  flatten ,
  iter ,
  iteri ,
  map ,
  mapi_1 as mapi,
  rev_map ,
  fold_left ,
  fold_right ,
  iter2 ,
  map2 ,
  rev_map2 ,
  fold_left2 ,
  fold_right2 ,
  for_all ,
  exists ,
  for_all2 ,
  exists2 ,
  mem ,
  memq ,
  find ,
  find_opt ,
  filter ,
  find_all ,
  partition ,
  assoc ,
  assoc_opt ,
  assq ,
  assq_opt ,
  mem_assoc ,
  mem_assq ,
  remove_assoc ,
  remove_assq ,
  split ,
  combine ,
  sort ,
  stable_sort ,
  fast_sort ,
  sort_uniq ,
  merge ,
  
end
--[[ No side effect ]]
