--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";

function length(param) do
  return 3;
end end

Mt.from_pair_suites("Es6_module_test", --[[ :: ]][
      --[[ tuple ]][
        "list_length",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      List.length(--[[ :: ]][
                            1,
                            --[[ :: ]][
                              2,
                              --[[ [] ]]0
                            ]
                          ]),
                      2
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "length",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        3,
                        3
                      ]);
            end end)
        ],
        --[[ [] ]]0
      ]
    ]);

exports.length = length;
--[[  Not a pure module ]]
