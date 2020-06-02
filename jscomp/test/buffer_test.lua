--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Bytes = require "../../lib/js/bytes.lua";
__Buffer = require "../../lib/js/buffer.lua";
Caml_bytes = require "../../lib/js/caml_bytes.lua";

v = "gso";

suites_000 = --[[ tuple ]][
  "equal",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                --[[ tuple ]][
                  Caml_bytes.get(Bytes.make(3, --[[ "a" ]]97), 0),
                  Bytes.make(3, --[[ "a" ]]97)[0]
                ],
                --[[ tuple ]][
                  --[[ "a" ]]97,
                  --[[ "a" ]]97
                ]
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "equal2",
    (function (param) do
        u = Bytes.make(3, --[[ "a" ]]97);
        u[0] = --[[ "b" ]]98;
        return --[[ Eq ]]Block.__(0, [
                  --[[ tuple ]][
                    u[0],
                    --[[ "g" ]]103
                  ],
                  --[[ tuple ]][
                    --[[ "b" ]]98,
                    --[[ "g" ]]103
                  ]
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "buffer",
      (function (param) do
          v = __Buffer.create(30);
          for i = 0 , 10 , 1 do
            __Buffer.add_string(v, String(i));
          end
          return --[[ Eq ]]Block.__(0, [
                    __Buffer.contents(v),
                    "012345678910"
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

Mt.from_pair_suites("Buffer_test", suites);

exports.v = v;
exports.suites = suites;
--[[  Not a pure module ]]
