__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
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

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[--[[ v ]]2]);
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

m = List.fold_left((function(acc, param) do
        return add(param[1], param[2], acc);
      end end), --[[ Empty ]]0, --[[ :: ]]{
      --[[ tuple ]]{
        10,
        --[[ "a" ]]97
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          3,
          --[[ "b" ]]98
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            7,
            --[[ "c" ]]99
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              20,
              --[[ "d" ]]100
            },
            --[[ [] ]]0
          }
        }
      }
    });

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

function find_1(x, _param) do
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

s = List.fold_left((function(acc, param) do
        return add_1(param[1], param[2], acc);
      end end), --[[ Empty ]]0, --[[ :: ]]{
      --[[ tuple ]]{
        "10",
        --[[ "a" ]]97
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "3",
          --[[ "b" ]]98
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "7",
            --[[ "c" ]]99
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "20",
              --[[ "d" ]]100
            },
            --[[ [] ]]0
          }
        }
      }
    });

Mt.from_pair_suites("Map_find_test", --[[ :: ]]{
      --[[ tuple ]]{
        "int",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      find(10, m),
                      --[[ "a" ]]97
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "string",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        find_1("10", s),
                        --[[ "a" ]]97
                      });
            end end)
        },
        --[[ [] ]]0
      }
    });

exports = {};
return exports;
--[[ m Not a pure module ]]
