'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Lexing = require("../../lib/js/lexing.js");
Arith_lexer = require("./arith_lexer.js");
Arith_parser = require("./arith_parser.js");
Arith_syntax = require("./arith_syntax.js");
Number_lexer = require("./number_lexer.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function get_tokens(lex, str) do
  buf = Lexing.from_string(str);
  _acc = --[ [] ]--0;
  while(true) do
    acc = _acc;
    v = Curry._1(lex, buf);
    if (v == --[ EOF ]--7) then do
      return List.rev(acc);
    end else do
      _acc = --[ :: ]--[
        v,
        acc
      ];
      continue ;
    end end 
  end;
end end

function f(param) do
  return get_tokens(Arith_lexer.lexeme, param);
end end

function from_tokens(lst) do
  l = do
    contents: lst
  end;
  return (function (param) do
      match = l.contents;
      if (match) then do
        l.contents = match[1];
        return match[0];
      end else do
        throw Caml_builtin_exceptions.end_of_file;
      end end 
    end end);
end end

lexer_suites_000 = --[ tuple ]--[
  "arith_token",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                get_tokens(Arith_lexer.lexeme, "x + 3 + 4 + y"),
                --[ :: ]--[
                  --[ IDENT ]--Block.__(1, ["x"]),
                  --[ :: ]--[
                    --[ PLUS ]--0,
                    --[ :: ]--[
                      --[ NUMERAL ]--Block.__(0, [3]),
                      --[ :: ]--[
                        --[ PLUS ]--0,
                        --[ :: ]--[
                          --[ NUMERAL ]--Block.__(0, [4]),
                          --[ :: ]--[
                            --[ PLUS ]--0,
                            --[ :: ]--[
                              --[ IDENT ]--Block.__(1, ["y"]),
                              --[ [] ]--0
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]);
    end end)
];

lexer_suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "simple token",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  Arith_lexer.lexeme(Lexing.from_string("10")),
                  --[ NUMERAL ]--Block.__(0, [10])
                ]);
      end end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "number_lexer",
      (function (param) do
          v = do
            contents: --[ [] ]--0
          end;
          add = function (t) do
            v.contents = --[ :: ]--[
              t,
              v.contents
            ];
            return --[ () ]--0;
          end end;
          Number_lexer.token(add, Lexing.from_string("32 + 32 ( ) * / "));
          return --[ Eq ]--Block.__(0, [
                    List.rev(v.contents),
                    --[ :: ]--[
                      "number",
                      --[ :: ]--[
                        "32",
                        --[ :: ]--[
                          "new line",
                          --[ :: ]--[
                            "+",
                            --[ :: ]--[
                              "new line",
                              --[ :: ]--[
                                "number",
                                --[ :: ]--[
                                  "32",
                                  --[ :: ]--[
                                    "new line",
                                    --[ :: ]--[
                                      "(",
                                      --[ :: ]--[
                                        "new line",
                                        --[ :: ]--[
                                          ")",
                                          --[ :: ]--[
                                            "new line",
                                            --[ :: ]--[
                                              "*",
                                              --[ :: ]--[
                                                "new line",
                                                --[ :: ]--[
                                                  "/",
                                                  --[ :: ]--[
                                                    "new line",
                                                    --[ :: ]--[
                                                      "eof",
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
        end end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "simple number",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      Arith_syntax.str(Arith_parser.toplevel(Arith_lexer.lexeme, Lexing.from_string("10"))),
                      "10."
                    ]);
          end end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "arith",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        Arith_syntax.str(Arith_parser.toplevel(Arith_lexer.lexeme, Lexing.from_string("x + 3 + 4 + y"))),
                        "x+3.+4.+y"
                      ]);
            end end)
        ],
        --[ [] ]--0
      ]
    ]
  ]
];

lexer_suites = --[ :: ]--[
  lexer_suites_000,
  lexer_suites_001
];

Mt.from_pair_suites("Lexer_test", lexer_suites);

exports.get_tokens = get_tokens;
exports.f = f;
exports.from_tokens = from_tokens;
exports.lexer_suites = lexer_suites;
--[  Not a pure module ]--
