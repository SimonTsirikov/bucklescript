--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
$$Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";

list_suites_000 = --[[ tuple ]][
  "length",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                1,
                List.length(--[[ :: ]][
                      --[[ tuple ]][
                        0,
                        1,
                        2,
                        3,
                        4
                      ],
                      --[[ [] ]]0
                    ])
              ]);
    end end)
];

list_suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "length2",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  5,
                  List.length(--[[ :: ]][
                        0,
                        --[[ :: ]][
                          1,
                          --[[ :: ]][
                            2,
                            --[[ :: ]][
                              3,
                              --[[ :: ]][
                                4,
                                --[[ [] ]]0
                              ]
                            ]
                          ]
                        ]
                      ])
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "long_length",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    30000,
                    List.length($$Array.to_list($$Array.init(30000, (function (param) do
                                    return 0;
                                  end end))))
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "sort",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      List.sort(Caml_primitive.caml_int_compare, --[[ :: ]][
                            4,
                            --[[ :: ]][
                              1,
                              --[[ :: ]][
                                2,
                                --[[ :: ]][
                                  3,
                                  --[[ [] ]]0
                                ]
                              ]
                            ]
                          ]),
                      --[[ :: ]][
                        1,
                        --[[ :: ]][
                          2,
                          --[[ :: ]][
                            3,
                            --[[ :: ]][
                              4,
                              --[[ [] ]]0
                            ]
                          ]
                        ]
                      ]
                    ]);
          end end)
      ],
      --[[ [] ]]0
    ]
  ]
];

list_suites = --[[ :: ]][
  list_suites_000,
  list_suites_001
];

Mt.from_pair_suites("List_test", list_suites);

exports.list_suites = list_suites;
--[[  Not a pure module ]]
