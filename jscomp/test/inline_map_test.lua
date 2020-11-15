__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Caml_primitive = require "......lib.js.caml_primitive";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function height(param) do
  if (param) then do
    return param[5];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, x, d, r) do
  hl = l and l[5] or 0;
  hr = r and r[5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[4];
      ld = l[3];
      lv = l[2];
      ll = l[1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[1]), lr[2], lr[3], create(lr[4], x, d, r));
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
      rr = r[4];
      rd = r[3];
      rv = r[2];
      rl = r[1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[1]), rl[2], rl[3], create(rl[4], rv, rd, rr));
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
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, data, param) do
  if (param) then do
    r = param[4];
    d = param[3];
    v = param[2];
    l = param[1];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]]{
              l,
              x,
              data,
              r,
              param[5]
            };
    end else if (c < 0) then do
      return bal(add(x, data, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          };
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[2]);
      if (c == 0) then do
        return param[3];
      end else do
        _param = c < 0 and param[1] or param[4];
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

Mt.from_pair_suites("Inline_map_test", --[[ :: ]]{
      --[[ tuple ]]{
        "find",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      find(10, m),
                      --[[ "a" ]]97
                    });
          end end)
      },
      --[[ [] ]]0
    });

exports = {};
return exports;
--[[ m Not a pure module ]]
