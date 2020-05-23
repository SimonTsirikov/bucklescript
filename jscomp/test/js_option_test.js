'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Js_option = require("../../lib/js/js_option.js");

function simpleEq(a, b) do
  return a == b;
end

var option_suites_000 = --[ tuple ]--[
  "option_isSome_Some",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                true,
                true
              ]);
    end)
];

var option_suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "option_isSome_None",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  false,
                  false
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "option_isNone_Some",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    false,
                    false
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "option_isNone_None",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      true,
                      true
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "option_isSomeValue_Eq",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        true,
                        Js_option.isSomeValue(simpleEq, 2, 2)
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "option_isSomeValue_Diff",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          false,
                          Js_option.isSomeValue(simpleEq, 1, 2)
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "option_isSomeValue_DiffNone",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            false,
                            Js_option.isSomeValue(simpleEq, 1, undefined)
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "option_getExn_Some",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              2,
                              Js_option.getExn(2)
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "option_equal_Eq",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                true,
                                Js_option.equal(simpleEq, 2, 2)
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "option_equal_Diff",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  false,
                                  Js_option.equal(simpleEq, 1, 2)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "option_equal_DiffNone",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    false,
                                    Js_option.equal(simpleEq, 1, undefined)
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "option_andThen_SomeSome",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      true,
                                      Js_option.isSomeValue(simpleEq, 3, Js_option.andThen((function (a) do
                                                  return a + 1 | 0;
                                                end), 2))
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "option_andThen_SomeNone",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        false,
                                        Js_option.isSomeValue(simpleEq, 3, Js_option.andThen((function (param) do
                                                    return ;
                                                  end), 2))
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "option_map_Some",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          true,
                                          Js_option.isSomeValue(simpleEq, 3, Js_option.map((function (a) do
                                                      return a + 1 | 0;
                                                    end), 2))
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "option_map_None",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            undefined,
                                            Js_option.map((function (a) do
                                                    return a + 1 | 0;
                                                  end), undefined)
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "option_default_Some",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              2,
                                              Js_option.getWithDefault(3, 2)
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "option_default_None",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                3,
                                                Js_option.getWithDefault(3, undefined)
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "option_filter_Pass",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  true,
                                                  Js_option.isSomeValue(simpleEq, 2, Js_option.filter((function (a) do
                                                              return a % 2 == 0;
                                                            end), 2))
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "option_filter_Reject",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    undefined,
                                                    Js_option.filter((function (a) do
                                                            return a % 3 == 0;
                                                          end), 2)
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "option_filter_None",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      undefined,
                                                      Js_option.filter((function (a) do
                                                              return a % 3 == 0;
                                                            end), undefined)
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "option_firstSome_First",
                                          (function (param) do
                                              return --[ Eq ]--Block.__(0, [
                                                        true,
                                                        Js_option.isSomeValue(simpleEq, 3, Js_option.firstSome(3, 2))
                                                      ]);
                                            end)
                                        ],
                                        --[ :: ]--[
                                          --[ tuple ]--[
                                            "option_firstSome_First",
                                            (function (param) do
                                                return --[ Eq ]--Block.__(0, [
                                                          true,
                                                          Js_option.isSomeValue(simpleEq, 2, Js_option.firstSome(undefined, 2))
                                                        ]);
                                              end)
                                          ],
                                          --[ :: ]--[
                                            --[ tuple ]--[
                                              "option_firstSome_None",
                                              (function (param) do
                                                  return --[ Eq ]--Block.__(0, [
                                                            undefined,
                                                            Js_option.firstSome(undefined, undefined)
                                                          ]);
                                                end)
                                            ],
                                            --[ [] ]--0
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
];

var option_suites = --[ :: ]--[
  option_suites_000,
  option_suites_001
];

Mt.from_pair_suites("Js_option_test", option_suites);

exports.simpleEq = simpleEq;
exports.option_suites = option_suites;
--[  Not a pure module ]--
