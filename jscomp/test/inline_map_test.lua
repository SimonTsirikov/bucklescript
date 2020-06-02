--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function height(param) do
  if (param) then do
    return param[4];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]][
          l,
          x,
          d,
          r,
          hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end end

function bal(l, x, d, r) do
  hl = l and l[4] or 0;
  hr = r and r[4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[3];
      ld = l[2];
      lv = l[1];
      ll = l[0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[0]), lr[1], lr[2], create(lr[3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[3];
      rd = r[2];
      rv = r[1];
      rl = r[0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[0]), rl[1], rl[2], create(rl[3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[[ Node ]][
            l,
            x,
            d,
            r,
            hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end end

function add(x, data, param) do
  if (param) then do
    r = param[3];
    d = param[2];
    v = param[1];
    l = param[0];
    c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return --[[ Node ]][
              l,
              x,
              data,
              r,
              param[4]
            ];
    end else if (c < 0) then do
      return bal(add(x, data, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, r));
    end end  end 
  end else do
    return --[[ Node ]][
            --[[ Empty ]]0,
            x,
            data,
            --[[ Empty ]]0,
            1
          ];
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_int_compare(x, param[1]);
      if (c == 0) then do
        return param[2];
      end else do
        _param = c < 0 and param[0] or param[3];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end end

m = List.fold_left((function (acc, param) do
        return add(param[0], param[1], acc);
      end end), --[[ Empty ]]0, --[[ :: ]][
      --[[ tuple ]][
        10,
        --[[ "a" ]]97
      ],
      --[[ :: ]][
        --[[ tuple ]][
          3,
          --[[ "b" ]]98
        ],
        --[[ :: ]][
          --[[ tuple ]][
            7,
            --[[ "c" ]]99
          ],
          --[[ :: ]][
            --[[ tuple ]][
              20,
              --[[ "d" ]]100
            ],
            --[[ [] ]]0
          ]
        ]
      ]
    ]);

Mt.from_pair_suites("Inline_map_test", --[[ :: ]][
      --[[ tuple ]][
        "find",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      find(10, m),
                      --[[ "a" ]]97
                    ]);
          end end)
      ],
      --[[ [] ]]0
    ]);

--[[ m Not a pure module ]]
