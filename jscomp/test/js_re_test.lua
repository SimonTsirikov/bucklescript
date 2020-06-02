--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Caml_option = require "../../lib/js/caml_option.lua";

suites_000 = --[[ tuple ]][
  "captures",
  (function (param) do
      re = /(\d+)-(?:(\d+))?/g;
      match = re.exec("3-");
      if (match ~= null) then do
        defined = Caml_array.caml_array_get(match, 1);
        __undefined = Caml_array.caml_array_get(match, 2);
        return --[[ Eq ]]Block.__(0, [
                  --[[ tuple ]][
                    "3",
                    null
                  ],
                  --[[ tuple ]][
                    defined,
                    __undefined
                  ]
                ]);
      end else do
        return --[[ Fail ]]Block.__(8, [--[[ () ]]0]);
      end end 
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "fromString",
    (function (param) do
        contentOf = function (tag, xmlString) do
          param = new RegExp("<" .. (tag .. (">(.*?)<\\/" .. (tag .. ">")))).exec(xmlString);
          if (param ~= null) then do
            return Caml_option.nullable_to_opt(Caml_array.caml_array_get(param, 1));
          end
           end 
        end end;
        return --[[ Eq ]]Block.__(0, [
                  contentOf("div", "<div>Hi</div>"),
                  "Hi"
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "exec_literal",
      (function (param) do
          match = /[^.]+/.exec("http://xxx.domain.com");
          if (match ~= null) then do
            return --[[ Eq ]]Block.__(0, [
                      "http://xxx",
                      Caml_array.caml_array_get(match, 0)
                    ]);
          end else do
            return --[[ FailWith ]]Block.__(9, ["regex should match"]);
          end end 
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "exec_no_match",
        (function (param) do
            match = /https:\/\/(.*)/.exec("http://xxx.domain.com");
            if (match ~= null) then do
              return --[[ FailWith ]]Block.__(9, ["regex should not match"]);
            end else do
              return --[[ Ok ]]Block.__(4, [true]);
            end end 
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "test_str",
          (function (param) do
              res = new RegExp("foo").test("#foo#");
              return --[[ Eq ]]Block.__(0, [
                        true,
                        res
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "fromStringWithFlags",
            (function (param) do
                res = new RegExp("foo", "g");
                return --[[ Eq ]]Block.__(0, [
                          true,
                          res.global
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "result_index",
              (function (param) do
                  match = new RegExp("zbar").exec("foobarbazbar");
                  if (match ~= null) then do
                    return --[[ Eq ]]Block.__(0, [
                              8,
                              match.index
                            ]);
                  end else do
                    return --[[ Fail ]]Block.__(8, [--[[ () ]]0]);
                  end end 
                end end)
            ],
            --[[ :: ]][
              --[[ tuple ]][
                "result_input",
                (function (param) do
                    input = "foobar";
                    match = /foo/g.exec(input);
                    if (match ~= null) then do
                      return --[[ Eq ]]Block.__(0, [
                                input,
                                match.input
                              ]);
                    end else do
                      return --[[ Fail ]]Block.__(8, [--[[ () ]]0]);
                    end end 
                  end end)
              ],
              --[[ :: ]][
                --[[ tuple ]][
                  "t_flags",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, [
                                "gi",
                                /./ig.flags
                              ]);
                    end end)
                ],
                --[[ :: ]][
                  --[[ tuple ]][
                    "t_global",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, [
                                  true,
                                  /./ig.global
                                ]);
                      end end)
                  ],
                  --[[ :: ]][
                    --[[ tuple ]][
                      "t_ignoreCase",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, [
                                    true,
                                    /./ig.ignoreCase
                                  ]);
                        end end)
                    ],
                    --[[ :: ]][
                      --[[ tuple ]][
                        "t_lastIndex",
                        (function (param) do
                            re = /na/g;
                            re.exec("banana");
                            return --[[ Eq ]]Block.__(0, [
                                      4,
                                      re.lastIndex
                                    ]);
                          end end)
                      ],
                      --[[ :: ]][
                        --[[ tuple ]][
                          "t_setLastIndex",
                          (function (param) do
                              re = /na/g;
                              before = re.lastIndex;
                              re.lastIndex = 42;
                              after = re.lastIndex;
                              return --[[ Eq ]]Block.__(0, [
                                        --[[ tuple ]][
                                          0,
                                          42
                                        ],
                                        --[[ tuple ]][
                                          before,
                                          after
                                        ]
                                      ]);
                            end end)
                        ],
                        --[[ :: ]][
                          --[[ tuple ]][
                            "t_multiline",
                            (function (param) do
                                return --[[ Eq ]]Block.__(0, [
                                          false,
                                          /./ig.multiline
                                        ]);
                              end end)
                          ],
                          --[[ :: ]][
                            --[[ tuple ]][
                              "t_source",
                              (function (param) do
                                  return --[[ Eq ]]Block.__(0, [
                                            "f.+o",
                                            /f.+o/ig.source
                                          ]);
                                end end)
                            ],
                            --[[ :: ]][
                              --[[ tuple ]][
                                "t_sticky",
                                (function (param) do
                                    return --[[ Eq ]]Block.__(0, [
                                              true,
                                              /./yg.sticky
                                            ]);
                                  end end)
                              ],
                              --[[ :: ]][
                                --[[ tuple ]][
                                  "t_unicode",
                                  (function (param) do
                                      return --[[ Eq ]]Block.__(0, [
                                                false,
                                                /./yg.unicode
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
];

suites = --[[ :: ]][
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_re_test", suites);

exports.suites = suites;
--[[  Not a pure module ]]
