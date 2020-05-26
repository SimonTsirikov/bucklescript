'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Queue = require("../../lib/js/queue.js");
Genlex = require("../../lib/js/genlex.js");
Stream = require("../../lib/js/stream.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");

Parse_error = Caml_exceptions.create("Stream_parser_test.Parse_error");

function parse(token) do
  look_ahead = do
    length: 0,
    first: --[ Nil ]--0,
    last: --[ Nil ]--0
  end;
  token$1 = function (param) do
    if (look_ahead.length == 0) then do
      try do
        return Curry._1(token, --[ () ]--0);
      end
      catch (exn)do
        return --[ Kwd ]--Block.__(0, ["=="]);
      end
    end else do
      return Queue.pop(look_ahead);
    end end 
  end;
  parse_atom = function (param) do
    e = token$1(--[ () ]--0);
    local ___conditional___=(e.tag | 0);
    do
       if ___conditional___ = 0--[ Kwd ]-- then do
          if (e[0] == "(") then do
            v = parse_expr_aux(parse_term_aux(parse_atom(--[ () ]--0)));
            match = token$1(--[ () ]--0);
            if (match.tag) then do
              throw [
                    Parse_error,
                    "Unbalanced parens"
                  ];
            end else if (match[0] == ")") then do
              return v;
            end else do
              throw [
                    Parse_error,
                    "Unbalanced parens"
                  ];
            end end  end 
          end else do
            Queue.push(e, look_ahead);
            throw [
                  Parse_error,
                  "unexpected token"
                ];
          end end end end end 
       if ___conditional___ = 2--[ Int ]-- then do
          return e[0];end end end 
       do
      else do
        Queue.push(e, look_ahead);
        throw [
              Parse_error,
              "unexpected token"
            ];
        end end
        
    end
  end;
  parse_term_aux = function (e1) do
    e = token$1(--[ () ]--0);
    if (e.tag) then do
      Queue.push(e, look_ahead);
      return e1;
    end else do
      local ___conditional___=(e[0]);
      do
         if ___conditional___ = "*" then do
            return Caml_int32.imul(e1, parse_term_aux(parse_atom(--[ () ]--0)));end end end 
         if ___conditional___ = "/" then do
            return Caml_int32.div(e1, parse_term_aux(parse_atom(--[ () ]--0)));end end end 
         do
        else do
          Queue.push(e, look_ahead);
          return e1;
          end end
          
      end
    end end 
  end;
  parse_expr_aux = function (e1) do
    e = token$1(--[ () ]--0);
    if (e.tag) then do
      Queue.push(e, look_ahead);
      return e1;
    end else do
      local ___conditional___=(e[0]);
      do
         if ___conditional___ = "+" then do
            return e1 + parse_expr_aux(parse_term_aux(parse_atom(--[ () ]--0))) | 0;end end end 
         if ___conditional___ = "-" then do
            return e1 - parse_expr_aux(parse_term_aux(parse_atom(--[ () ]--0))) | 0;end end end 
         do
        else do
          Queue.push(e, look_ahead);
          return e1;
          end end
          
      end
    end end 
  end;
  r = parse_expr_aux(parse_term_aux(parse_atom(--[ () ]--0)));
  return --[ tuple ]--[
          r,
          Queue.fold((function (acc, x) do
                  return --[ :: ]--[
                          x,
                          acc
                        ];
                end), --[ [] ]--0, look_ahead)
        ];
end

