'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var $$String = require("../../lib/js/string.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Ext_string_test = require("./ext_string_test.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function ff(x) do
  var a;
  switch (x) do
    case "0" :
    case "1" :
    case "2" :
        a = 3;
        break;
    case "3" :
        a = 4;
        break;
    case "4" :
        a = 6;
        break;
    case "7" :
        a = 7;
        break;
    default:
      a = 8;
  end
  return a + 3 | 0;
end

function gg(x) do
  var a;
  switch (x) do
    case 0 :
    case 1 :
    case 2 :
        a = 3;
        break;
    case 3 :
        a = 4;
        break;
    case 4 :
        a = 6;
        break;
    case 5 :
    case 6 :
    case 7 :
        a = 8;
        break;
    case 8 :
        a = 7;
        break;
    default:
      a = 8;
  end
  return a + 3 | 0;
end

function rev_split_by_char(c, s) do
  var loop = function (i, l) do
    try do
      var i$prime = $$String.index_from(s, i, c);
      var s$prime = $$String.sub(s, i, i$prime - i | 0);
      return loop(i$prime + 1 | 0, s$prime == "" ? l : --[ :: ]--[
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
  var len = #s;
  if (len ~= 0) then do
    var _l = --[ [] ]--0;
    var _i = len;
    while(true) do
      var i = _i;
      var l = _l;
      if (i ~= 0) then do
        var i$prime;
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
        var l_000 = $$String.sub(s, i$prime + 1 | 0, (i - i$prime | 0) - 1 | 0);
        var l$1 = --[ :: ]--[
          l_000,
          l
        ];
        var l$2 = i$prime == 0 ? --[ :: ]--[
            "",
            l$1
          ] : l$1;
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
