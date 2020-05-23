'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Caml_obj = require("../../lib/js/caml_obj.js");

function date(param) do
  return new Date("1976-03-08T12:34:56.789+01:23");
end

var suites_000 = --[ tuple ]--[
  "valueOf",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                195131516789,
                new Date("1976-03-08T12:34:56.789+01:23").valueOf()
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "make",
    (function (param) do
        return --[ Ok ]--Block.__(4, [new Date().getTime() > 1487223505382]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "parseAsFloat",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    Date.parse("1976-03-08T12:34:56.789+01:23"),
                    195131516789
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "parseAsFloat_invalid",
        (function (param) do
            return --[ Ok ]--Block.__(4, [isNaN(Date.parse("gibberish"))]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "fromFloat",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        "1976-03-08T11:11:56.789Z",
                        new Date(195131516789).toISOString()
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "fromString_valid",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          195131516789,
                          new Date("1976-03-08T12:34:56.789+01:23").getTime()
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "fromString_invalid",
              (function (param) do
                  return --[ Ok ]--Block.__(4, [isNaN(new Date("gibberish").getTime())]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "makeWithYM",
                (function (param) do
                    var d = new Date(1984, 4);
                    return --[ Eq ]--Block.__(0, [
                              --[ tuple ]--[
                                1984,
                                4
                              ],
                              --[ tuple ]--[
                                d.getFullYear(),
                                d.getMonth()
                              ]
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "makeWithYMD",
                  (function (param) do
                      var d = new Date(1984, 4, 6);
                      return --[ Eq ]--Block.__(0, [
                                --[ tuple ]--[
                                  1984,
                                  4,
                                  6
                                ],
                                --[ tuple ]--[
                                  d.getFullYear(),
                                  d.getMonth(),
                                  d.getDate()
                                ]
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "makeWithYMDH",
                    (function (param) do
                        var d = new Date(1984, 4, 6, 3);
                        return --[ Eq ]--Block.__(0, [
                                  --[ tuple ]--[
                                    1984,
                                    4,
                                    6,
                                    3
                                  ],
                                  --[ tuple ]--[
                                    d.getFullYear(),
                                    d.getMonth(),
                                    d.getDate(),
                                    d.getHours()
                                  ]
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "makeWithYMDHM",
                      (function (param) do
                          var d = new Date(1984, 4, 6, 3, 59);
                          return --[ Eq ]--Block.__(0, [
                                    --[ tuple ]--[
                                      1984,
                                      4,
                                      6,
                                      3,
                                      59
                                    ],
                                    --[ tuple ]--[
                                      d.getFullYear(),
                                      d.getMonth(),
                                      d.getDate(),
                                      d.getHours(),
                                      d.getMinutes()
                                    ]
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "makeWithYMDHMS",
                        (function (param) do
                            var d = new Date(1984, 4, 6, 3, 59, 27);
                            return --[ Eq ]--Block.__(0, [
                                      --[ tuple ]--[
                                        1984,
                                        4,
                                        6,
                                        3,
                                        59,
                                        27
                                      ],
                                      --[ tuple ]--[
                                        d.getFullYear(),
                                        d.getMonth(),
                                        d.getDate(),
                                        d.getHours(),
                                        d.getMinutes(),
                                        d.getSeconds()
                                      ]
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "utcWithYM",
                          (function (param) do
                              var d = Date.UTC(1984, 4);
                              var d$1 = new Date(d);
                              return --[ Eq ]--Block.__(0, [
                                        --[ tuple ]--[
                                          1984,
                                          4
                                        ],
                                        --[ tuple ]--[
                                          d$1.getUTCFullYear(),
                                          d$1.getUTCMonth()
                                        ]
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "utcWithYMD",
                            (function (param) do
                                var d = Date.UTC(1984, 4, 6);
                                var d$1 = new Date(d);
                                return --[ Eq ]--Block.__(0, [
                                          --[ tuple ]--[
                                            1984,
                                            4,
                                            6
                                          ],
                                          --[ tuple ]--[
                                            d$1.getUTCFullYear(),
                                            d$1.getUTCMonth(),
                                            d$1.getUTCDate()
                                          ]
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "utcWithYMDH",
                              (function (param) do
                                  var d = Date.UTC(1984, 4, 6, 3);
                                  var d$1 = new Date(d);
                                  return --[ Eq ]--Block.__(0, [
                                            --[ tuple ]--[
                                              1984,
                                              4,
                                              6,
                                              3
                                            ],
                                            --[ tuple ]--[
                                              d$1.getUTCFullYear(),
                                              d$1.getUTCMonth(),
                                              d$1.getUTCDate(),
                                              d$1.getUTCHours()
                                            ]
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "utcWithYMDHM",
                                (function (param) do
                                    var d = Date.UTC(1984, 4, 6, 3, 59);
                                    var d$1 = new Date(d);
                                    return --[ Eq ]--Block.__(0, [
                                              --[ tuple ]--[
                                                1984,
                                                4,
                                                6,
                                                3,
                                                59
                                              ],
                                              --[ tuple ]--[
                                                d$1.getUTCFullYear(),
                                                d$1.getUTCMonth(),
                                                d$1.getUTCDate(),
                                                d$1.getUTCHours(),
                                                d$1.getUTCMinutes()
                                              ]
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "utcWithYMDHMS",
                                  (function (param) do
                                      var d = Date.UTC(1984, 4, 6, 3, 59, 27);
                                      var d$1 = new Date(d);
                                      return --[ Eq ]--Block.__(0, [
                                                --[ tuple ]--[
                                                  1984,
                                                  4,
                                                  6,
                                                  3,
                                                  59,
                                                  27
                                                ],
                                                --[ tuple ]--[
                                                  d$1.getUTCFullYear(),
                                                  d$1.getUTCMonth(),
                                                  d$1.getUTCDate(),
                                                  d$1.getUTCHours(),
                                                  d$1.getUTCMinutes(),
                                                  d$1.getUTCSeconds()
                                                ]
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "getFullYear",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  1976,
                                                  new Date("1976-03-08T12:34:56.789+01:23").getFullYear()
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "getMilliseconds",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    789,
                                                    new Date("1976-03-08T12:34:56.789+01:23").getMilliseconds()
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "getSeconds",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      56,
                                                      new Date("1976-03-08T12:34:56.789+01:23").getSeconds()
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "getTime",
                                          (function (param) do
                                              return --[ Eq ]--Block.__(0, [
                                                        195131516789,
                                                        new Date("1976-03-08T12:34:56.789+01:23").getTime()
                                                      ]);
                                            end)
                                        ],
                                        --[ :: ]--[
                                          --[ tuple ]--[
                                            "getUTCDate",
                                            (function (param) do
                                                return --[ Eq ]--Block.__(0, [
                                                          8,
                                                          new Date("1976-03-08T12:34:56.789+01:23").getUTCDate()
                                                        ]);
                                              end)
                                          ],
                                          --[ :: ]--[
                                            --[ tuple ]--[
                                              "getUTCDay",
                                              (function (param) do
                                                  return --[ Eq ]--Block.__(0, [
                                                            1,
                                                            new Date("1976-03-08T12:34:56.789+01:23").getUTCDay()
                                                          ]);
                                                end)
                                            ],
                                            --[ :: ]--[
                                              --[ tuple ]--[
                                                "getUTCFUllYear",
                                                (function (param) do
                                                    return --[ Eq ]--Block.__(0, [
                                                              1976,
                                                              new Date("1976-03-08T12:34:56.789+01:23").getUTCFullYear()
                                                            ]);
                                                  end)
                                              ],
                                              --[ :: ]--[
                                                --[ tuple ]--[
                                                  "getUTCHours",
                                                  (function (param) do
                                                      return --[ Eq ]--Block.__(0, [
                                                                11,
                                                                new Date("1976-03-08T12:34:56.789+01:23").getUTCHours()
                                                              ]);
                                                    end)
                                                ],
                                                --[ :: ]--[
                                                  --[ tuple ]--[
                                                    "getUTCMilliseconds",
                                                    (function (param) do
                                                        return --[ Eq ]--Block.__(0, [
                                                                  789,
                                                                  new Date("1976-03-08T12:34:56.789+01:23").getUTCMilliseconds()
                                                                ]);
                                                      end)
                                                  ],
                                                  --[ :: ]--[
                                                    --[ tuple ]--[
                                                      "getUTCMinutes",
                                                      (function (param) do
                                                          return --[ Eq ]--Block.__(0, [
                                                                    11,
                                                                    new Date("1976-03-08T12:34:56.789+01:23").getUTCMinutes()
                                                                  ]);
                                                        end)
                                                    ],
                                                    --[ :: ]--[
                                                      --[ tuple ]--[
                                                        "getUTCMonth",
                                                        (function (param) do
                                                            return --[ Eq ]--Block.__(0, [
                                                                      2,
                                                                      new Date("1976-03-08T12:34:56.789+01:23").getUTCMonth()
                                                                    ]);
                                                          end)
                                                      ],
                                                      --[ :: ]--[
                                                        --[ tuple ]--[
                                                          "getUTCSeconds",
                                                          (function (param) do
                                                              return --[ Eq ]--Block.__(0, [
                                                                        56,
                                                                        new Date("1976-03-08T12:34:56.789+01:23").getUTCSeconds()
                                                                      ]);
                                                            end)
                                                        ],
                                                        --[ :: ]--[
                                                          --[ tuple ]--[
                                                            "getYear",
                                                            (function (param) do
                                                                return --[ Eq ]--Block.__(0, [
                                                                          1976,
                                                                          new Date("1976-03-08T12:34:56.789+01:23").getFullYear()
                                                                        ]);
                                                              end)
                                                          ],
                                                          --[ :: ]--[
                                                            --[ tuple ]--[
                                                              "setDate",
                                                              (function (param) do
                                                                  var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                  d.setDate(12);
                                                                  return --[ Eq ]--Block.__(0, [
                                                                            12,
                                                                            d.getDate()
                                                                          ]);
                                                                end)
                                                            ],
                                                            --[ :: ]--[
                                                              --[ tuple ]--[
                                                                "setFullYear",
                                                                (function (param) do
                                                                    var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                    d.setFullYear(1986);
                                                                    return --[ Eq ]--Block.__(0, [
                                                                              1986,
                                                                              d.getFullYear()
                                                                            ]);
                                                                  end)
                                                              ],
                                                              --[ :: ]--[
                                                                --[ tuple ]--[
                                                                  "setFullYearM",
                                                                  (function (param) do
                                                                      var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                      d.setFullYear(1986, 7);
                                                                      return --[ Eq ]--Block.__(0, [
                                                                                --[ tuple ]--[
                                                                                  1986,
                                                                                  7
                                                                                ],
                                                                                --[ tuple ]--[
                                                                                  d.getFullYear(),
                                                                                  d.getMonth()
                                                                                ]
                                                                              ]);
                                                                    end)
                                                                ],
                                                                --[ :: ]--[
                                                                  --[ tuple ]--[
                                                                    "setFullYearMD",
                                                                    (function (param) do
                                                                        var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                        d.setFullYear(1986, 7, 23);
                                                                        return --[ Eq ]--Block.__(0, [
                                                                                  --[ tuple ]--[
                                                                                    1986,
                                                                                    7,
                                                                                    23
                                                                                  ],
                                                                                  --[ tuple ]--[
                                                                                    d.getFullYear(),
                                                                                    d.getMonth(),
                                                                                    d.getDate()
                                                                                  ]
                                                                                ]);
                                                                      end)
                                                                  ],
                                                                  --[ :: ]--[
                                                                    --[ tuple ]--[
                                                                      "setHours",
                                                                      (function (param) do
                                                                          var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                          d.setHours(22);
                                                                          return --[ Eq ]--Block.__(0, [
                                                                                    22,
                                                                                    d.getHours()
                                                                                  ]);
                                                                        end)
                                                                    ],
                                                                    --[ :: ]--[
                                                                      --[ tuple ]--[
                                                                        "setHoursM",
                                                                        (function (param) do
                                                                            var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                            d.setHours(22, 48);
                                                                            return --[ Eq ]--Block.__(0, [
                                                                                      --[ tuple ]--[
                                                                                        22,
                                                                                        48
                                                                                      ],
                                                                                      --[ tuple ]--[
                                                                                        d.getHours(),
                                                                                        d.getMinutes()
                                                                                      ]
                                                                                    ]);
                                                                          end)
                                                                      ],
                                                                      --[ :: ]--[
                                                                        --[ tuple ]--[
                                                                          "setHoursMS",
                                                                          (function (param) do
                                                                              var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                              d.setHours(22, 48, 54);
                                                                              return --[ Eq ]--Block.__(0, [
                                                                                        --[ tuple ]--[
                                                                                          22,
                                                                                          48,
                                                                                          54
                                                                                        ],
                                                                                        --[ tuple ]--[
                                                                                          d.getHours(),
                                                                                          d.getMinutes(),
                                                                                          d.getSeconds()
                                                                                        ]
                                                                                      ]);
                                                                            end)
                                                                        ],
                                                                        --[ :: ]--[
                                                                          --[ tuple ]--[
                                                                            "setMilliseconds",
                                                                            (function (param) do
                                                                                var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                d.setMilliseconds(543);
                                                                                return --[ Eq ]--Block.__(0, [
                                                                                          543,
                                                                                          d.getMilliseconds()
                                                                                        ]);
                                                                              end)
                                                                          ],
                                                                          --[ :: ]--[
                                                                            --[ tuple ]--[
                                                                              "setMinutes",
                                                                              (function (param) do
                                                                                  var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                  d.setMinutes(18);
                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                            18,
                                                                                            d.getMinutes()
                                                                                          ]);
                                                                                end)
                                                                            ],
                                                                            --[ :: ]--[
                                                                              --[ tuple ]--[
                                                                                "setMinutesS",
                                                                                (function (param) do
                                                                                    var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                    d.setMinutes(18, 42);
                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                              --[ tuple ]--[
                                                                                                18,
                                                                                                42
                                                                                              ],
                                                                                              --[ tuple ]--[
                                                                                                d.getMinutes(),
                                                                                                d.getSeconds()
                                                                                              ]
                                                                                            ]);
                                                                                  end)
                                                                              ],
                                                                              --[ :: ]--[
                                                                                --[ tuple ]--[
                                                                                  "setMinutesSMs",
                                                                                  (function (param) do
                                                                                      var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                      d.setMinutes(18, 42, 311);
                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                --[ tuple ]--[
                                                                                                  18,
                                                                                                  42,
                                                                                                  311
                                                                                                ],
                                                                                                --[ tuple ]--[
                                                                                                  d.getMinutes(),
                                                                                                  d.getSeconds(),
                                                                                                  d.getMilliseconds()
                                                                                                ]
                                                                                              ]);
                                                                                    end)
                                                                                ],
                                                                                --[ :: ]--[
                                                                                  --[ tuple ]--[
                                                                                    "setMonth",
                                                                                    (function (param) do
                                                                                        var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                        d.setMonth(10);
                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                  10,
                                                                                                  d.getMonth()
                                                                                                ]);
                                                                                      end)
                                                                                  ],
                                                                                  --[ :: ]--[
                                                                                    --[ tuple ]--[
                                                                                      "setMonthD",
                                                                                      (function (param) do
                                                                                          var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                          d.setMonth(10, 14);
                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                    --[ tuple ]--[
                                                                                                      10,
                                                                                                      14
                                                                                                    ],
                                                                                                    --[ tuple ]--[
                                                                                                      d.getMonth(),
                                                                                                      d.getDate()
                                                                                                    ]
                                                                                                  ]);
                                                                                        end)
                                                                                    ],
                                                                                    --[ :: ]--[
                                                                                      --[ tuple ]--[
                                                                                        "setSeconds",
                                                                                        (function (param) do
                                                                                            var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                            d.setSeconds(36);
                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                      36,
                                                                                                      d.getSeconds()
                                                                                                    ]);
                                                                                          end)
                                                                                      ],
                                                                                      --[ :: ]--[
                                                                                        --[ tuple ]--[
                                                                                          "setSecondsMs",
                                                                                          (function (param) do
                                                                                              var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                              d.setSeconds(36, 420);
                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                        --[ tuple ]--[
                                                                                                          36,
                                                                                                          420
                                                                                                        ],
                                                                                                        --[ tuple ]--[
                                                                                                          d.getSeconds(),
                                                                                                          d.getMilliseconds()
                                                                                                        ]
                                                                                                      ]);
                                                                                            end)
                                                                                        ],
                                                                                        --[ :: ]--[
                                                                                          --[ tuple ]--[
                                                                                            "setUTCDate",
                                                                                            (function (param) do
                                                                                                var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                d.setUTCDate(12);
                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                          12,
                                                                                                          d.getUTCDate()
                                                                                                        ]);
                                                                                              end)
                                                                                          ],
                                                                                          --[ :: ]--[
                                                                                            --[ tuple ]--[
                                                                                              "setUTCFullYear",
                                                                                              (function (param) do
                                                                                                  var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                  d.setUTCFullYear(1986);
                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                            1986,
                                                                                                            d.getUTCFullYear()
                                                                                                          ]);
                                                                                                end)
                                                                                            ],
                                                                                            --[ :: ]--[
                                                                                              --[ tuple ]--[
                                                                                                "setUTCFullYearM",
                                                                                                (function (param) do
                                                                                                    var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                    d.setUTCFullYear(1986, 7);
                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                              --[ tuple ]--[
                                                                                                                1986,
                                                                                                                7
                                                                                                              ],
                                                                                                              --[ tuple ]--[
                                                                                                                d.getUTCFullYear(),
                                                                                                                d.getUTCMonth()
                                                                                                              ]
                                                                                                            ]);
                                                                                                  end)
                                                                                              ],
                                                                                              --[ :: ]--[
                                                                                                --[ tuple ]--[
                                                                                                  "setUTCFullYearMD",
                                                                                                  (function (param) do
                                                                                                      var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                      d.setUTCFullYear(1986, 7, 23);
                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                --[ tuple ]--[
                                                                                                                  1986,
                                                                                                                  7,
                                                                                                                  23
                                                                                                                ],
                                                                                                                --[ tuple ]--[
                                                                                                                  d.getUTCFullYear(),
                                                                                                                  d.getUTCMonth(),
                                                                                                                  d.getUTCDate()
                                                                                                                ]
                                                                                                              ]);
                                                                                                    end)
                                                                                                ],
                                                                                                --[ :: ]--[
                                                                                                  --[ tuple ]--[
                                                                                                    "setUTCHours",
                                                                                                    (function (param) do
                                                                                                        var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                        d.setUTCHours(22);
                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                  22,
                                                                                                                  d.getUTCHours()
                                                                                                                ]);
                                                                                                      end)
                                                                                                  ],
                                                                                                  --[ :: ]--[
                                                                                                    --[ tuple ]--[
                                                                                                      "setUTCHoursM",
                                                                                                      (function (param) do
                                                                                                          var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                          d.setUTCHours(22, 48);
                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                    --[ tuple ]--[
                                                                                                                      22,
                                                                                                                      48
                                                                                                                    ],
                                                                                                                    --[ tuple ]--[
                                                                                                                      d.getUTCHours(),
                                                                                                                      d.getUTCMinutes()
                                                                                                                    ]
                                                                                                                  ]);
                                                                                                        end)
                                                                                                    ],
                                                                                                    --[ :: ]--[
                                                                                                      --[ tuple ]--[
                                                                                                        "setUTCHoursMS",
                                                                                                        (function (param) do
                                                                                                            var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                            d.setUTCHours(22, 48, 54);
                                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                                      --[ tuple ]--[
                                                                                                                        22,
                                                                                                                        48,
                                                                                                                        54
                                                                                                                      ],
                                                                                                                      --[ tuple ]--[
                                                                                                                        d.getUTCHours(),
                                                                                                                        d.getUTCMinutes(),
                                                                                                                        d.getUTCSeconds()
                                                                                                                      ]
                                                                                                                    ]);
                                                                                                          end)
                                                                                                      ],
                                                                                                      --[ :: ]--[
                                                                                                        --[ tuple ]--[
                                                                                                          "setUTCMilliseconds",
                                                                                                          (function (param) do
                                                                                                              var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                              d.setUTCMilliseconds(543);
                                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                                        543,
                                                                                                                        d.getUTCMilliseconds()
                                                                                                                      ]);
                                                                                                            end)
                                                                                                        ],
                                                                                                        --[ :: ]--[
                                                                                                          --[ tuple ]--[
                                                                                                            "setUTCMinutes",
                                                                                                            (function (param) do
                                                                                                                var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                d.setUTCMinutes(18);
                                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                                          18,
                                                                                                                          d.getUTCMinutes()
                                                                                                                        ]);
                                                                                                              end)
                                                                                                          ],
                                                                                                          --[ :: ]--[
                                                                                                            --[ tuple ]--[
                                                                                                              "setUTCMinutesS",
                                                                                                              (function (param) do
                                                                                                                  var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                  d.setUTCMinutes(18, 42);
                                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                                            --[ tuple ]--[
                                                                                                                              18,
                                                                                                                              42
                                                                                                                            ],
                                                                                                                            --[ tuple ]--[
                                                                                                                              d.getUTCMinutes(),
                                                                                                                              d.getUTCSeconds()
                                                                                                                            ]
                                                                                                                          ]);
                                                                                                                end)
                                                                                                            ],
                                                                                                            --[ :: ]--[
                                                                                                              --[ tuple ]--[
                                                                                                                "setUTCMinutesSMs",
                                                                                                                (function (param) do
                                                                                                                    var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                    d.setUTCMinutes(18, 42, 311);
                                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                                              --[ tuple ]--[
                                                                                                                                18,
                                                                                                                                42,
                                                                                                                                311
                                                                                                                              ],
                                                                                                                              --[ tuple ]--[
                                                                                                                                d.getUTCMinutes(),
                                                                                                                                d.getUTCSeconds(),
                                                                                                                                d.getUTCMilliseconds()
                                                                                                                              ]
                                                                                                                            ]);
                                                                                                                  end)
                                                                                                              ],
                                                                                                              --[ :: ]--[
                                                                                                                --[ tuple ]--[
                                                                                                                  "setUTCMonth",
                                                                                                                  (function (param) do
                                                                                                                      var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                      d.setUTCMonth(10);
                                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                                10,
                                                                                                                                d.getUTCMonth()
                                                                                                                              ]);
                                                                                                                    end)
                                                                                                                ],
                                                                                                                --[ :: ]--[
                                                                                                                  --[ tuple ]--[
                                                                                                                    "setUTCMonthD",
                                                                                                                    (function (param) do
                                                                                                                        var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                        d.setUTCMonth(10, 14);
                                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                                  --[ tuple ]--[
                                                                                                                                    10,
                                                                                                                                    14
                                                                                                                                  ],
                                                                                                                                  --[ tuple ]--[
                                                                                                                                    d.getUTCMonth(),
                                                                                                                                    d.getUTCDate()
                                                                                                                                  ]
                                                                                                                                ]);
                                                                                                                      end)
                                                                                                                  ],
                                                                                                                  --[ :: ]--[
                                                                                                                    --[ tuple ]--[
                                                                                                                      "setUTCSeconds",
                                                                                                                      (function (param) do
                                                                                                                          var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                          d.setUTCSeconds(36);
                                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                                    36,
                                                                                                                                    d.getUTCSeconds()
                                                                                                                                  ]);
                                                                                                                        end)
                                                                                                                    ],
                                                                                                                    --[ :: ]--[
                                                                                                                      --[ tuple ]--[
                                                                                                                        "setUTCSecondsMs",
                                                                                                                        (function (param) do
                                                                                                                            var d = new Date("1976-03-08T12:34:56.789+01:23");
                                                                                                                            d.setUTCSeconds(36, 420);
                                                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                                                      --[ tuple ]--[
                                                                                                                                        36,
                                                                                                                                        420
                                                                                                                                      ],
                                                                                                                                      --[ tuple ]--[
                                                                                                                                        d.getUTCSeconds(),
                                                                                                                                        d.getUTCMilliseconds()
                                                                                                                                      ]
                                                                                                                                    ]);
                                                                                                                          end)
                                                                                                                      ],
                                                                                                                      --[ :: ]--[
                                                                                                                        --[ tuple ]--[
                                                                                                                          "toDateString",
                                                                                                                          (function (param) do
                                                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                                                        "Mon Mar 08 1976",
                                                                                                                                        new Date("1976-03-08T12:34:56.789+01:23").toDateString()
                                                                                                                                      ]);
                                                                                                                            end)
                                                                                                                        ],
                                                                                                                        --[ :: ]--[
                                                                                                                          --[ tuple ]--[
                                                                                                                            "toGMTString",
                                                                                                                            (function (param) do
                                                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                                                          "Mon, 08 Mar 1976 11:11:56 GMT",
                                                                                                                                          new Date("1976-03-08T12:34:56.789+01:23").toUTCString()
                                                                                                                                        ]);
                                                                                                                              end)
                                                                                                                          ],
                                                                                                                          --[ :: ]--[
                                                                                                                            --[ tuple ]--[
                                                                                                                              "toISOString",
                                                                                                                              (function (param) do
                                                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                                                            "1976-03-08T11:11:56.789Z",
                                                                                                                                            new Date("1976-03-08T12:34:56.789+01:23").toISOString()
                                                                                                                                          ]);
                                                                                                                                end)
                                                                                                                            ],
                                                                                                                            --[ :: ]--[
                                                                                                                              --[ tuple ]--[
                                                                                                                                "toJSON",
                                                                                                                                (function (param) do
                                                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                                                              "1976-03-08T11:11:56.789Z",
                                                                                                                                              new Date("1976-03-08T12:34:56.789+01:23").toJSON()
                                                                                                                                            ]);
                                                                                                                                  end)
                                                                                                                              ],
                                                                                                                              --[ :: ]--[
                                                                                                                                --[ tuple ]--[
                                                                                                                                  "toJSONUnsafe",
                                                                                                                                  (function (param) do
                                                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                                                "1976-03-08T11:11:56.789Z",
                                                                                                                                                new Date("1976-03-08T12:34:56.789+01:23").toJSON()
                                                                                                                                              ]);
                                                                                                                                    end)
                                                                                                                                ],
                                                                                                                                --[ :: ]--[
                                                                                                                                  --[ tuple ]--[
                                                                                                                                    "toUTCString",
                                                                                                                                    (function (param) do
                                                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                                                  "Mon, 08 Mar 1976 11:11:56 GMT",
                                                                                                                                                  new Date("1976-03-08T12:34:56.789+01:23").toUTCString()
                                                                                                                                                ]);
                                                                                                                                      end)
                                                                                                                                  ],
                                                                                                                                  --[ :: ]--[
                                                                                                                                    --[ tuple ]--[
                                                                                                                                      "eq",
                                                                                                                                      (function (param) do
                                                                                                                                          var a = new Date("2013-03-01T01:10:00");
                                                                                                                                          var b = new Date("2013-03-01T01:10:00");
                                                                                                                                          var c = new Date("2013-03-01T01:10:01");
                                                                                                                                          return --[ Ok ]--Block.__(4, [Caml_obj.caml_equal(a, b) and Caml_obj.caml_notequal(b, c) and Caml_obj.caml_greaterthan(c, b)]);
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

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_date_test", suites);

var N = --[ alias ]--0;

exports.N = N;
exports.date = date;
exports.suites = suites;
--[  Not a pure module ]--
