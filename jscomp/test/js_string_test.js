'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Caml_option = require("../../lib/js/caml_option.js");

var suites_000 = --[ tuple ]--[
  "make",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                "null",
                String(null).concat("")
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "fromCharCode",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  "a",
                  String.fromCharCode(97)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "fromCharCodeMany",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    "az",
                    String.fromCharCode(97, 122)
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "fromCodePoint",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      "a",
                      String.fromCodePoint(97)
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "fromCodePointMany",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        "az",
                        String.fromCodePoint(97, 122)
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "length",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          3,
                          "foo".length
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "get",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            "a",
                            "foobar"[4]
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "charAt",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              "a",
                              "foobar".charAt(4)
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "charCodeAt",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                97,
                                "foobar".charCodeAt(4)
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "codePointAt",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  97,
                                  "foobar".codePointAt(4)
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "codePointAt - out of bounds",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    undefined,
                                    "foobar".codePointAt(98)
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "concat",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      "foobar",
                                      "foo".concat("bar")
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "concatMany",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        "foobarbaz",
                                        "foo".concat("bar", "baz")
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "endsWith",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          true,
                                          "foobar".endsWith("bar")
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "endsWithFrom",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            false,
                                            "foobar".endsWith("bar", 1)
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "includes",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              true,
                                              "foobarbaz".includes("bar")
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "includesFrom",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                false,
                                                "foobarbaz".includes("bar", 4)
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "indexOf",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  3,
                                                  "foobarbaz".indexOf("bar")
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "indexOfFrom",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    -1,
                                                    "foobarbaz".indexOf("bar", 4)
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "lastIndexOf",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      3,
                                                      "foobarbaz".lastIndexOf("bar")
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "lastIndexOfFrom",
                                          (function (param) do
                                              return --[ Eq ]--Block.__(0, [
                                                        3,
                                                        "foobarbaz".lastIndexOf("bar", 4)
                                                      ]);
                                            end)
                                        ],
                                        --[ :: ]--[
                                          --[ tuple ]--[
                                            "localeCompare",
                                            (function (param) do
                                                return --[ Eq ]--Block.__(0, [
                                                          0,
                                                          "foo".localeCompare("foo")
                                                        ]);
                                              end)
                                          ],
                                          --[ :: ]--[
                                            --[ tuple ]--[
                                              "match",
                                              (function (param) do
                                                  return --[ Eq ]--Block.__(0, [
                                                            [
                                                              "na",
                                                              "na"
                                                            ],
                                                            Caml_option.null_to_opt("banana".match(/na+/g))
                                                          ]);
                                                end)
                                            ],
                                            --[ :: ]--[
                                              --[ tuple ]--[
                                                "match - no match",
                                                (function (param) do
                                                    return --[ Eq ]--Block.__(0, [
                                                              undefined,
                                                              Caml_option.null_to_opt("banana".match(/nanana+/g))
                                                            ]);
                                                  end)
                                              ],
                                              --[ :: ]--[
                                                --[ tuple ]--[
                                                  "normalize",
                                                  (function (param) do
                                                      return --[ Eq ]--Block.__(0, [
                                                                "foo",
                                                                "foo".normalize()
                                                              ]);
                                                    end)
                                                ],
                                                --[ :: ]--[
                                                  --[ tuple ]--[
                                                    "normalizeByForm",
                                                    (function (param) do
                                                        return --[ Eq ]--Block.__(0, [
                                                                  "foo",
                                                                  "foo".normalize("NFKD")
                                                                ]);
                                                      end)
                                                  ],
                                                  --[ :: ]--[
                                                    --[ tuple ]--[
                                                      "repeat",
                                                      (function (param) do
                                                          return --[ Eq ]--Block.__(0, [
                                                                    "foofoofoo",
                                                                    "foo".repeat(3)
                                                                  ]);
                                                        end)
                                                    ],
                                                    --[ :: ]--[
                                                      --[ tuple ]--[
                                                        "replace",
                                                        (function (param) do
                                                            return --[ Eq ]--Block.__(0, [
                                                                      "fooBORKbaz",
                                                                      "foobarbaz".replace("bar", "BORK")
                                                                    ]);
                                                          end)
                                                      ],
                                                      --[ :: ]--[
                                                        --[ tuple ]--[
                                                          "replaceByRe",
                                                          (function (param) do
                                                              return --[ Eq ]--Block.__(0, [
                                                                        "fooBORKBORK",
                                                                        "foobarbaz".replace(/ba./g, "BORK")
                                                                      ]);
                                                            end)
                                                        ],
                                                        --[ :: ]--[
                                                          --[ tuple ]--[
                                                            "unsafeReplaceBy0",
                                                            (function (param) do
                                                                var replace = function (whole, offset, s) do
                                                                  if (whole == "bar") then do
                                                                    return "BORK";
                                                                  end else do
                                                                    return "DORK";
                                                                  end end 
                                                                end;
                                                                return --[ Eq ]--Block.__(0, [
                                                                          "fooBORKDORK",
                                                                          "foobarbaz".replace(/ba./g, replace)
                                                                        ]);
                                                              end)
                                                          ],
                                                          --[ :: ]--[
                                                            --[ tuple ]--[
                                                              "unsafeReplaceBy1",
                                                              (function (param) do
                                                                  var replace = function (whole, p1, offset, s) do
                                                                    if (whole == "bar") then do
                                                                      return "BORK";
                                                                    end else do
                                                                      return "DORK";
                                                                    end end 
                                                                  end;
                                                                  return --[ Eq ]--Block.__(0, [
                                                                            "fooBORKDORK",
                                                                            "foobarbaz".replace(/ba./g, replace)
                                                                          ]);
                                                                end)
                                                            ],
                                                            --[ :: ]--[
                                                              --[ tuple ]--[
                                                                "unsafeReplaceBy2",
                                                                (function (param) do
                                                                    var replace = function (whole, p1, p2, offset, s) do
                                                                      if (whole == "bar") then do
                                                                        return "BORK";
                                                                      end else do
                                                                        return "DORK";
                                                                      end end 
                                                                    end;
                                                                    return --[ Eq ]--Block.__(0, [
                                                                              "fooBORKDORK",
                                                                              "foobarbaz".replace(/ba./g, replace)
                                                                            ]);
                                                                  end)
                                                              ],
                                                              --[ :: ]--[
                                                                --[ tuple ]--[
                                                                  "unsafeReplaceBy3",
                                                                  (function (param) do
                                                                      var replace = function (whole, p1, p2, p3, offset, s) do
                                                                        if (whole == "bar") then do
                                                                          return "BORK";
                                                                        end else do
                                                                          return "DORK";
                                                                        end end 
                                                                      end;
                                                                      return --[ Eq ]--Block.__(0, [
                                                                                "fooBORKDORK",
                                                                                "foobarbaz".replace(/ba./g, replace)
                                                                              ]);
                                                                    end)
                                                                ],
                                                                --[ :: ]--[
                                                                  --[ tuple ]--[
                                                                    "search",
                                                                    (function (param) do
                                                                        return --[ Eq ]--Block.__(0, [
                                                                                  3,
                                                                                  "foobarbaz".search(/ba./g)
                                                                                ]);
                                                                      end)
                                                                  ],
                                                                  --[ :: ]--[
                                                                    --[ tuple ]--[
                                                                      "slice",
                                                                      (function (param) do
                                                                          return --[ Eq ]--Block.__(0, [
                                                                                    "bar",
                                                                                    "foobarbaz".slice(3, 6)
                                                                                  ]);
                                                                        end)
                                                                    ],
                                                                    --[ :: ]--[
                                                                      --[ tuple ]--[
                                                                        "sliceToEnd",
                                                                        (function (param) do
                                                                            return --[ Eq ]--Block.__(0, [
                                                                                      "barbaz",
                                                                                      "foobarbaz".slice(3)
                                                                                    ]);
                                                                          end)
                                                                      ],
                                                                      --[ :: ]--[
                                                                        --[ tuple ]--[
                                                                          "split",
                                                                          (function (param) do
                                                                              return --[ Eq ]--Block.__(0, [
                                                                                        [
                                                                                          "foo",
                                                                                          "bar",
                                                                                          "baz"
                                                                                        ],
                                                                                        "foo bar baz".split(" ")
                                                                                      ]);
                                                                            end)
                                                                        ],
                                                                        --[ :: ]--[
                                                                          --[ tuple ]--[
                                                                            "splitAtMost",
                                                                            (function (param) do
                                                                                return --[ Eq ]--Block.__(0, [
                                                                                          [
                                                                                            "foo",
                                                                                            "bar"
                                                                                          ],
                                                                                          "foo bar baz".split(" ", 2)
                                                                                        ]);
                                                                              end)
                                                                          ],
                                                                          --[ :: ]--[
                                                                            --[ tuple ]--[
                                                                              "splitByRe",
                                                                              (function (param) do
                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                            [
                                                                                              "a",
                                                                                              "#",
                                                                                              undefined,
                                                                                              "b",
                                                                                              "#",
                                                                                              ":",
                                                                                              "c"
                                                                                            ],
                                                                                            "a#b#:c".split(/(#)(:)?/)
                                                                                          ]);
                                                                                end)
                                                                            ],
                                                                            --[ :: ]--[
                                                                              --[ tuple ]--[
                                                                                "splitByReAtMost",
                                                                                (function (param) do
                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                              [
                                                                                                "a",
                                                                                                "#",
                                                                                                undefined
                                                                                              ],
                                                                                              "a#b#:c".split(/(#)(:)?/, 3)
                                                                                            ]);
                                                                                  end)
                                                                              ],
                                                                              --[ :: ]--[
                                                                                --[ tuple ]--[
                                                                                  "startsWith",
                                                                                  (function (param) do
                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                true,
                                                                                                "foobarbaz".startsWith("foo")
                                                                                              ]);
                                                                                    end)
                                                                                ],
                                                                                --[ :: ]--[
                                                                                  --[ tuple ]--[
                                                                                    "startsWithFrom",
                                                                                    (function (param) do
                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                  false,
                                                                                                  "foobarbaz".startsWith("foo", 1)
                                                                                                ]);
                                                                                      end)
                                                                                  ],
                                                                                  --[ :: ]--[
                                                                                    --[ tuple ]--[
                                                                                      "substr",
                                                                                      (function (param) do
                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                    "barbaz",
                                                                                                    "foobarbaz".substr(3)
                                                                                                  ]);
                                                                                        end)
                                                                                    ],
                                                                                    --[ :: ]--[
                                                                                      --[ tuple ]--[
                                                                                        "substrAtMost",
                                                                                        (function (param) do
                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                      "bar",
                                                                                                      "foobarbaz".substr(3, 3)
                                                                                                    ]);
                                                                                          end)
                                                                                      ],
                                                                                      --[ :: ]--[
                                                                                        --[ tuple ]--[
                                                                                          "substring",
                                                                                          (function (param) do
                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                        "bar",
                                                                                                        "foobarbaz".substring(3, 6)
                                                                                                      ]);
                                                                                            end)
                                                                                        ],
                                                                                        --[ :: ]--[
                                                                                          --[ tuple ]--[
                                                                                            "substringToEnd",
                                                                                            (function (param) do
                                                                                                return --[ Eq ]--Block.__(0, [
                                                                                                          "barbaz",
                                                                                                          "foobarbaz".substring(3)
                                                                                                        ]);
                                                                                              end)
                                                                                          ],
                                                                                          --[ :: ]--[
                                                                                            --[ tuple ]--[
                                                                                              "toLowerCase",
                                                                                              (function (param) do
                                                                                                  return --[ Eq ]--Block.__(0, [
                                                                                                            "bork",
                                                                                                            "BORK".toLowerCase()
                                                                                                          ]);
                                                                                                end)
                                                                                            ],
                                                                                            --[ :: ]--[
                                                                                              --[ tuple ]--[
                                                                                                "toLocaleLowerCase",
                                                                                                (function (param) do
                                                                                                    return --[ Eq ]--Block.__(0, [
                                                                                                              "bork",
                                                                                                              "BORK".toLocaleLowerCase()
                                                                                                            ]);
                                                                                                  end)
                                                                                              ],
                                                                                              --[ :: ]--[
                                                                                                --[ tuple ]--[
                                                                                                  "toUpperCase",
                                                                                                  (function (param) do
                                                                                                      return --[ Eq ]--Block.__(0, [
                                                                                                                "FUBAR",
                                                                                                                "fubar".toUpperCase()
                                                                                                              ]);
                                                                                                    end)
                                                                                                ],
                                                                                                --[ :: ]--[
                                                                                                  --[ tuple ]--[
                                                                                                    "toLocaleUpperCase",
                                                                                                    (function (param) do
                                                                                                        return --[ Eq ]--Block.__(0, [
                                                                                                                  "FUBAR",
                                                                                                                  "fubar".toLocaleUpperCase()
                                                                                                                ]);
                                                                                                      end)
                                                                                                  ],
                                                                                                  --[ :: ]--[
                                                                                                    --[ tuple ]--[
                                                                                                      "trim",
                                                                                                      (function (param) do
                                                                                                          return --[ Eq ]--Block.__(0, [
                                                                                                                    "foo",
                                                                                                                    "  foo  ".trim()
                                                                                                                  ]);
                                                                                                        end)
                                                                                                    ],
                                                                                                    --[ :: ]--[
                                                                                                      --[ tuple ]--[
                                                                                                        "anchor",
                                                                                                        (function (param) do
                                                                                                            return --[ Eq ]--Block.__(0, [
                                                                                                                      "<a name=\"bar\">foo</a>",
                                                                                                                      "foo".anchor("bar")
                                                                                                                    ]);
                                                                                                          end)
                                                                                                      ],
                                                                                                      --[ :: ]--[
                                                                                                        --[ tuple ]--[
                                                                                                          "link",
                                                                                                          (function (param) do
                                                                                                              return --[ Eq ]--Block.__(0, [
                                                                                                                        "<a href=\"https://reason.ml\">foo</a>",
                                                                                                                        "foo".link("https://reason.ml")
                                                                                                                      ]);
                                                                                                            end)
                                                                                                        ],
                                                                                                        --[ :: ]--[
                                                                                                          --[ tuple ]--[
                                                                                                            "File \"js_string_test.ml\", line 211, characters 4-11",
                                                                                                            (function (param) do
                                                                                                                return --[ Ok ]--Block.__(4, ["ab".includes("a")]);
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
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_string_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