lexer = Genlex.make_lexer(--[ :: ]--[
      "(",
      --[ :: ]--[
        "*",
        --[ :: ]--[
          "/",
          --[ :: ]--[
            "+",
            --[ :: ]--[
              "-",
              --[ :: ]--[
                ")",
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ]
    ]);

function token(chars) do
  strm = lexer(chars);
  return (function (param) do
      return Stream.next(strm);
    end);
end

function l_parse(token) do
  look_ahead = do
    length: 0,
    first: --[ Nil ]--0,
    last: --[ Nil ]--0
  end;
  token$1 = function (param) do
    if (look_ahead.length == 0) then do
      try do
        return Curry._1(token, --[ () ]--0);
      end
      catch (exn)do
        return --[ Kwd ]--Block.__(0, ["=="]);
      end
    end else do
      return Queue.pop(look_ahead);
    end end 
  end;
  parse_f_aux = function (_a) do
    while(true) do
      a = _a;
      t = token$1(--[ () ]--0);
      if (t.tag) then do
        Queue.push(t, look_ahead);
        return a;
      end else do
        local ___conditional___=(t[0]);
        do
           if ___conditional___ = "*" then do
              _a = Caml_int32.imul(a, parse_f(--[ () ]--0));
              continue ;end end end 
           if ___conditional___ = "/" then do
              _a = Caml_int32.div(a, parse_f(--[ () ]--0));
              continue ;end end end 
           do
          else do
            Queue.push(t, look_ahead);
            return a;
            end end
            
        end
      end end 
    end;
  end;
  parse_f = function (param) do
    t = token$1(--[ () ]--0);
    local ___conditional___=(t.tag | 0);
    do
       if ___conditional___ = 0--[ Kwd ]-- then do
          if (t[0] == "(") then do
            v = parse_t_aux(parse_f_aux(parse_f(--[ () ]--0)));
            t$1 = token$1(--[ () ]--0);
            if (t$1.tag) then do
              throw [
                    Parse_error,
                    "Unbalanced )"
                  ];
            end else if (t$1[0] == ")") then do
              return v;
            end else do
              throw [
                    Parse_error,
                    "Unbalanced )"
                  ];
            end end  end 
          end else do
            throw [
                  Parse_error,
                  "Unexpected token"
                ];
          end end end end end 
       if ___conditional___ = 2--[ Int ]-- then do
          return t[0];end end end 
       do
      else do
        throw [
              Parse_error,
              "Unexpected token"
            ];
        end end
        
    end
  end;
  parse_t_aux = function (_a) do
    while(true) do
      a = _a;
      t = token$1(--[ () ]--0);
      if (t.tag) then do
        Queue.push(t, look_ahead);
        return a;
      end else do
        local ___conditional___=(t[0]);
        do
           if ___conditional___ = "+" then do
              _a = a + parse_f_aux(parse_f(--[ () ]--0)) | 0;
              continue ;end end end 
           if ___conditional___ = "-" then do
              _a = a - parse_f_aux(parse_f(--[ () ]--0)) | 0;
              continue ;end end end 
           do
          else do
            Queue.push(t, look_ahead);
            return a;
            end end
            
        end
      end end 
    end;
  end;
  r = parse_t_aux(parse_f_aux(parse_f(--[ () ]--0)));
  return --[ tuple ]--[
          r,
          Queue.fold((function (acc, x) do
                  return --[ :: ]--[
                          x,
                          acc
                        ];
                end), --[ [] ]--0, look_ahead)
        ];
end

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

match = parse(token(Stream.of_string("1 + 2 + (3  - 2) * 3 * 3  - 2 a")));

eq("File \"stream_parser_test.ml\", line 132, characters 5-12", --[ tuple ]--[
      match[0],
      match[1]
    ], --[ tuple ]--[
      10,
      --[ :: ]--[
        --[ Ident ]--Block.__(1, ["a"]),
        --[ [] ]--0
      ]
    ]);

eq("File \"stream_parser_test.ml\", line 133, characters 5-12", --[ tuple ]--[
      2,
      --[ :: ]--[
        --[ Kwd ]--Block.__(0, ["=="]),
        --[ [] ]--0
      ]
    ], parse(token(Stream.of_string("3 - 2  - 1"))));

eq("File \"stream_parser_test.ml\", line 134, characters 5-12", --[ tuple ]--[
      0,
      --[ :: ]--[
        --[ Kwd ]--Block.__(0, ["=="]),
        --[ [] ]--0
      ]
    ], l_parse(token(Stream.of_string("3 - 2  - 1"))));

Mt.from_pair_suites("Stream_parser_test", suites.contents);

exports.Parse_error = Parse_error;
exports.parse = parse;
exports.lexer = lexer;
exports.token = token;
exports.l_parse = l_parse;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[ lexer Not a pure module ]--
