'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Pervasives = require("../../lib/js/pervasives.js");

suites_000 = --[[ tuple ]][
  "_NaN <> _NaN",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                false,
                NaN == NaN
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "isNaN - _NaN",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  true,
                  isNaN(NaN)
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "isNaN - 0.",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    false,
                    isNaN(0)
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "isFinite - infinity",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      false,
                      isFinite(Pervasives.infinity)
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "isFinite - neg_infinity",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        false,
                        isFinite(Pervasives.neg_infinity)
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "isFinite - _NaN",
            (function (param) do
                return --[[ Eq ]]Block.__(0, [
                          false,
                          isFinite(NaN)
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "isFinite - 0.",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, [
                            true,
                            isFinite(0)
                          ]);
                end end)
            ],
            --[[ :: ]][
              --[[ tuple ]][
                "toExponential",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, [
                              "1.23456e+2",
                              (123.456).toExponential()
                            ]);
                  end end)
              ],
              --[[ :: ]][
                --[[ tuple ]][
                  "toExponential - large number",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, [
                                "1.2e+21",
                                (1.2e21).toExponential()
                              ]);
                    end end)
                ],
                --[[ :: ]][
                  --[[ tuple ]][
                    "toExponentialWithPrecision - digits:2",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, [
                                  "1.23e+2",
                                  (123.456).toExponential(2)
                                ]);
                      end end)
                  ],
                  --[[ :: ]][
                    --[[ tuple ]][
                      "toExponentialWithPrecision - digits:4",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, [
                                    "1.2346e+2",
                                    (123.456).toExponential(4)
                                  ]);
                        end end)
                    ],
                    --[[ :: ]][
                      --[[ tuple ]][
                        "toExponentialWithPrecision - digits:20",
                        (function (param) do
                            return --[[ Eq ]]Block.__(0, [
                                      "0.00000000000000000000e+0",
                                      (0).toExponential(20)
                                    ]);
                          end end)
                      ],
                      --[[ :: ]][
                        --[[ tuple ]][
                          "File \"js_float_test.ml\", line 31, characters 3-10",
                          (function (param) do
                              return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                            (0).toExponential(101);
                                            return --[[ () ]]0;
                                          end end)]);
                            end end)
                        ],
                        --[[ :: ]][
                          --[[ tuple ]][
                            "toExponentialWithPrecision - digits:-1",
                            (function (param) do
                                return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                              (0).toExponential(-1);
                                              return --[[ () ]]0;
                                            end end)]);
                              end end)
                          ],
                          --[[ :: ]][
                            --[[ tuple ]][
                              "toFixed",
                              (function (param) do
                                  return --[[ Eq ]]Block.__(0, [
                                            "123",
                                            (123.456).toFixed()
                                          ]);
                                end end)
                            ],
                            --[[ :: ]][
                              --[[ tuple ]][
                                "toFixed - large number",
                                (function (param) do
                                    return --[[ Eq ]]Block.__(0, [
                                              "1.2e+21",
                                              (1.2e21).toFixed()
                                            ]);
                                  end end)
                              ],
                              --[[ :: ]][
                                --[[ tuple ]][
                                  "toFixedWithPrecision - digits:2",
                                  (function (param) do
                                      return --[[ Eq ]]Block.__(0, [
                                                "123.46",
                                                (123.456).toFixed(2)
                                              ]);
                                    end end)
                                ],
                                --[[ :: ]][
                                  --[[ tuple ]][
                                    "toFixedWithPrecision - digits:4",
                                    (function (param) do
                                        return --[[ Eq ]]Block.__(0, [
                                                  "123.4560",
                                                  (123.456).toFixed(4)
                                                ]);
                                      end end)
                                  ],
                                  --[[ :: ]][
                                    --[[ tuple ]][
                                      "toFixedWithPrecision - digits:20",
                                      (function (param) do
                                          return --[[ Eq ]]Block.__(0, [
                                                    "0.00000000000000000000",
                                                    (0).toFixed(20)
                                                  ]);
                                        end end)
                                    ],
                                    --[[ :: ]][
                                      --[[ tuple ]][
                                        "toFixedWithPrecision - digits:101",
                                        (function (param) do
                                            return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                          (0).toFixed(101);
                                                          return --[[ () ]]0;
                                                        end end)]);
                                          end end)
                                      ],
                                      --[[ :: ]][
                                        --[[ tuple ]][
                                          "toFixedWithPrecision - digits:-1",
                                          (function (param) do
                                              return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                            (0).toFixed(-1);
                                                            return --[[ () ]]0;
                                                          end end)]);
                                            end end)
                                        ],
                                        --[[ :: ]][
                                          --[[ tuple ]][
                                            "toPrecision",
                                            (function (param) do
                                                return --[[ Eq ]]Block.__(0, [
                                                          "123.456",
                                                          (123.456).toPrecision()
                                                        ]);
                                              end end)
                                          ],
                                          --[[ :: ]][
                                            --[[ tuple ]][
                                              "toPrecision - large number",
                                              (function (param) do
                                                  return --[[ Eq ]]Block.__(0, [
                                                            "1.2e+21",
                                                            (1.2e21).toPrecision()
                                                          ]);
                                                end end)
                                            ],
                                            --[[ :: ]][
                                              --[[ tuple ]][
                                                "toPrecisionWithPrecision - digits:2",
                                                (function (param) do
                                                    return --[[ Eq ]]Block.__(0, [
                                                              "1.2e+2",
                                                              (123.456).toPrecision(2)
                                                            ]);
                                                  end end)
                                              ],
                                              --[[ :: ]][
                                                --[[ tuple ]][
                                                  "toPrecisionWithPrecision - digits:4",
                                                  (function (param) do
                                                      return --[[ Eq ]]Block.__(0, [
                                                                "123.5",
                                                                (123.456).toPrecision(4)
                                                              ]);
                                                    end end)
                                                ],
                                                --[[ :: ]][
                                                  --[[ tuple ]][
                                                    "toPrecisionWithPrecision - digits:20",
                                                    (function (param) do
                                                        return --[[ Eq ]]Block.__(0, [
                                                                  "0.0000000000000000000",
                                                                  (0).toPrecision(20)
                                                                ]);
                                                      end end)
                                                  ],
                                                  --[[ :: ]][
                                                    --[[ tuple ]][
                                                      "File \"js_float_test.ml\", line 61, characters 3-10",
                                                      (function (param) do
                                                          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                                        (0).toPrecision(101);
                                                                        return --[[ () ]]0;
                                                                      end end)]);
                                                        end end)
                                                    ],
                                                    --[[ :: ]][
                                                      --[[ tuple ]][
                                                        "toPrecisionWithPrecision - digits:-1",
                                                        (function (param) do
                                                            return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                                          (0).toPrecision(-1);
                                                                          return --[[ () ]]0;
                                                                        end end)]);
                                                          end end)
                                                      ],
                                                      --[[ :: ]][
                                                        --[[ tuple ]][
                                                          "toString",
                                                          (function (param) do
                                                              return --[[ Eq ]]Block.__(0, [
                                                                        "1.23",
                                                                        (1.23).toString()
                                                                      ]);
                                                            end end)
                                                        ],
                                                        --[[ :: ]][
                                                          --[[ tuple ]][
                                                            "toString - large number",
                                                            (function (param) do
                                                                return --[[ Eq ]]Block.__(0, [
                                                                          "1.2e+21",
                                                                          (1.2e21).toString()
                                                                        ]);
                                                              end end)
                                                          ],
                                                          --[[ :: ]][
                                                            --[[ tuple ]][
                                                              "toStringWithRadix - radix:2",
                                                              (function (param) do
                                                                  return --[[ Eq ]]Block.__(0, [
                                                                            "1111011.0111010010111100011010100111111011111001110111",
                                                                            (123.456).toString(2)
                                                                          ]);
                                                                end end)
                                                            ],
                                                            --[[ :: ]][
                                                              --[[ tuple ]][
                                                                "toStringWithRadix - radix:16",
                                                                (function (param) do
                                                                    return --[[ Eq ]]Block.__(0, [
                                                                              "7b.74bc6a7ef9dc",
                                                                              (123.456).toString(16)
                                                                            ]);
                                                                  end end)
                                                              ],
                                                              --[[ :: ]][
                                                                --[[ tuple ]][
                                                                  "toStringWithRadix - radix:36",
                                                                  (function (param) do
                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                "3f",
                                                                                (123).toString(36)
                                                                              ]);
                                                                    end end)
                                                                ],
                                                                --[[ :: ]][
                                                                  --[[ tuple ]][
                                                                    "toStringWithRadix - radix:37",
                                                                    (function (param) do
                                                                        return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                                                      (0).toString(37);
                                                                                      return --[[ () ]]0;
                                                                                    end end)]);
                                                                      end end)
                                                                  ],
                                                                  --[[ :: ]][
                                                                    --[[ tuple ]][
                                                                      "toStringWithRadix - radix:1",
                                                                      (function (param) do
                                                                          return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                                                        (0).toString(1);
                                                                                        return --[[ () ]]0;
                                                                                      end end)]);
                                                                        end end)
                                                                    ],
                                                                    --[[ :: ]][
                                                                      --[[ tuple ]][
                                                                        "toStringWithRadix - radix:-1",
                                                                        (function (param) do
                                                                            return --[[ ThrowAny ]]Block.__(7, [(function (param) do
                                                                                          (0).toString(-1);
                                                                                          return --[[ () ]]0;
                                                                                        end end)]);
                                                                          end end)
                                                                      ],
                                                                      --[[ :: ]][
                                                                        --[[ tuple ]][
                                                                          "fromString - 123",
                                                                          (function (param) do
                                                                              return --[[ Eq ]]Block.__(0, [
                                                                                        123,
                                                                                        Number("123")
                                                                                      ]);
                                                                            end end)
                                                                        ],
                                                                        --[[ :: ]][
                                                                          --[[ tuple ]][
                                                                            "fromString - 12.3",
                                                                            (function (param) do
                                                                                return --[[ Eq ]]Block.__(0, [
                                                                                          12.3,
                                                                                          Number("12.3")
                                                                                        ]);
                                                                              end end)
                                                                          ],
                                                                          --[[ :: ]][
                                                                            --[[ tuple ]][
                                                                              "fromString - empty string",
                                                                              (function (param) do
                                                                                  return --[[ Eq ]]Block.__(0, [
                                                                                            0,
                                                                                            Number("")
                                                                                          ]);
                                                                                end end)
                                                                            ],
                                                                            --[[ :: ]][
                                                                              --[[ tuple ]][
                                                                                "fromString - 0x11",
                                                                                (function (param) do
                                                                                    return --[[ Eq ]]Block.__(0, [
                                                                                              17,
                                                                                              Number("0x11")
                                                                                            ]);
                                                                                  end end)
                                                                              ],
                                                                              --[[ :: ]][
                                                                                --[[ tuple ]][
                                                                                  "fromString - 0b11",
                                                                                  (function (param) do
                                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                                3,
                                                                                                Number("0b11")
                                                                                              ]);
                                                                                    end end)
                                                                                ],
                                                                                --[[ :: ]][
                                                                                  --[[ tuple ]][
                                                                                    "fromString - 0o11",
                                                                                    (function (param) do
                                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                                  9,
                                                                                                  Number("0o11")
                                                                                                ]);
                                                                                      end end)
                                                                                  ],
                                                                                  --[[ :: ]][
                                                                                    --[[ tuple ]][
                                                                                      "fromString - invalid string",
                                                                                      (function (param) do
                                                                                          return --[[ Eq ]]Block.__(0, [
                                                                                                    true,
                                                                                                    isNaN(Number("foo"))
                                                                                                  ]);
                                                                                        end end)
                                                                                    ],
                                                                                    --[[ [] ]]0
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

suites = --[[ :: ]][
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_float_test", suites);

exports.suites = suites;
--[[  Not a pure module ]]
