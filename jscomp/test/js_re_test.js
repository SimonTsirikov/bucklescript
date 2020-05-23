'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_option = require("../../lib/js/caml_option.js");

var suites_000 = --[ tuple ]--[
  "captures",
  (function (param) do
      var re = /(\d+)-(?:(\d+))?/g;
      var match = re.exec("3-");
      if (match ~= null) then do
        var defined = Caml_array.caml_array_get(match, 1);
        var $$undefined = Caml_array.caml_array_get(match, 2);
        return --[ Eq ]--Block.__(0, [
                  --[ tuple ]--[
                    "3",
                    null
                  ],
                  --[ tuple ]--[
                    defined,
                    $$undefined
                  ]
                ]);
      end else do
        return --[ Fail ]--Block.__(8, [--[ () ]--0]);
      end end 
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "fromString",
    (function (param) do
        var contentOf = function (tag, xmlString) do
          var param = new RegExp("<" .. (tag .. (">(.*?)<\\/" .. (tag .. ">")))).exec(xmlString);
          if (param ~= null) then do
            return Caml_option.nullable_to_opt(Caml_array.caml_array_get(param, 1));
          end
           end 
        end;
        return --[ Eq ]--Block.__(0, [
                  contentOf("div", "<div>Hi</div>"),
                  "Hi"
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "exec_literal",
      (function (param) do
          var match = /[^.]+/.exec("http://xxx.domain.com");
          if (match ~= null) then do
            return --[ Eq ]--Block.__(0, [
                      "http://xxx",
                      Caml_array.caml_array_get(match, 0)
                    ]);
          end else do
            return --[ FailWith ]--Block.__(9, ["regex should match"]);
          end end 
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "exec_no_match",
        (function (param) do
            var match = /https:\/\/(.*)/.exec("http://xxx.domain.com");
            if (match ~= null) then do
              return --[ FailWith ]--Block.__(9, ["regex should not match"]);
            end else do
              return --[ Ok ]--Block.__(4, [true]);
            end end 
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "test_str",
          (function (param) do
              var res = new RegExp("foo").test("#foo#");
              return --[ Eq ]--Block.__(0, [
                        true,
                        res
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "fromStringWithFlags",
            (function (param) do
                var res = new RegExp("foo", "g");
                return --[ Eq ]--Block.__(0, [
                          true,
                          res.global
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "result_index",
              (function (param) do
                  var match = new RegExp("zbar").exec("foobarbazbar");
                  if (match ~= null) then do
                    return --[ Eq ]--Block.__(0, [
                              8,
                              match.index
                            ]);
                  end else do
                    return --[ Fail ]--Block.__(8, [--[ () ]--0]);
                  end end 
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "result_input",
                (function (param) do
                    var input = "foobar";
                    var match = /foo/g.exec(input);
                    if (match ~= null) then do
                      return --[ Eq ]--Block.__(0, [
                                input,
                                match.input
                              ]);
                    end else do
                      return --[ Fail ]--Block.__(8, [--[ () ]--0]);
                    end end 
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "t_flags",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                "gi",
                                /./ig.flags
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "t_global",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  true,
                                  /./ig.global
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "t_ignoreCase",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    true,
                                    /./ig.ignoreCase
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "t_lastIndex",
                        (function (param) do
                            var re = /na/g;
                            re.exec("banana");
                            return --[ Eq ]--Block.__(0, [
                                      4,
                                      re.lastIndex
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "t_setLastIndex",
                          (function (param) do
                              var re = /na/g;
                              var before = re.lastIndex;
                              re.lastIndex = 42;
                              var after = re.lastIndex;
                              return --[ Eq ]--Block.__(0, [
                                        --[ tuple ]--[
                                          0,
                                          42
                                        ],
                                        --[ tuple ]--[
                                          before,
                                          after
                                        ]
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "t_multiline",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          false,
                                          /./ig.multiline
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "t_source",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            "f.+o",
                                            /f.+o/ig.source
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "t_sticky",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              true,
                                              /./yg.sticky
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "t_unicode",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                false,
                                                /./yg.unicode
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
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_re_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
