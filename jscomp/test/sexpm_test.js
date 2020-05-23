'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Sexpm = require("./sexpm.js");
var Format = require("../../lib/js/format.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, param) do
  var y = param[1];
  var x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function print_or_error(fmt, x) do
  if (x[0] >= 106380200) do
    return Curry._1(Format.fprintf(fmt, --[ Format ]--[
                    --[ Formatting_gen ]--Block.__(18, [
                        --[ Open_box ]--Block.__(1, [--[ Format ]--[
                              --[ End_of_format ]--0,
                              ""
                            ]]),
                        --[ String_literal ]--Block.__(11, [
                            "Error:",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ Formatting_lit ]--Block.__(17, [
                                    --[ Close_box ]--0,
                                    --[ Formatting_lit ]--Block.__(17, [
                                        --[ Flush_newline ]--4,
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "@[Error:%s@]@."
                  ]), x[1]);
  end else do
    return Curry._2(Format.fprintf(fmt, --[ Format ]--[
                    --[ Formatting_gen ]--Block.__(18, [
                        --[ Open_box ]--Block.__(1, [--[ Format ]--[
                              --[ End_of_format ]--0,
                              ""
                            ]]),
                        --[ String_literal ]--Block.__(11, [
                            "Ok:",
                            --[ Alpha ]--Block.__(15, [--[ Formatting_lit ]--Block.__(17, [
                                    --[ Close_box ]--0,
                                    --[ Formatting_lit ]--Block.__(17, [
                                        --[ Flush_newline ]--4,
                                        --[ End_of_format ]--0
                                      ])
                                  ])])
                          ])
                      ]),
                    "@[Ok:%a@]@."
                  ]), Sexpm.print, x[1]);
  end
end

var a = Sexpm.parse_string("(x x gh 3 3)");

eq("File \"sexpm_test.ml\", line 17, characters 7-14", --[ tuple ]--[
      --[ `Ok ]--[
        17724,
        --[ `List ]--[
          848054398,
          --[ :: ]--[
            --[ `Atom ]--[
              726615281,
              "x"
            ],
            --[ :: ]--[
              --[ `Atom ]--[
                726615281,
                "x"
              ],
              --[ :: ]--[
                --[ `Atom ]--[
                  726615281,
                  "gh"
                ],
                --[ :: ]--[
                  --[ `Atom ]--[
                    726615281,
                    "3"
                  ],
                  --[ :: ]--[
                    --[ `Atom ]--[
                      726615281,
                      "3"
                    ],
                    --[ [] ]--0
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      a
    ]);

eq("File \"sexpm_test.ml\", line 21, characters 7-14", --[ tuple ]--[
      Curry._2(Format.asprintf(--[ Format ]--[
                  --[ Alpha ]--Block.__(15, [--[ End_of_format ]--0]),
                  "%a"
                ]), print_or_error, a).trim(),
      "Ok:(x x gh 3 3)\n".trim()
    ]);

Mt.from_pair_suites("Sexpm_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.print_or_error = print_or_error;
--[ a Not a pure module ]--
