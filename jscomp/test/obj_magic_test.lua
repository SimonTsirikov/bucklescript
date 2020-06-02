--[['use strict';]]

Mt = require "./mt.lua";
Obj = require "../../lib/js/obj.lua";
Block = require "../../lib/js/block.lua";

empty_backtrace = --[[ obj_block ]]Block.__(Obj.abstract_tag, []);

function is_block(x) do
  return typeof x ~= "number";
end end

suites_000 = --[[ tuple ]][
  "is_block_test1",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                false,
                false
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "is_block_test2",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  true,
                  typeof --[[ :: ]][
                    3,
                    --[[ [] ]]0
                  ] ~= "number"
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "is_block_test3",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    true,
                    true
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "is_block_test4",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      false,
                      false
                    ]);
          end end)
      ],
      --[[ [] ]]0
    ]
  ]
];

suites = --[[ :: ]][
  suites_000,
  suites_001
];

Mt.from_pair_suites("Obj_magic_test", suites);

exports.empty_backtrace = empty_backtrace;
exports.is_block = is_block;
exports.suites = suites;
--[[  Not a pure module ]]
