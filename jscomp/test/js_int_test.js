'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");

suites_000 = --[ tuple ]--[
  "toExponential",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                "1.23456e+5",
                (123456).toExponential()
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "toExponentialWithPrecision - digits:2",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  "1.23e+5",
                  (123456).toExponential(2)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "toExponentialWithPrecision - digits:4",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    "1.2346e+5",
                    (123456).toExponential(4)
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "toExponentialWithPrecision - digits:20",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      "0.00000000000000000000e+0",
                      (0).toExponential(20)
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "File \"js_int_test.ml\", line 12, characters 3-10",
          (function (param) do
              return --[ ThrowAny ]--Block.__(7, [(function (param) do
                            (0).toExponential(101);
                            return --[ () ]--0;
                          end)]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "toExponentialWithPrecision - digits:-1",
            (function (param) do
                return --[ ThrowAny ]--Block.__(7, [(function (param) do
                              (0).toExponential(-1);
                              return --[ () ]--0;
                            end)]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "toPrecision",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            "123456",
                            (123456).toPrecision()
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "toPrecisionWithPrecision - digits:2",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              "1.2e+5",
                              (123456).toPrecision(2)
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "toPrecisionWithPrecision - digits:4",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                "1.235e+5",
                                (123456).toPrecision(4)
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "toPrecisionWithPrecision - digits:20",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  "0.0000000000000000000",
                                  (0).toPrecision(20)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "File \"js_int_test.ml\", line 25, characters 3-10",
                      (function (param) do
                          return --[ ThrowAny ]--Block.__(7, [(function (param) do
                                        (0).toPrecision(101);
                                        return --[ () ]--0;
                                      end)]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "toPrecisionWithPrecision - digits:-1",
                        (function (param) do
                            return --[ ThrowAny ]--Block.__(7, [(function (param) do
                                          (0).toPrecision(-1);
                                          return --[ () ]--0;
                                        end)]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "toString",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        "123",
                                        (123).toString()
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "toStringWithRadix - radix:2",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          "11110001001000000",
                                          (123456).toString(2)
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "toStringWithRadix - radix:16",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            "1e240",
                                            (123456).toString(16)
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "toStringWithRadix - radix:36",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              "2n9c",
                                              (123456).toString(36)
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "toStringWithRadix - radix:37",
                                  (function (param) do
                                      return --[ ThrowAny ]--Block.__(7, [(function (param) do
                                                    (0).toString(37);
                                                    return --[ () ]--0;
                                                  end)]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "toStringWithRadix - radix:1",
                                    (function (param) do
                                        return --[ ThrowAny ]--Block.__(7, [(function (param) do
                                                      (0).toString(1);
                                                      return --[ () ]--0;
                                                    end)]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "toStringWithRadix - radix:-1",
                                      (function (param) do
                                          return --[ ThrowAny ]--Block.__(7, [(function (param) do
                                                        (0).toString(-1);
                                                        return --[ () ]--0;
                                                      end)]);
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
];

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_int_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
