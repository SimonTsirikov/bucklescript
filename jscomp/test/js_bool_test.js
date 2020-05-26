'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");

function f(x) do
  if (x) then do
    return true;
  end else do
    return false;
  end end 
end end

function f2(x) do
  if (x) then do
    return true;
  end else do
    return false;
  end end 
end end

function f4(x) do
  if (x) then do
    return true;
  end else do
    return false;
  end end 
end end

u = 1;

v = true;

suites_000 = --[[ tuple ]][
  "caml_bool_eq_caml_bool",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                u,
                true
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "js_bool_eq_js_bool",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  v,
                  true
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "js_bool_neq_acml_bool",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    true,
                    true == true
                  ]);
        end end)
    ],
    --[[ [] ]]0
  ]
];

suites = --[[ :: ]][
  suites_000,
  suites_001
];

function ff(u) do
  if (u == true) then do
    return 1;
  end else do
    return 2;
  end end 
end end

function fi(x, y) do
  return x == y;
end end

function fb(x, y) do
  return x == y;
end end

function fadd(x, y) do
  return x + y | 0;
end end

function ffadd(x, y) do
  return x + y;
end end

function ss(x) do
  return "xx" > x;
end end

function bb(x) do
  return --[[ tuple ]][
          true > x,
          false,
          true,
          true <= x,
          false,
          false < x,
          false >= x,
          true
        ];
end end

consts = --[[ tuple ]][
  false,
  false,
  true,
  false,
  true,
  false,
  true,
  true
];

bool_array = [
  true,
  false
];

Mt.from_pair_suites("Js_bool_test", suites);

f3 = true;

exports.f = f;
exports.f2 = f2;
exports.f4 = f4;
exports.f3 = f3;
exports.u = u;
exports.v = v;
exports.suites = suites;
exports.ff = ff;
exports.fi = fi;
exports.fb = fb;
exports.fadd = fadd;
exports.ffadd = ffadd;
exports.ss = ss;
exports.bb = bb;
exports.consts = consts;
exports.bool_array = bool_array;
--[[  Not a pure module ]]
