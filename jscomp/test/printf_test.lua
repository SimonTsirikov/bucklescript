--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Format = require "../../lib/js/format.lua";
Printf = require "../../lib/js/printf.lua";

function print_pair(fmt, param) do
  return Curry._2(Format.fprintf(fmt, --[[ Format ]][
                  --[[ Char_literal ]]Block.__(12, [
                      --[[ "(" ]]40,
                      --[[ Int ]]Block.__(4, [
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ Char_literal ]]Block.__(12, [
                              --[[ "," ]]44,
                              --[[ Int ]]Block.__(4, [
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ Char_literal ]]Block.__(12, [
                                      --[[ ")" ]]41,
                                      --[[ End_of_format ]]0
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "(%d,%d)"
                ]), param[0], param[1]);
end end

suites_000 = --[[ tuple ]][
  "sprintf_simple",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                "3232",
                Curry._2(Printf.sprintf(--[[ Format ]][
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Int ]]Block.__(4, [
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ End_of_format ]]0
                                ])
                            ]),
                          "%s%d"
                        ]), "32", 32)
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "print_asprintf",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  "xx",
                  Format.asprintf(--[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "xx",
                            --[[ End_of_format ]]0
                          ]),
                        "xx"
                      ])
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "print_pair",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    "(1,2)",
                    Curry._2(Format.asprintf(--[[ Format ]][
                              --[[ Alpha ]]Block.__(15, [--[[ End_of_format ]]0]),
                              "%a"
                            ]), print_pair, --[[ tuple ]][
                          1,
                          2
                        ])
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

v = Format.asprintf(--[[ Format ]][
      --[[ String_literal ]]Block.__(11, [
          "xx",
          --[[ End_of_format ]]0
        ]),
      "xx"
    ]);

Mt.from_pair_suites("Printf_test", suites);

exports.print_pair = print_pair;
exports.suites = suites;
exports.v = v;
--[[ v Not a pure module ]]
