'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Caml_obj = require("../../lib/js/caml_obj.js");

function date(param) do
  return new Date("1976-03-08T12:34:56.789+01:23");
end end

suites_000 = --[[ tuple ]][
  "valueOf",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                195131516789,
                new Date("1976-03-08T12:34:56.789+01:23").valueOf()
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "make",
    (function (param) do
        return --[[ Ok ]]Block.__(4, [new Date().getTime() > 1487223505382]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "parseAsFloat",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    Date.parse("1976-03-08T12:34:56.789+01:23"),
                    195131516789
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "parseAsFloat_invalid",
        (function (param) do
            return --[[ Ok ]]Block.__(4, [isNaN(Date.parse("gibberish"))]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "fromFloat",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        "1976-03-08T11:11:56.789Z",
                        new Date(195131516789).toISOString()
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "fromString_valid",
            (function (param) do
                return --[[ Eq ]]Block.__(0, [
                          195131516789,
                          new Date("1976-03-08T12:34:56.789+01:23").getTime()
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "fromString_invalid",
              (function (param) do
                  return --[[ Ok ]]Block.__(4, [isNaN(new Date("gibberish").getTime())]);
                end end)
            ],
            --[[ :: ]][
              --[[ tuple ]][
                "makeWithYM",
                (function (param) do
                    d = new Date(1984, 4);
                    return --[[ Eq ]]Block.__(0, [
                              --[[ tuple ]][
                                1984,
                                4
                              ],
                              --[[ tuple ]][
                                d.getFullYear(),
                                d.getMonth()
                              ]
                            ]);
                  end end)
              ],
              --[[ :: ]][
                --[[ tuple ]][
                  "makeWithYMD",
                  (function (param) do
                      d = new Date(1984, 4, 6);
                      return --[[ Eq ]]Block.__(0, [
                                --[[ tuple ]][
                                  1984,
                                  4,
                                  6
                                ],
                                --[[ tuple ]][
                                  d.getFullYear(),
                                  d.getMonth(),
                                  d.getDate()
                                ]
                              ]);
                    end end)
                ],
                --[[ :: ]][
                  --[[ tuple ]][
                    "makeWithYMDH",
                    (function (param) do
                        d = new Date(1984, 4, 6, 3);
                        return --[[ Eq ]]Block.__(0, [
                                  --[[ tuple ]][
                                    1984,
                                    4,
                                    6,
                                    3
                                  ],
                                  --[[ tuple ]][
                                    d.getFullYear(),
                                    d.getMonth(),
                                    d.getDate(),
                                    d.getHours()
                                  ]
                                ]);
                      end end)
                  ],
                  --[[ :: ]][
                    --[[ tuple ]][
                      "makeWithYMDHM",
                      (function (param) do
                          d = new Date(1984, 4, 6, 3, 59);
                          return --[[ Eq ]]Block.__(0, [
                                    --[[ tuple ]][
                                      1984,
                                      4,
                                      6,
                                      3,
                                      59
                                    ],
                                    --[[ tuple ]][
                                      d.getFullYear(),
                                      d.getMonth(),
                                      d.getDate(),
                                      d.getHours(),
                                      d.getMinutes()
                                    ]
                                  ]);
                        end end)
                    ],
                    --[[ :: ]][
                      --[[ tuple ]][
                        "makeWithYMDHMS",
                        (function (param) do
                            d = new Date(1984, 4, 6, 3, 59, 27);
                            return --[[ Eq ]]Block.__(0, [
                                      --[[ tuple ]][
                                        1984,
                                        4,
                                        6,
                                        3,
                                        59,
                                        27
                                      ],
                                      --[[ tuple ]][
                                        d.getFullYear(),
                                        d.getMonth(),
                                        d.getDate(),
                                        d.getHours(),
                                        d.getMinutes(),
                                        d.getSeconds()
                                      ]
                                    ]);
                          end end)
                      ],
                      --[[ :: ]][
                        --[[ tuple ]][
                          "utcWithYM",
                          (function (param) do
                              d = Date.UTC(1984, 4);
                              d$1 = new Date(d);
                              return --[[ Eq ]]Block.__(0, [
                                        --[[ tuple ]][
                                          1984,
                                          4
                                        ],
                                        --[[ tuple ]][
                                          d$1.getUTCFullYear(),
                                          d$1.getUTCMonth()
                                        ]
                                      ]);
                            end end)
                        ],
                        --[[ :: ]][
                          --[[ tuple ]][
                            "utcWithYMD",
                            (function (param) do
                                d = Date.UTC(1984, 4, 6);
                                d$1 = new Date(d);
                                return --[[ Eq ]]Block.__(0, [
                                          --[[ tuple ]][
                                            1984,
                                            4,
                                            6
                                          ],
                                          --[[ tuple ]][
                                            d$1.getUTCFullYear(),
                                            d$1.getUTCMonth(),
                                            d$1.getUTCDate()
                                          ]
                                        ]);
                              end end)
                          ],
                          --[[ :: ]][
                            --[[ tuple ]][
                              "utcWithYMDH",
                              (function (param) do
                                  d = Date.UTC(1984, 4, 6, 3);
                                  d$1 = new Date(d);
                                  return --[[ Eq ]]Block.__(0, [
                                            --[[ tuple ]][
                                              1984,
                                              4,
                                              6,
                                              3
                                            ],
                                            --[[ tuple ]][
                                              d$1.getUTCFullYear(),
                                              d$1.getUTCMonth(),
                                              d$1.getUTCDate(),
                                              d$1.getUTCHours()
                                            ]
                                          ]);
                                end end)
                            ],
                            --[[ :: ]][
                              --[[ tuple ]][
                                "utcWithYMDHM",
                                (function (param) do
                                    d = Date.UTC(1984, 4, 6, 3, 59);
                                    d$1 = new Date(d);
                                    return --[[ Eq ]]Block.__(0, [
                                              --[[ tuple ]][
                                                1984,
                                                4,
                                                6,
                                                3,
                                                59
                                              ],
                                              --[[ tuple ]][
                                                d$1.getUTCFullYear(),
                                                d$1.getUTCMonth(),
                                                d$1.getUTCDate(),
                                                d$1.getUTCHours(),
                                                d$1.getUTCMinutes()
                                              ]
                                            ]);
                                  end end)
                              ],
                              --[[ :: ]][
                                --[[ tuple ]][
                                  "utcWithYMDHMS",
                                  (function (param) do
                                      d = Date.UTC(1984, 4, 6, 3, 59, 27);
                                      d$1 = new Date(d);
                                      return --[[ Eq ]]Block.__(0, [
                                                --[[ tuple ]][
                                                  1984,
                                                  4,
                                                  6,
                                                  3,
                                                  59,
                                                  27
                                                ],
                                                --[[ tuple ]][
                                                  d$1.getUTCFullYear(),
                                                  d$1.getUTCMonth(),
                                                  d$1.getUTCDate(),
                                                  d$1.getUTCHours(),
                                                  d$1.getUTCMinutes(),
                                                  d$1.getUTCSeconds()
                                                ]
                                              ]);
                                    end end)
                                ],
                                --[[ :: ]][
                                  --[[ tuple ]][
                                    "getFullYear",
                                    (function (param) do
                                        return --[[ Eq ]]Block.__(0, [
                                                  1976,
                                                  new Date("1976-03-08T12:34:56.789+01:23").getFullYear()
                                                ]);
                                      end end)
                                  ],
                                  --[[ :: ]][
                                    --[[ tuple ]][
                                      "getMilliseconds",
                                      (function (param) do
                                          return --[[ Eq ]]Block.__(0, [
                                                    789,
                                                    new Date("1976-03-08T12:34:56.789+01:23").getMilliseconds()
                                                  ]);
                                        end end)
                                    ],
                                    --[[ :: ]][
                                      --[[ tuple ]][
                                        "getSeconds",
                                        (function (param) do
                                            return --[[ Eq ]]Block.__(0, [
                                                      56,
                                                      new Date("1976-03-08T12:34:56.789+01:23").getSeconds()
                                                    ]);
                                          end end)
                                      ],
                                      --[[ :: ]][
                                        --[[ tuple ]][
                                          "getTime",
                                          (function (param) do
                                              return --[[ Eq ]]Block.__(0, [
                                                        195131516789,
                                                        new Date("1976-03-08T12:34:56.789+01:23").getTime()
                                                      ]);
                                            end end)
                                        ],
                                        --[[ :: ]][
                                          --[[ tuple ]][
                                            "getUTCDate",
                                            (function (param) do
                                                return --[[ Eq ]]Block.__(0, [
                                                          8,
                                                          new Date("1976-03-08T12:34:56.789+01:23").getUTCDate()
                                                        ]);
                                              end end)
                                          ],
                                          --[[ :: ]][
                                            --[[ tuple ]][
                                              "getUTCDay",
                                              (function (param) do
                                                  return --[[ Eq ]]Block.__(0, [
                                                            1,
                                                            new Date("1976-03-08T12:34:56.789+01:23").getUTCDay()
                                                          ]);
                                                end end)
                                            ],
                                            --[[ :: ]][
                                              --[[ tuple ]][
                                                "getUTCFUllYear",
                                                (function (param) do
                                                    return --[[ Eq ]]Block.__(0, [
                                                              1976,
                                                              new Date("1976-03-08T12:34:56.789+01:23").getUTCFullYear()
                                                            ]);
                                                  end end)
                                              ],
                                              --[[ :: ]][
                                                --[[ tuple ]][
                                                  "getUTCHours",
                                                  (function (param) do
                                                      return --[[ Eq ]]Block.__(0, [
                                                                11,
                                                                new Date("1976-03-08T12:34:56.789+01:23").getUTCHours()
                                                              ]);
                                                    end end)
                                                ],
                                                --[[ :: ]][
                                                  --[[ tuple ]][
                                                    "getUTCMilliseconds",
                                                    (function (param) do
                                                        return --[[ Eq ]]Block.__(0, [
                                                                  789,
                                                                  new Date("1976-03-08T12:34:56.789+01:23").getUTCMilliseconds()
                                                                ]);
                                                      end end)
                                                  ],
                                                  --[[ :: ]][
                                                    --[[ tuple ]][
                                                      "getUTCMinutes",
                                                      (function (param) do
                                                          return --[[ Eq ]]Block.__(0, [
                                                                    11,
                                                                    new Date("1976-03-08T12:34:56.789+01:23").getUTCMinutes()
                                                                  ]);
                                                        end end)
                                                    ],
                                                    --[[ :: ]][
                                                      --[[ tuple ]][
                                                        "getUTCMonth",
                                                        (function (param) do
                                                            return --[[ Eq ]]Block.__(0, [
                                                                      2,
                                                                      new Date("1976-03-08T12:34:56.789+01:23").getUTCMonth()
                                                                    ]);
                                                          end end)
                                                      ],
                                                      --[[ :: ]][
                                                        --[[ tuple ]][
                                                          "getUTCSeconds",
                                                          (function (param) do
                                                              return --[[ Eq ]]Block.__(0, [
                                                                        56,
                                                                        new Date("1976-03-08T12:34:56.789+01:23").getUTCSeconds()
                                                                      ]);
                                                            end end)
                                                        ],
                                                        --[[ :: ]][
                                                          --[[ tuple ]][
                                                            "getYear",
                                                            (function (param) do
                                                                return --[[ Eq ]]Block.__(0, [
                                                                          1976,
                                                                          new Date("1976-03-08T12:34:56.789+01:23").getFullYear()
                                                                        ]);
                                                              end end)
                                                          ],
                                                          --[[ :: ]][
                                                            --[[ tuple ]][
                                                              "setDate",
                                                              (function (param) do
                                                                  d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                  d.setDate(12);
                                                                  return --[[ Eq ]]Block.__(0, [
                                                                            12,
                                                                            d.getDate()
                                                                          ]);
                                                                end end)
                                                            ],
                                                            --[[ :: ]][
                                                              --[[ tuple ]][
                                                                "setFullYear",
                                                                (function (param) do
                                                                    d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                    d.setFullYear(1986);
                                                                    return --[[ Eq ]]Block.__(0, [
                                                                              1986,
                                                                              d.getFullYear()
                                                                            ]);
                                                                  end end)
                                                              ],
                                                              --[[ :: ]][
                                                                --[[ tuple ]][
                                                                  "setFullYearM",
                                                                  (function (param) do
                                                                      d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                      d.setFullYear(1986, 7);
                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                --[[ tuple ]][
                                                                                  1986,
                                                                                  7
                                                                                ],
                                                                                --[[ tuple ]][
                                                                                  d.getFullYear(),
                                                                                  d.getMonth()
                                                                                ]
                                                                              ]);
                                                                    end end)
                                                                ],
                                                                --[[ :: ]][
                                                                  --[[ tuple ]][
                                                                    "setFullYearMD",
                                                                    (function (param) do
                                                                        d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                        d.setFullYear(1986, 7, 23);
                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                  --[[ tuple ]][
                                                                                    1986,
                                                                                    7,
                                                                                    23
                                                                                  ],
                                                                                  --[[ tuple ]][
                                                                                    d.getFullYear(),
                                                                                    d.getMonth(),
                                                                                    d.getDate()
                                                                                  ]
                                                                                ]);
                                                                      end end)
                                                                  ],
                                                                  --[[ :: ]][
                                                                    --[[ tuple ]][
                                                                      "setHours",
                                                                      (function (param) do
                                                                          d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                          d.setHours(22);
                                                                          return --[[ Eq ]]Block.__(0, [
                                                                                    22,
                                                                                    d.getHours()
                                                                                  ]);
                                                                        end end)
                                                                    ],
                                                                    --[[ :: ]][
                                                                      --[[ tuple ]][
                                                                        "setHoursM",
                                                                        (function (param) do
                                                                            d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                            d.setHours(22, 48);
                                                                            return --[[ Eq ]]Block.__(0, [
                                                                                      --[[ tuple ]][
                                                                                        22,
                                                                                        48
                                                                                      ],
                                                                                      --[[ tuple ]][
                                                                                        d.getHours(),
                                                                                        d.getMinutes()
                                                                                      ]
                                                                                    ]);
                                                                          end end)
                                                                      ],
                                                                      --[[ :: ]][
                                                                        --[[ tuple ]][
                                                                          "setHoursMS",
                                                                          (function (param) do
                                                                              d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                              d.setHours(22, 48, 54);
                                                                              return --[[ Eq ]]Block.__(0, [
                                                                                        --[[ tuple ]][
                                                                                          22,
                                                                                          48,
                                                                                          54
                                                                                        ],
                                                                                        --[[ tuple ]][
                                                                                          d.getHours(),
                                                                                          d.getMinutes(),
                                                                                          d.getSeconds()
                                                                                        ]
                                                                                      ]);
                                                                            end end)
                                                                        ],
                                                                        --[[ :: ]][
                                                                          --[[ tuple ]][
                                                                            "setMilliseconds",
                                                                            (function (param) do
                                                                                d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                d.setMilliseconds(543);
                                                                                return --[[ Eq ]]Block.__(0, [
                                                                                          543,
                                                                                          d.getMilliseconds()
                                                                                        ]);
                                                                              end end)
                                                                          ],
                                                                          --[[ :: ]][
                                                                            --[[ tuple ]][
                                                                              "setMinutes",
                                                                              (function (param) do
                                                                                  d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                  d.setMinutes(18);
                                                                                  return --[[ Eq ]]Block.__(0, [
                                                                                            18,
                                                                                            d.getMinutes()
                                                                                          ]);
                                                                                end end)
                                                                            ],
                                                                            --[[ :: ]][
                                                                              --[[ tuple ]][
                                                                                "setMinutesS",
                                                                                (function (param) do
                                                                                    d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                    d.setMinutes(18, 42);
                                                                                    return --[[ Eq ]]Block.__(0, [
                                                                                              --[[ tuple ]][
                                                                                                18,
                                                                                                42
                                                                                              ],
                                                                                              --[[ tuple ]][
                                                                                                d.getMinutes(),
                                                                                                d.getSeconds()
                                                                                              ]
                                                                                            ]);
                                                                                  end end)
                                                                              ],
                                                                              --[[ :: ]][
                                                                                --[[ tuple ]][
                                                                                  "setMinutesSMs",
                                                                                  (function (param) do
                                                                                      d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                      d.setMinutes(18, 42, 311);
                                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                                --[[ tuple ]][
                                                                                                  18,
                                                                                                  42,
                                                                                                  311
                                                                                                ],
                                                                                                --[[ tuple ]][
                                                                                                  d.getMinutes(),
                                                                                                  d.getSeconds(),
                                                                                                  d.getMilliseconds()
                                                                                                ]
                                                                                              ]);
                                                                                    end end)
                                                                                ],
                                                                                --[[ :: ]][
                                                                                  --[[ tuple ]][
                                                                                    "setMonth",
                                                                                    (function (param) do
                                                                                        d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                        d.setMonth(10);
                                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                                  10,
                                                                                                  d.getMonth()
                                                                                                ]);
                                                                                      end end)
                                                                                  ],
                                                                                  --[[ :: ]][
                                                                                    --[[ tuple ]][
                                                                                      "setMonthD",
                                                                                      (function (param) do
                                                                                          d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                          d.setMonth(10, 14);
                                                                                          return --[[ Eq ]]Block.__(0, [
                                                                                                    --[[ tuple ]][
                                                                                                      10,
                                                                                                      14
                                                                                                    ],
                                                                                                    --[[ tuple ]][
                                                                                                      d.getMonth(),
                                                                                                      d.getDate()
                                                                                                    ]
                                                                                                  ]);
                                                                                        end end)
                                                                                    ],
                                                                                    --[[ :: ]][
                                                                                      --[[ tuple ]][
                                                                                        "setSeconds",
                                                                                        (function (param) do
                                                                                            d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                            d.setSeconds(36);
                                                                                            return --[[ Eq ]]Block.__(0, [
                                                                                                      36,
                                                                                                      d.getSeconds()
                                                                                                    ]);
                                                                                          end end)
                                                                                      ],
                                                                                      --[[ :: ]][
                                                                                        --[[ tuple ]][
                                                                                          "setSecondsMs",
                                                                                          (function (param) do
                                                                                              d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                              d.setSeconds(36, 420);
                                                                                              return --[[ Eq ]]Block.__(0, [
                                                                                                        --[[ tuple ]][
                                                                                                          36,
                                                                                                          420
                                                                                                        ],
                                                                                                        --[[ tuple ]][
                                                                                                          d.getSeconds(),
                                                                                                          d.getMilliseconds()
                                                                                                        ]
                                                                                                      ]);
                                                                                            end end)
                                                                                        ],
                                                                                        --[[ :: ]][
                                                                                          --[[ tuple ]][
                                                                                            "setUTCDate",
                                                                                            (function (param) do
                                                                                                d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                d.setUTCDate(12);
                                                                                                return --[[ Eq ]]Block.__(0, [
                                                                                                          12,
                                                                                                          d.getUTCDate()
                                                                                                        ]);
                                                                                              end end)
                                                                                          ],
                                                                                          --[[ :: ]][
                                                                                            --[[ tuple ]][
                                                                                              "setUTCFullYear",
                                                                                              (function (param) do
                                                                                                  d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                  d.setUTCFullYear(1986);
                                                                                                  return --[[ Eq ]]Block.__(0, [
                                                                                                            1986,
                                                                                                            d.getUTCFullYear()
                                                                                                          ]);
                                                                                                end end)
                                                                                            ],
                                                                                            --[[ :: ]][
                                                                                              --[[ tuple ]][
                                                                                                "setUTCFullYearM",
                                                                                                (function (param) do
                                                                                                    d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                    d.setUTCFullYear(1986, 7);
                                                                                                    return --[[ Eq ]]Block.__(0, [
                                                                                                              --[[ tuple ]][
                                                                                                                1986,
                                                                                                                7
                                                                                                              ],
                                                                                                              --[[ tuple ]][
                                                                                                                d.getUTCFullYear(),
                                                                                                                d.getUTCMonth()
                                                                                                              ]
                                                                                                            ]);
                                                                                                  end end)
                                                                                              ],
                                                                                              --[[ :: ]][
                                                                                                --[[ tuple ]][
                                                                                                  "setUTCFullYearMD",
                                                                                                  (function (param) do
                                                                                                      d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                      d.setUTCFullYear(1986, 7, 23);
                                                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                                                --[[ tuple ]][
                                                                                                                  1986,
                                                                                                                  7,
                                                                                                                  23
                                                                                                                ],
                                                                                                                --[[ tuple ]][
                                                                                                                  d.getUTCFullYear(),
                                                                                                                  d.getUTCMonth(),
                                                                                                                  d.getUTCDate()
                                                                                                                ]
                                                                                                              ]);
                                                                                                    end end)
                                                                                                ],
                                                                                                --[[ :: ]][
                                                                                                  --[[ tuple ]][
                                                                                                    "setUTCHours",
                                                                                                    (function (param) do
                                                                                                        d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                        d.setUTCHours(22);
                                                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                                                  22,
                                                                                                                  d.getUTCHours()
                                                                                                                ]);
                                                                                                      end end)
                                                                                                  ],
                                                                                                  --[[ :: ]][
                                                                                                    --[[ tuple ]][
                                                                                                      "setUTCHoursM",
                                                                                                      (function (param) do
                                                                                                          d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                          d.setUTCHours(22, 48);
                                                                                                          return --[[ Eq ]]Block.__(0, [
                                                                                                                    --[[ tuple ]][
                                                                                                                      22,
                                                                                                                      48
                                                                                                                    ],
                                                                                                                    --[[ tuple ]][
                                                                                                                      d.getUTCHours(),
                                                                                                                      d.getUTCMinutes()
                                                                                                                    ]
                                                                                                                  ]);
                                                                                                        end end)
                                                                                                    ],
                                                                                                    --[[ :: ]][
                                                                                                      --[[ tuple ]][
                                                                                                        "setUTCHoursMS",
                                                                                                        (function (param) do
                                                                                                            d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                            d.setUTCHours(22, 48, 54);
                                                                                                            return --[[ Eq ]]Block.__(0, [
                                                                                                                      --[[ tuple ]][
                                                                                                                        22,
                                                                                                                        48,
                                                                                                                        54
                                                                                                                      ],
                                                                                                                      --[[ tuple ]][
                                                                                                                        d.getUTCHours(),
                                                                                                                        d.getUTCMinutes(),
                                                                                                                        d.getUTCSeconds()
                                                                                                                      ]
                                                                                                                    ]);
                                                                                                          end end)
                                                                                                      ],
                                                                                                      --[[ :: ]][
                                                                                                        --[[ tuple ]][
                                                                                                          "setUTCMilliseconds",
                                                                                                          (function (param) do
                                                                                                              d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                              d.setUTCMilliseconds(543);
                                                                                                              return --[[ Eq ]]Block.__(0, [
                                                                                                                        543,
                                                                                                                        d.getUTCMilliseconds()
                                                                                                                      ]);
                                                                                                            end end)
                                                                                                        ],
                                                                                                        --[[ :: ]][
                                                                                                          --[[ tuple ]][
                                                                                                            "setUTCMinutes",
                                                                                                            (function (param) do
                                                                                                                d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                d.setUTCMinutes(18);
                                                                                                                return --[[ Eq ]]Block.__(0, [
                                                                                                                          18,
                                                                                                                          d.getUTCMinutes()
                                                                                                                        ]);
                                                                                                              end end)
                                                                                                          ],
                                                                                                          --[[ :: ]][
                                                                                                            --[[ tuple ]][
                                                                                                              "setUTCMinutesS",
                                                                                                              (function (param) do
                                                                                                                  d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                  d.setUTCMinutes(18, 42);
                                                                                                                  return --[[ Eq ]]Block.__(0, [
                                                                                                                            --[[ tuple ]][
                                                                                                                              18,
                                                                                                                              42
                                                                                                                            ],
                                                                                                                            --[[ tuple ]][
                                                                                                                              d.getUTCMinutes(),
                                                                                                                              d.getUTCSeconds()
                                                                                                                            ]
                                                                                                                          ]);
                                                                                                                end end)
                                                                                                            ],
                                                                                                            --[[ :: ]][
                                                                                                              --[[ tuple ]][
                                                                                                                "setUTCMinutesSMs",
                                                                                                                (function (param) do
                                                                                                                    d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                    d.setUTCMinutes(18, 42, 311);
                                                                                                                    return --[[ Eq ]]Block.__(0, [
                                                                                                                              --[[ tuple ]][
                                                                                                                                18,
                                                                                                                                42,
                                                                                                                                311
                                                                                                                              ],
                                                                                                                              --[[ tuple ]][
                                                                                                                                d.getUTCMinutes(),
                                                                                                                                d.getUTCSeconds(),
                                                                                                                                d.getUTCMilliseconds()
                                                                                                                              ]
                                                                                                                            ]);
                                                                                                                  end end)
                                                                                                              ],
                                                                                                              --[[ :: ]][
                                                                                                                --[[ tuple ]][
                                                                                                                  "setUTCMonth",
                                                                                                                  (function (param) do
                                                                                                                      d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                      d.setUTCMonth(10);
                                                                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                                                                10,
                                                                                                                                d.getUTCMonth()
                                                                                                                              ]);
                                                                                                                    end end)
                                                                                                                ],
                                                                                                                --[[ :: ]][
                                                                                                                  --[[ tuple ]][
                                                                                                                    "setUTCMonthD",
                                                                                                                    (function (param) do
                                                                                                                        d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                        d.setUTCMonth(10, 14);
                                                                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                                                                  --[[ tuple ]][
                                                                                                                                    10,
                                                                                                                                    14
                                                                                                                                  ],
                                                                                                                                  --[[ tuple ]][
                                                                                                                                    d.getUTCMonth(),
                                                                                                                                    d.getUTCDate()
                                                                                                                                  ]
                                                                                                                                ]);
                                                                                                                      end end)
                                                                                                                  ],
                                                                                                                  --[[ :: ]][
                                                                                                                    --[[ tuple ]][
                                                                                                                      "setUTCSeconds",
                                                                                                                      (function (param) do
                                                                                                                          d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                          d.setUTCSeconds(36);
                                                                                                                          return --[[ Eq ]]Block.__(0, [
                                                                                                                                    36,
                                                                                                                                    d.getUTCSeconds()
                                                                                                                                  ]);
                                                                                                                        end end)
                                                                                                                    ],
                                                                                                                    --[[ :: ]][
                                                                                                                      --[[ tuple ]][
                                                                                                                        "setUTCSecondsMs",
                                                                                                                        (function (param) do
                                                                                                                            d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                            d.setUTCSeconds(36, 420);
                                                                                                                            return --[[ Eq ]]Block.__(0, [
                                                                                                                                      --[[ tuple ]][
                                                                                                                                        36,
                                                                                                                                        420
                                                                                                                                      ],
                                                                                                                                      --[[ tuple ]][
                                                                                                                                        d.getUTCSeconds(),
                                                                                                                                        d.getUTCMilliseconds()
                                                                                                                                      ]
                                                                                                                                    ]);
                                                                                                                          end end)
                                                                                                                      ],
                                                                                                                      --[[ :: ]][
                                                                                                                        --[[ tuple ]][
                                                                                                                          "toDateString",
                                                                                                                          (function (param) do
                                                                                                                              return --[[ Eq ]]Block.__(0, [
                                                                                                                                        "Mon Mar 08 1976",
                                                                                                                                        new Date("1976-03-08T12:34:56.789+01:23").toDateString()
                                                                                                                                      ]);
                                                                                                                            end end)
                                                                                                                        ],
                                                                                                                        --[[ :: ]][
                                                                                                                          --[[ tuple ]][
                                                                                                                            "toGMTString",
                                                                                                                            (function (param) do
                                                                                                                                return --[[ Eq ]]Block.__(0, [
                                                                                                                                          "Mon, 08 Mar 1976 11:11:56 GMT",
                                                                                                                                          new Date("1976-03-08T12:34:56.789+01:23").toUTCString()
                                                                                                                                        ]);
                                                                                                                              end end)
                                                                                                                          ],
                                                                                                                          --[[ :: ]][
                                                                                                                            --[[ tuple ]][
                                                                                                                              "toISOString",
                                                                                                                              (function (param) do
                                                                                                                                  return --[[ Eq ]]Block.__(0, [
                                                                                                                                            "1976-03-08T11:11:56.789Z",
                                                                                                                                            new Date("1976-03-08T12:34:56.789+01:23").toISOString()
                                                                                                                                          ]);
                                                                                                                                end end)
                                                                                                                            ],
                                                                                                                            --[[ :: ]][
                                                                                                                              --[[ tuple ]][
                                                                                                                                "toJSON",
                                                                                                                                (function (param) do
                                                                                                                                    return --[[ Eq ]]Block.__(0, [
                                                                                                                                              "1976-03-08T11:11:56.789Z",
                                                                                                                                              new Date("1976-03-08T12:34:56.789+01:23").toJSON()
                                                                                                                                            ]);
                                                                                                                                  end end)
                                                                                                                              ],
                                                                                                                              --[[ :: ]][
                                                                                                                                --[[ tuple ]][
                                                                                                                                  "toJSONUnsafe",
                                                                                                                                  (function (param) do
                                                                                                                                      return --[[ Eq ]]Block.__(0, [
                                                                                                                                                "1976-03-08T11:11:56.789Z",
                                                                                                                                                new Date("1976-03-08T12:34:56.789+01:23").toJSON()
                                                                                                                                              ]);
                                                                                                                                    end end)
                                                                                                                                ],
                                                                                                                                --[[ :: ]][
                                                                                                                                  --[[ tuple ]][
                                                                                                                                    "toUTCString",
                                                                                                                                    (function (param) do
                                                                                                                                        return --[[ Eq ]]Block.__(0, [
                                                                                                                                                  "Mon, 08 Mar 1976 11:11:56 GMT",
                                                                                                                                                  new Date("1976-03-08T12:34:56.789+01:23").toUTCString()
                                                                                                                                                ]);
                                                                                                                                      end end)
                                                                                                                                  ],
                                                                                                                                  --[[ :: ]][
                                                                                                                                    --[[ tuple ]][
                                                                                                                                      "eq",
                                                                                                                                      (function (param) do
                                                                                                                                          a = new Date("2013-03-01T01:10:00");
                                                                                                                                          b = new Date("2013-03-01T01:10:00");
                                                                                                                                          c = new Date("2013-03-01T01:10:01");
                                                                                                                                          return --[[ Ok ]]Block.__(4, [Caml_obj.caml_equal(a, b) and Caml_obj.caml_notequal(b, c) and Caml_obj.caml_greaterthan(c, b)]);
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

Mt.from_pair_suites("Js_date_test", suites);

N = --[[ alias ]]0;

exports.N = N;
exports.date = date;
exports.suites = suites;
--[[  Not a pure module ]]
