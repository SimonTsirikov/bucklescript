'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Js_vector = require("../../lib/js/js_vector.js");
var Caml_option = require("../../lib/js/caml_option.js");

var suites_000 = --[ tuple ]--[
  "File \"js_array_test.ml\", line 3, characters 4-11",
  (function (param) do
      var x = [
        1,
        2,
        3,
        4,
        5
      ];
      return --[ Eq ]--Block.__(0, [
                [
                  2,
                  4
                ],
                (Js_vector.filterInPlace((function (x) do
                          return x % 2 == 0;
                        end), x), x)
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "File \"js_array_test.ml\", line 11, characters 4-11",
    (function (param) do
        var x = [
          1,
          2,
          3,
          4,
          5
        ];
        return --[ Eq ]--Block.__(0, [
                  true,
                  (Js_vector.filterInPlace((function (x) do
                            return x > 10;
                          end), x), #x == 0)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "isArray_array",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    true,
                    Array.isArray([])
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "isArray_int",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      false,
                      Array.isArray(34)
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "length",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        3,
                        [
                          1,
                          2,
                          3
                        ].length
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "copyWithin",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          [
                            1,
                            2,
                            3,
                            1,
                            2
                          ],
                          [
                              1,
                              2,
                              3,
                              4,
                              5
                            ].copyWithin(-2)
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "copyWithinFrom",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            [
                              4,
                              5,
                              3,
                              4,
                              5
                            ],
                            [
                                1,
                                2,
                                3,
                                4,
                                5
                              ].copyWithin(0, 3)
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "copyWithinFromRange",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              [
                                4,
                                2,
                                3,
                                4,
                                5
                              ],
                              [
                                  1,
                                  2,
                                  3,
                                  4,
                                  5
                                ].copyWithin(0, 3, 4)
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "fillInPlace",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                [
                                  4,
                                  4,
                                  4
                                ],
                                [
                                    1,
                                    2,
                                    3
                                  ].fill(4)
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "fillFromInPlace",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  [
                                    1,
                                    4,
                                    4
                                  ],
                                  [
                                      1,
                                      2,
                                      3
                                    ].fill(4, 1)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "fillRangeInPlace",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    [
                                      1,
                                      4,
                                      3
                                    ],
                                    [
                                        1,
                                        2,
                                        3
                                      ].fill(4, 1, 2)
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "pop",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      3,
                                      Caml_option.undefined_to_opt([
                                              1,
                                              2,
                                              3
                                            ].pop())
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "pop - empty array",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        undefined,
                                        Caml_option.undefined_to_opt([].pop())
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "push",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          4,
                                          [
                                              1,
                                              2,
                                              3
                                            ].push(4)
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "pushMany",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            5,
                                            [
                                                1,
                                                2,
                                                3
                                              ].push(4, 5)
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "reverseInPlace",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              [
                                                3,
                                                2,
                                                1
                                              ],
                                              [
                                                  1,
                                                  2,
                                                  3
                                                ].reverse()
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "shift",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                1,
                                                Caml_option.undefined_to_opt([
                                                        1,
                                                        2,
                                                        3
                                                      ].shift())
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "shift - empty array",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  undefined,
                                                  Caml_option.undefined_to_opt([].shift())
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "sortInPlace",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    [
                                                      1,
                                                      2,
                                                      3
                                                    ],
                                                    [
                                                        3,
                                                        1,
                                                        2
                                                      ].sort()
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "sortInPlaceWith",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      [
                                                        3,
                                                        2,
                                                        1
                                                      ],
                                                      [
                                                          3,
                                                          1,
                                                          2
                                                        ].sort((function (a, b) do
                                                              return b - a | 0;
                                                            end))
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "spliceInPlace",
                                          (function (param) do
                                              var arr = [
                                                1,
                                                2,
                                                3,
                                                4
                                              ];
                                              var removed = arr.splice(2, 0, 5);
                                              return --[ Eq ]--Block.__(0, [
                                                        --[ tuple ]--[
                                                          [
                                                            1,
                                                            2,
                                                            5,
                                                            3,
                                                            4
                                                          ],
                                                          []
                                                        ],
                                                        --[ tuple ]--[
                                                          arr,
                                                          removed
                                                        ]
                                                      ]);
                                            end)
                                        ],
                                        --[ :: ]--[
                                          --[ tuple ]--[
                                            "removeFromInPlace",
                                            (function (param) do
                                                var arr = [
                                                  1,
                                                  2,
                                                  3,
                                                  4
                                                ];
                                                var removed = arr.splice(2);
                                                return --[ Eq ]--Block.__(0, [
                                                          --[ tuple ]--[
                                                            [
                                                              1,
                                                              2
                                                            ],
                                                            [
                                                              3,
                                                              4
                                                            ]
                                                          ],
                                                          --[ tuple ]--[
                                                            arr,
                                                            removed
                                                          ]
                                                        ]);
                                              end)
                                          ],
                                          --[ :: ]--[
                                            --[ tuple ]--[
                                              "removeCountInPlace",
                                              (function (param) do
                                                  var arr = [
                                                    1,
                                                    2,
                                                    3,
                                                    4
                                                  ];
                                                  var removed = arr.splice(2, 1);
                                                  return --[ Eq ]--Block.__(0, [
                                                            --[ tuple ]--[
                                                              [
                                                                1,
                                                                2,
                                                                4
                                                              ],
                                                              [3]
                                                            ],
                                                            --[ tuple ]--[
                                                              arr,
                                                              removed
                                                            ]
                                                          ]);
                                                end)
                                            ],
                                            --[ :: ]--[
                                              --[ tuple ]--[
                                                "unshift",
                                                (function (param) do
                                                    return --[ Eq ]--Block.__(0, [
                                                              4,
                                                              [
                                                                  1,
                                                                  2,
                                                                  3
                                                                ].unshift(4)
                                                            ]);
                                                  end)
                                              ],
                                              --[ :: ]--[
                                                --[ tuple ]--[
                                                  "unshiftMany",
                                                  (function (param) do
                                                      return --[ Eq ]--Block.__(0, [
                                                                5,
                                                                [
                                                                    1,
                                                                    2,
                                                                    3
                                                                  ].unshift(4, 5)
                                                              ]);
                                                    end)
                                                ],
                                                --[ :: ]--[
                                                  --[ tuple ]--[
                                                    "append",
                                                    (function (param) do
                                                        return --[ Eq ]--Block.__(0, [
                                                                  [
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4
                                                                  ],
                                                                  [
                                                                      1,
                                                                      2,
                                                                      3
                                                                    ].concat([4])
                                                                ]);
                                                      end)
                                                  ],
                                                  --[ :: ]--[
                                                    --[ tuple ]--[
                                                      "concat",
                                                      (function (param) do
                                                          return --[ Eq ]--Block.__(0, [
                                                                    [
                                                                      1,
                                                                      2,
                                                                      3,
                                                                      4,
                                                                      5
                                                                    ],
                                                                    [
                                                                        1,
                                                                        2,
                                                                        3
                                                                      ].concat([
                                                                          4,
                                                                          5
                                                                        ])
                                                                  ]);
                                                        end)
                                                    ],
                                                    --[ :: ]--[
                                                      --[ tuple ]--[
                                                        "concatMany",
                                                        (function (param) do
                                                            return --[ Eq ]--Block.__(0, [
                                                                      [
                                                                        1,
                                                                        2,
                                                                        3,
                                                                        4,
                                                                        5,
                                                                        6,
                                                                        7
                                                                      ],
                                                                      [
                                                                          1,
                                                                          2,
                                                                          3
                                                                        ].concat([
                                                                            4,
                                                                            5
                                                                          ], [
                                                                            6,
                                                                            7
                                                                          ])
                                                                    ]);
                                                          end)
                                                      ],
                                                      --[ :: ]--[
                                                        --[ tuple ]--[
                                                          "includes",
                                                          (function (param) do
                                                              return --[ Eq ]--Block.__(0, [
                                                                        true,
                                                                        [
                                                                            1,
                                                                            2,
                                                                            3
                                                                          ].includes(3)
                                                                      ]);
                                                            end)
                                                        ],
                                                        --[ :: ]--[
                                                          --[ tuple ]--[
                                                            "indexOf",
                                                            (function (param) do
                                                                return --[ Eq ]--Block.__(0, [
                                                                          1,
                                                                          [
                                                                              1,
                                                                              2,
                                                                              3
                                                                            ].indexOf(2)
                                                                        ]);
                                                              end)
                                                          ],
                                                          --[ :: ]--[
                                                            --[ tuple ]--[
                                                              "indexOfFrom",
                                                              (function (param) do
                                                                  return --[ Eq ]--Block.__(0, [
                                                                            3,
                                                                            [
                                                                                1,
                                                                                2,
                                                                                3,
                                                                                2
                                                                              ].indexOf(2, 2)
                                                                          ]);
                                                                end)
                                                            ],
                                                            --[ :: ]--[
                                                              --[ tuple ]--[
                                                                "join",
                                                                (function (param) do
                                                                    return --[ Eq ]--Block.__(0, [
                                                                              "1,2,3",
                                                                              [
                                                                                  1,
                                                                                  2,
                                                                                  3
                                                                                ].join()
                                                                            ]);
                                                                  end)
                                                              ],
                                                              --[ :: ]--[
                                                                --[ tuple ]--[
                                                                  "joinWith",
                                                                  (function (param) do
                                                                      return --[ Eq ]--Block.__(0, [
                                                                                "1;2;3",
                                                                                [
                                                                                    1,
                                                                                    2,
                                                                                    3
                                                                                  ].join(";")
                                                                              ]);
                                                                    end)
                                                                ],
                                                                --[ :: ]--[
                                                                  --[ tuple ]--[
                                                                    "lastIndexOf",
                                                                    (function (param) do
                                                                        return --[ Eq ]--Block.__(0, [
                                                                                  1,
                                                                                  [
                                                                                      1,
                                                                                      2,
                                                                                      3
                                                                                    ].lastIndexOf(2)
                                                                                ]);
                                                                      end)
                                                                  ],
                                                                  --[ :: ]--[
                                                                    --[ tuple ]--[
                                                                      "lastIndexOfFrom",
                                                                      (function (param) do
                                                                          return --[ Eq ]--Block.__(0, [
                                                                                    1,
                                                                                    [
                                                                                        1,
                                                                                        2,
                                                                                        3,
                                                                                        2
                                                                                      ].lastIndexOf(2, 2)
                                                                                  ]);
                                                                        end)
                                                                    ],
                                                                    --[ :: ]--[
                                                                      --[ tuple ]--[
                                                                        "slice",
                                                                        (function (param) do
                                                                            return --[ Eq ]--Block.__(0, [
                                                                                      [
                                                                                        2,
                                                                                        3
                                                                                      ],
                                                                                      [
                                                                                          1,
                                                                                          2,
                                                                                          3,
                                                                                          4,
                                                                                          5
                                                                                        ].slice(1, 3)
                                                                                    ]);
                                                                          end)
                                                                      ],
                                                                      --[ :: ]--[
                                                                        --[ tuple ]--[
                                                                          "copy",
                                                                          (function (param) do
                                                                              return --[ Eq ]--Block.__(0, [
                                                                                        [
                                                                                          1,
                                                                                          2,
                                                                                          3,
                                                                                          4,
                                                                                          5
                                                                                        ],
                                                                                        [
                                                                                            1,
                                                                                            2,
                                                                                            3,
                                                                                            4,
                                                                                            5
                                                                                          ].slice()
                                                                                      ]);
                                                                            end)
                                                                        ],
                                                                        --[ :: ]--[
                                                                          --[ tuple ]--[
                                                                            "sliceFrom",
                                                                            (function (param) do
                                                                                return --[ Eq ]--Block.__(0, [
                                                                                          [
                                                                                            3,
                                                                                            4,
                                                                                            5
                                                                                          ],
                                                                                          [
                                                                                              1,
                                                                                              2,
                                                                                              3,
                                                                                              4,
                                                                                              5
                                                                                            ].slice(2)
                                                                                        ]);
                                                                              end)
                                                                          ],
                                                                          --[ :: ]--[
                                                                            --[ tuple ]--[
                                                                              "toString",
                                                                              (function (param) do
                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                            "1,2,3",
                                                                                            [
                                                                                                1,
                                                                                                2,
                                                                                                3
                                                                                              ].toString()
                                                                                          ]);
                                                                                end)
                                                                            ],
                                                                            --[ :: ]--[
                                                                              --[ tuple ]--[
                                                                                "toLocaleString",
                                                                                (function (param) do
                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                              "1,2,3",
                                                                                              [
                                                                                                  1,
                                                                                                  2,
                                                                                                  3
                                                                                                ].toLocaleString()
                                                                                            ]);
                                                                                  end)
                                                                              ],
                                                                              --[ :: ]--[
                                                                                --[ tuple ]--[
                                                                                  "every",
                                                                                  (function (param) do
                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                true,
                                                                                                [
                                                                                                    1,
                                                                                                    2,
                                                                                                    3
                                                                                                  ].every((function (n) do
                                                                                                        return n > 0;
                                                                                                      end))
                                                                                              ]);
                                                                                    end)
                                                                                ],
                                                                                --[ :: ]--[
                                                                                  --[ tuple ]--[
                                                                                    "everyi",
                                                                                    (function (param) do
                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                  false,
                                                                                                  [
                                                                                                      1,
                                                                                                      2,
                                                                                                      3
                                                                                                    ].every((function (param, i) do
                                                                                                          return i > 0;
                                                                                                        end))
                                                                                                ]);
                                                                                      end)
                                                                                  ],
                                                                                  --[ :: ]--[
                                                                                    --[ tuple ]--[
                                                                                      "filter",
                                                                                      (function (param) do
                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                    [
                                                                                                      2,
                                                                                                      4
                                                                                                    ],
                                                                                                    [
                                                                                                        1,
                                                                                                        2,
                                                                                                        3,
                                                                                                        4
                                                                                                      ].filter((function (n) do
                                                                                                            return n % 2 == 0;
                                                                                                          end))
                                                                                                  ]);
                                                                                        end)
                                                                                    ],
                                                                                    --[ :: ]--[
                                                                                      --[ tuple ]--[
                                                                                        "filteri",
                                                                                        (function (param) do
                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                      [
                                                                                                        1,
                                                                                                        3
                                                                                                      ],
                                                                                                      [
                                                                                                          1,
                                                                                                          2,
                                                                                                          3,
                                                                                                          4
                                                                                                        ].filter((function (param, i) do
                                                                                                              return i % 2 == 0;
                                                                                                            end))
                                                                                                    ]);
                                                                                          end)
                                                                                      ],
                                                                                      --[ :: ]--[
                                                                                        --[ tuple ]--[
                                                                                          "find",
                                                                                          (function (param) do
                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                        2,
                                                                                                        Caml_option.undefined_to_opt([
                                                                                                                1,
                                                                                                                2,
                                                                                                                3,
                                                                                                                4
                                                                                                              ].find((function (n) do
                                                                                                                    return n % 2 == 0;
                                                                                                                  end)))
                                                                                                      ]);
                                                                                            end)
                                                                                        ],
                                                                                        --[ :: ]--[
                                                                                          --[ tuple ]--[
                                                                                            "find - no match",
                                                                                            (function (param) do
                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                          undefined,
                                                                                                          Caml_option.undefined_to_opt([
                                                                                                                  1,
                                                                                                                  2,
                                                                                                                  3,
                                                                                                                  4
                                                                                                                ].find((function (n) do
                                                                                                                      return n % 2 == 5;
                                                                                                                    end)))
                                                                                                        ]);
                                                                                              end)
                                                                                          ],
                                                                                          --[ :: ]--[
                                                                                            --[ tuple ]--[
                                                                                              "findi",
                                                                                              (function (param) do
                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                            1,
                                                                                                            Caml_option.undefined_to_opt([
                                                                                                                    1,
                                                                                                                    2,
                                                                                                                    3,
                                                                                                                    4
                                                                                                                  ].find((function (param, i) do
                                                                                                                        return i % 2 == 0;
                                                                                                                      end)))
                                                                                                          ]);
                                                                                                end)
                                                                                            ],
                                                                                            --[ :: ]--[
                                                                                              --[ tuple ]--[
                                                                                                "findi - no match",
                                                                                                (function (param) do
                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                              undefined,
                                                                                                              Caml_option.undefined_to_opt([
                                                                                                                      1,
                                                                                                                      2,
                                                                                                                      3,
                                                                                                                      4
                                                                                                                    ].find((function (param, i) do
                                                                                                                          return i % 2 == 5;
                                                                                                                        end)))
                                                                                                            ]);
                                                                                                  end)
                                                                                              ],
                                                                                              --[ :: ]--[
                                                                                                --[ tuple ]--[
                                                                                                  "findIndex",
                                                                                                  (function (param) do
                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                1,
                                                                                                                [
                                                                                                                    1,
                                                                                                                    2,
                                                                                                                    3,
                                                                                                                    4
                                                                                                                  ].findIndex((function (n) do
                                                                                                                        return n % 2 == 0;
                                                                                                                      end))
                                                                                                              ]);
                                                                                                    end)
                                                                                                ],
                                                                                                --[ :: ]--[
                                                                                                  --[ tuple ]--[
                                                                                                    "findIndexi",
                                                                                                    (function (param) do
                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                  0,
                                                                                                                  [
                                                                                                                      1,
                                                                                                                      2,
                                                                                                                      3,
                                                                                                                      4
                                                                                                                    ].findIndex((function (param, i) do
                                                                                                                          return i % 2 == 0;
                                                                                                                        end))
                                                                                                                ]);
                                                                                                      end)
                                                                                                  ],
                                                                                                  --[ :: ]--[
                                                                                                    --[ tuple ]--[
                                                                                                      "forEach",
                                                                                                      (function (param) do
                                                                                                          var sum = do
                                                                                                            contents: 0
                                                                                                          end;
                                                                                                          [
                                                                                                              1,
                                                                                                              2,
                                                                                                              3
                                                                                                            ].forEach((function (n) do
                                                                                                                  sum.contents = sum.contents + n | 0;
                                                                                                                  return --[ () ]--0;
                                                                                                                end));
                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                    6,
                                                                                                                    sum.contents
                                                                                                                  ]);
                                                                                                        end)
                                                                                                    ],
                                                                                                    --[ :: ]--[
                                                                                                      --[ tuple ]--[
                                                                                                        "forEachi",
                                                                                                        (function (param) do
                                                                                                            var sum = do
                                                                                                              contents: 0
                                                                                                            end;
                                                                                                            [
                                                                                                                1,
                                                                                                                2,
                                                                                                                3
                                                                                                              ].forEach((function (param, i) do
                                                                                                                    sum.contents = sum.contents + i | 0;
                                                                                                                    return --[ () ]--0;
                                                                                                                  end));
                                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                                      3,
                                                                                                                      sum.contents
                                                                                                                    ]);
                                                                                                          end)
                                                                                                      ],
                                                                                                      --[ :: ]--[
                                                                                                        --[ tuple ]--[
                                                                                                          "map",
                                                                                                          (function (param) do
                                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                                        [
                                                                                                                          2,
                                                                                                                          4,
                                                                                                                          6,
                                                                                                                          8
                                                                                                                        ],
                                                                                                                        [
                                                                                                                            1,
                                                                                                                            2,
                                                                                                                            3,
                                                                                                                            4
                                                                                                                          ].map((function (n) do
                                                                                                                                return (n << 1);
                                                                                                                              end))
                                                                                                                      ]);
                                                                                                            end)
                                                                                                        ],
                                                                                                        --[ :: ]--[
                                                                                                          --[ tuple ]--[
                                                                                                            "map",
                                                                                                            (function (param) do
                                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                                          [
                                                                                                                            0,
                                                                                                                            2,
                                                                                                                            4,
                                                                                                                            6
                                                                                                                          ],
                                                                                                                          [
                                                                                                                              1,
                                                                                                                              2,
                                                                                                                              3,
                                                                                                                              4
                                                                                                                            ].map((function (param, i) do
                                                                                                                                  return (i << 1);
                                                                                                                                end))
                                                                                                                        ]);
                                                                                                              end)
                                                                                                          ],
                                                                                                          --[ :: ]--[
                                                                                                            --[ tuple ]--[
                                                                                                              "reduce",
                                                                                                              (function (param) do
                                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                                            -10,
                                                                                                                            [
                                                                                                                                1,
                                                                                                                                2,
                                                                                                                                3,
                                                                                                                                4
                                                                                                                              ].reduce((function (acc, n) do
                                                                                                                                    return acc - n | 0;
                                                                                                                                  end), 0)
                                                                                                                          ]);
                                                                                                                end)
                                                                                                            ],
                                                                                                            --[ :: ]--[
                                                                                                              --[ tuple ]--[
                                                                                                                "reducei",
                                                                                                                (function (param) do
                                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                                              -6,
                                                                                                                              [
                                                                                                                                  1,
                                                                                                                                  2,
                                                                                                                                  3,
                                                                                                                                  4
                                                                                                                                ].reduce((function (acc, param, i) do
                                                                                                                                      return acc - i | 0;
                                                                                                                                    end), 0)
                                                                                                                            ]);
                                                                                                                  end)
                                                                                                              ],
                                                                                                              --[ :: ]--[
                                                                                                                --[ tuple ]--[
                                                                                                                  "reduceRight",
                                                                                                                  (function (param) do
                                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                                -10,
                                                                                                                                [
                                                                                                                                    1,
                                                                                                                                    2,
                                                                                                                                    3,
                                                                                                                                    4
                                                                                                                                  ].reduceRight((function (acc, n) do
                                                                                                                                        return acc - n | 0;
                                                                                                                                      end), 0)
                                                                                                                              ]);
                                                                                                                    end)
                                                                                                                ],
                                                                                                                --[ :: ]--[
                                                                                                                  --[ tuple ]--[
                                                                                                                    "reduceRighti",
                                                                                                                    (function (param) do
                                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                                  -6,
                                                                                                                                  [
                                                                                                                                      1,
                                                                                                                                      2,
                                                                                                                                      3,
                                                                                                                                      4
                                                                                                                                    ].reduceRight((function (acc, param, i) do
                                                                                                                                          return acc - i | 0;
                                                                                                                                        end), 0)
                                                                                                                                ]);
                                                                                                                      end)
                                                                                                                  ],
                                                                                                                  --[ :: ]--[
                                                                                                                    --[ tuple ]--[
                                                                                                                      "some",
                                                                                                                      (function (param) do
                                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                                    false,
                                                                                                                                    [
                                                                                                                                        1,
                                                                                                                                        2,
                                                                                                                                        3,
                                                                                                                                        4
                                                                                                                                      ].some((function (n) do
                                                                                                                                            return n <= 0;
                                                                                                                                          end))
                                                                                                                                  ]);
                                                                                                                        end)
                                                                                                                    ],
                                                                                                                    --[ :: ]--[
                                                                                                                      --[ tuple ]--[
                                                                                                                        "somei",
                                                                                                                        (function (param) do
                                                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                                                      true,
                                                                                                                                      [
                                                                                                                                          1,
                                                                                                                                          2,
                                                                                                                                          3,
                                                                                                                                          4
                                                                                                                                        ].some((function (param, i) do
                                                                                                                                              return i <= 0;
                                                                                                                                            end))
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
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_array_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
