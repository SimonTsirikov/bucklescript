'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Bytes = require("../../lib/js/bytes.js");
$$String = require("../../lib/js/string.js");
Caml_bytes = require("../../lib/js/caml_bytes.js");
Ext_string_test = require("./ext_string_test.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function ff(x) do
  a;
  local ___conditional___=(x);
  do
     if ___conditional___ = "0"
     or ___conditional___ = "1"
     or ___conditional___ = "2" then do
        a = 3;end else 
     if ___conditional___ = "3" then do
        a = 4;end else 
     if ___conditional___ = "4" then do
        a = 6;end else 
     if ___conditional___ = "7" then do
        a = 7;end else 
     do end end end end end
    else do
      a = 8;
      end end
      
  end
  return a + 3 | 0;
end

function gg(x) do
  a;
  local ___conditional___=(x);
  do
     if ___conditional___ = 0
     or ___conditional___ = 1
     or ___conditional___ = 2 then do
        a = 3;end else 
     if ___conditional___ = 3 then do
        a = 4;end else 
     if ___conditional___ = 4 then do
        a = 6;end else 
     if ___conditional___ = 5
     or ___conditional___ = 6
     or ___conditional___ = 7 then do
        a = 8;end else 
     if ___conditional___ = 8 then do
        a = 7;end else 
     do end end end end end end
    else do
      a = 8;
      end end
      
  end
  return a + 3 | 0;
end

function rev_split_by_char(c, s) do
  loop = function (i, l) do
    try do
      i$prime = $$String.index_from(s, i, c);
      s$prime = $$String.sub(s, i, i$prime - i | 0);
      return loop(i$prime + 1 | 0, s$prime == "" and l or --[ :: ]--[
                    s$prime,
                    l
                  ]);
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        return --[ :: ]--[
                $$String.sub(s, i, #s - i | 0),
                l
              ];
      end else do
        throw exn;
      end end 
    end
  end;
  return loop(0, --[ [] ]--0);
end

function xsplit(delim, s) do
  len = #s;
  if (len ~= 0) then do
    _l = --[ [] ]--0;
    _i = len;
    while(true) do
      i = _i;
      l = _l;
      if (i ~= 0) then do
        i$prime;
        try do
          i$prime = $$String.rindex_from(s, i - 1 | 0, delim);
        end
        catch (exn)do
          if (exn == Caml_builtin_exceptions.not_found) then do
            return --[ :: ]--[
                    $$String.sub(s, 0, i),
                    l
                  ];
          end else do
            throw exn;
          end end 
        end
        l_000 = $$String.sub(s, i$prime + 1 | 0, (i - i$prime | 0) - 1 | 0);
        l$1 = --[ :: ]--[
          l_000,
          l
        ];
        l$2 = i$prime == 0 and --[ :: ]--[
            "",
            l$1
          ] or l$1;
        _i = i$prime;
        _l = l$2;
        continue ;
      end else do
        return l;
      end end 
    end;
  end else do
    return --[ [] ]--0;
  end end 
end

function string_of_chars(x) do
  return $$String.concat("", List.map((function (prim) do
                    return String.fromCharCode(prim);
                  end), x));
end

Mt.from_pair_suites("String_test", --[ :: ]--[
      --[ tuple ]--[
        "mutliple switch",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      9,
                      ff("4")
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "int switch",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        9,
                        gg(4)
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "escape_normal",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          "haha",
                          $$String.escaped("haha")
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "escape_bytes",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            Bytes.of_string("haha"),
                            Bytes.escaped(Bytes.of_string("haha"))
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "escape_quote",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              "\\\"\\\"",
                              $$String.escaped("\"\"")
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "rev_split_by_char",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                --[ :: ]--[
                                  "",
                                  --[ :: ]--[
                                    "bbbb",
                                    --[ :: ]--[
                                      "bbbb",
                                      --[ [] ]--0
                                    ]
                                  ]
                                ],
                                rev_split_by_char(--[ "a" ]--97, "bbbbabbbba")
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "File \"string_test.ml\", line 74, characters 2-9",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  --[ :: ]--[
                                    "aaaa",
                                    --[ [] ]--0
                                  ],
                                  rev_split_by_char(--[ "," ]--44, "aaaa")
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "xsplit",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    --[ :: ]--[
                                      "a",
                                      --[ :: ]--[
                                        "b",
                                        --[ :: ]--[
                                          "c",
                                          --[ [] ]--0
                                        ]
                                      ]
                                    ],
                                    xsplit(--[ "." ]--46, "a.b.c")
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "split_empty",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      --[ [] ]--0,
                                      Ext_string_test.split(undefined, "", --[ "_" ]--95)
                                    ]);
                          end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "split_empty2",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        --[ :: ]--[
                                          "test_unsafe_obj_ffi_ppx.cmi",
                                          --[ [] ]--0
                                        ],
                                        Ext_string_test.split(false, " test_unsafe_obj_ffi_ppx.cmi", --[ " " ]--32)
                                      ]);
                            end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "rfind",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          7,
                                          Ext_string_test.rfind("__", "__index__js")
                                        ]);
                              end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "rfind_2",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            0,
                                            Ext_string_test.rfind("__", "__index_js")
                                          ]);
                                end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "rfind_3",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              -1,
                                              Ext_string_test.rfind("__", "_index_js")
                                            ]);
                                  end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "find",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                0,
                                                Ext_string_test.find(undefined, "__", "__index__js")
                                              ]);
                                    end)
                                ],
                                --[ :: ]--[
                                  --[ tuple ]--[
                                    "find_2",
                                    (function (param) do
                                        return --[ Eq ]--Block.__(0, [
                                                  6,
                                                  Ext_string_test.find(undefined, "__", "_index__js")
                                                ]);
                                      end)
                                  ],
                                  --[ :: ]--[
                                    --[ tuple ]--[
                                      "find_3",
                                      (function (param) do
                                          return --[ Eq ]--Block.__(0, [
                                                    -1,
                                                    Ext_string_test.find(undefined, "__", "_index_js")
                                                  ]);
                                        end)
                                    ],
                                    --[ :: ]--[
                                      --[ tuple ]--[
                                        "of_char",
                                        (function (param) do
                                            return --[ Eq ]--Block.__(0, [
                                                      String.fromCharCode(--[ "0" ]--48),
                                                      Caml_bytes.bytes_to_string(Bytes.make(1, --[ "0" ]--48))
                                                    ]);
                                          end)
                                      ],
                                      --[ :: ]--[
                                        --[ tuple ]--[
                                          "of_chars",
                                          (function (param) do
                                              return --[ Eq ]--Block.__(0, [
                                                        string_of_chars(--[ :: ]--[
                                                              --[ "0" ]--48,
                                                              --[ :: ]--[
                                                                --[ "1" ]--49,
                                                                --[ :: ]--[
                                                                  --[ "2" ]--50,
                                                                  --[ [] ]--0
                                                                ]
                                                              ]
                                                            ]),
                                                        "012"
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
    ]);

exports.ff = ff;
exports.gg = gg;
exports.rev_split_by_char = rev_split_by_char;
exports.xsplit = xsplit;
exports.string_of_chars = string_of_chars;
--[  Not a pure module ]--
