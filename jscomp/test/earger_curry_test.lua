--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Pervasives = require "../../lib/js/pervasives.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function map(f, a) do
  f$1 = Curry.__1(f);
  a$1 = a;
  l = #a$1;
  if (l == 0) then do
    return [];
  end else do
    r = Caml_array.caml_make_vect(l, f$1(a$1[0]));
    for i = 1 , l - 1 | 0 , 1 do
      r[i] = f$1(a$1[i]);
    end
    return r;
  end end 
end end

function init(l, f) do
  l$1 = l;
  f$1 = Curry.__1(f);
  if (l$1 == 0) then do
    return [];
  end else do
    if (l$1 < 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Array.init"
          ];
    end
     end 
    res = Caml_array.caml_make_vect(l$1, f$1(0));
    for i = 1 , l$1 - 1 | 0 , 1 do
      res[i] = f$1(i);
    end
    return res;
  end end 
end end

function fold_left(f, x, a) do
  f$1 = Curry.__2(f);
  x$1 = x;
  a$1 = a;
  r = x$1;
  for i = 0 , #a$1 - 1 | 0 , 1 do
    r = f$1(r, a$1[i]);
  end
  return r;
end end

function f2(param) do
  arr = init(30000000, (function (i) do
          return i;
        end end));
  b = map((function (i) do
          return i + i - 1;
        end end), arr);
  v = fold_left((function (prim, prim$1) do
          return prim + prim$1;
        end end), 0, b);
  console.log(Pervasives.string_of_float(v));
  return --[[ () ]]0;
end end

f2(--[[ () ]]0);

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

v = do
  contents: 0
end;

all_v = do
  contents: --[[ [] ]]0
end;

function add5(a0, a1, a2, a3, a4) do
  console.log(--[[ tuple ]][
        a0,
        a1,
        a2,
        a3,
        a4
      ]);
  all_v.contents = --[[ :: ]][
    v.contents,
    all_v.contents
  ];
  return (((a0 + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0;
end end

function f(x) do
  v.contents = v.contents + 1 | 0;
  partial_arg = 2;
  v.contents = v.contents + 1 | 0;
  partial_arg$1 = 1;
  return (function (param, param$1) do
      return add5(x, partial_arg$1, partial_arg, param, param$1);
    end end);
end end

function g(x) do
  v.contents = v.contents + 1 | 0;
  partial_arg = 2;
  v.contents = v.contents + 1 | 0;
  partial_arg$1 = 1;
  u = function (param, param$1) do
    return add5(x, partial_arg$1, partial_arg, param, param$1);
  end end;
  all_v.contents = --[[ :: ]][
    v.contents,
    all_v.contents
  ];
  return u;
end end

a = f(0)(3, 4);

b = f(0)(3, 5);

c = Curry._2(g(0), 3, 4);

d = Curry._2(g(0), 3, 5);

eq("File \"earger_curry_test.ml\", line 118, characters 7-14", a, 10);

eq("File \"earger_curry_test.ml\", line 119, characters 7-14", b, 11);

eq("File \"earger_curry_test.ml\", line 120, characters 7-14", c, 10);

eq("File \"earger_curry_test.ml\", line 121, characters 7-14", d, 11);

eq("File \"earger_curry_test.ml\", line 122, characters 7-14", all_v.contents, --[[ :: ]][
      8,
      --[[ :: ]][
        8,
        --[[ :: ]][
          6,
          --[[ :: ]][
            6,
            --[[ :: ]][
              4,
              --[[ :: ]][
                2,
                --[[ [] ]]0
              ]
            ]
          ]
        ]
      ]
    ]);

Mt.from_pair_suites("Earger_curry_test", suites.contents);

exports.map = map;
exports.init = init;
exports.fold_left = fold_left;
exports.f2 = f2;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.all_v = all_v;
exports.add5 = add5;
exports.f = f;
exports.g = g;
exports.a = a;
exports.b = b;
exports.c = c;
exports.d = d;
--[[  Not a pure module ]]
