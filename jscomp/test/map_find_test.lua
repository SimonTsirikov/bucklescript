--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function height(param) do
  if (param) then do
    return param[--[[ h ]]4];
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
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      ld = l[--[[ d ]]2];
      lv = l[--[[ v ]]1];
      ll = l[--[[ l ]]0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[--[[ l ]]0]), lr[--[[ v ]]1], lr[--[[ d ]]2], create(lr[--[[ r ]]3], x, d, r));
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end  end 
    end else do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          };
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rd = r[--[[ d ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create(rl[--[[ r ]]3], rv, rd, rr));
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end  end 
    end else do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          };
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
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
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
                --[[ h ]]m[--[[ h ]]4]
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
      c = Caml_primitive.caml_int_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return param[--[[ d ]]2];
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

m = List.fold_left((function (acc, param) do
        return add(param[0], param[1], acc);
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

function height$1(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create$1(l, x, d, r) do
  hl = height$1(l);
  hr = height$1(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal$1(l, x, d, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      ld = l[--[[ d ]]2];
      lv = l[--[[ v ]]1];
      ll = l[--[[ l ]]0];
      if (height$1(ll) >= height$1(lr)) then do
        return create$1(ll, lv, ld, create$1(lr, x, d, r));
      end else if (lr) then do
        return create$1(create$1(ll, lv, ld, lr[--[[ l ]]0]), lr[--[[ v ]]1], lr[--[[ d ]]2], create$1(lr[--[[ r ]]3], x, d, r));
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end  end 
    end else do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          };
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rd = r[--[[ d ]]2];
      rv = r[--[[ v ]]1];
      rl = r[--[[ l ]]0];
      if (height$1(rr) >= height$1(rl)) then do
        return create$1(create$1(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create$1(create$1(l, x, d, rl[--[[ l ]]0]), rl[--[[ v ]]1], rl[--[[ d ]]2], create$1(rl[--[[ r ]]3], rv, rd, rr));
      end else do
        throw {
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            };
      end end  end 
    end else do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          };
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

function add$1(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]3];
    d = m[--[[ d ]]2];
    v = m[--[[ v ]]1];
    l = m[--[[ l ]]0];
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
                --[[ h ]]m[--[[ h ]]4]
              };
      end end 
    end else if (c < 0) then do
      ll = add$1(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal$1(ll, v, d, r);
      end end 
    end else do
      rr = add$1(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal$1(l, v, d, rr);
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

function find$1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]1]);
      if (c == 0) then do
        return param[--[[ d ]]2];
      end else do
        _param = c < 0 and param[--[[ l ]]0] or param[--[[ r ]]3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

s = List.fold_left((function (acc, param) do
        return add$1(param[0], param[1], acc);
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
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      find(10, m),
                      --[[ "a" ]]97
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "string",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        find$1("10", s),
                        --[[ "a" ]]97
                      });
            end end)
        },
        --[[ [] ]]0
      }
    });

--[[ m Not a pure module ]]
