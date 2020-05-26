'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Js_math = require("../../lib/js/js_math.js");

suites_000 = --[ tuple ]--[
  "_E",
  (function (param) do
      return --[ ApproxThreshold ]--Block.__(6, [
                0.001,
                2.718,
                Math.E
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "_LN2",
    (function (param) do
        return --[ ApproxThreshold ]--Block.__(6, [
                  0.001,
                  0.693,
                  Math.LN2
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "_LN10",
      (function (param) do
          return --[ ApproxThreshold ]--Block.__(6, [
                    0.001,
                    2.303,
                    Math.LN10
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "_LOG2E",
        (function (param) do
            return --[ ApproxThreshold ]--Block.__(6, [
                      0.001,
                      1.443,
                      Math.LOG2E
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "_LOG10E",
          (function (param) do
              return --[ ApproxThreshold ]--Block.__(6, [
                        0.001,
                        0.434,
                        Math.LOG10E
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "_PI",
            (function (param) do
                return --[ ApproxThreshold ]--Block.__(6, [
                          0.00001,
                          3.14159,
                          Math.PI
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "_SQRT1_2",
              (function (param) do
                  return --[ ApproxThreshold ]--Block.__(6, [
                            0.001,
                            0.707,
                            Math.SQRT1_2
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "_SQRT2",
                (function (param) do
                    return --[ ApproxThreshold ]--Block.__(6, [
                              0.001,
                              1.414,
                              Math.SQRT2
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "abs_int",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                4,
                                Math.abs(-4)
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "abs_float",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  1.2,
                                  Math.abs(-1.2)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "acos",
                      (function (param) do
                          return --[ ApproxThreshold ]--Block.__(6, [
                                    0.001,
                                    1.159,
                                    Math.acos(0.4)
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "acosh",
                        (function (param) do
                            return --[ ApproxThreshold ]--Block.__(6, [
                                      0.001,
                                      0.622,
                                      Math.acosh(1.2)
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "asin",
                          (function (param) do
                              return --[ ApproxThreshold ]--Block.__(6, [
                                        0.001,
                                        0.411,
                                        Math.asin(0.4)
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "asinh",
                            (function (param) do
                                return --[ ApproxThreshold ]--Block.__(6, [
                                          0.001,
                                          0.390,
                                          Math.asinh(0.4)
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "atan",
                              (function (param) do
                                  return --[ ApproxThreshold ]--Block.__(6, [
                                            0.001,
                                            0.380,
                                            Math.atan(0.4)
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "atanh",
                                (function (param) do
                                    return --[ ApproxThreshold ]--Block.__(6, [
                                              0.001,
                                              0.423,
                                              Math.atanh(0.4)
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "atan2",
                                  (function (param) do
                                      return --[ ApproxThreshold ]--Block.__(6, [
                                                0.001,
                                                0.588,
                                                Math.atan2(0.4, 0.6)
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "cbrt",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  2,
                                                  Math.cbrt(8)
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "unsafe_ceil_int",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    4,
                                                    Math.ceil(3.2)
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "ceil_int",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      4,
                                                      Js_math.ceil_int(3.2)
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "ceil_float",
                                          (function (param) do
                                              return --[ Eq ]--Block.__(0, [
                                                        4,
                                                        Math.ceil(3.2)
                                                      ]);
                                            end)
                                        ],
                                        --[ :: ]--[
                                          --[ tuple ]--[
                                            "cos",
                                            (function (param) do
                                                return --[ ApproxThreshold ]--Block.__(6, [
                                                          0.001,
                                                          0.921,
                                                          Math.cos(0.4)
                                                        ]);
                                              end)
                                          ],
                                          --[ :: ]--[
                                            --[ tuple ]--[
                                              "cosh",
                                              (function (param) do
                                                  return --[ ApproxThreshold ]--Block.__(6, [
                                                            0.001,
                                                            1.081,
                                                            Math.cosh(0.4)
                                                          ]);
                                                end)
                                            ],
                                            --[ :: ]--[
                                              --[ tuple ]--[
                                                "exp",
                                                (function (param) do
                                                    return --[ ApproxThreshold ]--Block.__(6, [
                                                              0.001,
                                                              1.491,
                                                              Math.exp(0.4)
                                                            ]);
                                                  end)
                                              ],
                                              --[ :: ]--[
                                                --[ tuple ]--[
                                                  "expm1",
                                                  (function (param) do
                                                      return --[ ApproxThreshold ]--Block.__(6, [
                                                                0.001,
                                                                0.491,
                                                                Math.expm1(0.4)
                                                              ]);
                                                    end)
                                                ],
                                                --[ :: ]--[
                                                  --[ tuple ]--[
                                                    "unsafe_floor_int",
                                                    (function (param) do
                                                        return --[ Eq ]--Block.__(0, [
                                                                  3,
                                                                  Math.floor(3.2)
                                                                ]);
                                                      end)
                                                  ],
                                                  --[ :: ]--[
                                                    --[ tuple ]--[
                                                      "floor_int",
                                                      (function (param) do
                                                          return --[ Eq ]--Block.__(0, [
                                                                    3,
                                                                    Js_math.floor_int(3.2)
                                                                  ]);
                                                        end)
                                                    ],
                                                    --[ :: ]--[
                                                      --[ tuple ]--[
                                                        "floor_float",
                                                        (function (param) do
                                                            return --[ Eq ]--Block.__(0, [
                                                                      3,
                                                                      Math.floor(3.2)
                                                                    ]);
                                                          end)
                                                      ],
                                                      --[ :: ]--[
                                                        --[ tuple ]--[
                                                          "fround",
                                                          (function (param) do
                                                              return --[ Approx ]--Block.__(5, [
                                                                        3.2,
                                                                        Math.fround(3.2)
                                                                      ]);
                                                            end)
                                                        ],
                                                        --[ :: ]--[
                                                          --[ tuple ]--[
                                                            "hypot",
                                                            (function (param) do
                                                                return --[ ApproxThreshold ]--Block.__(6, [
                                                                          0.001,
                                                                          0.721,
                                                                          Math.hypot(0.4, 0.6)
                                                                        ]);
                                                              end)
                                                          ],
                                                          --[ :: ]--[
                                                            --[ tuple ]--[
                                                              "hypotMany",
                                                              (function (param) do
                                                                  return --[ ApproxThreshold ]--Block.__(6, [
                                                                            0.001,
                                                                            1.077,
                                                                            Math.hypot(0.4, 0.6, 0.8)
                                                                          ]);
                                                                end)
                                                            ],
                                                            --[ :: ]--[
                                                              --[ tuple ]--[
                                                                "imul",
                                                                (function (param) do
                                                                    return --[ Eq ]--Block.__(0, [
                                                                              8,
                                                                              Math.imul(4, 2)
                                                                            ]);
                                                                  end)
                                                              ],
                                                              --[ :: ]--[
                                                                --[ tuple ]--[
                                                                  "log",
                                                                  (function (param) do
                                                                      return --[ ApproxThreshold ]--Block.__(6, [
                                                                                0.001,
                                                                                -0.916,
                                                                                Math.log(0.4)
                                                                              ]);
                                                                    end)
                                                                ],
                                                                --[ :: ]--[
                                                                  --[ tuple ]--[
                                                                    "log1p",
                                                                    (function (param) do
                                                                        return --[ ApproxThreshold ]--Block.__(6, [
                                                                                  0.001,
                                                                                  0.336,
                                                                                  Math.log1p(0.4)
                                                                                ]);
                                                                      end)
                                                                  ],
                                                                  --[ :: ]--[
                                                                    --[ tuple ]--[
                                                                      "log10",
                                                                      (function (param) do
                                                                          return --[ ApproxThreshold ]--Block.__(6, [
                                                                                    0.001,
                                                                                    -0.397,
                                                                                    Math.log10(0.4)
                                                                                  ]);
                                                                        end)
                                                                    ],
                                                                    --[ :: ]--[
                                                                      --[ tuple ]--[
                                                                        "log2",
                                                                        (function (param) do
                                                                            return --[ ApproxThreshold ]--Block.__(6, [
                                                                                      0.001,
                                                                                      -1.321,
                                                                                      Math.log2(0.4)
                                                                                    ]);
                                                                          end)
                                                                      ],
                                                                      --[ :: ]--[
                                                                        --[ tuple ]--[
                                                                          "max_int",
                                                                          (function (param) do
                                                                              return --[ Eq ]--Block.__(0, [
                                                                                        4,
                                                                                        Math.max(2, 4)
                                                                                      ]);
                                                                            end)
                                                                        ],
                                                                        --[ :: ]--[
                                                                          --[ tuple ]--[
                                                                            "maxMany_int",
                                                                            (function (param) do
                                                                                return --[ Eq ]--Block.__(0, [
                                                                                          4,
                                                                                          Math.max(2, 4, 3)
                                                                                        ]);
                                                                              end)
                                                                          ],
                                                                          --[ :: ]--[
                                                                            --[ tuple ]--[
                                                                              "max_float",
                                                                              (function (param) do
                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                            4.2,
                                                                                            Math.max(2.7, 4.2)
                                                                                          ]);
                                                                                end)
                                                                            ],
                                                                            --[ :: ]--[
                                                                              --[ tuple ]--[
                                                                                "maxMany_float",
                                                                                (function (param) do
                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                              4.2,
                                                                                              Math.max(2.7, 4.2, 3.9)
                                                                                            ]);
                                                                                  end)
                                                                              ],
                                                                              --[ :: ]--[
                                                                                --[ tuple ]--[
                                                                                  "min_int",
                                                                                  (function (param) do
                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                2,
                                                                                                Math.min(2, 4)
                                                                                              ]);
                                                                                    end)
                                                                                ],
                                                                                --[ :: ]--[
                                                                                  --[ tuple ]--[
                                                                                    "minMany_int",
                                                                                    (function (param) do
                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                  2,
                                                                                                  Math.min(2, 4, 3)
                                                                                                ]);
                                                                                      end)
                                                                                  ],
                                                                                  --[ :: ]--[
                                                                                    --[ tuple ]--[
                                                                                      "min_float",
                                                                                      (function (param) do
                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                    2.7,
                                                                                                    Math.min(2.7, 4.2)
                                                                                                  ]);
                                                                                        end)
                                                                                    ],
                                                                                    --[ :: ]--[
                                                                                      --[ tuple ]--[
                                                                                        "minMany_float",
                                                                                        (function (param) do
                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                      2.7,
                                                                                                      Math.min(2.7, 4.2, 3.9)
                                                                                                    ]);
                                                                                          end)
                                                                                      ],
                                                                                      --[ :: ]--[
                                                                                        --[ tuple ]--[
                                                                                          "random",
                                                                                          (function (param) do
                                                                                              a = Math.random();
                                                                                              return --[ Ok ]--Block.__(4, [a >= 0 and a < 1]);
                                                                                            end)
                                                                                        ],
                                                                                        --[ :: ]--[
                                                                                          --[ tuple ]--[
                                                                                            "random_int",
                                                                                            (function (param) do
                                                                                                a = Js_math.random_int(1, 3);
                                                                                                return --[ Ok ]--Block.__(4, [a >= 1 and a < 3]);
                                                                                              end)
                                                                                          ],
                                                                                          --[ :: ]--[
                                                                                            --[ tuple ]--[
                                                                                              "unsafe_round",
                                                                                              (function (param) do
                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                            3,
                                                                                                            Math.round(3.2)
                                                                                                          ]);
                                                                                                end)
                                                                                            ],
                                                                                            --[ :: ]--[
                                                                                              --[ tuple ]--[
                                                                                                "round",
                                                                                                (function (param) do
                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                              3,
                                                                                                              Math.round(3.2)
                                                                                                            ]);
                                                                                                  end)
                                                                                              ],
                                                                                              --[ :: ]--[
                                                                                                --[ tuple ]--[
                                                                                                  "sign_int",
                                                                                                  (function (param) do
                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                -1,
                                                                                                                Math.sign(-4)
                                                                                                              ]);
                                                                                                    end)
                                                                                                ],
                                                                                                --[ :: ]--[
                                                                                                  --[ tuple ]--[
                                                                                                    "sign_float",
                                                                                                    (function (param) do
                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                  -1,
                                                                                                                  Math.sign(-4.2)
                                                                                                                ]);
                                                                                                      end)
                                                                                                  ],
                                                                                                  --[ :: ]--[
                                                                                                    --[ tuple ]--[
                                                                                                      "sign_float -0",
                                                                                                      (function (param) do
                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                    -0,
                                                                                                                    Math.sign(-0)
                                                                                                                  ]);
                                                                                                        end)
                                                                                                    ],
                                                                                                    --[ :: ]--[
                                                                                                      --[ tuple ]--[
                                                                                                        "sin",
                                                                                                        (function (param) do
                                                                                                            return --[ ApproxThreshold ]--Block.__(6, [
                                                                                                                      0.001,
                                                                                                                      0.389,
                                                                                                                      Math.sin(0.4)
                                                                                                                    ]);
                                                                                                          end)
                                                                                                      ],
                                                                                                      --[ :: ]--[
                                                                                                        --[ tuple ]--[
                                                                                                          "sinh",
                                                                                                          (function (param) do
                                                                                                              return --[ ApproxThreshold ]--Block.__(6, [
                                                                                                                        0.001,
                                                                                                                        0.410,
                                                                                                                        Math.sinh(0.4)
                                                                                                                      ]);
                                                                                                            end)
                                                                                                        ],
                                                                                                        --[ :: ]--[
                                                                                                          --[ tuple ]--[
                                                                                                            "sqrt",
                                                                                                            (function (param) do
                                                                                                                return --[ ApproxThreshold ]--Block.__(6, [
                                                                                                                          0.001,
                                                                                                                          0.632,
                                                                                                                          Math.sqrt(0.4)
                                                                                                                        ]);
                                                                                                              end)
                                                                                                          ],
                                                                                                          --[ :: ]--[
                                                                                                            --[ tuple ]--[
                                                                                                              "tan",
                                                                                                              (function (param) do
                                                                                                                  return --[ ApproxThreshold ]--Block.__(6, [
                                                                                                                            0.001,
                                                                                                                            0.422,
                                                                                                                            Math.tan(0.4)
                                                                                                                          ]);
                                                                                                                end)
                                                                                                            ],
                                                                                                            --[ :: ]--[
                                                                                                              --[ tuple ]--[
                                                                                                                "tanh",
                                                                                                                (function (param) do
                                                                                                                    return --[ ApproxThreshold ]--Block.__(6, [
                                                                                                                              0.001,
                                                                                                                              0.379,
                                                                                                                              Math.tanh(0.4)
                                                                                                                            ]);
                                                                                                                  end)
                                                                                                              ],
                                                                                                              --[ :: ]--[
                                                                                                                --[ tuple ]--[
                                                                                                                  "unsafe_trunc",
                                                                                                                  (function (param) do
                                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                                4,
                                                                                                                                Math.trunc(4.2156)
                                                                                                                              ]);
                                                                                                                    end)
                                                                                                                ],
                                                                                                                --[ :: ]--[
                                                                                                                  --[ tuple ]--[
                                                                                                                    "trunc",
                                                                                                                    (function (param) do
                                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                                  4,
                                                                                                                                  Math.trunc(4.2156)
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

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_math_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
