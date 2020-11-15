__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_primitive = require "......lib.js.caml_primitive";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function height(param) do
  if (param) then do
    return param[--[[ h ]]5];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, x, d, r) do
  hl = l and l[--[[ h ]]5] or 0;
  hr = r and r[--[[ h ]]5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]4];
      ld = l[--[[ d ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[--[[ l ]]1]), lr[--[[ v ]]2], lr[--[[ d ]]3], create(lr[--[[ r ]]4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]4];
      rd = r[--[[ d ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[[ l ]]1]), rl[--[[ v ]]2], rl[--[[ d ]]3], create(rl[--[[ r ]]4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]4];
    d = m[--[[ d ]]3];
    v = m[--[[ v ]]2];
    l = m[--[[ l ]]1];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[[ Node ]]{
                --[[ l ]]l,
                --[[ v ]]x,
                --[[ d ]]data,
                --[[ r ]]r,
                --[[ h ]]m[--[[ h ]]5]
              };
      end end 
    end else if (c < 0) then do
      ll = add(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      rr = add(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]data,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function cons_enum(_m, _e) do
  while(true) do
    e = _e;
    m = _m;
    if (m) then do
      _e = --[[ More ]]{
        m[--[[ v ]]2],
        m[--[[ d ]]3],
        m[--[[ r ]]4],
        e
      };
      _m = m[--[[ l ]]1];
      ::continue:: ;
    end else do
      return e;
    end end 
  end;
end end

function compare(cmp, m1, m2) do
  _e1 = cons_enum(m1, --[[ End ]]0);
  _e2 = cons_enum(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_int_compare(e1[1], e2[1]);
        if (c ~= 0) then do
          return c;
        end else do
          c_1 = Curry._2(cmp, e1[2], e2[2]);
          if (c_1 ~= 0) then do
            return c_1;
          end else do
            _e2 = cons_enum(e2[3], e2[4]);
            _e1 = cons_enum(e1[3], e1[4]);
            ::continue:: ;
          end end 
        end end 
      end else do
        return 1;
      end end 
    end else if (e2) then do
      return -1;
    end else do
      return 0;
    end end  end 
  end;
end end

function equal(cmp, m1, m2) do
  _e1 = cons_enum(m1, --[[ End ]]0);
  _e2 = cons_enum(m2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2 and e1[1] == e2[1] and Curry._2(cmp, e1[2], e2[2])) then do
        _e2 = cons_enum(e2[3], e2[4]);
        _e1 = cons_enum(e1[3], e1[4]);
        ::continue:: ;
      end else do
        return false;
      end end 
    end else if (e2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

function cardinal(param) do
  if (param) then do
    return (cardinal(param[--[[ l ]]1]) + 1 | 0) + cardinal(param[--[[ r ]]4]) | 0;
  end else do
    return 0;
  end end 
end end

function height_1(param) do
  if (param) then do
    return param[--[[ h ]]5];
  end else do
    return 0;
  end end 
end end

function create_1(l, x, d, r) do
  hl = height_1(l);
  hr = height_1(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal_1(l, x, d, r) do
  hl = l and l[--[[ h ]]5] or 0;
  hr = r and r[--[[ h ]]5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]4];
      ld = l[--[[ d ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height_1(ll) >= height_1(lr)) then do
        return create_1(ll, lv, ld, create_1(lr, x, d, r));
      end else if (lr) then do
        return create_1(create_1(ll, lv, ld, lr[--[[ l ]]1]), lr[--[[ v ]]2], lr[--[[ d ]]3], create_1(lr[--[[ r ]]4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]4];
      rd = r[--[[ d ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height_1(rr) >= height_1(rl)) then do
        return create_1(create_1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create_1(create_1(l, x, d, rl[--[[ l ]]1]), rl[--[[ v ]]2], rl[--[[ d ]]3], create_1(rl[--[[ r ]]4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add_1(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]4];
    d = m[--[[ d ]]3];
    v = m[--[[ v ]]2];
    l = m[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[[ Node ]]{
                --[[ l ]]l,
                --[[ v ]]x,
                --[[ d ]]data,
                --[[ r ]]r,
                --[[ h ]]m[--[[ h ]]5]
              };
      end end 
    end else if (c < 0) then do
      ll = add_1(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_1(ll, v, d, r);
      end end 
    end else do
      rr = add_1(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_1(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]data,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return param[--[[ d ]]3];
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function of_list(kvs) do
  return List.fold_left((function(acc, param) do
                return add(param[1], param[2], acc);
              end end), --[[ Empty ]]0, kvs);
end end

int_map_suites_000 = --[[ tuple ]]{
  "add",
  (function(param) do
      v = of_list(--[[ :: ]]{
            --[[ tuple ]]{
              1,
              --[[ "1" ]]49
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                2,
                --[[ "3" ]]51
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  3,
                  --[[ "4" ]]52
                },
                --[[ [] ]]0
              }
            }
          });
      return --[[ Eq ]]Block.__(0, {
                cardinal(v),
                3
              });
    end end)
};

int_map_suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "equal",
    (function(param) do
        v = of_list(--[[ :: ]]{
              --[[ tuple ]]{
                1,
                --[[ "1" ]]49
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  2,
                  --[[ "3" ]]51
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    3,
                    --[[ "4" ]]52
                  },
                  --[[ [] ]]0
                }
              }
            });
        u = of_list(--[[ :: ]]{
              --[[ tuple ]]{
                2,
                --[[ "3" ]]51
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  3,
                  --[[ "4" ]]52
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    1,
                    --[[ "1" ]]49
                  },
                  --[[ [] ]]0
                }
              }
            });
        return --[[ Eq ]]Block.__(0, {
                  compare(Caml_primitive.caml_int_compare, u, v),
                  0
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "equal2",
      (function(param) do
          v = of_list(--[[ :: ]]{
                --[[ tuple ]]{
                  1,
                  --[[ "1" ]]49
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    2,
                    --[[ "3" ]]51
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      3,
                      --[[ "4" ]]52
                    },
                    --[[ [] ]]0
                  }
                }
              });
          u = of_list(--[[ :: ]]{
                --[[ tuple ]]{
                  2,
                  --[[ "3" ]]51
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    3,
                    --[[ "4" ]]52
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      1,
                      --[[ "1" ]]49
                    },
                    --[[ [] ]]0
                  }
                }
              });
          return --[[ Eq ]]Block.__(0, {
                    true,
                    equal((function(x, y) do
                            return x == y;
                          end end), u, v)
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "iteration",
        (function(param) do
            m = --[[ Empty ]]0;
            for i = 0 , 10000 , 1 do
              m = add_1(__String(i), __String(i), m);
            end
            v = -1;
            for i_1 = 0 , 10000 , 1 do
              if (find(__String(i_1), m) ~= __String(i_1)) then do
                v = i_1;
              end
               end 
            end
            return --[[ Eq ]]Block.__(0, {
                      v,
                      -1
                    });
          end end)
      },
      --[[ [] ]]0
    }
  }
};

int_map_suites = --[[ :: ]]{
  int_map_suites_000,
  int_map_suites_001
};

Mt.from_pair_suites("Map_test", int_map_suites);

exports = {};
return exports;
--[[  Not a pure module ]]
