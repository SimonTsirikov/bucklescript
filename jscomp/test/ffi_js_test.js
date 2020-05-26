'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");

keys = (function (x){return Object.keys(x)});

function $$higher_order(x){
   return function(y,z){
      return x + y + z
   }
  }
;

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
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

int_config = do
  hi: 3,
  low: 32
end;

string_config = do
  hi: 3,
  low: "32"
end;

eq("File \"ffi_js_test.ml\", line 32, characters 5-12", --[[ tuple ]][
      6,
      $$higher_order(1)(2, 3)
    ]);

same_type_000 = --[[ :: ]][
  int_config,
  --[[ :: ]][
    do
      hi: 3,
      low: 32
    end,
    --[[ [] ]]0
  ]
];

same_type_001 = --[[ :: ]][
  string_config,
  --[[ :: ]][
    do
      hi: 3,
      low: "32"
    end,
    --[[ [] ]]0
  ]
];

same_type = --[[ tuple ]][
  same_type_000,
  same_type_001
];

v_obj = do
  hi: (function () do
      console.log("hei");
      return --[[ () ]]0; end
    end)
end;

eq("File \"ffi_js_test.ml\", line 44, characters 5-12", --[[ tuple ]][
      #Object.keys(int_config),
      2
    ]);

eq("File \"ffi_js_test.ml\", line 45, characters 5-12", --[[ tuple ]][
      #Object.keys(string_config),
      2
    ]);

eq("File \"ffi_js_test.ml\", line 46, characters 5-12", --[[ tuple ]][
      Object.keys(v_obj).indexOf("hi_x"),
      -1
    ]);

eq("File \"ffi_js_test.ml\", line 47, characters 5-12", --[[ tuple ]][
      Object.keys(v_obj).indexOf("hi"),
      0
    ]);

u = do
  contents: 3
end;

side_effect_config = (u.contents = u.contents + 1 | 0, do
    hi: 3,
    low: 32
  end);

eq("File \"ffi_js_test.ml\", line 54, characters 5-12", --[[ tuple ]][
      u.contents,
      4
    ]);

function vv(z) do
  return z.hh();
end end

function v(z) do
  return z.ff();
end end

function vvv(z) do
  return z.ff_pipe();
end end

function vvvv(z) do
  return z.ff_pipe2();
end end

function create_prim(param) do
  return do
          "x'": 3,
          "x''": 3,
          "x''''": 2
        end;
end end

function ffff(x) do
  x.setGADT = 3;
  x.setGADT2 = --[[ tuple ]][
    3,
    "3"
  ];
  x.setGADT2 = --[[ tuple ]][
    "3",
    3
  ];
  match = x[3];
  console.log(--[[ tuple ]][
        match[0],
        match[1]
      ]);
  console.log(x.getGADT);
  match$1 = x.getGADT2;
  console.log(match$1[0], match$1[1]);
  match$2 = x[0];
  console.log(match$2[0], match$2[1]);
  x[0] = --[[ tuple ]][
    1,
    "x"
  ];
  x[3] = --[[ tuple ]][
    3,
    "x"
  ];
  return --[[ () ]]0;
end end

Mt.from_pair_suites("Ffi_js_test", suites.contents);

exports.keys = keys;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.int_config = int_config;
exports.string_config = string_config;
exports.same_type = same_type;
exports.v_obj = v_obj;
exports.u = u;
exports.side_effect_config = side_effect_config;
exports.vv = vv;
exports.v = v;
exports.vvv = vvv;
exports.vvvv = vvvv;
exports.create_prim = create_prim;
exports.ffff = ffff;
--[[  Not a pure module ]]
