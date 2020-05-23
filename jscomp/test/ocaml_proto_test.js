'use strict';

var Mt = require("./mt.js");
var Char = require("../../lib/js/char.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var Curry = require("../../lib/js/curry.js");
var Lexing = require("../../lib/js/lexing.js");
var Printf = require("../../lib/js/printf.js");
var $$String = require("../../lib/js/string.js");
var Parsing = require("../../lib/js/parsing.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Filename = require("../../lib/js/filename.js");
var Printexc = require("../../lib/js/printexc.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_format = require("../../lib/js/caml_format.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Caml_string = require("../../lib/js/caml_string.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function field(optionsOpt, label, number, type_, name) do
  var options = optionsOpt ~= undefined ? optionsOpt : --[ [] ]--0;
  return do
          field_name: name,
          field_number: number,
          field_label: label,
          field_type: type_,
          field_options: options
        end;
end

function map(map_optionsOpt, number, key_type, value_type, name) do
  var map_options = map_optionsOpt ~= undefined ? map_optionsOpt : --[ [] ]--0;
  return do
          map_name: name,
          map_number: number,
          map_key_type: key_type,
          map_value_type: value_type,
          map_options: map_options
        end;
end

function oneof_field(optionsOpt, number, type_, name) do
  var options = optionsOpt ~= undefined ? optionsOpt : --[ [] ]--0;
  return do
          field_name: name,
          field_number: number,
          field_label: --[ Oneof ]---978693923,
          field_type: type_,
          field_options: options
        end;
end

var message_counter = do
  contents: 0
end;

function extension_range_range(from, to_) do
  var to_$1 = typeof to_ == "number" ? --[ To_max ]--0 : --[ To_number ]--[to_[1]];
  return --[ Extension_range ]--Block.__(1, [
            from,
            to_$1
          ]);
end

function message(content, message_name) do
  message_counter.contents = message_counter.contents + 1 | 0;
  return do
          id: message_counter.contents,
          message_name: message_name,
          message_body: content
        end;
end

function $$import($$public, file_name) do
  return do
          file_name: file_name,
          public: $$public ~= undefined
        end;
end

function extend(extend_name, extend_body) do
  message_counter.contents = message_counter.contents + 1 | 0;
  return do
          id: message_counter.contents,
          extend_name: extend_name,
          extend_body: extend_body
        end;
end

function proto(syntax, file_option, $$package, $$import, message, $$enum, proto$1, extend, param) do
  var proto$2 = proto$1 ~= undefined ? proto$1 : (do
        syntax: syntax,
        imports: --[ [] ]--0,
        file_options: --[ [] ]--0,
        package: undefined,
        messages: --[ [] ]--0,
        enums: --[ [] ]--0,
        extends: --[ [] ]--0
      end);
  var proto$3 = syntax ~= undefined ? (do
        syntax: syntax,
        imports: proto$2.imports,
        file_options: proto$2.file_options,
        package: proto$2.package,
        messages: proto$2.messages,
        enums: proto$2.enums,
        extends: proto$2.extends
      end) : proto$2;
  var proto$4 = $$package ~= undefined ? (do
        syntax: proto$3.syntax,
        imports: proto$3.imports,
        file_options: proto$3.file_options,
        package: $$package,
        messages: proto$3.messages,
        enums: proto$3.enums,
        extends: proto$3.extends
      end) : proto$3;
  var proto$5 = message ~= undefined ? (do
        syntax: proto$4.syntax,
        imports: proto$4.imports,
        file_options: proto$4.file_options,
        package: proto$4.package,
        messages: --[ :: ]--[
          message,
          proto$2.messages
        ],
        enums: proto$4.enums,
        extends: proto$4.extends
      end) : proto$4;
  var proto$6 = $$enum ~= undefined ? (do
        syntax: proto$5.syntax,
        imports: proto$5.imports,
        file_options: proto$5.file_options,
        package: proto$5.package,
        messages: proto$5.messages,
        enums: --[ :: ]--[
          $$enum,
          proto$2.enums
        ],
        extends: proto$5.extends
      end) : proto$5;
  var proto$7 = $$import ~= undefined ? (do
        syntax: proto$6.syntax,
        imports: --[ :: ]--[
          $$import,
          proto$2.imports
        ],
        file_options: proto$6.file_options,
        package: proto$6.package,
        messages: proto$6.messages,
        enums: proto$6.enums,
        extends: proto$6.extends
      end) : proto$6;
  var proto$8 = file_option ~= undefined ? (do
        syntax: proto$7.syntax,
        imports: proto$7.imports,
        file_options: --[ :: ]--[
          file_option,
          proto$2.file_options
        ],
        package: proto$7.package,
        messages: proto$7.messages,
        enums: proto$7.enums,
        extends: proto$7.extends
      end) : proto$7;
  if (extend ~= undefined) do
    return do
            syntax: proto$8.syntax,
            imports: proto$8.imports,
            file_options: proto$8.file_options,
            package: proto$8.package,
            messages: proto$8.messages,
            enums: proto$8.enums,
            extends: --[ :: ]--[
              extend,
              proto$2.extends
            ]
          end;
  end else do
    return proto$8;
  end
end

function file_option(file_options, name) do
  var x;
  try do
    x = List.assoc(name, file_options);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return ;
    end else do
      throw exn;
    end
  end
  return x;
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
      if (exn == Caml_builtin_exceptions.not_found) do
        return --[ :: ]--[
                $$String.sub(s, i, #s - i | 0),
                l
              ];
      end else do
        throw exn;
      end
    end
  end;
  return loop(0, --[ [] ]--0);
end

function pop_last(param) do
  if (param) do
    var tl = param[1];
    if (tl) do
      return --[ :: ]--[
              param[0],
              pop_last(tl)
            ];
    end else do
      return --[ [] ]--0;
    end
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "Invalid argument [] for pop_last"
        ];
  end
end

function apply_until(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var x = Curry._1(f, param[0]);
      if (x ~= undefined) do
        return x;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function string_of_string_list(l) do
  return Curry._1(Printf.sprintf(--[ Format ]--[
                  --[ Char_literal ]--Block.__(12, [
                      --[ "[" ]--91,
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ Char_literal ]--Block.__(12, [
                              --[ "]" ]--93,
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  "[%s]"
                ]), $$String.concat(",", l));
end

function string_fold_lefti(f, e0, s) do
  var len = #s;
  var _acc = e0;
  var _i = 0;
  while(true) do
    var i = _i;
    var acc = _acc;
    if (i == len) do
      return acc;
    end else do
      _i = i + 1 | 0;
      _acc = Curry._3(f, acc, i, s.charCodeAt(i));
      continue ;
    end
  end;
end

function option_default(x, param) do
  if (param ~= undefined) do
    return Caml_option.valFromOption(param);
  end else do
    return x;
  end
end

function from_lexbuf(lexbuf) do
  var x = lexbuf.lex_curr_p.pos_fname;
  var file_name = x == "" ? undefined : x;
  var line = lexbuf.lex_curr_p.pos_lnum;
  return do
          file_name: file_name,
          line: line
        end;
end

function file_name(param) do
  return param.file_name;
end

function line(param) do
  return param.line;
end

function to_string(param) do
  return Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "File ",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ", line ",
                              --[ Int ]--Block.__(4, [
                                  --[ Int_i ]--3,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ":\n",
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "File %s, line %i:\n"
                ]), option_default("", param.file_name), param.line);
end

function string_of_programmatic_error(e) do
  var tmp;
  switch (e) do
    case --[ Invalid_string_split ]--0 :
        tmp = "string split error";
        break;
    case --[ Unexpected_field_type ]--1 :
        tmp = "unexpected field type";
        break;
    case --[ No_type_found_for_id ]--2 :
        tmp = "no type was found for type id";
        break;
    case --[ One_of_should_be_inlined_in_message ]--3 :
        tmp = "one of variant encoding must be inlined in message";
        break;
    
  end
  return "Programatic_error" .. tmp;
end

var Compilation_error = Caml_exceptions.create("Ocaml_proto_test.Exception.Compilation_error");

function prepare_error(param) do
  if (typeof param == "number") do
    return Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "Syntax error",
                    --[ End_of_format ]--0
                  ]),
                "Syntax error"
              ]);
  end else do
    switch (param.tag | 0) do
      case --[ Unresolved_type ]--0 :
          var match = param[0];
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "unresolved type for field name : ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " (type:",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ", in message: ",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ ")" ]--41,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "unresolved type for field name : %s (type:%s, in message: %s)"
                        ]), match.field_name, match.type_, match.message_name);
      case --[ Duplicated_field_number ]--1 :
          var match$1 = param[0];
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "duplicated field number for field name: ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " (previous field name:",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ", message: ",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ ")" ]--41,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "duplicated field number for field name: %s (previous field name:%s, message: %s)"
                        ]), match$1.field_name, match$1.previous_field_name, match$1.message_name);
      case --[ Invalid_default_value ]--2 :
          var match$2 = param[0];
          return Curry._2(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "invalid default value for field name:",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " (info: ",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ Char_literal ]--Block.__(12, [
                                              --[ ")" ]--41,
                                              --[ End_of_format ]--0
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "invalid default value for field name:%s (info: %s)"
                        ]), option_default("", match$2.field_name), match$2.info);
      case --[ Unsupported_field_type ]--3 :
          var match$3 = param[0];
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "unsupported field type for field name:",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " with type:",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              " in bakend: ",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "unsupported field type for field name:%s with type:%s in bakend: %s"
                        ]), option_default("", match$3.field_name), match$3.field_type, match$3.backend_name);
      case --[ Programatic_error ]--4 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "programmatic error: ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "programmatic error: %s"
                        ]), string_of_programmatic_error(param[0]));
      case --[ Invalid_import_qualifier ]--5 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Invalid import qualified, only 'public' supported",
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "%sInvalid import qualified, only 'public' supported"
                        ]), to_string(param[0]));
      case --[ Invalid_file_name ]--6 :
          return Curry._1(Printf.sprintf(Pervasives.$caret$caret(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "Invalid file name: ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          ", ",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "Invalid file name: %s, "
                            ], --[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "format must <name>.proto",
                                  --[ End_of_format ]--0
                                ]),
                              "format must <name>.proto"
                            ])), param[0]);
      case --[ Import_file_not_found ]--7 :
          return Curry._1(Printf.sprintf(Pervasives.$caret$caret(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "File: ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          ", ",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "File: %s, "
                            ], --[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "could not be found.",
                                  --[ End_of_format ]--0
                                ]),
                              "could not be found."
                            ])), param[0]);
      case --[ Invalid_packed_option ]--8 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "Invalid packed option for field: ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "Invalid packed option for field: %s"
                        ]), param[0]);
      case --[ Missing_semicolon_for_enum_value ]--9 :
          return Curry._2(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Missing semicolon for enum value: ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ]),
                          "%sMissing semicolon for enum value: %s"
                        ]), to_string(param[1]), param[0]);
      case --[ Invalid_enum_specification ]--10 :
          return Curry._2(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Missing enum specification (<identifier> = <id>;) for enum value: ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ]),
                          "%sMissing enum specification (<identifier> = <id>;) for enum value: %s"
                        ]), to_string(param[1]), param[0]);
      case --[ Invalid_mutable_option ]--11 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "Invalid mutable option for field ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "Invalid mutable option for field %s"
                        ]), option_default("", param[0]));
      case --[ Missing_one_of_name ]--12 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Missing oneof name",
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "%sMissing oneof name"
                        ]), to_string(param[0]));
      case --[ Invalid_field_label ]--13 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Invalid field label. [required|repeated|optional] expected",
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "%sInvalid field label. [required|repeated|optional] expected"
                        ]), to_string(param[0]));
      case --[ Missing_field_label ]--14 :
          return Curry._1(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  "Missing field label. [required|repeated|optional] expected",
                                  --[ End_of_format ]--0
                                ])
                            ]),
                          "%sMissing field label. [required|repeated|optional] expected"
                        ]), to_string(param[0]));
      case --[ Parsing_error ]--15 :
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "File ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ", line ",
                                      --[ Int ]--Block.__(4, [
                                          --[ Int_i ]--3,
                                          --[ No_padding ]--0,
                                          --[ No_precision ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ":\n",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "File %s, line %i:\n%s"
                        ]), param[0], param[1], param[2]);
      
    end
  end
end

function add_loc(loc, exn) do
  if (exn[0] == Compilation_error) do
    var tmp = exn[1];
    if (typeof tmp ~= "number") do
      switch (tmp.tag | 0) do
        case --[ Invalid_import_qualifier ]--5 :
        case --[ Missing_semicolon_for_enum_value ]--9 :
        case --[ Invalid_enum_specification ]--10 :
        case --[ Missing_one_of_name ]--12 :
        case --[ Invalid_field_label ]--13 :
        case --[ Missing_field_label ]--14 :
            return exn;
        default:
          
      end
    end
    
  end
  var file_name$1 = option_default("", file_name(loc));
  var line$1 = line(loc);
  var detail = Printexc.to_string(exn);
  return [
          Compilation_error,
          --[ Parsing_error ]--Block.__(15, [
              file_name$1,
              line$1,
              detail
            ])
        ];
end

Printexc.register_printer((function (exn) do
        if (exn[0] == Compilation_error) do
          return prepare_error(exn[1]);
        end
        
      end));

function invalid_default_value(field_name, info, param) do
  throw [
        Compilation_error,
        --[ Invalid_default_value ]--Block.__(2, [do
              field_name: field_name,
              info: info
            end])
      ];
end

function unsupported_field_type(field_name, field_type, backend_name, param) do
  throw [
        Compilation_error,
        --[ Unsupported_field_type ]--Block.__(3, [do
              field_name: field_name,
              field_type: field_type,
              backend_name: backend_name
            end])
      ];
end

function invalid_enum_specification(enum_name, loc) do
  throw [
        Compilation_error,
        --[ Invalid_enum_specification ]--Block.__(10, [
            enum_name,
            loc
          ])
      ];
end

var yytransl_const = [
  257,
  258,
  259,
  261,
  262,
  263,
  265,
  266,
  267,
  268,
  269,
  270,
  271,
  272,
  273,
  274,
  275,
  276,
  277,
  278,
  279,
  280,
  281,
  282,
  283,
  0,
  0
];

var yytransl_block = [
  260,
  264,
  284,
  285,
  286,
  287,
  0
];

var yyact = [
  (function (param) do
      throw [
            Caml_builtin_exceptions.failure,
            "parser"
          ];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(_1, undefined, undefined, undefined, undefined, undefined, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, _1, undefined, undefined, undefined, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, _1, undefined, undefined, undefined, undefined, undefined, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, _1, undefined, undefined, undefined, undefined, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, _1, undefined, undefined, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, undefined, _1, undefined, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, undefined, undefined, undefined, _1, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, _1, undefined, undefined, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, _1, undefined, undefined, undefined, undefined, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, _1, undefined, undefined, undefined, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, _1, undefined, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, undefined, _1, _2, undefined, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(undefined, undefined, undefined, undefined, undefined, undefined, _2, _1, --[ () ]--0);
    end),
  (function (__caml_parser_env) do
      var _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _3;
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 2);
      var _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return $$import(undefined, _2);
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 3);
      var _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return $$import(--[ () ]--0, _3);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      throw [
            Compilation_error,
            --[ Invalid_import_qualifier ]--Block.__(5, [_1])
          ];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _2[1];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return message(_4, _2[1]);
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      return message(--[ [] ]--0, _2[1]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              --[ [] ]--0
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _2
            ];
    end),
  (function (__caml_parser_env) do
      return --[ Message_field ]--Block.__(0, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      return --[ Message_map_field ]--Block.__(1, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      return --[ Message_oneof_field ]--Block.__(2, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      return --[ Message_sub ]--Block.__(3, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      return --[ Message_enum ]--Block.__(4, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      return --[ Message_extension ]--Block.__(5, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      throw [
            Compilation_error,
            --[ Syntax_error ]--0
          ];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return extend(_2[1], _4);
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      return extend(_2[1], --[ [] ]--0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              --[ [] ]--0
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _2
            ];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _2;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              --[ [] ]--0
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      var _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _3
            ];
    end),
  (function (__caml_parser_env) do
      return --[ Extension_single_number ]--Block.__(0, [Parsing.peek_val(__caml_parser_env, 0)]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      var _3 = Parsing.peek_val(__caml_parser_env, 0);
      return extension_range_range(_1, --[ `Number ]--[
                  -703661335,
                  _3
                ]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      return extension_range_range(_1, --[ Max ]--3850884);
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 4);
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return do
              oneof_name: _2[1],
              oneof_fields: _4
            end;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      throw [
            Compilation_error,
            --[ Missing_one_of_name ]--Block.__(12, [_1])
          ];
    end),
  (function (__caml_parser_env) do
      return --[ [] ]--0;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _2
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 5);
      var _2 = Parsing.peek_val(__caml_parser_env, 4);
      var _4 = Parsing.peek_val(__caml_parser_env, 2);
      var _5 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return oneof_field(_5, _4, _1[1], _2);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 4);
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return oneof_field(undefined, _4, _1[1], _2);
    end),
  (function (__caml_parser_env) do
      var _3 = Parsing.peek_val(__caml_parser_env, 7);
      var _5 = Parsing.peek_val(__caml_parser_env, 5);
      var _7 = Parsing.peek_val(__caml_parser_env, 3);
      var _9 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return map(undefined, _9, _3[1], _5[1], _7);
    end),
  (function (__caml_parser_env) do
      var _3 = Parsing.peek_val(__caml_parser_env, 8);
      var _5 = Parsing.peek_val(__caml_parser_env, 6);
      var _7 = Parsing.peek_val(__caml_parser_env, 4);
      var _9 = Parsing.peek_val(__caml_parser_env, 2);
      var _10 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return map(_10, _9, _3[1], _5[1], _7);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 6);
      var _2 = Parsing.peek_val(__caml_parser_env, 5);
      var _3 = Parsing.peek_val(__caml_parser_env, 4);
      var _5 = Parsing.peek_val(__caml_parser_env, 2);
      var _6 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return field(_6, _1, _5, _2[1], _3);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 5);
      var _2 = Parsing.peek_val(__caml_parser_env, 4);
      var _3 = Parsing.peek_val(__caml_parser_env, 3);
      var _5 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return field(undefined, _1, _5, _2[1], _3);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 5);
      Parsing.peek_val(__caml_parser_env, 4);
      Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      throw [
            Compilation_error,
            --[ Missing_field_label ]--Block.__(14, [_1[0]])
          ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 4);
      Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      throw [
            Compilation_error,
            --[ Missing_field_label ]--Block.__(14, [_1[0]])
          ];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0)[1];
    end),
  (function (__caml_parser_env) do
      return "required";
    end),
  (function (__caml_parser_env) do
      return "optional";
    end),
  (function (__caml_parser_env) do
      return "repeated";
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 0);
      return "oneof";
    end),
  (function (__caml_parser_env) do
      return "enum";
    end),
  (function (__caml_parser_env) do
      return "package";
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 0);
      return "import";
    end),
  (function (__caml_parser_env) do
      return "public";
    end),
  (function (__caml_parser_env) do
      return "option";
    end),
  (function (__caml_parser_env) do
      return "extensions";
    end),
  (function (__caml_parser_env) do
      return "extend";
    end),
  (function (__caml_parser_env) do
      return "syntax";
    end),
  (function (__caml_parser_env) do
      return "message";
    end),
  (function (__caml_parser_env) do
      return "to";
    end),
  (function (__caml_parser_env) do
      return "max";
    end),
  (function (__caml_parser_env) do
      return "map";
    end),
  (function (__caml_parser_env) do
      return --[ Required ]--202657151;
    end),
  (function (__caml_parser_env) do
      return --[ Repeated ]---368609126;
    end),
  (function (__caml_parser_env) do
      return --[ Optional ]---132092992;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      throw [
            Compilation_error,
            --[ Invalid_field_label ]--Block.__(13, [_1[0]])
          ];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end),
  (function (__caml_parser_env) do
      return --[ [] ]--0;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              --[ [] ]--0
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      var _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _3
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      var _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ tuple ]--[
              _1[1],
              _3
            ];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _5 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ tuple ]--[
              _2[1],
              _5
            ];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0)[1];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1)[1];
    end),
  (function (__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return _1 .. _2[1];
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return --[ tuple ]--[
              _2,
              _4
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ Constant_int ]--Block.__(2, [_1]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ Constant_float ]--Block.__(3, [_1]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      var litteral = _1[1];
      switch (litteral) do
        case "false" :
            return --[ Constant_bool ]--Block.__(1, [false]);
        case "true" :
            return --[ Constant_bool ]--Block.__(1, [true]);
        default:
          return --[ Constant_litteral ]--Block.__(4, [litteral]);
      end
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ Constant_string ]--Block.__(0, [_1]);
    end),
  (function (__caml_parser_env) do
      var _2 = Parsing.peek_val(__caml_parser_env, 3);
      var _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      var enum_valuesOpt = _4;
      var enum_name = _2[1];
      var enum_values = enum_valuesOpt ~= undefined ? enum_valuesOpt : --[ [] ]--0;
      message_counter.contents = message_counter.contents + 1 | 0;
      return do
              enum_id: message_counter.contents,
              enum_name: enum_name,
              enum_values: enum_values
            end;
    end),
  (function (__caml_parser_env) do
      return --[ [] ]--0;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      var _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[ :: ]--[
              _1,
              _2
            ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 3);
      var _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return do
              enum_value_name: _1[1],
              enum_value_int: _3
            end;
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      var enum_value = _1[1];
      var loc = _1[0];
      throw [
            Compilation_error,
            --[ Missing_semicolon_for_enum_value ]--Block.__(9, [
                enum_value,
                loc
              ])
          ];
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[1], _1[0]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[1], _1[0]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[1], _1[0]);
    end),
  (function (__caml_parser_env) do
      var _1 = Parsing.peek_val(__caml_parser_env, 0);
      return invalid_enum_specification(_1[1], _1[0]);
    end),
  (function (__caml_parser_env) do
      return --[ () ]--0;
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 1);
      return --[ () ]--0;
    end),
  (function (__caml_parser_env) do
      return --[ () ]--0;
    end),
  (function (__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 1);
      return --[ () ]--0;
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end),
  (function (__caml_parser_env) do
      throw [
            Parsing.YYexit,
            Parsing.peek_val(__caml_parser_env, 0)
          ];
    end)
];

var yytables = do
  actions: yyact,
  transl_const: yytransl_const,
  transl_block: yytransl_block,
  lhs: "\xff\xff\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\b\0\t\0\n\0\x0b\0\f\0\x07\0\x18\0\x18\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x19\0\x13\0\x13\0\x13\0\x1b\0\x12\0\x12\0\x1d\0\x1d\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x17\0\x17\0!\0!\0\x16\0\x15\0\x15\0\"\0\"\0\"\0\x11\0\x11\0#\0#\0$\0$\0 \0 \0\x0e\0\x0e\0\x0e\0\x0e\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0&\0&\0&\0&\0\r\0\r\0'\0'\0(\0(\0*\0*\0+\0+\0\x14\0)\0)\0)\0)\0\x10\0,\0,\0\x0f\0\x0f\0\x0f\0\x0f\0\x0f\0\x0f\0\x1c\0\x1c\0\x1e\0\x1e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  len: "\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x04\0\x03\0\x04\0\x04\0\x03\0\x05\0\x04\0\x01\0\x02\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x05\0\x04\0\x01\0\x02\0\x03\0\x01\0\x03\0\x01\0\x03\0\x03\0\x05\0\x04\0\0\0\x02\0\x06\0\x05\0\n\0\x0b\0\x07\0\x06\0\x06\0\x05\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x03\0\x02\0\x01\0\x03\0\x03\0\x05\0\x01\0\x03\0\x01\0\x02\0\x05\0\x01\0\x01\0\x01\0\x01\0\x05\0\0\0\x02\0\x04\0\x03\0\x04\0\x02\0\x02\0\x01\0\x01\0\x02\0\x01\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0",
  defred: "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0r\0\0\0R\0T\0S\0\0\0s\0\0\0\0\0\0\0t\0\0\0\0\0u\0\0\0\0\0v\0\0\0\0\0w\0\0\0\0\0\0\0\0\0\0\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0y\0\0\0z\0\0\0\0\0{\0\0\0\0\0\0\0|\0\0\0}\0\0\0W\0\0\0\0\0\0\0\0\0\x01\0B\0C\0D\0E\0N\0F\0G\0H\0I\0J\0K\0L\0M\0O\0P\0Q\0A\0\0\0\x02\0\0\0\0\0l\0k\0\x03\0\0\0\x04\0\0\0\0\0\x05\0\0\0\x06\0\0\0\0\0\0\0\0\0\0\0\\\0^\0\0\0\0\0\0\0\x19\0\x18\0\x15\0\x16\0\x1a\0\f\0\r\0\x17\0\x07\0\b\0\0\0\t\0\0\0\0\0\n\0\x0b\0\0\0\0\0V\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0n\0\0\0\0\0\0\0\0\0\0\0\0\0_\0\0\0\0\x004\x003\x001\0\0\0\0\0d\0a\0b\0c\0Z\0Y\0\0\0\0\0j\0\0\0\0\0\0\0\0\0p\0\0\x008\0\0\0*\0\0\0$\0(\0&\0'\0)\0\0\0\0\0\0\0%\0o\0\0\0\0\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0\0\0\0\0q\0\0\0\0\0\0\0#\0\0\0.\0\0\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  dgoto: "\r\0\x0f\0\x15\0\x19\0\x1c\0\x1f\0\"\0)\x003\x005\x008\0<\0>\0\x10\0\xae\0\xa5\0*\0\xb0\0+\0,\0-\x009\0\xb2\0.\0/\x000\x001\x002\0\x8d\0\xb3\0\xa9\0\xb5\0\xb6\0\xbe\0:\0\x88\0\x89\0W\0\x17\0C\0D\0\x9f\0k\0l\0\xa6\0",
  sindex: "\xd2\0\xf5\xfe\x13\xff\xed\xfe\n\xff\x1e\xff4\xff\x89\xff:\xffF\xff5\xffV\xff[\xff\0\0\x18\xff\0\0b\0\0\0\0\0\0\0\xe1\xff\0\0i\0K\xffB\xff\0\0k\0M\xff\0\0z\0\x06\xff\0\0{\0]\xff\0\0\x7f\0a\xff\xfe\xfe\r\xffd\xffl\xff\0\0\x89\xff\x89\xff\x89\xff\x89\xff\x89\xff\x86\0\xa0\xff\0\0\x89\xff\0\0\x88\0\0\0\x8b\0\x86\xff\0\0\x97\0}\xff5\xff\0\0\x9a\0\0\0\x9c\0\0\0~\xff\x97\xff\x9f\xff\x96\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9a\xff\0\0\xe1\xff\x98\xff\0\0\0\0\0\0\xa4\xff\0\0\x9c\xff\xa7\xff\0\0\xaa\xff\0\0\xa5\xff\xa2\xff\xa5\xff\xb3\xff\xa1\xff\0\0\0\0\x05\xff\xbf\xff\xc3\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xfe\0\x005\xff\xa5\xff\0\0\0\0\xcb\xff9\xff\0\0\x1f\xff\xda\xff\xdf\xff,\xff\xed\xfe\xe1\xff\xe8\xff\x9c\xff\x9c\xffI\xff\0\0\xe2\xff\xa5\xff\xe2\xff\xa5\xff\xe6\xff9\xff\0\0\x10\xff\xa5\xff\0\0\0\0\0\0\xe2\xff\xe4\xff\0\0\0\0\0\0\0\0\0\0\0\0)\xff\xed\xff\0\0\xe2\xff\xed\xfe\xe8\xff\xe5\xff\0\0\xf5\xff\0\0\xe8\xff\0\0\xe7\xff\0\0\0\0\0\0\0\0\0\0\xe8\xff\xf5\xff\xc2\xff\0\0\0\0\xe2\xff\xe2\xff\0\0\xa5\xff\x13\xff\xf5\xff\xe8\xff\xe2\xff9\xff\xa5\xff\xe2\xff)\xff\0\0\xf5\xff\xf3\xff\0\0\xf5\xff\xf4\xff\xf5\xff\0\0\xe2\xff\0\0\xf5\xff\0\0\xe2\xff\xa5\xff\xe2\xff)\xff\xf9\xff\xe2\xff\xa5\xff\xe2\xff\xf6\xff\xe2\xff\x13\0\xe1\xff\xfd\xff\x0e\0)\xff\xa5\xff\xe2\xff\xe2\xff",
  rindex: "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0,\x01<\x01F\x01G\x01H\x01\0\0\0\0\0\0N\x01\0\0\0\0\0\0\0\0\x0b\0\0\0\0\0\x0f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0I\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0:\0L\0\0\0\0\0I\0I\0\0\0\0\0e\0\0\0w\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0?\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0L\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0N\0\0\0\0\0\x89\0\x9b\0\0\0\0\0O\0\xad\0\0\0\xc4\xff\0\0\0\0c\0\0\0\0\0\x17\0\0\0\0\0u\0\0\0-\0\0\0\xb8\0\0\0\xc1\0\0\0\x87\0\0\0\x99\0\0\0\0\0\xab\0\0\0\xfc\xfe\0\0\b\xff\0\0\0\0\0\0\0\0\0\0\0\0m\xff\x9e\xff",
  gindex: "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\xff\xfe\xff\xbe\x01\xff\xff\xc7\x01\x02\0\xbb\x01\xc6\x01\xca\xff\xc5\x01\xc8\x01\xc8\0\0\0\xa1\x01\0\0\xa3\xff\x1d\x01\x95\xff\0\0\0\0\x17\x01\0\0\xd6\xff\0\0\xa9\xff\0\0S\x01\0\0t\xff\0\0\0\x001\x01",
  tablesize: 470,
  table: "\x16\0!\0\x84\0\x1d\0\xc1\0|\0\xbb\0f\0#\0\x0e\0\x8f\x002\0\x18\0:\0\x96\x000\0\x1b\0\x11\0\x12\0\x13\0\x11\0\x12\0\x13\0e\0`\x009\0g\0:\0\x97\0h\0\x92\0\x99\0\xb4\0\xa8\0\x1e\0i\0\x93\0a\0\xd1\x009\0\xa4\0\xbd\0m\0@\0j\0 \0A\0\x14\0\xa7\0\xb8\0\x14\0\xb9\0\xcf\0A\0\xd6\0B\0\xbf\0!\0i\0\xc5\0h\0\x0e\0B\0/\0\xc8\0\xdf\0%\0\x8c\0\xc2\0\x98\0\x8c\0\xa3\0\xca\0\xac\0\x11\0\x12\0\x13\0\x1e\0!\0\x1b\0&\x006\x007\0\xce\0;\0\x9b\0\x9c\0\x9d\0\x9e\0\xad\0\xa8\0Z\0[\0\\\0\xcc\0\xaa\0\xab\0;\0E\0@\0\xd0\0\x1f\0\xd2\0'\0\x14\0X\0Y\0]\0^\0;\0;\0;\0;\0;\0;\0;\0\xd5\x005\0\xd7\0\x1c\0;\0\xd9\0_\0b\0c\0;\0;\0d\0e\0\xe0\0\xe1\0m\0\xdc\0n\0t\0?\0w\0\x1d\0\xaf\0x\0;\0\xb1\0!\0\x1b\0$\0%\0\xbc\0&\0y\0'\0(\0z\0{\0>\0}\0\x1e\0~\0\x7f\0<\0<\0<\0<\0<\0<\0<\0!\0\x1b\0$\0%\0<\0&\0=\0'\0,\0<\0<\0\x80\0\x82\0\x81\0\x83\0\xaf\0\x85\0\x86\0\xb1\0`\0\x8a\0\xbc\0\x87\0\x8b\0<\0\x8e\0\x8c\0\x91\0+\0\xac\0\x11\0\x12\0\x13\0\x1e\0!\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0;\0\x1b\0\x90\0\x1b\0\x94\0\xad\0\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\x07\0\b\0\t\0\n\0\x0b\0\f\0\x95\0\x9a\0\x14\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R\0S\0T\0U\0o\0p\0q\0r\0s\0\xa1\0\xa2\0\xa8\0v\0\xba\0\xb7\0\xc0\0\xc6\0\xc9\0V\0!\0!\0!\0!\0!\0!\0!\0!\0!\0\xc3\0!\0!\0!\0!\0\xc7\0\xd3\0!\0!\0\xd4\0\xd8\0\xda\0\xdd\0e\0e\0e\0e\0e\0e\0e\0e\0e\0!\0e\0e\0e\0e\x002\x002\0e\0e\x000\0\xdb\0\xde\0\x13\0 \0 \0 \0 \0 \0 \0 \0 \0 \0e\0 \0 \0 \0 \0m\0\x12\0 \0 \0/\0/\0/\0/\0/\0/\0/\0\x0f\0\x10\0\x14\0m\0/\0i\0 \0h\0\x11\0/\0/\x006\x006\x006\x006\x006\x006\x006\0X\0i\x007\0h\x006\0f\0/\0\"\0-\x006\x006\0@\0@\0@\0@\0@\0@\0@\0\x1f\0\x1f\0\x1f\0\x1f\0@\0\x1f\x006\0\x1f\0\x1f\0@\0@\x005\x005\x005\x005\x005\x005\x005\0\x1c\0\x1c\0\x1c\0\x1c\x005\0\x1c\0@\0\x1c\0\x1c\x005\x005\0?\0?\0?\0?\0?\0?\0?\0\x1d\0\x1d\0\x1d\0\x1d\0?\0\x1d\x005\0\x1d\0\x1d\0?\0?\0>\0>\0>\0>\0>\0>\0>\0\x1e\0\x1e\0\x1e\0\x1e\0>\0\x1e\0?\0\x1e\0\x1e\0>\0>\0=\0=\0=\0=\0=\0=\0=\0,\0,\0,\0,\0=\0,\0>\0,\0,\0=\0=\0`\0`\0`\0`\0\x1a\0`\x004\0`\0`\0+\0+\0+\0+\0=\0+\0 \0+\0+\x006\0=\0u\0\xcb\0\xcd\0?\0\xa0\0\xc4\0",
  check: "\x02\0\0\0Y\0\x04\0\xa1\0;\0\x92\0\t\x01\x06\0\x14\x01g\0\0\0\x1f\x01\x11\x01\x0f\x01\0\0\x06\x01\x01\x01\x02\x01\x03\x01\x01\x01\x02\x01\x03\x01\0\0\x12\x01\x11\x01\x1c\x01\x1f\x01\x1d\x01\x1f\x01\x19\x01|\0\x8b\0\x11\x01\x04\x01\x16\x01\x1f\x01\x1f\x01\xc3\0\x1f\x01\x85\0\x94\0\0\0\x13\x01\x1f\x01\0\0\x16\x01\x1f\x01\x87\0\x8e\0\x1f\x01\x90\0\xc0\0\x16\x01\xd3\0\x1f\x01\x95\0\x05\x01\0\0\xa6\0\0\0\x14\x01\x1f\x01\0\0\xab\0\xde\0\b\x01\x1a\x01\xa1\0{\0\x1a\x01\x1b\x01\xb3\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\n\x01\0\0\x1d\x01\xbe\0\x0b\x01\x1c\x01\x1d\x01\x1e\x01\x1f\x01\x10\x01\x11\x01\x19\x01\x1a\x01\x1b\x01\xbb\0\x89\0\x8a\0\x0b\x01\0\0\0\0\xc1\0\0\0\xc3\0\f\x01\x1f\x01\0\0\x1f\x01\0\0\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\xd1\0\0\0\xd3\0\0\0\x0b\x01\xd6\0\0\0\0\0\x1f\x01\x10\x01\x11\x01\0\0\x1f\x01\xde\0\xdf\0\x1f\x01\xdb\0\x19\x01\0\0\0\0\0\0\0\0\x8b\0\0\0\x1f\x01\x8b\0\x05\x01\x06\x01\x07\x01\b\x01\x94\0\n\x01\x0e\x01\f\x01\r\x01\0\0\x1b\x01\0\0\0\0\0\0\0\0\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\0\0\f\x01\0\0\x10\x01\x11\x01\x19\x01\x1b\x01\x13\x01\x19\x01\xb5\0\x1d\x01\x12\x01\xb5\0\0\0\x12\x01\xbc\0\x1f\x01\x12\x01\x1f\x01\x1c\x01\x1a\x01\x1f\x01\0\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1c\x01\f\x01\x12\x01\x10\x01\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\x07\0\b\0\t\0\n\0\x0b\0\f\0\x1c\x01\x15\x01\x1f\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\t\x01\n\x01\x0b\x01\f\x01\r\x01\x0e\x01\x0f\x01\x10\x01*\0+\0,\0-\0.\0\x1d\x01\x19\x01\x11\x012\0\x15\x01\x1a\x01\x19\x01\x19\x01\x18\x01\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1d\x01\n\x01\x0b\x01\f\x01\r\x01\x1a\x01\x1d\x01\x10\x01\x11\x01\x1f\x01\x1b\x01\x1f\x01\x19\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x0b\x01\f\x01\r\x01\x1a\x01\x1b\x01\x10\x01\x11\x01\x1a\x01\x17\x01\x1d\x01\0\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x0b\x01\f\x01\r\x01\x11\x01\0\0\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\0\0\0\0\0\0\x1f\x01\x0b\x01\x11\x01\x1f\x01\x11\x01\0\0\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x13\x01\x1f\x01\x11\x01\x1f\x01\x0b\x01\x11\x01\x1f\x01\x11\x01\x11\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\x05\x01\x06\x01\x07\x01\b\x01\x03\0\n\x01\b\0\f\x01\r\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x05\0\f\x01\r\x01\t\0\x0b\x000\0\xb5\0\xbc\0\f\0\x82\0\xa5\0",
  error_function: Parsing.parse_error,
  names_const: "REQUIRED\0OPTIONAL\0REPEATED\0MESSAGE\0ENUM\0PACKAGE\0PUBLIC\0OPTION\0EXTENSIONS\0EXTEND\0SYNTAX\0TO\0MAX\0MAP\0RBRACE\0LBRACE\0RBRACKET\0LBRACKET\0RPAREN\0LPAREN\0RANGLEB\0LANGLEB\0EQUAL\0SEMICOLON\0COMMA\0EOF\0",
  names_block: "ONE_OF\0IMPORT\0STRING\0INT\0FLOAT\0IDENT\0"
end;

function proto_(lexfun, lexbuf) do
  return Parsing.yyparse(yytables, 7, lexfun, lexbuf);
end

function update_loc(lexbuf) do
  var pos = lexbuf.lex_curr_p;
  lexbuf.lex_curr_p = do
    pos_fname: pos.pos_fname,
    pos_lnum: pos.pos_lnum + 1 | 0,
    pos_bol: pos.pos_cnum,
    pos_cnum: pos.pos_cnum
  end;
  return --[ () ]--0;
end

var __ocaml_lex_tables = do
  lex_base: "\0\0\xea\xff\xeb\xffN\0\xed\xff\xee\xff\x01\0\xa0\0\xf0\0;\x01\x88\x01\x9e\x01\xf2\xff\x10\0\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xf9\xff\xfa\xff\xfb\xff\xfc\xff\xfd\xff\xfe\xff\xff\xff\xf3\xff\xf4\xff\x1a\0\xbe\x01\xc8\x01\x92\x01\xa8\x01#\0\xef\xff\xed\x01:\x02\x87\x02\xd4\x02!\x03n\x03\x05\0\x12\x01\xfd\xff\xfe\xff\xff\xff\x06\0\x07\0!\x01\xfc\xff\xfd\xff\x11\0\xff\xff\x0b\0\f\0\xfe\xff\xc2\x01\xfc\xff\xfd\xff\xfe\xff\xc9\x03\xff\xff",
  lex_backtrk: "\x0f\0\xff\xff\xff\xff\x13\0\xff\xff\xff\xff\x15\0\x13\0\x13\0\x0f\0\x0e\0\x0f\0\xff\xff\x15\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0f\0\x0f\0\xff\xff\xff\xff\xff\xff\xff\xff\x13\0\x0f\0\x13\0\x13\0\x10\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\x02\0\xff\xff\x02\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x02\0\xff\xff",
  lex_default: "\x01\0\0\0\0\0\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff+\0\0\0\0\0\0\0\xff\xff\xff\xff1\0\0\0\0\0\xff\xff\0\0\xff\xff\xff\xff\0\x009\0\0\0\0\0\0\0\xff\xff\0\0",
  lex_trans: "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\x05\0\x05\0\x04\0\x06\0(\0\x05\0,\0,\0(\0.\0.\x003\x003\0\0\x005\x005\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\x13\0\x14\0\0\0\x0b\0\x0e\0\x0b\0\t\0\r\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x19\0\x0f\0\x12\0\x10\0\x11\0\x1a\x006\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x16\0\0\0\x15\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x07\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x18\0\"\0\x17\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0 \0!\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\"\0\0\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\x02\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0&\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\x1f\0,\0\x1f\0\"\0-\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\0\x003\0\0\0\0\x004\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\x002\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x1d\0\0\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1d\0\x1c\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\0\0\x1c\0:\0\0\0\0\0\0\0\0\0\x1f\0\0\0\x1f\0\0\0\x1c\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\0\0\x1c\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\0\0\0\0\0\0*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"\0\0\0\0\0;\0\0\0\0\x000\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1c\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0\0\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\0\x008\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0%\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0'\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0<\0\0\0<\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0<\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_check: "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\x06\0\0\0\0\0\x06\0(\0-\0.\0(\0-\0.\x004\x005\0\xff\xff4\x005\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0\0\0\0\r\x002\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x1b\0 \0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\xff\xff\xff\xff\xff\xff\xff\xff\x03\0\xff\xff\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\xff\xff\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\0\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\b\0)\0\b\0\b\0)\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\xff\xff/\0\xff\xff\xff\xff/\0\xff\xff\xff\xff\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0/\0\xff\xff\xff\xff\xff\xff\b\0\xff\xff\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\n\0\xff\xff\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x0b\0\n\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\xff\xff\x0b\x007\0\xff\xff\xff\xff\xff\xff\xff\xff\x1c\0\xff\xff\x1c\0\xff\xff\n\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\xff\xff\x0b\0\xff\xff\xff\xff\xff\xff\x0b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1d\0\xff\xff\xff\xff\xff\xff\xff\xff)\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\"\0\xff\xff\xff\xff7\0\xff\xff\xff\xff/\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1d\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0#\0\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\xff\xff\xff\xff\xff\xff\xff\xff#\0\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0$\0\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\xff\xff7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\xff\xff\xff\xff\xff\xff\xff\xff$\0\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0%\0\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\xff\xff\xff\xff\xff\xff\xff\xff%\0\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0&\0\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0\xff\xff\xff\xff\xff\xff\xff\xff&\0\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0'\0\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0\xff\xff\xff\xff\xff\xff\xff\xff'\0\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0;\0\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff;\0\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_base_code: "",
  lex_backtrk_code: "",
  lex_default_code: "",
  lex_trans_code: "",
  lex_check_code: "",
  lex_code: ""
end;

function __ocaml_lex_string_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    var __ocaml_lex_state = ___ocaml_lex_state;
    var l = _l;
    var __ocaml_lex_state$1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    switch (__ocaml_lex_state$1) do
      case 0 :
          var c = Lexing.lexeme_char(lexbuf, 1);
          ___ocaml_lex_state = 55;
          _l = --[ :: ]--[
            Char.escaped(c),
            l
          ];
          continue ;
      case 1 :
          return --[ String_value ]--[$$String.concat("", List.rev(l))];
      case 2 :
          ___ocaml_lex_state = 55;
          _l = --[ :: ]--[
            Lexing.lexeme(lexbuf),
            l
          ];
          continue ;
      case 3 :
          return --[ String_eof ]--0;
      default:
        Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state$1;
        continue ;
    end
  end;
end

function __ocaml_lex_comment_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    var __ocaml_lex_state = ___ocaml_lex_state;
    var l = _l;
    var __ocaml_lex_state$1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    switch (__ocaml_lex_state$1) do
      case 0 :
          update_loc(lexbuf);
          return --[ Comment_value ]--[$$String.concat("", List.rev(l))];
      case 1 :
          ___ocaml_lex_state = 41;
          _l = --[ :: ]--[
            Lexing.lexeme(lexbuf),
            l
          ];
          continue ;
      case 2 :
          return --[ Comment_eof ]--0;
      default:
        Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state$1;
        continue ;
    end
  end;
end

function __ocaml_lex_multi_line_comment_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    var __ocaml_lex_state = ___ocaml_lex_state;
    var l = _l;
    var __ocaml_lex_state$1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    switch (__ocaml_lex_state$1) do
      case 0 :
          update_loc(lexbuf);
          ___ocaml_lex_state = 47;
          continue ;
      case 1 :
          Lexing.lexeme(lexbuf);
          return --[ Comment_value ]--[$$String.concat("", List.rev(l))];
      case 2 :
          ___ocaml_lex_state = 47;
          _l = --[ :: ]--[
            Lexing.lexeme(lexbuf),
            l
          ];
          continue ;
      case 3 :
          return --[ Comment_eof ]--0;
      default:
        Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state$1;
        continue ;
    end
  end;
end

function lexer(lexbuf) do
  var lexbuf$1 = lexbuf;
  var ___ocaml_lex_state = 0;
  while(true) do
    var __ocaml_lex_state = ___ocaml_lex_state;
    var __ocaml_lex_state$1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf$1);
    switch (__ocaml_lex_state$1) do
      case 0 :
          return --[ LBRACE ]--15;
      case 1 :
          return --[ RBRACE ]--14;
      case 2 :
          return --[ LBRACKET ]--17;
      case 3 :
          return --[ RBRACKET ]--16;
      case 4 :
          return --[ RPAREN ]--18;
      case 5 :
          return --[ LPAREN ]--19;
      case 6 :
          return --[ LANGLEB ]--21;
      case 7 :
          return --[ RANGLEB ]--20;
      case 8 :
          return --[ EQUAL ]--22;
      case 9 :
          return --[ SEMICOLON ]--23;
      case 10 :
          return --[ COMMA ]--24;
      case 11 :
          var match = __ocaml_lex_comment_rec(--[ [] ]--0, lexbuf$1, 41);
          if (match) do
            ___ocaml_lex_state = 0;
            continue ;
          end else do
            return --[ EOF ]--25;
          end
      case 12 :
          var match$1 = __ocaml_lex_multi_line_comment_rec(--[ [] ]--0, lexbuf$1, 47);
          if (match$1) do
            ___ocaml_lex_state = 0;
            continue ;
          end else do
            return --[ EOF ]--25;
          end
      case 13 :
          var match$2 = __ocaml_lex_string_rec(--[ [] ]--0, lexbuf$1, 55);
          if (match$2) do
            return --[ STRING ]--Block.__(2, [match$2[0]]);
          end else do
            return --[ EOF ]--25;
          end
      case 14 :
          return --[ INT ]--Block.__(3, [Caml_format.caml_int_of_string(Lexing.lexeme(lexbuf$1))]);
      case 15 :
          return --[ FLOAT ]--Block.__(4, [Caml_format.caml_float_of_string(Lexing.lexeme(lexbuf$1))]);
      case 16 :
          return --[ FLOAT ]--Block.__(4, [Number.NaN]);
      case 17 :
          update_loc(lexbuf$1);
          ___ocaml_lex_state = 0;
          continue ;
      case 18 :
          ___ocaml_lex_state = 0;
          continue ;
      case 19 :
          var loc = from_lexbuf(lexbuf$1);
          var ident = Lexing.lexeme(lexbuf$1);
          switch (ident) do
            case "enum" :
                return --[ ENUM ]--4;
            case "extend" :
                return --[ EXTEND ]--9;
            case "extensions" :
                return --[ EXTENSIONS ]--8;
            case "import" :
                return --[ IMPORT ]--Block.__(1, [loc]);
            case "map" :
                return --[ MAP ]--13;
            case "max" :
                return --[ MAX ]--12;
            case "message" :
                return --[ MESSAGE ]--3;
            case "oneof" :
                return --[ ONE_OF ]--Block.__(0, [loc]);
            case "option" :
                return --[ OPTION ]--7;
            case "optional" :
                return --[ OPTIONAL ]--1;
            case "package" :
                return --[ PACKAGE ]--5;
            case "public" :
                return --[ PUBLIC ]--6;
            case "repeated" :
                return --[ REPEATED ]--2;
            case "required" :
                return --[ REQUIRED ]--0;
            case "syntax" :
                return --[ SYNTAX ]--10;
            case "to" :
                return --[ TO ]--11;
            default:
              return --[ IDENT ]--Block.__(5, [--[ tuple ]--[
                          loc,
                          ident
                        ]]);
          end
      case 20 :
          return --[ EOF ]--25;
      case 21 :
          var s = Curry._1(Printf.sprintf(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "Unknown character found ",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "Unknown character found %s"
                  ]), Lexing.lexeme(lexbuf$1));
          throw [
                Caml_builtin_exceptions.failure,
                s
              ];
      default:
        Curry._1(lexbuf$1.refill_buff, lexbuf$1);
        ___ocaml_lex_state = __ocaml_lex_state$1;
        continue ;
    end
  end;
end

function let_decl_of_and(param) do
  if (param ~= undefined) do
    return "and";
  end else do
    return "let rec";
  end
end

function string_of_basic_type(param) do
  switch (param) do
    case --[ Bt_string ]--0 :
        return "string";
    case --[ Bt_float ]--1 :
        return "float";
    case --[ Bt_int ]--2 :
        return "int";
    case --[ Bt_int32 ]--3 :
        return "int32";
    case --[ Bt_int64 ]--4 :
        return "int64";
    case --[ Bt_bytes ]--5 :
        return "bytes";
    case --[ Bt_bool ]--6 :
        return "bool";
    
  end
end

function string_of_field_type(param) do
  if (typeof param == "number") do
    return "unit";
  end else if (param.tag) do
    var param$1 = param[0];
    var match = param$1.udt_module;
    if (match ~= undefined) do
      return match .. ("." .. param$1.udt_type_name);
    end else do
      return param$1.udt_type_name;
    end
  end else do
    return string_of_basic_type(param[0]);
  end
end

function string_of_record_field_type(param) do
  switch (param.tag | 0) do
    case --[ Rft_required ]--0 :
        return string_of_field_type(param[0][0]);
    case --[ Rft_optional ]--1 :
        return string_of_field_type(param[0][0]) .. " option";
    case --[ Rft_repeated_field ]--2 :
        var match = param[0];
        return string_of_field_type(match[1]) .. (" " .. (
                  match[0] ? "Pbrt.Repeated_field.t" : "list"
                ));
    case --[ Rft_associative_field ]--3 :
        var match$1 = param[0];
        if (match$1[0]) do
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ Char_literal ]--Block.__(12, [
                              --[ "(" ]--40,
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ", ",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ") ",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "(%s, %s) %s"
                        ]), string_of_basic_type(match$1[2][0]), string_of_field_type(match$1[3][0]), "Hashtbl.t");
        end else do
          return Curry._3(Printf.sprintf(--[ Format ]--[
                          --[ Char_literal ]--Block.__(12, [
                              --[ "(" ]--40,
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " * ",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ") ",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "(%s * %s) %s"
                        ]), string_of_basic_type(match$1[2][0]), string_of_field_type(match$1[3][0]), "list");
        end
    case --[ Rft_variant_field ]--4 :
        return param[0].v_name;
    
  end
end

function function_name_of_user_defined(prefix, param) do
  var match = param.udt_module;
  if (match ~= undefined) do
    return Curry._3(Printf.sprintf(--[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ "." ]--46,
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ Char_literal ]--Block.__(12, [
                                    --[ "_" ]--95,
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "%s.%s_%s"
                  ]), match, prefix, param.udt_type_name);
  end else do
    return Curry._2(Printf.sprintf(--[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ "_" ]--95,
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "%s_%s"
                  ]), prefix, param.udt_type_name);
  end
end

function string_of_payload_kind(capitalize, payload_kind, packed) do
  var s;
  if (typeof payload_kind == "number") do
    switch (payload_kind) do
      case --[ Pk_bits32 ]--0 :
          s = packed ? "bytes" : "bits32";
          break;
      case --[ Pk_bits64 ]--1 :
          s = packed ? "bytes" : "bits64";
          break;
      case --[ Pk_bytes ]--2 :
          s = "bytes";
          break;
      
    end
  end else do
    s = packed ? "bytes" : "varint";
  end
  if (capitalize ~= undefined) do
    return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
  end else do
    return s;
  end
end

function line$1(scope, s) do
  scope.items = --[ :: ]--[
    --[ Line ]--Block.__(0, [s]),
    scope.items
  ];
  return --[ () ]--0;
end

function scope(scope$1, f) do
  var sub_scope = do
    items: --[ [] ]--0
  end;
  Curry._1(f, sub_scope);
  scope$1.items = --[ :: ]--[
    --[ Scope ]--Block.__(1, [sub_scope]),
    scope$1.items
  ];
  return --[ () ]--0;
end

function indentation_prefix(n) do
  switch (n) do
    case 0 :
        return "";
    case 1 :
        return "  ";
    case 2 :
        return "    ";
    case 3 :
        return "      ";
    case 4 :
        return "        ";
    case 5 :
        return "          ";
    case 6 :
        return "            ";
    case 7 :
        return "              ";
    case 8 :
        return "                ";
    default:
      return Caml_bytes.bytes_to_string(Bytes.make(n, --[ " " ]--32));
  end
end

function print(scope) do
  var loop = function (_acc, i, _param) do
    while(true) do
      var param = _param;
      var acc = _acc;
      if (param) do
        var match = param[0];
        if (match.tag) do
          var items = match[0].items;
          var sub = loop(--[ [] ]--0, i + 1 | 0, items);
          _param = param[1];
          _acc = Pervasives.$at(sub, acc);
          continue ;
        end else do
          _param = param[1];
          _acc = --[ :: ]--[
            indentation_prefix(i) .. match[0],
            acc
          ];
          continue ;
        end
      end else do
        return acc;
      end
    end;
  end;
  return $$String.concat("\n", loop(--[ [] ]--0, 0, scope.items));
end

function runtime_function(param) do
  var match = param[0];
  if (match ~= 427938126) do
    if (match ~= 779642422) do
      throw [
            Caml_builtin_exceptions.failure,
            "Invalid encoding/OCaml type combination"
          ];
    end
    var match$1 = param[1];
    if (typeof match$1 == "number") do
      switch (match$1) do
        case --[ Pk_bits32 ]--0 :
            switch (param[2]) do
              case --[ Bt_float ]--1 :
                  return "Pbrt.Encoder.float_as_bits32";
              case --[ Bt_int ]--2 :
                  return "Pbrt.Encoder.int_as_bits32";
              case --[ Bt_int32 ]--3 :
                  return "Pbrt.Encoder.int32_as_bits32";
              case --[ Bt_string ]--0 :
              case --[ Bt_int64 ]--4 :
              case --[ Bt_bytes ]--5 :
              case --[ Bt_bool ]--6 :
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Invalid encoding/OCaml type combination"
                      ];
              
            end
        case --[ Pk_bits64 ]--1 :
            switch (param[2]) do
              case --[ Bt_float ]--1 :
                  return "Pbrt.Encoder.float_as_bits64";
              case --[ Bt_int ]--2 :
                  return "Pbrt.Encoder.int_as_bits64";
              case --[ Bt_int64 ]--4 :
                  return "Pbrt.Encoder.int64_as_bits64";
              case --[ Bt_string ]--0 :
              case --[ Bt_int32 ]--3 :
              case --[ Bt_bytes ]--5 :
              case --[ Bt_bool ]--6 :
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Invalid encoding/OCaml type combination"
                      ];
              
            end
        case --[ Pk_bytes ]--2 :
            var match$2 = param[2];
            if (match$2 ~= 5) do
              if (match$2 ~= 0) do
                throw [
                      Caml_builtin_exceptions.failure,
                      "Invalid encoding/OCaml type combination"
                    ];
              end else do
                return "Pbrt.Encoder.string";
              end
            end else do
              return "Pbrt.Encoder.bytes";
            end
        
      end
    end else if (match$1[0]) do
      switch (param[2]) do
        case --[ Bt_int ]--2 :
            return "Pbrt.Encoder.int_as_zigzag";
        case --[ Bt_int32 ]--3 :
            return "Pbrt.Encoder.int32_as_zigzag";
        case --[ Bt_int64 ]--4 :
            return "Pbrt.Encoder.int64_as_zigzag";
        case --[ Bt_string ]--0 :
        case --[ Bt_float ]--1 :
        case --[ Bt_bytes ]--5 :
        case --[ Bt_bool ]--6 :
            throw [
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                ];
        
      end
    end else do
      switch (param[2]) do
        case --[ Bt_int ]--2 :
            return "Pbrt.Encoder.int_as_varint";
        case --[ Bt_int32 ]--3 :
            return "Pbrt.Encoder.int32_as_varint";
        case --[ Bt_int64 ]--4 :
            return "Pbrt.Encoder.int64_as_varint";
        case --[ Bt_string ]--0 :
        case --[ Bt_float ]--1 :
        case --[ Bt_bytes ]--5 :
            throw [
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                ];
        case --[ Bt_bool ]--6 :
            return "Pbrt.Encoder.bool";
        
      end
    end
  end else do
    var match$3 = param[1];
    if (typeof match$3 == "number") do
      switch (match$3) do
        case --[ Pk_bits32 ]--0 :
            switch (param[2]) do
              case --[ Bt_float ]--1 :
                  return "Pbrt.Decoder.float_as_bits32";
              case --[ Bt_int ]--2 :
                  return "Pbrt.Decoder.int_as_bits32";
              case --[ Bt_int32 ]--3 :
                  return "Pbrt.Decoder.int32_as_bits32";
              case --[ Bt_string ]--0 :
              case --[ Bt_int64 ]--4 :
              case --[ Bt_bytes ]--5 :
              case --[ Bt_bool ]--6 :
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Invalid encoding/OCaml type combination"
                      ];
              
            end
        case --[ Pk_bits64 ]--1 :
            switch (param[2]) do
              case --[ Bt_float ]--1 :
                  return "Pbrt.Decoder.float_as_bits64";
              case --[ Bt_int ]--2 :
                  return "Pbrt.Decoder.int_as_bits64";
              case --[ Bt_int64 ]--4 :
                  return "Pbrt.Decoder.int64_as_bits64";
              case --[ Bt_string ]--0 :
              case --[ Bt_int32 ]--3 :
              case --[ Bt_bytes ]--5 :
              case --[ Bt_bool ]--6 :
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Invalid encoding/OCaml type combination"
                      ];
              
            end
        case --[ Pk_bytes ]--2 :
            var match$4 = param[2];
            if (match$4 ~= 5) do
              if (match$4 ~= 0) do
                throw [
                      Caml_builtin_exceptions.failure,
                      "Invalid encoding/OCaml type combination"
                    ];
              end else do
                return "Pbrt.Decoder.string";
              end
            end else do
              return "Pbrt.Decoder.bytes";
            end
        
      end
    end else if (match$3[0]) do
      switch (param[2]) do
        case --[ Bt_int ]--2 :
            return "Pbrt.Decoder.int_as_zigzag";
        case --[ Bt_int32 ]--3 :
            return "Pbrt.Decoder.int32_as_zigzag";
        case --[ Bt_int64 ]--4 :
            return "Pbrt.Decoder.int64_as_zigzag";
        case --[ Bt_string ]--0 :
        case --[ Bt_float ]--1 :
        case --[ Bt_bytes ]--5 :
        case --[ Bt_bool ]--6 :
            throw [
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                ];
        
      end
    end else do
      switch (param[2]) do
        case --[ Bt_int ]--2 :
            return "Pbrt.Decoder.int_as_varint";
        case --[ Bt_int32 ]--3 :
            return "Pbrt.Decoder.int32_as_varint";
        case --[ Bt_int64 ]--4 :
            return "Pbrt.Decoder.int64_as_varint";
        case --[ Bt_string ]--0 :
        case --[ Bt_float ]--1 :
        case --[ Bt_bytes ]--5 :
            throw [
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                ];
        case --[ Bt_bool ]--6 :
            return "Pbrt.Decoder.bool";
        
      end
    end
  end
end

function decode_basic_type(bt, pk) do
  return runtime_function(--[ tuple ]--[
              --[ Decode ]--427938126,
              pk,
              bt
            ]);
end

function decode_field_f(field_type, pk) do
  if (typeof field_type == "number") do
    return "Pbrt.Decoder.empty_nested d";
  end else if (field_type.tag) do
    var t = field_type[0];
    var f_name = function_name_of_user_defined("decode", t);
    if (t.udt_nested) do
      return f_name .. " (Pbrt.Decoder.nested d)";
    end else do
      return f_name .. " d";
    end
  end else do
    return decode_basic_type(field_type[0], pk) .. " d";
  end
end

function gen_decode_record(and_, param, sc) do
  var r_fields = param.r_fields;
  var r_name = param.r_name;
  var all_lists = List.fold_left((function (acc, param) do
          var rf_field_type = param.rf_field_type;
          switch (rf_field_type.tag | 0) do
            case --[ Rft_repeated_field ]--2 :
            case --[ Rft_associative_field ]--3 :
                break;
            default:
              return acc;
          end
          if (rf_field_type[0][0]) do
            return acc;
          end else do
            return --[ :: ]--[
                    param.rf_label,
                    acc
                  ];
          end
        end), --[ [] ]--0, r_fields);
  var process_field_common = function (sc, encoding_number, pk_as_string, f) do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "| Some (",
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ", Pbrt.",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ") -> (",
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "| Some (%i, Pbrt.%s) -> ("
                ]), encoding_number, pk_as_string));
    scope(sc, (function (sc) do
            Curry._1(f, sc);
            return line$1(sc, "loop ()");
          end));
    line$1(sc, ")");
    line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "| Some (",
                      --[ Int ]--Block.__(4, [
                          --[ Int_i ]--3,
                          --[ No_padding ]--0,
                          --[ No_precision ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ", pk) -> raise (",
                              --[ End_of_format ]--0
                            ])
                        ])
                    ]),
                  "| Some (%i, pk) -> raise ("
                ]), encoding_number));
    scope(sc, (function (sc) do
            return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                --[ String_literal ]--Block.__(11, [
                                    "Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (",
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ String_literal ]--Block.__(11, [
                                            ", pk))",
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ]),
                                "Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (%s, pk))"
                              ]), Curry._2(Printf.sprintf(--[ Format ]--[
                                    --[ String_literal ]--Block.__(11, [
                                        "\"Message(",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ String_literal ]--Block.__(11, [
                                                "), field(",
                                                --[ Int ]--Block.__(4, [
                                                    --[ Int_i ]--3,
                                                    --[ No_padding ]--0,
                                                    --[ No_precision ]--0,
                                                    --[ String_literal ]--Block.__(11, [
                                                        ")\"",
                                                        --[ End_of_format ]--0
                                                      ])
                                                  ])
                                              ])
                                          ])
                                      ]),
                                    "\"Message(%s), field(%i)\""
                                  ]), r_name, encoding_number)));
          end));
    return line$1(sc, ")");
  end;
  var mutable_record_name = r_name .. "_mutable";
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " decode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " d =",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s decode_%s d ="
              ]), let_decl_of_and(and_), r_name));
  return scope(sc, (function (sc) do
                line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "let v = default_",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " () in",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "let v = default_%s () in"
                            ]), mutable_record_name));
                line$1(sc, "let rec loop () = ");
                scope(sc, (function (sc) do
                        line$1(sc, "match Pbrt.Decoder.key d with");
                        line$1(sc, "| None -> (");
                        scope(sc, (function (sc) do
                                return List.iter((function (field_name) do
                                              return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                  --[ String_literal ]--Block.__(11, [
                                                                      "v.",
                                                                      --[ String ]--Block.__(2, [
                                                                          --[ No_padding ]--0,
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              " <- List.rev v.",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                      --[ ";" ]--59,
                                                                                      --[ End_of_format ]--0
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ]),
                                                                  "v.%s <- List.rev v.%s;"
                                                                ]), field_name, field_name));
                                            end), all_lists);
                              end));
                        line$1(sc, ")");
                        List.iter((function (param) do
                                var rf_field_type = param.rf_field_type;
                                var rf_label = param.rf_label;
                                switch (rf_field_type.tag | 0) do
                                  case --[ Rft_required ]--0 :
                                      var sc$1 = sc;
                                      var rf_label$1 = rf_label;
                                      var param$1 = rf_field_type[0];
                                      var pk = param$1[2];
                                      var field_type = param$1[0];
                                      return process_field_common(sc$1, param$1[1], string_of_payload_kind(--[ () ]--0, pk, false), (function (sc) do
                                                    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                        --[ String_literal ]--Block.__(11, [
                                                                            "v.",
                                                                            --[ String ]--Block.__(2, [
                                                                                --[ No_padding ]--0,
                                                                                --[ String_literal ]--Block.__(11, [
                                                                                    " <- ",
                                                                                    --[ String ]--Block.__(2, [
                                                                                        --[ No_padding ]--0,
                                                                                        --[ Char_literal ]--Block.__(12, [
                                                                                            --[ ";" ]--59,
                                                                                            --[ End_of_format ]--0
                                                                                          ])
                                                                                      ])
                                                                                  ])
                                                                              ])
                                                                          ]),
                                                                        "v.%s <- %s;"
                                                                      ]), rf_label$1, decode_field_f(field_type, pk)));
                                                  end));
                                  case --[ Rft_optional ]--1 :
                                      var sc$2 = sc;
                                      var rf_label$2 = rf_label;
                                      var param$2 = rf_field_type[0];
                                      var pk$1 = param$2[2];
                                      var field_type$1 = param$2[0];
                                      return process_field_common(sc$2, param$2[1], string_of_payload_kind(--[ () ]--0, pk$1, false), (function (sc) do
                                                    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                        --[ String_literal ]--Block.__(11, [
                                                                            "v.",
                                                                            --[ String ]--Block.__(2, [
                                                                                --[ No_padding ]--0,
                                                                                --[ String_literal ]--Block.__(11, [
                                                                                    " <- Some (",
                                                                                    --[ String ]--Block.__(2, [
                                                                                        --[ No_padding ]--0,
                                                                                        --[ String_literal ]--Block.__(11, [
                                                                                            ");",
                                                                                            --[ End_of_format ]--0
                                                                                          ])
                                                                                      ])
                                                                                  ])
                                                                              ])
                                                                          ]),
                                                                        "v.%s <- Some (%s);"
                                                                      ]), rf_label$2, decode_field_f(field_type$1, pk$1)));
                                                  end));
                                  case --[ Rft_repeated_field ]--2 :
                                      var sc$3 = sc;
                                      var rf_label$3 = rf_label;
                                      var param$3 = rf_field_type[0];
                                      var is_packed = param$3[4];
                                      var pk$2 = param$3[3];
                                      var encoding_number = param$3[2];
                                      var field_type$2 = param$3[1];
                                      if (param$3[0]) do
                                        if (is_packed) do
                                          return process_field_common(sc$3, encoding_number, "Bytes", (function (sc) do
                                                        line$1(sc, "Pbrt.Decoder.packed_fold (fun () d -> ");
                                                        scope(sc, (function (sc) do
                                                                return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                                    --[ String_literal ]--Block.__(11, [
                                                                                        "Pbrt.Repeated_field.add (",
                                                                                        --[ String ]--Block.__(2, [
                                                                                            --[ No_padding ]--0,
                                                                                            --[ String_literal ]--Block.__(11, [
                                                                                                ") v.",
                                                                                                --[ String ]--Block.__(2, [
                                                                                                    --[ No_padding ]--0,
                                                                                                    --[ Char_literal ]--Block.__(12, [
                                                                                                        --[ ";" ]--59,
                                                                                                        --[ End_of_format ]--0
                                                                                                      ])
                                                                                                  ])
                                                                                              ])
                                                                                          ])
                                                                                      ]),
                                                                                    "Pbrt.Repeated_field.add (%s) v.%s;"
                                                                                  ]), decode_field_f(field_type$2, pk$2), rf_label$3));
                                                              end));
                                                        return line$1(sc, ") () d;");
                                                      end));
                                        end else do
                                          return process_field_common(sc$3, encoding_number, string_of_payload_kind(--[ () ]--0, pk$2, false), (function (sc) do
                                                        return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                "Pbrt.Repeated_field.add (",
                                                                                --[ String ]--Block.__(2, [
                                                                                    --[ No_padding ]--0,
                                                                                    --[ String_literal ]--Block.__(11, [
                                                                                        ") v.",
                                                                                        --[ String ]--Block.__(2, [
                                                                                            --[ No_padding ]--0,
                                                                                            --[ String_literal ]--Block.__(11, [
                                                                                                "; ",
                                                                                                --[ End_of_format ]--0
                                                                                              ])
                                                                                          ])
                                                                                      ])
                                                                                  ])
                                                                              ]),
                                                                            "Pbrt.Repeated_field.add (%s) v.%s; "
                                                                          ]), decode_field_f(field_type$2, pk$2), rf_label$3));
                                                      end));
                                        end
                                      end else if (is_packed) do
                                        return process_field_common(sc$3, encoding_number, "Bytes", (function (sc) do
                                                      return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              "v.",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ String_literal ]--Block.__(11, [
                                                                                      " <- Pbrt.Decoder.packed_fold (fun l d -> (",
                                                                                      --[ String ]--Block.__(2, [
                                                                                          --[ No_padding ]--0,
                                                                                          --[ String_literal ]--Block.__(11, [
                                                                                              ")::l) [] d;",
                                                                                              --[ End_of_format ]--0
                                                                                            ])
                                                                                        ])
                                                                                    ])
                                                                                ])
                                                                            ]),
                                                                          "v.%s <- Pbrt.Decoder.packed_fold (fun l d -> (%s)::l) [] d;"
                                                                        ]), rf_label$3, decode_field_f(field_type$2, pk$2)));
                                                    end));
                                      end else do
                                        return process_field_common(sc$3, encoding_number, string_of_payload_kind(--[ () ]--0, pk$2, false), (function (sc) do
                                                      return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              "v.",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ String_literal ]--Block.__(11, [
                                                                                      " <- (",
                                                                                      --[ String ]--Block.__(2, [
                                                                                          --[ No_padding ]--0,
                                                                                          --[ String_literal ]--Block.__(11, [
                                                                                              ") :: v.",
                                                                                              --[ String ]--Block.__(2, [
                                                                                                  --[ No_padding ]--0,
                                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                                      --[ ";" ]--59,
                                                                                                      --[ End_of_format ]--0
                                                                                                    ])
                                                                                                ])
                                                                                            ])
                                                                                        ])
                                                                                    ])
                                                                                ])
                                                                            ]),
                                                                          "v.%s <- (%s) :: v.%s;"
                                                                        ]), rf_label$3, decode_field_f(field_type$2, pk$2), rf_label$3));
                                                    end));
                                      end
                                  case --[ Rft_associative_field ]--3 :
                                      var sc$4 = sc;
                                      var rf_label$4 = rf_label;
                                      var param$4 = rf_field_type[0];
                                      var match = param$4[3];
                                      var value_pk = match[1];
                                      var value_type = match[0];
                                      var match$1 = param$4[2];
                                      var at = param$4[0];
                                      var decode_key_f = decode_basic_type(match$1[0], match$1[1]);
                                      return process_field_common(sc$4, param$4[1], "Bytes", (function (sc) do
                                                    line$1(sc, "let decode_value = (fun d ->");
                                                    scope(sc, (function (sc) do
                                                            return line$1(sc, decode_field_f(value_type, value_pk));
                                                          end));
                                                    line$1(sc, ") in");
                                                    var decode_expression = Curry._1(Printf.sprintf(--[ Format ]--[
                                                              --[ String_literal ]--Block.__(11, [
                                                                  "(Pbrt.Decoder.map_entry d ~decode_key:",
                                                                  --[ String ]--Block.__(2, [
                                                                      --[ No_padding ]--0,
                                                                      --[ String_literal ]--Block.__(11, [
                                                                          " ~decode_value)",
                                                                          --[ End_of_format ]--0
                                                                        ])
                                                                    ])
                                                                ]),
                                                              "(Pbrt.Decoder.map_entry d ~decode_key:%s ~decode_value)"
                                                            ]), decode_key_f);
                                                    if (at) do
                                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "let a, b = ",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                " in",
                                                                                --[ End_of_format ]--0
                                                                              ])
                                                                          ])
                                                                      ]),
                                                                    "let a, b = %s in"
                                                                  ]), decode_expression));
                                                      return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              "Hashtbl.add v.",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ String_literal ]--Block.__(11, [
                                                                                      " a b;",
                                                                                      --[ End_of_format ]--0
                                                                                    ])
                                                                                ])
                                                                            ]),
                                                                          "Hashtbl.add v.%s a b;"
                                                                        ]), rf_label$4));
                                                    end else do
                                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "v.",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                " <- (",
                                                                                --[ End_of_format ]--0
                                                                              ])
                                                                          ])
                                                                      ]),
                                                                    "v.%s <- ("
                                                                  ]), rf_label$4));
                                                      scope(sc, (function (sc) do
                                                              return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                                  --[ String ]--Block.__(2, [
                                                                                      --[ No_padding ]--0,
                                                                                      --[ String_literal ]--Block.__(11, [
                                                                                          "::v.",
                                                                                          --[ String ]--Block.__(2, [
                                                                                              --[ No_padding ]--0,
                                                                                              --[ Char_literal ]--Block.__(12, [
                                                                                                  --[ ";" ]--59,
                                                                                                  --[ End_of_format ]--0
                                                                                                ])
                                                                                            ])
                                                                                        ])
                                                                                    ]),
                                                                                  "%s::v.%s;"
                                                                                ]), decode_expression, rf_label$4));
                                                            end));
                                                      return line$1(sc, ");");
                                                    end
                                                  end));
                                  case --[ Rft_variant_field ]--4 :
                                      var sc$5 = sc;
                                      var rf_label$5 = rf_label;
                                      var param$5 = rf_field_type[0];
                                      return List.iter((function (param) do
                                                    var pk = param.vc_payload_kind;
                                                    var vc_field_type = param.vc_field_type;
                                                    var vc_constructor = param.vc_constructor;
                                                    return process_field_common(sc$5, param.vc_encoding_number, string_of_payload_kind(--[ () ]--0, pk, false), (function (sc) do
                                                                  if (vc_field_type) do
                                                                    return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                                                        --[ String_literal ]--Block.__(11, [
                                                                                            "v.",
                                                                                            --[ String ]--Block.__(2, [
                                                                                                --[ No_padding ]--0,
                                                                                                --[ String_literal ]--Block.__(11, [
                                                                                                    " <- ",
                                                                                                    --[ String ]--Block.__(2, [
                                                                                                        --[ No_padding ]--0,
                                                                                                        --[ String_literal ]--Block.__(11, [
                                                                                                            " (",
                                                                                                            --[ String ]--Block.__(2, [
                                                                                                                --[ No_padding ]--0,
                                                                                                                --[ String_literal ]--Block.__(11, [
                                                                                                                    ");",
                                                                                                                    --[ End_of_format ]--0
                                                                                                                  ])
                                                                                                              ])
                                                                                                          ])
                                                                                                      ])
                                                                                                  ])
                                                                                              ])
                                                                                          ]),
                                                                                        "v.%s <- %s (%s);"
                                                                                      ]), rf_label$5, vc_constructor, decode_field_f(vc_field_type[0], pk)));
                                                                  end else do
                                                                    line$1(sc, "Pbrt.Decoder.empty_nested d;");
                                                                    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                                                        --[ String_literal ]--Block.__(11, [
                                                                                            "v.",
                                                                                            --[ String ]--Block.__(2, [
                                                                                                --[ No_padding ]--0,
                                                                                                --[ String_literal ]--Block.__(11, [
                                                                                                    " <- ",
                                                                                                    --[ String ]--Block.__(2, [
                                                                                                        --[ No_padding ]--0,
                                                                                                        --[ Char_literal ]--Block.__(12, [
                                                                                                            --[ ";" ]--59,
                                                                                                            --[ End_of_format ]--0
                                                                                                          ])
                                                                                                      ])
                                                                                                  ])
                                                                                              ])
                                                                                          ]),
                                                                                        "v.%s <- %s;"
                                                                                      ]), rf_label$5, vc_constructor));
                                                                  end
                                                                end));
                                                  end), param$5.v_constructors);
                                  
                                end
                              end), r_fields);
                        return line$1(sc, "| Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()");
                      end));
                line$1(sc, "in");
                line$1(sc, "loop ();");
                line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "let v:",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " = Obj.magic v in",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "let v:%s = Obj.magic v in"
                            ]), r_name));
                return line$1(sc, "v");
              end));
end

function gen_decode_variant(and_, param, sc) do
  var v_constructors = param.v_constructors;
  var v_name = param.v_name;
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " decode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " d = ",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s decode_%s d = "
              ]), let_decl_of_and(and_), v_name));
  return scope(sc, (function (sc) do
                line$1(sc, Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "let rec loop () = ",
                              --[ End_of_format ]--0
                            ]),
                          "let rec loop () = "
                        ]));
                scope(sc, (function (sc) do
                        line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                      --[ String_literal ]--Block.__(11, [
                                          "let ret:",
                                          --[ String ]--Block.__(2, [
                                              --[ No_padding ]--0,
                                              --[ String_literal ]--Block.__(11, [
                                                  " = match Pbrt.Decoder.key d with",
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ]),
                                      "let ret:%s = match Pbrt.Decoder.key d with"
                                    ]), v_name));
                        scope(sc, (function (sc) do
                                line$1(sc, "| None -> failwith \"None of the known key is found\"");
                                List.iter((function (ctor) do
                                        var sc$1 = sc;
                                        var param = ctor;
                                        var vc_encoding_number = param.vc_encoding_number;
                                        var vc_field_type = param.vc_field_type;
                                        var vc_constructor = param.vc_constructor;
                                        if (vc_field_type) do
                                          return line$1(sc$1, Curry._3(Printf.sprintf(--[ Format ]--[
                                                              --[ String_literal ]--Block.__(11, [
                                                                  "| Some (",
                                                                  --[ Int ]--Block.__(4, [
                                                                      --[ Int_i ]--3,
                                                                      --[ No_padding ]--0,
                                                                      --[ No_precision ]--0,
                                                                      --[ String_literal ]--Block.__(11, [
                                                                          ", _) -> ",
                                                                          --[ String ]--Block.__(2, [
                                                                              --[ No_padding ]--0,
                                                                              --[ String_literal ]--Block.__(11, [
                                                                                  " (",
                                                                                  --[ String ]--Block.__(2, [
                                                                                      --[ No_padding ]--0,
                                                                                      --[ Char_literal ]--Block.__(12, [
                                                                                          --[ ")" ]--41,
                                                                                          --[ End_of_format ]--0
                                                                                        ])
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ]),
                                                              "| Some (%i, _) -> %s (%s)"
                                                            ]), vc_encoding_number, vc_constructor, decode_field_f(vc_field_type[0], param.vc_payload_kind)));
                                        end else do
                                          return line$1(sc$1, Curry._2(Printf.sprintf(--[ Format ]--[
                                                              --[ String_literal ]--Block.__(11, [
                                                                  "| Some (",
                                                                  --[ Int ]--Block.__(4, [
                                                                      --[ Int_i ]--3,
                                                                      --[ No_padding ]--0,
                                                                      --[ No_precision ]--0,
                                                                      --[ String_literal ]--Block.__(11, [
                                                                          ", _) -> (Pbrt.Decoder.empty_nested d ; ",
                                                                          --[ String ]--Block.__(2, [
                                                                              --[ No_padding ]--0,
                                                                              --[ Char_literal ]--Block.__(12, [
                                                                                  --[ ")" ]--41,
                                                                                  --[ End_of_format ]--0
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ]),
                                                              "| Some (%i, _) -> (Pbrt.Decoder.empty_nested d ; %s)"
                                                            ]), vc_encoding_number, vc_constructor));
                                        end
                                      end), v_constructors);
                                line$1(sc, "| Some (n, payload_kind) -> (");
                                line$1(sc, "  Pbrt.Decoder.skip d payload_kind; ");
                                line$1(sc, "  loop () ");
                                return line$1(sc, ")");
                              end));
                        line$1(sc, "in");
                        return line$1(sc, "ret");
                      end));
                line$1(sc, "in");
                return line$1(sc, "loop ()");
              end));
end

function gen_decode_const_variant(and_, param, sc) do
  var cv_constructors = param.cv_constructors;
  var cv_name = param.cv_name;
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " decode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " d = ",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s decode_%s d = "
              ]), let_decl_of_and(and_), cv_name));
  return scope(sc, (function (sc) do
                line$1(sc, "match Pbrt.Decoder.int_as_varint d with");
                List.iter((function (param) do
                        return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                            --[ String_literal ]--Block.__(11, [
                                                "| ",
                                                --[ Int ]--Block.__(4, [
                                                    --[ Int_i ]--3,
                                                    --[ No_padding ]--0,
                                                    --[ No_precision ]--0,
                                                    --[ String_literal ]--Block.__(11, [
                                                        " -> (",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ Char_literal ]--Block.__(12, [
                                                                --[ ":" ]--58,
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ Char_literal ]--Block.__(12, [
                                                                        --[ ")" ]--41,
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ])
                                                  ])
                                              ]),
                                            "| %i -> (%s:%s)"
                                          ]), param[1], param[0], cv_name));
                      end), cv_constructors);
                return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                    --[ String_literal ]--Block.__(11, [
                                        "| _ -> failwith \"Unknown value for enum ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ Char_literal ]--Block.__(12, [
                                                --[ "\"" ]--34,
                                                --[ End_of_format ]--0
                                              ])
                                          ])
                                      ]),
                                    "| _ -> failwith \"Unknown value for enum %s\""
                                  ]), cv_name));
              end));
end

function gen_struct(and_, t, sc) do
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        tmp = --[ tuple ]--[
          gen_decode_record(and_, match[0], sc),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          gen_decode_variant(and_, match[0], sc),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          gen_decode_const_variant(and_, match[0], sc),
          true
        ];
        break;
    
  end
  return tmp[1];
end

function gen_sig(and_, t, sc) do
  var f = function (type_name) do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "val decode_",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " : Pbrt.Decoder.t -> ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  "val decode_%s : Pbrt.Decoder.t -> %s"
                ]), type_name, type_name));
    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "(** [decode_",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    " decoder] decodes a [",
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ String_literal ]--Block.__(11, [
                                            "] value from [decoder] *)",
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ])
                              ])
                          ]),
                        "(** [decode_%s decoder] decodes a [%s] value from [decoder] *)"
                      ]), type_name, type_name));
  end;
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        tmp = --[ tuple ]--[
          f(match[0].r_name),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          f(match[0].v_name),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          f(match[0].cv_name),
          true
        ];
        break;
    
  end
  return tmp[1];
end

var Codegen_decode = do
  gen_sig: gen_sig,
  gen_struct: gen_struct,
  ocamldoc_title: "Protobuf Decoding"
end;

var __log__ = do
  contents: undefined
end;

function log(x) do
  var match = __log__.contents;
  if (match ~= undefined) do
    return Printf.fprintf(Caml_option.valFromOption(match), x);
  end else do
    return Printf.ifprintf(Pervasives.stdout, x);
  end
end

function endline(s) do
  return Curry._1(log(--[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\n" ]--10,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "%s\n"
                ]), s);
end

function gen_pp_field(field_type) do
  if (typeof field_type ~= "number" and field_type.tag) do
    return function_name_of_user_defined("pp", field_type[0]);
  end
  return Curry._1(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "Pbrt.Pp.pp_",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ End_of_format ]--0
                        ])
                    ]),
                  "Pbrt.Pp.pp_%s"
                ]), string_of_field_type(field_type));
end

function gen_pp_record(and_, param, sc) do
  var r_fields = param.r_fields;
  var r_name = param.r_name;
  Curry._1(log(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "gen_pp, record_name: ",
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ "\n" ]--10,
                        --[ End_of_format ]--0
                      ])
                  ])
              ]),
            "gen_pp, record_name: %s\n"
          ]), r_name);
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " pp_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " fmt (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") = ",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s pp_%s fmt (v:%s) = "
              ]), let_decl_of_and(and_), r_name, r_name));
  return scope(sc, (function (sc) do
                line$1(sc, "let pp_i fmt () =");
                scope(sc, (function (sc) do
                        line$1(sc, "Format.pp_open_vbox fmt 1;");
                        List.iter((function (record_field) do
                                var rf_field_type = record_field.rf_field_type;
                                var rf_label = record_field.rf_label;
                                var var_name = Curry._1(Printf.sprintf(--[ Format ]--[
                                          --[ String_literal ]--Block.__(11, [
                                              "v.",
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ End_of_format ]--0
                                                ])
                                            ]),
                                          "v.%s"
                                        ]), rf_label);
                                switch (rf_field_type.tag | 0) do
                                  case --[ Rft_required ]--0 :
                                      var field_string_of = gen_pp_field(rf_field_type[0][0]);
                                      return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                          --[ String_literal ]--Block.__(11, [
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[ String ]--Block.__(2, [
                                                                  --[ No_padding ]--0,
                                                                  --[ String_literal ]--Block.__(11, [
                                                                      "\" ",
                                                                      --[ String ]--Block.__(2, [
                                                                          --[ No_padding ]--0,
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              " fmt ",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                      --[ ";" ]--59,
                                                                                      --[ End_of_format ]--0
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ])
                                                            ]),
                                                          "Pbrt.Pp.pp_record_field \"%s\" %s fmt %s;"
                                                        ]), rf_label, field_string_of, var_name));
                                  case --[ Rft_optional ]--1 :
                                      var field_string_of$1 = gen_pp_field(rf_field_type[0][0]);
                                      return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                          --[ String_literal ]--Block.__(11, [
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[ String ]--Block.__(2, [
                                                                  --[ No_padding ]--0,
                                                                  --[ String_literal ]--Block.__(11, [
                                                                      "\" (Pbrt.Pp.pp_option ",
                                                                      --[ String ]--Block.__(2, [
                                                                          --[ No_padding ]--0,
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              ") fmt ",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                      --[ ";" ]--59,
                                                                                      --[ End_of_format ]--0
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ])
                                                            ]),
                                                          "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_option %s) fmt %s;"
                                                        ]), rf_label, field_string_of$1, var_name));
                                  case --[ Rft_repeated_field ]--2 :
                                      var match = rf_field_type[0];
                                      var field_string_of$2 = gen_pp_field(match[1]);
                                      if (match[0]) do
                                        return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                            --[ String_literal ]--Block.__(11, [
                                                                "Pbrt.Pp.pp_record_field \"",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "\" (Pbrt.Pp.pp_list ",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                ") fmt (Pbrt.Repeated_field.to_list ",
                                                                                --[ String ]--Block.__(2, [
                                                                                    --[ No_padding ]--0,
                                                                                    --[ String_literal ]--Block.__(11, [
                                                                                        ");",
                                                                                        --[ End_of_format ]--0
                                                                                      ])
                                                                                  ])
                                                                              ])
                                                                          ])
                                                                      ])
                                                                  ])
                                                              ]),
                                                            "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_list %s) fmt (Pbrt.Repeated_field.to_list %s);"
                                                          ]), rf_label, field_string_of$2, var_name));
                                      end else do
                                        return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                            --[ String_literal ]--Block.__(11, [
                                                                "Pbrt.Pp.pp_record_field \"",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "\" (Pbrt.Pp.pp_list ",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                ") fmt ",
                                                                                --[ String ]--Block.__(2, [
                                                                                    --[ No_padding ]--0,
                                                                                    --[ Char_literal ]--Block.__(12, [
                                                                                        --[ ";" ]--59,
                                                                                        --[ End_of_format ]--0
                                                                                      ])
                                                                                  ])
                                                                              ])
                                                                          ])
                                                                      ])
                                                                  ])
                                                              ]),
                                                            "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_list %s) fmt %s;"
                                                          ]), rf_label, field_string_of$2, var_name));
                                      end
                                  case --[ Rft_associative_field ]--3 :
                                      var match$1 = rf_field_type[0];
                                      var pp_runtime_function = match$1[0] ? "pp_hastable" : "pp_associative_list";
                                      var pp_key = gen_pp_field(--[ Ft_basic_type ]--Block.__(0, [match$1[2][0]]));
                                      var pp_value = gen_pp_field(match$1[3][0]);
                                      return line$1(sc, Curry._5(Printf.sprintf(--[ Format ]--[
                                                          --[ String_literal ]--Block.__(11, [
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[ String ]--Block.__(2, [
                                                                  --[ No_padding ]--0,
                                                                  --[ String_literal ]--Block.__(11, [
                                                                      "\" (Pbrt.Pp.",
                                                                      --[ String ]--Block.__(2, [
                                                                          --[ No_padding ]--0,
                                                                          --[ Char_literal ]--Block.__(12, [
                                                                              --[ " " ]--32,
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                      --[ " " ]--32,
                                                                                      --[ String ]--Block.__(2, [
                                                                                          --[ No_padding ]--0,
                                                                                          --[ String_literal ]--Block.__(11, [
                                                                                              ") fmt ",
                                                                                              --[ String ]--Block.__(2, [
                                                                                                  --[ No_padding ]--0,
                                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                                      --[ ";" ]--59,
                                                                                                      --[ End_of_format ]--0
                                                                                                    ])
                                                                                                ])
                                                                                            ])
                                                                                        ])
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ])
                                                            ]),
                                                          "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.%s %s %s) fmt %s;"
                                                        ]), rf_label, pp_runtime_function, pp_key, pp_value, var_name));
                                  case --[ Rft_variant_field ]--4 :
                                      return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                          --[ String_literal ]--Block.__(11, [
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[ String ]--Block.__(2, [
                                                                  --[ No_padding ]--0,
                                                                  --[ String_literal ]--Block.__(11, [
                                                                      "\" ",
                                                                      --[ String ]--Block.__(2, [
                                                                          --[ No_padding ]--0,
                                                                          --[ String_literal ]--Block.__(11, [
                                                                              " fmt ",
                                                                              --[ String ]--Block.__(2, [
                                                                                  --[ No_padding ]--0,
                                                                                  --[ Char_literal ]--Block.__(12, [
                                                                                      --[ ";" ]--59,
                                                                                      --[ End_of_format ]--0
                                                                                    ])
                                                                                ])
                                                                            ])
                                                                        ])
                                                                    ])
                                                                ])
                                                            ]),
                                                          "Pbrt.Pp.pp_record_field \"%s\" %s fmt %s;"
                                                        ]), rf_label, "pp_" .. rf_field_type[0].v_name, var_name));
                                  
                                end
                              end), r_fields);
                        return line$1(sc, "Format.pp_close_box fmt ()");
                      end));
                line$1(sc, "in");
                return line$1(sc, "Pbrt.Pp.pp_brk pp_i fmt ()");
              end));
end

function gen_pp_variant(and_, param, sc) do
  var v_constructors = param.v_constructors;
  var v_name = param.v_name;
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " pp_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " fmt (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") =",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s pp_%s fmt (v:%s) ="
              ]), let_decl_of_and(and_), v_name, v_name));
  return scope(sc, (function (sc) do
                line$1(sc, "match v with");
                return List.iter((function (param) do
                              var vc_field_type = param.vc_field_type;
                              var vc_constructor = param.vc_constructor;
                              if (vc_field_type) do
                                var field_string_of = gen_pp_field(vc_field_type[0]);
                                return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " x -> Format.fprintf fmt \"",
                                                                --[ Formatting_gen ]--Block.__(18, [
                                                                    --[ Open_box ]--Block.__(1, [--[ Format ]--[
                                                                          --[ End_of_format ]--0,
                                                                          ""
                                                                        ]]),
                                                                    --[ String ]--Block.__(2, [
                                                                        --[ No_padding ]--0,
                                                                        --[ Char_literal ]--Block.__(12, [
                                                                            --[ "(" ]--40,
                                                                            --[ Char_literal ]--Block.__(12, [
                                                                                --[ "%" ]--37,
                                                                                --[ String_literal ]--Block.__(11, [
                                                                                    "a)",
                                                                                    --[ Formatting_lit ]--Block.__(17, [
                                                                                        --[ Close_box ]--0,
                                                                                        --[ String_literal ]--Block.__(11, [
                                                                                            "\" ",
                                                                                            --[ String ]--Block.__(2, [
                                                                                                --[ No_padding ]--0,
                                                                                                --[ String_literal ]--Block.__(11, [
                                                                                                    " x",
                                                                                                    --[ End_of_format ]--0
                                                                                                  ])
                                                                                              ])
                                                                                          ])
                                                                                      ])
                                                                                  ])
                                                                              ])
                                                                          ])
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "| %s x -> Format.fprintf fmt \"@[%s(%%a)@]\" %s x"
                                                  ]), vc_constructor, vc_constructor, field_string_of));
                              end else do
                                return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                "  -> Format.fprintf fmt \"",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ Char_literal ]--Block.__(12, [
                                                                        --[ "\"" ]--34,
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "| %s  -> Format.fprintf fmt \"%s\""
                                                  ]), vc_constructor, vc_constructor));
                              end
                            end), v_constructors);
              end));
end

function gen_pp_const_variant(and_, param, sc) do
  var cv_constructors = param.cv_constructors;
  var cv_name = param.cv_name;
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " pp_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " fmt (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") =",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s pp_%s fmt (v:%s) ="
              ]), let_decl_of_and(and_), cv_name, cv_name));
  return scope(sc, (function (sc) do
                line$1(sc, "match v with");
                return List.iter((function (param) do
                              var name = param[0];
                              return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                  --[ String_literal ]--Block.__(11, [
                                                      "| ",
                                                      --[ String ]--Block.__(2, [
                                                          --[ No_padding ]--0,
                                                          --[ String_literal ]--Block.__(11, [
                                                              " -> Format.fprintf fmt \"",
                                                              --[ String ]--Block.__(2, [
                                                                  --[ No_padding ]--0,
                                                                  --[ Char_literal ]--Block.__(12, [
                                                                      --[ "\"" ]--34,
                                                                      --[ End_of_format ]--0
                                                                    ])
                                                                ])
                                                            ])
                                                        ])
                                                    ]),
                                                  "| %s -> Format.fprintf fmt \"%s\""
                                                ]), name, name));
                            end), cv_constructors);
              end));
end

function gen_struct$1(and_, t, sc) do
  var match = t.spec;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        gen_pp_record(and_, match[0], sc);
        break;
    case --[ Variant ]--1 :
        gen_pp_variant(and_, match[0], sc);
        break;
    case --[ Const_variant ]--2 :
        gen_pp_const_variant(and_, match[0], sc);
        break;
    
  end
  return true;
end

function gen_sig$1(and_, t, sc) do
  var f = function (type_name) do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "val pp_",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " : Format.formatter -> ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " -> unit ",
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "val pp_%s : Format.formatter -> %s -> unit "
                ]), type_name, type_name));
    return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "(** [pp_",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    " v] formats v] *)",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ]),
                        "(** [pp_%s v] formats v] *)"
                      ]), type_name));
  end;
  var match = t.spec;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        f(match[0].r_name);
        break;
    case --[ Variant ]--1 :
        f(match[0].v_name);
        break;
    case --[ Const_variant ]--2 :
        f(match[0].cv_name);
        break;
    
  end
  return true;
end

var Codegen_pp = do
  gen_sig: gen_sig$1,
  gen_struct: gen_struct$1,
  ocamldoc_title: "Formatters"
end;

function height(param) do
  if (param) do
    return param[--[ h ]--4];
  end else do
    return 0;
  end
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l ? l[--[ h ]--4] : 0;
  var hr = r ? r[--[ h ]--4] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) do
        return create(create(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) do
        return create(create(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add(x, data, m) do
  if (m) do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_obj.caml_compare(x, v);
    if (c == 0) do
      if (d == data) do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end
    end else if (c < 0) do
      var ll = add(x, data, l);
      if (l == ll) do
        return m;
      end else do
        return bal(ll, v, d, r);
      end
    end else do
      var rr = add(x, data, r);
      if (r == rr) do
        return m;
      end else do
        return bal(l, v, d, rr);
      end
    end
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = Caml_obj.caml_compare(x, param[--[ v ]--1]);
      if (c == 0) do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--3];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function map$1(f, param) do
  if (param) do
    var l$prime = map$1(f, param[--[ l ]--0]);
    var d$prime = Curry._1(f, param[--[ d ]--2]);
    var r$prime = map$1(f, param[--[ r ]--3]);
    return --[ Node ]--[
            --[ l ]--l$prime,
            --[ v ]--param[--[ v ]--1],
            --[ d ]--d$prime,
            --[ r ]--r$prime,
            --[ h ]--param[--[ h ]--4]
          ];
  end else do
    return --[ Empty ]--0;
  end
end

function fold(f, _m, _accu) do
  while(true) do
    var accu = _accu;
    var m = _m;
    if (m) do
      _accu = Curry._3(f, m[--[ v ]--1], m[--[ d ]--2], fold(f, m[--[ l ]--0], accu));
      _m = m[--[ r ]--3];
      continue ;
    end else do
      return accu;
    end
  end;
end

function min_value(param) do
  var match = param[0];
  if (match ~= undefined) do
    var match$1 = param[1];
    if (match$1 ~= undefined) do
      return Caml_option.some(Caml_obj.caml_min(Caml_option.valFromOption(match), Caml_option.valFromOption(match$1)));
    end else do
      throw [
            Caml_builtin_exceptions.failure,
            "min_value error"
          ];
    end
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "min_value error"
        ];
  end
end

function eq_value(param) do
  var match = param[0];
  if (match ~= undefined) do
    var match$1 = param[1];
    if (match$1 ~= undefined) do
      return Caml_obj.caml_equal(Caml_option.valFromOption(match), Caml_option.valFromOption(match$1));
    end else do
      throw [
            Caml_builtin_exceptions.failure,
            "eq_value error"
          ];
    end
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "eq_value error"
        ];
  end
end

function string_of_option(f, param) do
  if (param ~= undefined) do
    return Curry._1(Printf.sprintf(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "Some(",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ ")" ]--41,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "Some(%s)"
                  ]), Curry._1(f, Caml_option.valFromOption(param)));
  end else do
    return "None";
  end
end

function reset(g) do
  return map$1((function (core) do
                return do
                        core: core,
                        index: undefined,
                        lowlink: undefined,
                        on_stack: false
                      end;
              end), g);
end

function strong_connect(g, sccs, stack, index, v) do
  Curry._2(log(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[Graph] processing v [",
                --[ Int ]--Block.__(4, [
                    --[ Int_i ]--3,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ String_literal ]--Block.__(11, [
                        "], index: ",
                        --[ Int ]--Block.__(4, [
                            --[ Int_i ]--3,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ "\n" ]--10,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ])
              ]),
            "[Graph] processing v [%i], index: %i\n"
          ]), v.core.id, index);
  v.index = index;
  v.lowlink = index;
  var stack$1 = --[ :: ]--[
    v,
    stack
  ];
  v.on_stack = true;
  var match = List.fold_left((function (param, id) do
          var index = param[2];
          var stack = param[1];
          var sccs = param[0];
          var w = find(id, g);
          Curry._2(log(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "[Graph] sub w [",
                        --[ Int ]--Block.__(4, [
                            --[ Int_i ]--3,
                            --[ No_padding ]--0,
                            --[ No_precision ]--0,
                            --[ String_literal ]--Block.__(11, [
                                "], w.index: ",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ Char_literal ]--Block.__(12, [
                                        --[ "\n" ]--10,
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "[Graph] sub w [%i], w.index: %s\n"
                  ]), w.core.id, string_of_option((function (prim) do
                      return String(prim);
                    end), w.index));
          var match = w.index;
          if (match ~= undefined) do
            if (w.on_stack) do
              v.lowlink = min_value(--[ tuple ]--[
                    v.lowlink,
                    w.index
                  ]);
            end
            return --[ tuple ]--[
                    sccs,
                    stack,
                    index
                  ];
          end else do
            var match$1 = strong_connect(g, sccs, stack, index + 1 | 0, w);
            v.lowlink = min_value(--[ tuple ]--[
                  v.lowlink,
                  w.lowlink
                ]);
            return --[ tuple ]--[
                    match$1[0],
                    match$1[1],
                    match$1[2]
                  ];
          end
        end), --[ tuple ]--[
        sccs,
        stack$1,
        index
      ], v.core.sub);
  var index$1 = match[2];
  var stack$2 = match[1];
  var sccs$1 = match[0];
  Curry._3(log(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[Graph] after sub for v [",
                --[ Int ]--Block.__(4, [
                    --[ Int_i ]--3,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ String_literal ]--Block.__(11, [
                        "], lowlink: ",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ", index: ",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ Char_literal ]--Block.__(12, [
                                        --[ "\n" ]--10,
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ])
              ]),
            "[Graph] after sub for v [%i], lowlink: %s, index: %s\n"
          ]), v.core.id, string_of_option((function (prim) do
              return String(prim);
            end), v.lowlink), string_of_option((function (prim) do
              return String(prim);
            end), v.index));
  Curry._1(log(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "[Graph]   -> stack : ",
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ "\n" ]--10,
                        --[ End_of_format ]--0
                      ])
                  ])
              ]),
            "[Graph]   -> stack : %s\n"
          ]), "[" .. ($$String.concat(";", List.map((function (param) do
                    return String(param.core.id);
                  end), stack$2)) .. "]"));
  if (eq_value(--[ tuple ]--[
          v.lowlink,
          v.index
        ])) do
    var match$1 = List.fold_left((function (param, n) do
            var splitted = param[2];
            var stack = param[1];
            var scc = param[0];
            if (splitted) do
              return --[ tuple ]--[
                      scc,
                      --[ :: ]--[
                        n,
                        stack
                      ],
                      splitted
                    ];
            end else do
              n.on_stack = false;
              if (n.core.id == v.core.id) do
                return --[ tuple ]--[
                        --[ :: ]--[
                          n.core.id,
                          scc
                        ],
                        stack,
                        true
                      ];
              end else do
                return --[ tuple ]--[
                        --[ :: ]--[
                          n.core.id,
                          scc
                        ],
                        stack,
                        false
                      ];
              end
            end
          end), --[ tuple ]--[
          --[ [] ]--0,
          --[ [] ]--0,
          false
        ], stack$2);
    return --[ tuple ]--[
            --[ :: ]--[
              match$1[0],
              sccs$1
            ],
            List.rev(match$1[1]),
            index$1
          ];
  end else do
    return --[ tuple ]--[
            sccs$1,
            stack$2,
            index$1
          ];
  end
end

function tarjan(g) do
  var g$1 = reset(g);
  return fold((function (param, n, param$1) do
                  var index = param$1[2];
                  var stack = param$1[1];
                  var sccs = param$1[0];
                  var match = n.index;
                  if (match ~= undefined) do
                    return --[ tuple ]--[
                            sccs,
                            stack,
                            index
                          ];
                  end else do
                    return strong_connect(g$1, sccs, stack, index, n);
                  end
                end), g$1, --[ tuple ]--[
                --[ [] ]--0,
                --[ [] ]--0,
                0
              ])[0];
end

function field_name(param) do
  return param.field_parsed.field_name;
end

function field_number(param) do
  return param.field_parsed.field_number;
end

function field_type(param) do
  return param.field_type;
end

function field_label(param) do
  return param.field_parsed.field_label;
end

function field_default(param) do
  return param.field_default;
end

function field_options(param) do
  return param.field_options;
end

function find_field_option(field_options, option_name) do
  var x;
  try do
    x = List.assoc(option_name, field_options);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return ;
    end else do
      throw exn;
    end
  end
  return Caml_option.some(x);
end

function field_option(param, option_name) do
  return find_field_option(param.field_options, option_name);
end

function type_id_of_type(param) do
  return param.id;
end

function type_of_id(all_types, id) do
  return List.find((function (t) do
                return type_id_of_type(t) == id;
              end), all_types);
end

function string_of_unresolved(param) do
  return Curry._3(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "unresolved:{scope ",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ", type_name: ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ", from_root: ",
                                      --[ Bool ]--Block.__(9, [
                                          --[ No_padding ]--0,
                                          --[ Char_literal ]--Block.__(12, [
                                              --[ "}" ]--125,
                                              --[ End_of_format ]--0
                                            ])
                                        ])
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "unresolved:{scope %s, type_name: %s, from_root: %b}"
                ]), string_of_string_list(param.scope), param.type_name, param.from_root);
end

function scope_of_package(param) do
  if (param ~= undefined) do
    return do
            packages: List.rev(rev_split_by_char(--[ "." ]--46, param)),
            message_names: --[ [] ]--0
          end;
  end else do
    return do
            packages: --[ [] ]--0,
            message_names: --[ [] ]--0
          end;
  end
end

function unresolved_of_string(s) do
  var match = rev_split_by_char(--[ "." ]--46, s);
  if (match) do
    return do
            scope: List.rev(match[1]),
            type_name: match[0],
            from_root: Caml_string.get(s, 0) == --[ "." ]--46
          end;
  end else do
    throw [
          Compilation_error,
          --[ Programatic_error ]--Block.__(4, [--[ Invalid_string_split ]--0])
        ];
  end
end

function field_type_of_string(s) do
  switch (s) do
    case "bool" :
        return --[ Field_type_bool ]--12;
    case "bytes" :
        return --[ Field_type_bytes ]--14;
    case "double" :
        return --[ Field_type_double ]--0;
    case "fixed32" :
        return --[ Field_type_fixed32 ]--8;
    case "fixed64" :
        return --[ Field_type_fixed64 ]--9;
    case "float" :
        return --[ Field_type_float ]--1;
    case "int32" :
        return --[ Field_type_int32 ]--2;
    case "int64" :
        return --[ Field_type_int64 ]--3;
    case "sfixed32" :
        return --[ Field_type_sfixed32 ]--10;
    case "sfixed64" :
        return --[ Field_type_sfixed64 ]--11;
    case "sint32" :
        return --[ Field_type_sint32 ]--6;
    case "sint64" :
        return --[ Field_type_sint64 ]--7;
    case "string" :
        return --[ Field_type_string ]--13;
    case "uint32" :
        return --[ Field_type_uint32 ]--4;
    case "uint64" :
        return --[ Field_type_uint64 ]--5;
    default:
      return --[ Field_type_type ]--[unresolved_of_string(s)];
  end
end

function compile_default_p2(all_types, field) do
  var field_name$1 = field_name(field);
  var field_type$1 = field_type(field);
  var field_default$1 = field_default(field);
  if (field_default$1 ~= undefined) do
    var constant = field_default$1;
    var exit = 0;
    if (typeof field_type$1 == "number") do
      switch (field_type$1) do
        case --[ Field_type_double ]--0 :
        case --[ Field_type_float ]--1 :
            exit = 1;
            break;
        case --[ Field_type_uint32 ]--4 :
        case --[ Field_type_uint64 ]--5 :
            exit = 3;
            break;
        case --[ Field_type_int32 ]--2 :
        case --[ Field_type_int64 ]--3 :
        case --[ Field_type_sint32 ]--6 :
        case --[ Field_type_sint64 ]--7 :
        case --[ Field_type_fixed32 ]--8 :
        case --[ Field_type_fixed64 ]--9 :
        case --[ Field_type_sfixed32 ]--10 :
        case --[ Field_type_sfixed64 ]--11 :
            exit = 2;
            break;
        case --[ Field_type_bool ]--12 :
            if (constant.tag == --[ Constant_bool ]--1) do
              return constant;
            end else do
              return invalid_default_value(field_name$1, "invalid default type (bool expected)", --[ () ]--0);
            end
        case --[ Field_type_string ]--13 :
            if (constant.tag) do
              return invalid_default_value(field_name$1, "invalid default type (string expected)", --[ () ]--0);
            end else do
              return constant;
            end
        case --[ Field_type_bytes ]--14 :
            return invalid_default_value(field_name$1, "default value not supported for bytes", --[ () ]--0);
        
      end
    end else if (constant.tag == --[ Constant_litteral ]--4) do
      var default_enum_value = constant[0];
      var match = type_of_id(all_types, field_type$1[0]);
      var spec = match.spec;
      if (spec.tag) do
        return invalid_default_value(field_name$1, "field of type message cannot have a default litteral value", --[ () ]--0);
      end else do
        var default_enum_value$1 = apply_until((function (param) do
                var enum_value_name = param.enum_value_name;
                if (enum_value_name == default_enum_value) do
                  return enum_value_name;
                end
                
              end), spec[0].enum_values);
        if (default_enum_value$1 ~= undefined) do
          return constant;
        end else do
          return invalid_default_value(field_name$1, "Invalid default enum value", --[ () ]--0);
        end
      end
    end else do
      return invalid_default_value(field_name$1, "default value not supported for message", --[ () ]--0);
    end
    switch (exit) do
      case 1 :
          switch (constant.tag | 0) do
            case --[ Constant_int ]--2 :
                return --[ Constant_float ]--Block.__(3, [constant[0]]);
            case --[ Constant_float ]--3 :
                return constant;
            default:
              return invalid_default_value(field_name$1, "invalid default type (float/int expected)", --[ () ]--0);
          end
      case 2 :
          if (constant.tag == --[ Constant_int ]--2) do
            return constant;
          end else do
            return invalid_default_value(field_name$1, "invalid default type (int expected)", --[ () ]--0);
          end
      case 3 :
          if (constant.tag == --[ Constant_int ]--2) do
            if (constant[0] >= 0) do
              return constant;
            end else do
              return invalid_default_value(field_name$1, "negative default value for unsigned int", --[ () ]--0);
            end
          end else do
            return invalid_default_value(field_name$1, "invalid default type (int expected)", --[ () ]--0);
          end
      
    end
  end
  
end

function get_default(field_name, field_options, field_type) do
  var constant;
  try do
    constant = List.assoc("default", field_options);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return ;
    end else do
      throw exn;
    end
  end
  return Caml_option.some(constant);
end

function compile_field_p1(field_parsed) do
  var field_options = field_parsed.field_options;
  var field_type = field_type_of_string(field_parsed.field_type);
  var field_default = get_default(field_parsed.field_name, field_options, field_type);
  return do
          field_parsed: field_parsed,
          field_type: field_type,
          field_default: field_default,
          field_options: field_options
        end;
end

function compile_map_p1(param) do
  return do
          map_name: param.map_name,
          map_number: param.map_number,
          map_key_type: field_type_of_string(param.map_key_type),
          map_value_type: field_type_of_string(param.map_value_type),
          map_options: param.map_options
        end;
end

function compile_oneof_p1(param) do
  return do
          oneof_name: param.oneof_name,
          oneof_fields: List.map(compile_field_p1, param.oneof_fields)
        end;
end

function not_found(f) do
  try do
    Curry._1(f, --[ () ]--0);
    return false;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return true;
    end else do
      throw exn;
    end
  end
end

function list_assoc2(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var match = param[0];
      if (Caml_obj.caml_equal(match[1], x)) do
        return match[0];
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function type_of_spec(file_name, file_options, id, scope, spec) do
  return do
          scope: scope,
          id: id,
          file_name: file_name,
          file_options: file_options,
          spec: spec
        end;
end

function compile_enum_p1(file_name, file_options, scope, param) do
  var enum_values = List.map((function (enum_value) do
          return do
                  enum_value_name: enum_value.enum_value_name,
                  enum_value_int: enum_value.enum_value_int
                end;
        end), param.enum_values);
  return type_of_spec(file_name, file_options, param.enum_id, scope, --[ Enum ]--Block.__(0, [do
                  enum_name: param.enum_name,
                  enum_values: enum_values
                end]));
end

function compile_message_p1(file_name, file_options, message_scope, param) do
  var message_name = param.message_name;
  var sub_scope_packages = message_scope.packages;
  var sub_scope_message_names = Pervasives.$at(message_scope.message_names, --[ :: ]--[
        message_name,
        --[ [] ]--0
      ]);
  var sub_scope = do
    packages: sub_scope_packages,
    message_names: sub_scope_message_names
  end;
  var match = List.fold_left((function (param, param$1) do
          var all_types = param[2];
          var extensions = param[1];
          var message_body = param[0];
          switch (param$1.tag | 0) do
            case --[ Message_field ]--0 :
                var field = --[ Message_field ]--Block.__(0, [compile_field_p1(param$1[0])]);
                return --[ tuple ]--[
                        --[ :: ]--[
                          field,
                          message_body
                        ],
                        extensions,
                        all_types
                      ];
            case --[ Message_map_field ]--1 :
                var field$1 = --[ Message_map_field ]--Block.__(2, [compile_map_p1(param$1[0])]);
                return --[ tuple ]--[
                        --[ :: ]--[
                          field$1,
                          message_body
                        ],
                        extensions,
                        all_types
                      ];
            case --[ Message_oneof_field ]--2 :
                var field$2 = --[ Message_oneof_field ]--Block.__(1, [compile_oneof_p1(param$1[0])]);
                return --[ tuple ]--[
                        --[ :: ]--[
                          field$2,
                          message_body
                        ],
                        extensions,
                        all_types
                      ];
            case --[ Message_sub ]--3 :
                var all_sub_types = compile_message_p1(file_name, file_options, sub_scope, param$1[0]);
                return --[ tuple ]--[
                        message_body,
                        extensions,
                        Pervasives.$at(all_types, all_sub_types)
                      ];
            case --[ Message_enum ]--4 :
                return --[ tuple ]--[
                        message_body,
                        extensions,
                        Pervasives.$at(all_types, --[ :: ]--[
                              compile_enum_p1(file_name, file_options, sub_scope, param$1[0]),
                              --[ [] ]--0
                            ])
                      ];
            case --[ Message_extension ]--5 :
                return --[ tuple ]--[
                        message_body,
                        Pervasives.$at(extensions, param$1[0]),
                        all_types
                      ];
            
          end
        end), --[ tuple ]--[
        --[ [] ]--0,
        --[ [] ]--0,
        --[ [] ]--0
      ], param.message_body);
  var message_body = List.rev(match[0]);
  var validate_duplicate = function (number_index, field) do
    var number = field_number(field);
    var name = field_name(field);
    if (not_found((function (param) do
              List.assoc(number, number_index);
              return --[ () ]--0;
            end)) and not_found((function (param) do
              list_assoc2(name, number_index);
              return --[ () ]--0;
            end))) do
      return --[ :: ]--[
              --[ tuple ]--[
                number,
                name
              ],
              number_index
            ];
    end else do
      var field_name$1 = name;
      var previous_field_name = "";
      var message_name$1 = message_name;
      throw [
            Compilation_error,
            --[ Duplicated_field_number ]--Block.__(1, [do
                  field_name: field_name$1,
                  previous_field_name: previous_field_name,
                  message_name: message_name$1
                end])
          ];
    end
  end;
  List.fold_left((function (number_index, param) do
          switch (param.tag | 0) do
            case --[ Message_field ]--0 :
                return validate_duplicate(number_index, param[0]);
            case --[ Message_oneof_field ]--1 :
                return List.fold_left(validate_duplicate, number_index, param[0].oneof_fields);
            case --[ Message_map_field ]--2 :
                return number_index;
            
          end
        end), --[ [] ]--0, message_body);
  return Pervasives.$at(match[2], --[ :: ]--[
              type_of_spec(file_name, file_options, param.id, message_scope, --[ Message ]--Block.__(1, [do
                        extensions: match[1],
                        message_name: message_name,
                        message_body: message_body
                      end])),
              --[ [] ]--0
            ]);
end

function compile_proto_p1(file_name, param) do
  var file_options = param.file_options;
  var scope = scope_of_package(param.package);
  var pbtt_msgs = List.fold_right((function (e, pbtt_msgs) do
          return --[ :: ]--[
                  compile_enum_p1(file_name, file_options, scope, e),
                  pbtt_msgs
                ];
        end), param.enums, --[ [] ]--0);
  return List.fold_left((function (pbtt_msgs, pbpt_msg) do
                return Pervasives.$at(pbtt_msgs, compile_message_p1(file_name, file_options, scope, pbpt_msg));
              end), pbtt_msgs, param.messages);
end

function type_scope_of_type(param) do
  return param.scope;
end

function is_empty_message(param) do
  var match = param.spec;
  if (match.tag) do
    return 0 == List.length(match[0].message_body);
  end else do
    return false;
  end
end

function type_name_of_type(param) do
  var match = param.spec;
  if (match.tag) do
    return match[0].message_name;
  end else do
    return match[0].enum_name;
  end
end

function find_all_types_in_field_scope(all_types, scope) do
  return List.filter((function (t) do
                  var match = type_scope_of_type(t);
                  var dec_scope = Pervasives.$at(match.packages, match.message_names);
                  return Caml_obj.caml_equal(dec_scope, scope);
                end))(all_types);
end

function compile_message_p2(types, param, message) do
  var message_name = message.message_name;
  var message_scope = Pervasives.$at(param.packages, Pervasives.$at(param.message_names, --[ :: ]--[
            message_name,
            --[ [] ]--0
          ]));
  var search_scopes = function (field_scope, from_root) do
    if (from_root) do
      return --[ :: ]--[
              field_scope,
              --[ [] ]--0
            ];
    end else do
      var loop = function (_scopes, _l) do
        while(true) do
          var l = _l;
          var scopes = _scopes;
          if (l) do
            _l = pop_last(l);
            _scopes = --[ :: ]--[
              Pervasives.$at(l, field_scope),
              scopes
            ];
            continue ;
          end else do
            return --[ :: ]--[
                    field_scope,
                    scopes
                  ];
          end
        end;
      end;
      return List.rev(loop(--[ [] ]--0, message_scope));
    end
  end;
  var compile_field_p2 = function (field_name, field_type) do
    Curry._1(log(--[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "[pbtt] field_name: ",
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ Char_literal ]--Block.__(12, [
                          --[ "\n" ]--10,
                          --[ End_of_format ]--0
                        ])
                    ])
                ]),
              "[pbtt] field_name: %s\n"
            ]), field_name);
    if (typeof field_type == "number") do
      var param = field_type;
      if (typeof param == "number") do
        return param;
      end else do
        throw [
              Compilation_error,
              --[ Programatic_error ]--Block.__(4, [--[ Unexpected_field_type ]--1])
            ];
      end
    end else do
      var unresolved = field_type[0];
      var type_name = unresolved.type_name;
      endline("[pbtt] " .. string_of_unresolved(unresolved));
      var search_scopes$1 = search_scopes(unresolved.scope, unresolved.from_root);
      Curry._1(log(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "[pbtt] message scope: ",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ "\n" ]--10,
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "[pbtt] message scope: %s\n"
              ]), string_of_string_list(message_scope));
      List.iteri((function (i, scope) do
              return Curry._2(log(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "[pbtt] search_scope[",
                                  --[ Int ]--Block.__(4, [
                                      --[ Int_i ]--3,
                                      --[ Lit_padding ]--Block.__(0, [
                                          --[ Right ]--1,
                                          2
                                        ]),
                                      --[ No_precision ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          "] : ",
                                          --[ String ]--Block.__(2, [
                                              --[ No_padding ]--0,
                                              --[ Char_literal ]--Block.__(12, [
                                                  --[ "\n" ]--10,
                                                  --[ End_of_format ]--0
                                                ])
                                            ])
                                        ])
                                    ])
                                ]),
                              "[pbtt] search_scope[%2i] : %s\n"
                            ]), i, string_of_string_list(scope));
            end), search_scopes$1);
      var id = apply_until((function (scope) do
              var types$1 = types;
              var scope$1 = scope;
              var type_name$1 = type_name;
              var types$2 = find_all_types_in_field_scope(types$1, scope$1);
              try do
                var t = List.find((function (t) do
                        return type_name$1 == type_name_of_type(t);
                      end), types$2);
                return type_id_of_type(t);
              end
              catch (exn)do
                if (exn == Caml_builtin_exceptions.not_found) do
                  return ;
                end else do
                  throw exn;
                end
              end
            end), search_scopes$1);
      if (id ~= undefined) do
        return --[ Field_type_type ]--[id];
      end else do
        var field_name$1 = field_name;
        var type_ = type_name;
        var message_name$1 = message_name;
        throw [
              Compilation_error,
              --[ Unresolved_type ]--Block.__(0, [do
                    field_name: field_name$1,
                    type_: type_,
                    message_name: message_name$1
                  end])
            ];
      end
    end
  end;
  var message_body = List.fold_left((function (message_body, param) do
          switch (param.tag | 0) do
            case --[ Message_field ]--0 :
                var field = param[0];
                var field_name$1 = field_name(field);
                var field_type$1 = field_type(field);
                var field_field_parsed = field.field_parsed;
                var field_field_type = compile_field_p2(field_name$1, field_type$1);
                var field_field_default = field.field_default;
                var field_field_options = field.field_options;
                var field$1 = do
                  field_parsed: field_field_parsed,
                  field_type: field_field_type,
                  field_default: field_field_default,
                  field_options: field_field_options
                end;
                var field_field_parsed$1 = field_field_parsed;
                var field_field_type$1 = field_field_type;
                var field_field_default$1 = compile_default_p2(types, field$1);
                var field_field_options$1 = field_field_options;
                var field$2 = do
                  field_parsed: field_field_parsed$1,
                  field_type: field_field_type$1,
                  field_default: field_field_default$1,
                  field_options: field_field_options$1
                end;
                return --[ :: ]--[
                        --[ Message_field ]--Block.__(0, [field$2]),
                        message_body
                      ];
            case --[ Message_oneof_field ]--1 :
                var oneof = param[0];
                var oneof_fields = List.fold_left((function (oneof_fields, field) do
                        var field_name$2 = field_name(field);
                        var field_type$2 = field_type(field);
                        var field_type$3 = compile_field_p2(field_name$2, field_type$2);
                        return --[ :: ]--[
                                do
                                  field_parsed: field.field_parsed,
                                  field_type: field_type$3,
                                  field_default: field.field_default,
                                  field_options: field.field_options
                                end,
                                oneof_fields
                              ];
                      end), --[ [] ]--0, oneof.oneof_fields);
                var oneof_fields$1 = List.rev(oneof_fields);
                return --[ :: ]--[
                        --[ Message_oneof_field ]--Block.__(1, [do
                              oneof_name: oneof.oneof_name,
                              oneof_fields: oneof_fields$1
                            end]),
                        message_body
                      ];
            case --[ Message_map_field ]--2 :
                var map = param[0];
                var map_name = map.map_name;
                var map_key_type = compile_field_p2(map_name, map.map_key_type);
                var map_value_type = compile_field_p2(map_name, map.map_value_type);
                var resolved_map = --[ Message_map_field ]--Block.__(2, [do
                      map_name: map_name,
                      map_number: map.map_number,
                      map_key_type: map_key_type,
                      map_value_type: map_value_type,
                      map_options: map.map_options
                    end]);
                return --[ :: ]--[
                        resolved_map,
                        message_body
                      ];
            
          end
        end), --[ [] ]--0, message.message_body);
  var message_body$1 = List.rev(message_body);
  return do
          extensions: message.extensions,
          message_name: message.message_name,
          message_body: message_body$1
        end;
end

function node_of_proto_type(param) do
  var match = param.spec;
  var id = param.id;
  if (match.tag) do
    var sub = List.flatten(List.map((function (param) do
                switch (param.tag | 0) do
                  case --[ Message_field ]--0 :
                      var field_type = param[0].field_type;
                      if (typeof field_type == "number") do
                        return --[ [] ]--0;
                      end else do
                        return --[ :: ]--[
                                field_type[0],
                                --[ [] ]--0
                              ];
                      end
                  case --[ Message_oneof_field ]--1 :
                      return List.flatten(List.map((function (param) do
                                        var field_type = param.field_type;
                                        if (typeof field_type == "number") do
                                          return --[ [] ]--0;
                                        end else do
                                          return --[ :: ]--[
                                                  field_type[0],
                                                  --[ [] ]--0
                                                ];
                                        end
                                      end), param[0].oneof_fields));
                  case --[ Message_map_field ]--2 :
                      var map_value_type = param[0].map_value_type;
                      if (typeof map_value_type == "number") do
                        return --[ [] ]--0;
                      end else do
                        return --[ :: ]--[
                                map_value_type[0],
                                --[ [] ]--0
                              ];
                      end
                  
                end
              end), match[0].message_body));
    return do
            id: id,
            sub: sub
          end;
  end else do
    return do
            id: id,
            sub: --[ [] ]--0
          end;
  end
end

function group(proto) do
  var g = List.map(node_of_proto_type, proto);
  var g$1 = List.fold_left((function (m, n) do
          var n$1 = n;
          var g = m;
          return add(n$1.id, n$1, g);
        end), --[ Empty ]--0, g);
  var sccs = tarjan(g$1);
  return List.map((function (l) do
                return List.map((function (id) do
                              return List.find((function (param) do
                                            var input_id = id;
                                            var param$1 = param;
                                            return input_id == param$1.id;
                                          end), proto);
                            end), l);
              end), sccs);
end

function type_decl_of_and(param) do
  if (param ~= undefined) do
    return "and";
  end else do
    return "type";
  end
end

function gen_type_record(mutable_, and_, param, sc) do
  var r_fields = param.r_fields;
  var r_name = param.r_name;
  var mutable_$1 = mutable_ ~= undefined;
  var is_imperative_type = function (param) do
    switch (param.tag | 0) do
      case --[ Rft_repeated_field ]--2 :
      case --[ Rft_associative_field ]--3 :
          if (param[0][0]) do
            return true;
          end else do
            return false;
          end
      default:
        return false;
    end
  end;
  var field_prefix = function (field_type, field_mutable) do
    if (field_mutable or !(is_imperative_type(field_type) or !mutable_$1)) do
      return "mutable ";
    end else do
      return "";
    end
  end;
  var r_name$1 = mutable_$1 ? r_name .. "_mutable" : r_name;
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " = {",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s %s = {"
              ]), type_decl_of_and(and_), r_name$1));
  scope(sc, (function (sc) do
          return List.iter((function (param) do
                        var rf_field_type = param.rf_field_type;
                        var prefix = field_prefix(rf_field_type, param.rf_mutable);
                        var type_string = string_of_record_field_type(rf_field_type);
                        return line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                                            --[ String ]--Block.__(2, [
                                                --[ No_padding ]--0,
                                                --[ String ]--Block.__(2, [
                                                    --[ No_padding ]--0,
                                                    --[ String_literal ]--Block.__(11, [
                                                        " : ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ Char_literal ]--Block.__(12, [
                                                                --[ ";" ]--59,
                                                                --[ End_of_format ]--0
                                                              ])
                                                          ])
                                                      ])
                                                  ])
                                              ]),
                                            "%s%s : %s;"
                                          ]), prefix, param.rf_label, type_string));
                      end), r_fields);
        end));
  return line$1(sc, "}");
end

function gen_type_variant(and_, variant, sc) do
  var v_constructors = variant.v_constructors;
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " =",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s %s ="
              ]), type_decl_of_and(and_), variant.v_name));
  return scope(sc, (function (sc) do
                return List.iter((function (param) do
                              var vc_field_type = param.vc_field_type;
                              var vc_constructor = param.vc_constructor;
                              if (vc_field_type) do
                                var type_string = string_of_field_type(vc_field_type[0]);
                                return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " of ",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ End_of_format ]--0
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "| %s of %s"
                                                  ]), vc_constructor, type_string));
                              end else do
                                return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ End_of_format ]--0
                                                          ])
                                                      ]),
                                                    "| %s"
                                                  ]), vc_constructor));
                              end
                            end), v_constructors);
              end));
end

function gen_type_const_variant(and_, param, sc) do
  var cv_constructors = param.cv_constructors;
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ " " ]--32,
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " =",
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "%s %s ="
              ]), type_decl_of_and(and_), param.cv_name));
  return scope(sc, (function (sc) do
                return List.iter((function (param) do
                              return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                  --[ String_literal ]--Block.__(11, [
                                                      "| ",
                                                      --[ String ]--Block.__(2, [
                                                          --[ No_padding ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ " " ]--32,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ]),
                                                  "| %s "
                                                ]), param[0]));
                            end), cv_constructors);
              end));
end

function gen_struct$2(and_, t, scope) do
  var match = t.spec;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        var r = match[0];
        gen_type_record(undefined, and_, r, scope);
        line$1(scope, "");
        gen_type_record(--[ () ]--0, --[ () ]--0, r, scope);
        break;
    case --[ Variant ]--1 :
        gen_type_variant(and_, match[0], scope);
        break;
    case --[ Const_variant ]--2 :
        gen_type_const_variant(and_, match[0], scope);
        break;
    
  end
  return true;
end

function gen_sig$2(and_, t, scope) do
  var match = t.spec;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        gen_type_record(undefined, and_, match[0], scope);
        break;
    case --[ Variant ]--1 :
        gen_type_variant(and_, match[0], scope);
        break;
    case --[ Const_variant ]--2 :
        gen_type_const_variant(and_, match[0], scope);
        break;
    
  end
  return true;
end

var Codegen_type = do
  gen_sig: gen_sig$2,
  gen_struct: gen_struct$2,
  ocamldoc_title: "Types"
end;

function gen_encode_field_key(sc, number, pk, is_packed) do
  var s = string_of_payload_kind(undefined, pk, is_packed);
  var s$1 = Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s)));
  return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "Pbrt.Encoder.key (",
                          --[ Int ]--Block.__(4, [
                              --[ Int_i ]--3,
                              --[ No_padding ]--0,
                              --[ No_precision ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  ", Pbrt.",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          ") encoder; ",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ])
                            ])
                        ]),
                      "Pbrt.Encoder.key (%i, Pbrt.%s) encoder; "
                    ]), number, Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s$1)))));
end

function encode_basic_type(bt, pk) do
  return runtime_function(--[ tuple ]--[
              --[ Encode ]--779642422,
              pk,
              bt
            ]);
end

function gen_encode_field_type(with_key, sc, var_name, encoding_number, pk, is_packed, field_type) do
  var encode_key = function (sc) do
    if (with_key ~= undefined) do
      return gen_encode_field_key(sc, encoding_number, pk, is_packed);
    end else do
      return --[ () ]--0;
    end
  end;
  if (typeof field_type == "number") do
    encode_key(sc);
    return line$1(sc, "Pbrt.Encoder.empty_nested encoder;");
  end else if (field_type.tag) do
    var ud = field_type[0];
    encode_key(sc);
    var f_name = function_name_of_user_defined("encode", ud);
    if (ud.udt_nested) do
      return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                          --[ String_literal ]--Block.__(11, [
                              "Pbrt.Encoder.nested (",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ " " ]--32,
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              ") encoder;",
                                              --[ End_of_format ]--0
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "Pbrt.Encoder.nested (%s %s) encoder;"
                        ]), f_name, var_name));
    end else do
      return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ " " ]--32,
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " encoder;",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ])
                            ]),
                          "%s %s encoder;"
                        ]), f_name, var_name));
    end
  end else do
    encode_key(sc);
    var rt = encode_basic_type(field_type[0], pk);
    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ " " ]--32,
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        " encoder;",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ]),
                        "%s %s encoder;"
                      ]), rt, var_name));
  end
end

function gen_encode_record(and_, param, sc) do
  var r_fields = param.r_fields;
  var r_name = param.r_name;
  Curry._1(log(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "gen_encode_record record_name: ",
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ Char_literal ]--Block.__(12, [
                        --[ "\n" ]--10,
                        --[ End_of_format ]--0
                      ])
                  ])
              ]),
            "gen_encode_record record_name: %s\n"
          ]), r_name);
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " encode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") encoder = ",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s encode_%s (v:%s) encoder = "
              ]), let_decl_of_and(and_), r_name, r_name));
  return scope(sc, (function (sc) do
                List.iter((function (record_field) do
                        var rf_field_type = record_field.rf_field_type;
                        var rf_label = record_field.rf_label;
                        switch (rf_field_type.tag | 0) do
                          case --[ Rft_required ]--0 :
                              var match = rf_field_type[0];
                              var var_name = Curry._1(Printf.sprintf(--[ Format ]--[
                                        --[ String_literal ]--Block.__(11, [
                                            "v.",
                                            --[ String ]--Block.__(2, [
                                                --[ No_padding ]--0,
                                                --[ End_of_format ]--0
                                              ])
                                          ]),
                                        "v.%s"
                                      ]), rf_label);
                              return gen_encode_field_type(--[ () ]--0, sc, var_name, match[1], match[2], false, match[0]);
                          case --[ Rft_optional ]--1 :
                              var match$1 = rf_field_type[0];
                              var pk = match$1[2];
                              var encoding_number = match$1[1];
                              var field_type = match$1[0];
                              line$1(sc, "(");
                              scope(sc, (function (sc) do
                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "match v.",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " with ",
                                                                --[ End_of_format ]--0
                                                              ])
                                                          ])
                                                      ]),
                                                    "match v.%s with "
                                                  ]), rf_label));
                                      line$1(sc, Printf.sprintf(--[ Format ]--[
                                                --[ String_literal ]--Block.__(11, [
                                                    "| Some x -> (",
                                                    --[ End_of_format ]--0
                                                  ]),
                                                "| Some x -> ("
                                              ]));
                                      scope(sc, (function (sc) do
                                              return gen_encode_field_type(--[ () ]--0, sc, "x", encoding_number, pk, false, field_type);
                                            end));
                                      line$1(sc, ")");
                                      return line$1(sc, "| None -> ();");
                                    end));
                              return line$1(sc, ");");
                          case --[ Rft_repeated_field ]--2 :
                              var match$2 = rf_field_type[0];
                              var is_packed = match$2[4];
                              var pk$1 = match$2[3];
                              var encoding_number$1 = match$2[2];
                              var field_type$1 = match$2[1];
                              if (match$2[0]) do
                                if (is_packed) do
                                  gen_encode_field_key(sc, encoding_number$1, pk$1, is_packed);
                                  line$1(sc, "Pbrt.Encoder.nested (fun encoder ->");
                                  scope(sc, (function (sc) do
                                          line$1(sc, "Pbrt.Repeated_field.iter (fun x -> ");
                                          scope(sc, (function (sc) do
                                                  return gen_encode_field_type(undefined, sc, "x", encoding_number$1, pk$1, is_packed, field_type$1);
                                                end));
                                          return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                              --[ String_literal ]--Block.__(11, [
                                                                  ") v.",
                                                                  --[ String ]--Block.__(2, [
                                                                      --[ No_padding ]--0,
                                                                      --[ Char_literal ]--Block.__(12, [
                                                                          --[ ";" ]--59,
                                                                          --[ End_of_format ]--0
                                                                        ])
                                                                    ])
                                                                ]),
                                                              ") v.%s;"
                                                            ]), rf_label));
                                        end));
                                  return line$1(sc, ") encoder;");
                                end else do
                                  line$1(sc, "Pbrt.Repeated_field.iter (fun x -> ");
                                  scope(sc, (function (sc) do
                                          return gen_encode_field_type(--[ () ]--0, sc, "x", encoding_number$1, pk$1, is_packed, field_type$1);
                                        end));
                                  return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                      --[ String_literal ]--Block.__(11, [
                                                          ") v.",
                                                          --[ String ]--Block.__(2, [
                                                              --[ No_padding ]--0,
                                                              --[ Char_literal ]--Block.__(12, [
                                                                  --[ ";" ]--59,
                                                                  --[ End_of_format ]--0
                                                                ])
                                                            ])
                                                        ]),
                                                      ") v.%s;"
                                                    ]), rf_label));
                                end
                              end else if (is_packed) do
                                gen_encode_field_key(sc, encoding_number$1, pk$1, is_packed);
                                line$1(sc, "Pbrt.Encoder.nested (fun encoder ->");
                                scope(sc, (function (sc) do
                                        line$1(sc, "List.iter (fun x -> ");
                                        scope(sc, (function (sc) do
                                                return gen_encode_field_type(undefined, sc, "x", encoding_number$1, pk$1, is_packed, field_type$1);
                                              end));
                                        return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                            --[ String_literal ]--Block.__(11, [
                                                                ") v.",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ Char_literal ]--Block.__(12, [
                                                                        --[ ";" ]--59,
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ]),
                                                            ") v.%s;"
                                                          ]), rf_label));
                                      end));
                                return line$1(sc, ") encoder;");
                              end else do
                                line$1(sc, "List.iter (fun x -> ");
                                scope(sc, (function (sc) do
                                        return gen_encode_field_type(--[ () ]--0, sc, "x", encoding_number$1, pk$1, is_packed, field_type$1);
                                      end));
                                return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        ") v.",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ Char_literal ]--Block.__(12, [
                                                                --[ ";" ]--59,
                                                                --[ End_of_format ]--0
                                                              ])
                                                          ])
                                                      ]),
                                                    ") v.%s;"
                                                  ]), rf_label));
                              end
                          case --[ Rft_associative_field ]--3 :
                              var match$3 = rf_field_type[0];
                              var match$4 = match$3[3];
                              var value_pk = match$4[1];
                              var value_type = match$4[0];
                              var match$5 = match$3[2];
                              var key_pk = match$5[1];
                              var encoding_number$2 = match$3[1];
                              line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                            --[ String_literal ]--Block.__(11, [
                                                "let encode_key = ",
                                                --[ String ]--Block.__(2, [
                                                    --[ No_padding ]--0,
                                                    --[ String_literal ]--Block.__(11, [
                                                        " in",
                                                        --[ End_of_format ]--0
                                                      ])
                                                  ])
                                              ]),
                                            "let encode_key = %s in"
                                          ]), encode_basic_type(match$5[0], key_pk)));
                              line$1(sc, "let encode_value = (fun x encoder ->");
                              scope(sc, (function (sc) do
                                      return gen_encode_field_type(undefined, sc, "x", -1, value_pk, false, value_type);
                                    end));
                              line$1(sc, ") in");
                              if (match$3[0]) do
                                line$1(sc, "Hashtbl.iter (fun k v ->");
                              end else do
                                line$1(sc, "List.iter (fun (k, v) ->");
                              end
                              scope(sc, (function (sc) do
                                      gen_encode_field_key(sc, encoding_number$2, --[ Pk_bytes ]--2, false);
                                      line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "let map_entry = (k, Pbrt.",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                "), (v, Pbrt.",
                                                                --[ String ]--Block.__(2, [
                                                                    --[ No_padding ]--0,
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        ") in",
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "let map_entry = (k, Pbrt.%s), (v, Pbrt.%s) in"
                                                  ]), string_of_payload_kind(--[ () ]--0, key_pk, false), string_of_payload_kind(--[ () ]--0, value_pk, false)));
                                      return line$1(sc, "Pbrt.Encoder.map_entry ~encode_key ~encode_value map_entry encoder");
                                    end));
                              return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                  --[ String_literal ]--Block.__(11, [
                                                      ") v.",
                                                      --[ String ]--Block.__(2, [
                                                          --[ No_padding ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ ";" ]--59,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ]),
                                                  ") v.%s;"
                                                ]), rf_label));
                          case --[ Rft_variant_field ]--4 :
                              var v_constructors = rf_field_type[0].v_constructors;
                              line$1(sc, "(");
                              scope(sc, (function (sc) do
                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "match v.",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " with",
                                                                --[ End_of_format ]--0
                                                              ])
                                                          ])
                                                      ]),
                                                    "match v.%s with"
                                                  ]), rf_label));
                                      return List.iter((function (param) do
                                                    var vc_payload_kind = param.vc_payload_kind;
                                                    var vc_encoding_number = param.vc_encoding_number;
                                                    var vc_field_type = param.vc_field_type;
                                                    var vc_constructor = param.vc_constructor;
                                                    if (vc_field_type) do
                                                      var field_type = vc_field_type[0];
                                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "| ",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                " x -> (",
                                                                                --[ End_of_format ]--0
                                                                              ])
                                                                          ])
                                                                      ]),
                                                                    "| %s x -> ("
                                                                  ]), vc_constructor));
                                                      scope(sc, (function (sc) do
                                                              return gen_encode_field_type(--[ () ]--0, sc, "x", vc_encoding_number, vc_payload_kind, false, field_type);
                                                            end));
                                                      return line$1(sc, ")");
                                                    end else do
                                                      line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        "| ",
                                                                        --[ String ]--Block.__(2, [
                                                                            --[ No_padding ]--0,
                                                                            --[ String_literal ]--Block.__(11, [
                                                                                " -> (",
                                                                                --[ End_of_format ]--0
                                                                              ])
                                                                          ])
                                                                      ]),
                                                                    "| %s -> ("
                                                                  ]), vc_constructor));
                                                      scope(sc, (function (sc) do
                                                              gen_encode_field_key(sc, vc_encoding_number, vc_payload_kind, false);
                                                              return line$1(sc, "Pbrt.Encoder.empty_nested encoder");
                                                            end));
                                                      return line$1(sc, ")");
                                                    end
                                                  end), v_constructors);
                                    end));
                              return line$1(sc, ");");
                          
                        end
                      end), r_fields);
                return line$1(sc, "()");
              end));
end

function gen_encode_variant(and_, variant, sc) do
  var v_constructors = variant.v_constructors;
  var v_name = variant.v_name;
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " encode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") encoder = ",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s encode_%s (v:%s) encoder = "
              ]), let_decl_of_and(and_), v_name, v_name));
  return scope(sc, (function (sc) do
                line$1(sc, "match v with");
                return List.iter((function (param) do
                              var vc_payload_kind = param.vc_payload_kind;
                              var vc_encoding_number = param.vc_encoding_number;
                              var vc_field_type = param.vc_field_type;
                              var vc_constructor = param.vc_constructor;
                              if (vc_field_type) do
                                var field_type = vc_field_type[0];
                                line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                              --[ String_literal ]--Block.__(11, [
                                                  "| ",
                                                  --[ String ]--Block.__(2, [
                                                      --[ No_padding ]--0,
                                                      --[ String_literal ]--Block.__(11, [
                                                          " x -> (",
                                                          --[ End_of_format ]--0
                                                        ])
                                                    ])
                                                ]),
                                              "| %s x -> ("
                                            ]), vc_constructor));
                                scope(sc, (function (sc) do
                                        return gen_encode_field_type(--[ () ]--0, sc, "x", vc_encoding_number, vc_payload_kind, false, field_type);
                                      end));
                                return line$1(sc, ")");
                              end else do
                                line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                              --[ String_literal ]--Block.__(11, [
                                                  "| ",
                                                  --[ String ]--Block.__(2, [
                                                      --[ No_padding ]--0,
                                                      --[ String_literal ]--Block.__(11, [
                                                          " -> (",
                                                          --[ End_of_format ]--0
                                                        ])
                                                    ])
                                                ]),
                                              "| %s -> ("
                                            ]), vc_constructor));
                                scope(sc, (function (sc) do
                                        gen_encode_field_key(sc, vc_encoding_number, vc_payload_kind, false);
                                        return line$1(sc, "Pbrt.Encoder.empty_nested encoder");
                                      end));
                                return line$1(sc, ")");
                              end
                            end), v_constructors);
              end));
end

function gen_encode_const_variant(and_, param, sc) do
  var cv_constructors = param.cv_constructors;
  var cv_name = param.cv_name;
  line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " encode_",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                " (v:",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ") encoder =",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "%s encode_%s (v:%s) encoder ="
              ]), let_decl_of_and(and_), cv_name, cv_name));
  return scope(sc, (function (sc) do
                line$1(sc, "match v with");
                return List.iter((function (param) do
                              var value = param[1];
                              var name = param[0];
                              return line$1(sc, value > 0 ? Curry._2(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " -> Pbrt.Encoder.int_as_varint ",
                                                                --[ Int ]--Block.__(4, [
                                                                    --[ Int_i ]--3,
                                                                    --[ No_padding ]--0,
                                                                    --[ No_precision ]--0,
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        " encoder",
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "| %s -> Pbrt.Encoder.int_as_varint %i encoder"
                                                  ]), name, value) : Curry._2(Printf.sprintf(--[ Format ]--[
                                                    --[ String_literal ]--Block.__(11, [
                                                        "| ",
                                                        --[ String ]--Block.__(2, [
                                                            --[ No_padding ]--0,
                                                            --[ String_literal ]--Block.__(11, [
                                                                " -> Pbrt.Encoder.int_as_varint (",
                                                                --[ Int ]--Block.__(4, [
                                                                    --[ Int_i ]--3,
                                                                    --[ No_padding ]--0,
                                                                    --[ No_precision ]--0,
                                                                    --[ String_literal ]--Block.__(11, [
                                                                        ") encoder",
                                                                        --[ End_of_format ]--0
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ]),
                                                    "| %s -> Pbrt.Encoder.int_as_varint (%i) encoder"
                                                  ]), name, value));
                            end), cv_constructors);
              end));
end

function gen_struct$3(and_, t, sc) do
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        tmp = --[ tuple ]--[
          gen_encode_record(and_, match[0], sc),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          gen_encode_variant(and_, match[0], sc),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          gen_encode_const_variant(and_, match[0], sc),
          true
        ];
        break;
    
  end
  return tmp[1];
end

function gen_sig$3(and_, t, sc) do
  var f = function (type_name) do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "val encode_",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " : ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " -> Pbrt.Encoder.t -> unit",
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "val encode_%s : %s -> Pbrt.Encoder.t -> unit"
                ]), type_name, type_name));
    return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "(** [encode_",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    " v encoder] encodes [v] with the given [encoder] *)",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ]),
                        "(** [encode_%s v encoder] encodes [v] with the given [encoder] *)"
                      ]), type_name));
  end;
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        tmp = --[ tuple ]--[
          f(match[0].r_name),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          f(match[0].v_name),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          f(match[0].cv_name),
          true
        ];
        break;
    
  end
  return tmp[1];
end

var Codegen_encode = do
  gen_sig: gen_sig$3,
  gen_struct: gen_struct$3,
  ocamldoc_title: "Protobuf Toding"
end;

function default_value_of_field_type(field_name, field_type, field_default) do
  if (typeof field_type == "number") do
    return "()";
  end else if (field_type.tag) do
    return function_name_of_user_defined("default", field_type[0]) .. " ()";
  end else do
    var field_name$1 = field_name;
    var basic_type = field_type[0];
    var field_default$1 = field_default;
    switch (basic_type) do
      case --[ Bt_string ]--0 :
          if (field_default$1 ~= undefined) do
            var match = field_default$1;
            if (match.tag) do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end else do
              return Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "\"" ]--34,
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ Char_literal ]--Block.__(12, [
                                          --[ "\"" ]--34,
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "\"%s\""
                            ]), match[0]);
            end
          end else do
            return "\"\"";
          end
      case --[ Bt_float ]--1 :
          if (field_default$1 ~= undefined) do
            var match$1 = field_default$1;
            if (match$1.tag == --[ Constant_float ]--3) do
              return Pervasives.string_of_float(match$1[0]);
            end else do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end
          end else do
            return "0.";
          end
      case --[ Bt_int ]--2 :
          if (field_default$1 ~= undefined) do
            var match$2 = field_default$1;
            if (match$2.tag == --[ Constant_int ]--2) do
              return String(match$2[0]);
            end else do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end
          end else do
            return "0";
          end
      case --[ Bt_int32 ]--3 :
          if (field_default$1 ~= undefined) do
            var match$3 = field_default$1;
            if (match$3.tag == --[ Constant_int ]--2) do
              return Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ Int ]--Block.__(4, [
                                  --[ Int_i ]--3,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ "l" ]--108,
                                      --[ End_of_format ]--0
                                    ])
                                ]),
                              "%il"
                            ]), match$3[0]);
            end else do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end
          end else do
            return "0l";
          end
      case --[ Bt_int64 ]--4 :
          if (field_default$1 ~= undefined) do
            var match$4 = field_default$1;
            if (match$4.tag == --[ Constant_int ]--2) do
              return Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ Int ]--Block.__(4, [
                                  --[ Int_i ]--3,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ "L" ]--76,
                                      --[ End_of_format ]--0
                                    ])
                                ]),
                              "%iL"
                            ]), match$4[0]);
            end else do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end
          end else do
            return "0L";
          end
      case --[ Bt_bytes ]--5 :
          if (field_default$1 ~= undefined) do
            var match$5 = field_default$1;
            if (match$5.tag) do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end else do
              return Curry._1(Printf.sprintf(--[ Format ]--[
                              --[ String_literal ]--Block.__(11, [
                                  "Bytes.of_string \"",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ Char_literal ]--Block.__(12, [
                                          --[ "\"" ]--34,
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ]),
                              "Bytes.of_string \"%s\""
                            ]), match$5[0]);
            end
          end else do
            return "Bytes.create 64";
          end
      case --[ Bt_bool ]--6 :
          if (field_default$1 ~= undefined) do
            var match$6 = field_default$1;
            if (match$6.tag == --[ Constant_bool ]--1) do
              var b = match$6[0];
              if (b) do
                return "true";
              end else do
                return "false";
              end
            end else do
              return invalid_default_value(field_name$1, "invalid default type", --[ () ]--0);
            end
          end else do
            return "false";
          end
      
    end
  end
end

function record_field_default_info(record_field) do
  var rf_field_type = record_field.rf_field_type;
  var rf_label = record_field.rf_label;
  var type_string = string_of_record_field_type(rf_field_type);
  var dfvft = function (field_type, defalut_value) do
    return default_value_of_field_type(rf_label, field_type, defalut_value);
  end;
  var default_value;
  switch (rf_field_type.tag | 0) do
    case --[ Rft_required ]--0 :
        var match = rf_field_type[0];
        default_value = dfvft(match[0], match[3]);
        break;
    case --[ Rft_optional ]--1 :
        var match$1 = rf_field_type[0];
        var default_value$1 = match$1[3];
        default_value = default_value$1 ~= undefined ? Curry._1(Printf.sprintf(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "Some (",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ ")" ]--41,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "Some (%s)"
                  ]), dfvft(match$1[0], default_value$1)) : "None";
        break;
    case --[ Rft_repeated_field ]--2 :
        var match$2 = rf_field_type[0];
        default_value = match$2[0] ? Curry._1(Printf.sprintf(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "Pbrt.Repeated_field.make (",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ Char_literal ]--Block.__(12, [
                                --[ ")" ]--41,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ]),
                    "Pbrt.Repeated_field.make (%s)"
                  ]), dfvft(match$2[1], undefined)) : "[]";
        break;
    case --[ Rft_associative_field ]--3 :
        default_value = rf_field_type[0][0] ? "Hashtbl.create 128" : "[]";
        break;
    case --[ Rft_variant_field ]--4 :
        var v_constructors = rf_field_type[0].v_constructors;
        if (v_constructors) do
          var match$3 = v_constructors[0];
          var vc_field_type = match$3.vc_field_type;
          var vc_constructor = match$3.vc_constructor;
          default_value = vc_field_type ? Curry._2(Printf.sprintf(--[ Format ]--[
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " (",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ ")" ]--41,
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ]),
                      "%s (%s)"
                    ]), vc_constructor, dfvft(vc_field_type[0], undefined)) : vc_constructor;
        end else do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "codegen_default.ml",
                  74,
                  15
                ]
              ];
        end
        break;
    
  end
  return --[ tuple ]--[
          rf_label,
          default_value,
          type_string
        ];
end

function gen_default_record(mutable_, and_, param, sc) do
  var r_name = param.r_name;
  var fields_default_info = List.map(record_field_default_info, param.r_fields);
  if (mutable_ ~= undefined) do
    var rn = r_name .. "_mutable";
    line$1(sc, Curry._3(Printf.sprintf(--[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ String_literal ]--Block.__(11, [
                          " default_",
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  " () : ",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " = {",
                                          --[ End_of_format ]--0
                                        ])
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "%s default_%s () : %s = {"
                ]), let_decl_of_and(and_), rn, rn));
    scope(sc, (function (sc) do
            return List.iter((function (param) do
                          return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ String_literal ]--Block.__(11, [
                                                      " = ",
                                                      --[ String ]--Block.__(2, [
                                                          --[ No_padding ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ ";" ]--59,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ])
                                                ]),
                                              "%s = %s;"
                                            ]), param[0], param[1]));
                        end), fields_default_info);
          end));
  end else do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ String_literal ]--Block.__(11, [
                          " default_",
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char_literal ]--Block.__(12, [
                                  --[ " " ]--32,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  "%s default_%s "
                ]), let_decl_of_and(and_), r_name));
    scope(sc, (function (sc) do
            List.iter((function (param) do
                    var fname = param[0];
                    return line$1(sc, Curry._4(Printf.sprintf(--[ Format ]--[
                                        --[ Char_literal ]--Block.__(12, [
                                            --[ "?" ]--63,
                                            --[ String ]--Block.__(2, [
                                                --[ No_padding ]--0,
                                                --[ String_literal ]--Block.__(11, [
                                                    ":((",
                                                    --[ String ]--Block.__(2, [
                                                        --[ No_padding ]--0,
                                                        --[ Char_literal ]--Block.__(12, [
                                                            --[ ":" ]--58,
                                                            --[ String ]--Block.__(2, [
                                                                --[ No_padding ]--0,
                                                                --[ String_literal ]--Block.__(11, [
                                                                    ") = ",
                                                                    --[ String ]--Block.__(2, [
                                                                        --[ No_padding ]--0,
                                                                        --[ Char_literal ]--Block.__(12, [
                                                                            --[ ")" ]--41,
                                                                            --[ End_of_format ]--0
                                                                          ])
                                                                      ])
                                                                  ])
                                                              ])
                                                          ])
                                                      ])
                                                  ])
                                              ])
                                          ]),
                                        "?%s:((%s:%s) = %s)"
                                      ]), fname, fname, param[2], param[1]));
                  end), fields_default_info);
            return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                --[ String_literal ]--Block.__(11, [
                                    "() : ",
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ String_literal ]--Block.__(11, [
                                            "  = {",
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ]),
                                "() : %s  = {"
                              ]), r_name));
          end));
    scope(sc, (function (sc) do
            return List.iter((function (param) do
                          return line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ ";" ]--59,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ]),
                                              "%s;"
                                            ]), param[0]));
                        end), fields_default_info);
          end));
  end
  return line$1(sc, "}");
end

function gen_default_variant(and_, param, sc) do
  var v_constructors = param.v_constructors;
  var v_name = param.v_name;
  if (v_constructors) do
    var match = v_constructors[0];
    var vc_field_type = match.vc_field_type;
    var vc_constructor = match.vc_constructor;
    var decl = let_decl_of_and(and_);
    if (vc_field_type) do
      var default_value = default_value_of_field_type(v_name, vc_field_type[0], undefined);
      return line$1(sc, Curry._5(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  " default_",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " () : ",
                                          --[ String ]--Block.__(2, [
                                              --[ No_padding ]--0,
                                              --[ String_literal ]--Block.__(11, [
                                                  " = ",
                                                  --[ String ]--Block.__(2, [
                                                      --[ No_padding ]--0,
                                                      --[ String_literal ]--Block.__(11, [
                                                          " (",
                                                          --[ String ]--Block.__(2, [
                                                              --[ No_padding ]--0,
                                                              --[ Char_literal ]--Block.__(12, [
                                                                  --[ ")" ]--41,
                                                                  --[ End_of_format ]--0
                                                                ])
                                                            ])
                                                        ])
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "%s default_%s () : %s = %s (%s)"
                        ]), decl, v_name, v_name, vc_constructor, default_value));
    end else do
      return line$1(sc, Curry._4(Printf.sprintf(--[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  " default_",
                                  --[ String ]--Block.__(2, [
                                      --[ No_padding ]--0,
                                      --[ String_literal ]--Block.__(11, [
                                          " (): ",
                                          --[ String ]--Block.__(2, [
                                              --[ No_padding ]--0,
                                              --[ String_literal ]--Block.__(11, [
                                                  " = ",
                                                  --[ String ]--Block.__(2, [
                                                      --[ No_padding ]--0,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ]),
                          "%s default_%s (): %s = %s"
                        ]), decl, v_name, v_name, vc_constructor));
    end
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "programmatic TODO error"
        ];
  end
end

function gen_default_const_variant(and_, param, sc) do
  var cv_constructors = param.cv_constructors;
  var cv_name = param.cv_name;
  var first_constructor_name;
  if (cv_constructors) do
    first_constructor_name = cv_constructors[0][0];
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "programmatic TODO error"
        ];
  end
  return line$1(sc, Curry._4(Printf.sprintf(--[ Format ]--[
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " default_",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      " () = (",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ Char_literal ]--Block.__(12, [
                                              --[ ":" ]--58,
                                              --[ String ]--Block.__(2, [
                                                  --[ No_padding ]--0,
                                                  --[ Char_literal ]--Block.__(12, [
                                                      --[ ")" ]--41,
                                                      --[ End_of_format ]--0
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ])
                        ]),
                      "%s default_%s () = (%s:%s)"
                    ]), let_decl_of_and(and_), cv_name, first_constructor_name, cv_name));
end

function gen_struct$4(and_, t, sc) do
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        var r = match[0];
        tmp = --[ tuple ]--[
          (gen_default_record(undefined, and_, r, sc), line$1(sc, ""), gen_default_record(--[ () ]--0, --[ () ]--0, r, sc)),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          gen_default_variant(and_, match[0], sc),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          gen_default_const_variant(undefined, match[0], sc),
          true
        ];
        break;
    
  end
  return tmp[1];
end

function gen_sig_record(sc, param) do
  var r_name = param.r_name;
  line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "val default_",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            " : ",
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "val default_%s : "
              ]), r_name));
  var fields_default_info = List.map(record_field_default_info, param.r_fields);
  scope(sc, (function (sc) do
          List.iter((function (param) do
                  return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                                      --[ Char_literal ]--Block.__(12, [
                                          --[ "?" ]--63,
                                          --[ String ]--Block.__(2, [
                                              --[ No_padding ]--0,
                                              --[ Char_literal ]--Block.__(12, [
                                                  --[ ":" ]--58,
                                                  --[ String ]--Block.__(2, [
                                                      --[ No_padding ]--0,
                                                      --[ String_literal ]--Block.__(11, [
                                                          " ->",
                                                          --[ End_of_format ]--0
                                                        ])
                                                    ])
                                                ])
                                            ])
                                        ]),
                                      "?%s:%s ->"
                                    ]), param[0], param[2]));
                end), fields_default_info);
          line$1(sc, "unit ->");
          return line$1(sc, r_name);
        end));
  line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "(** [default_",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            " ()] is the default value for type [",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    "] *)",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "(** [default_%s ()] is the default value for type [%s] *)"
              ]), r_name, r_name));
  return --[ () ]--0;
end

function gen_sig$4(and_, t, sc) do
  var f = function (type_name) do
    line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "val default_",
                      --[ String ]--Block.__(2, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              " : unit -> ",
                              --[ String ]--Block.__(2, [
                                  --[ No_padding ]--0,
                                  --[ End_of_format ]--0
                                ])
                            ])
                        ])
                    ]),
                  "val default_%s : unit -> %s"
                ]), type_name, type_name));
    return line$1(sc, Curry._2(Printf.sprintf(--[ Format ]--[
                        --[ String_literal ]--Block.__(11, [
                            "(** [default_",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    " ()] is the default value for type [",
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ String_literal ]--Block.__(11, [
                                            "] *)",
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ])
                              ])
                          ]),
                        "(** [default_%s ()] is the default value for type [%s] *)"
                      ]), type_name, type_name));
  end;
  var match = t.spec;
  var tmp;
  switch (match.tag | 0) do
    case --[ Record ]--0 :
        tmp = --[ tuple ]--[
          gen_sig_record(sc, match[0]),
          true
        ];
        break;
    case --[ Variant ]--1 :
        tmp = --[ tuple ]--[
          f(match[0].v_name),
          true
        ];
        break;
    case --[ Const_variant ]--2 :
        tmp = --[ tuple ]--[
          f(match[0].cv_name),
          true
        ];
        break;
    
  end
  return tmp[1];
end

var Codegen_default = do
  gen_sig: gen_sig$4,
  gen_struct: gen_struct$4,
  ocamldoc_title: "Default values"
end;

function rev_split_by_naming_convention(s) do
  var is_uppercase = function (c) do
    if (64 < c) do
      return c < 91;
    end else do
      return false;
    end
  end;
  var add_sub_string = function (start_i, end_i, l) do
    if (start_i == end_i) do
      return l;
    end else do
      return --[ :: ]--[
              $$String.sub(s, start_i, end_i - start_i | 0),
              l
            ];
    end
  end;
  var match = string_fold_lefti((function (param, i, c) do
          var start_i = param[1];
          var l = param[0];
          if (c ~= 95) do
            if (param[2] or !is_uppercase(c)) do
              return --[ tuple ]--[
                      l,
                      start_i,
                      is_uppercase(c)
                    ];
            end else do
              return --[ tuple ]--[
                      add_sub_string(start_i, i, l),
                      i,
                      true
                    ];
            end
          end else do
            return --[ tuple ]--[
                    add_sub_string(start_i, i, l),
                    i + 1 | 0,
                    false
                  ];
          end
        end), --[ tuple ]--[
        --[ [] ]--0,
        0,
        false
      ], s);
  var len = #s;
  return add_sub_string(match[1], len, match[0]);
end

function fix_ocaml_keyword_conflict(s) do
  switch (s) do
    case "and" :
    case "as" :
    case "asr" :
    case "assert" :
    case "begin" :
    case "class" :
    case "constraint" :
    case "do" :
    case "done" :
    case "downto" :
    case "else" :
    case "end" :
    case "exception" :
    case "external" :
    case "false" :
    case "for" :
    case "fun" :
    case "function" :
    case "functor" :
    case "if" :
    case "in" :
    case "include" :
    case "inherit" :
    case "initializer" :
    case "land" :
    case "lazy" :
    case "let" :
    case "lor" :
    case "lsl" :
    case "lsr" :
    case "lxor" :
    case "match" :
    case "method" :
    case "mod" :
    case "module" :
    case "mutable" :
    case "new" :
    case "nonrec" :
    case "object" :
    case "of" :
    case "open" :
    case "or" :
    case "private" :
    case "rec" :
    case "sig" :
    case "struct" :
    case "then" :
    case "to" :
    case "true" :
    case "try" :
    case "type" :
    case "val" :
    case "virtual" :
    case "when" :
    case "while" :
    case "with" :
        return s .. "_";
    default:
      return s;
  end
end

function constructor_name(s) do
  var s$1 = $$String.concat("_", List.rev(rev_split_by_naming_convention(s)));
  var s$2 = Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s$1)));
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s$2)));
end

function label_name_of_field_name(s) do
  var s$1 = $$String.concat("_", List.rev(rev_split_by_naming_convention(s)));
  return fix_ocaml_keyword_conflict(Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s$1))));
end

function module_of_file_name(file_name) do
  var file_name$1 = Curry._1(Filename.basename, file_name);
  var dot_index;
  try do
    dot_index = $$String.rindex(file_name$1, --[ "." ]--46);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      throw [
            Compilation_error,
            --[ Invalid_file_name ]--Block.__(6, [file_name$1])
          ];
    end
    throw exn;
  end
  return constructor_name($$String.sub(file_name$1, 0, dot_index) .. "_pb");
end

function type_name(message_scope, name) do
  var all_names = Pervasives.$at(message_scope, --[ :: ]--[
        name,
        --[ [] ]--0
      ]);
  var all_names$1 = List.map((function (s) do
          return List.map($$String.lowercase, List.rev(rev_split_by_naming_convention(s)));
        end), all_names);
  var all_names$2 = List.flatten(all_names$1);
  if (all_names$2) do
    if (all_names$2[1]) do
      return $$String.concat("_", all_names$2);
    end else do
      return fix_ocaml_keyword_conflict(all_names$2[0]);
    end
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "Programmatic error"
        ];
  end
end

function encoding_info_of_field_type(all_types, field_type) do
  if (typeof field_type == "number") do
    switch (field_type) do
      case --[ Field_type_sint32 ]--6 :
      case --[ Field_type_sint64 ]--7 :
          return --[ Pk_varint ]--[true];
      case --[ Field_type_float ]--1 :
      case --[ Field_type_fixed32 ]--8 :
      case --[ Field_type_sfixed32 ]--10 :
          return --[ Pk_bits32 ]--0;
      case --[ Field_type_double ]--0 :
      case --[ Field_type_fixed64 ]--9 :
      case --[ Field_type_sfixed64 ]--11 :
          return --[ Pk_bits64 ]--1;
      case --[ Field_type_int32 ]--2 :
      case --[ Field_type_int64 ]--3 :
      case --[ Field_type_uint32 ]--4 :
      case --[ Field_type_uint64 ]--5 :
      case --[ Field_type_bool ]--12 :
          return --[ Pk_varint ]--[false];
      case --[ Field_type_string ]--13 :
      case --[ Field_type_bytes ]--14 :
          return --[ Pk_bytes ]--2;
      
    end
  end else do
    var match = type_of_id(all_types, field_type[0]);
    if (match.spec.tag) do
      return --[ Pk_bytes ]--2;
    end else do
      return --[ Pk_varint ]--[false];
    end
  end
end

function encoding_of_field(all_types, field) do
  var match = field_option(field, "packed");
  var packed;
  if (match ~= undefined) do
    var match$1 = match;
    if (match$1.tag == --[ Constant_bool ]--1) do
      packed = match$1[0];
    end else do
      var field_name$1 = field_name(field);
      throw [
            Compilation_error,
            --[ Invalid_packed_option ]--Block.__(8, [field_name$1])
          ];
    end
  end else do
    packed = false;
  end
  var pk = encoding_info_of_field_type(all_types, field_type(field));
  return --[ tuple ]--[
          pk,
          field_number(field),
          packed,
          field_default(field)
        ];
end

function compile_field_type(field_name, all_types, file_options, field_options, file_name, field_type) do
  var match = find_field_option(field_options, "ocaml_type");
  var ocaml_type;
  if (match ~= undefined) do
    var match$1 = match;
    ocaml_type = match$1.tag == --[ Constant_litteral ]--4 and match$1[0] == "int_t" ? --[ Int_t ]---783406652 : --[ None ]--870530776;
  end else do
    ocaml_type = --[ None ]--870530776;
  end
  var match$2 = file_option(file_options, "int32_type");
  var int32_type;
  if (match$2 ~= undefined) do
    var match$3 = match$2;
    int32_type = match$3.tag == --[ Constant_litteral ]--4 and match$3[0] == "int_t" ? --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int ]--2]) : --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int32 ]--3]);
  end else do
    int32_type = --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int32 ]--3]);
  end
  var match$4 = file_option(file_options, "int64_type");
  var int64_type;
  if (match$4 ~= undefined) do
    var match$5 = match$4;
    int64_type = match$5.tag == --[ Constant_litteral ]--4 and match$5[0] == "int_t" ? --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int ]--2]) : --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int64 ]--4]);
  end else do
    int64_type = --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int64 ]--4]);
  end
  if (typeof field_type == "number") do
    switch (field_type) do
      case --[ Field_type_double ]--0 :
      case --[ Field_type_float ]--1 :
          return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_float ]--1]);
      case --[ Field_type_int32 ]--2 :
      case --[ Field_type_uint32 ]--4 :
      case --[ Field_type_sint32 ]--6 :
      case --[ Field_type_fixed32 ]--8 :
          if (ocaml_type ~= -783406652) do
            return int32_type;
          end else do
            return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int ]--2]);
          end
      case --[ Field_type_int64 ]--3 :
      case --[ Field_type_uint64 ]--5 :
      case --[ Field_type_sint64 ]--7 :
      case --[ Field_type_fixed64 ]--9 :
          if (ocaml_type ~= -783406652) do
            return int64_type;
          end else do
            return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_int ]--2]);
          end
      case --[ Field_type_sfixed32 ]--10 :
          return unsupported_field_type(field_name, "sfixed32", "OCaml", --[ () ]--0);
      case --[ Field_type_sfixed64 ]--11 :
          return unsupported_field_type(field_name, "sfixed64", "OCaml", --[ () ]--0);
      case --[ Field_type_bool ]--12 :
          return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_bool ]--6]);
      case --[ Field_type_string ]--13 :
          return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_string ]--0]);
      case --[ Field_type_bytes ]--14 :
          return --[ Ft_basic_type ]--Block.__(0, [--[ Bt_bytes ]--5]);
      
    end
  end else do
    var all_types$1 = all_types;
    var file_name$1 = file_name;
    var i = field_type[0];
    var module_ = module_of_file_name(file_name$1);
    var t;
    try do
      t = type_of_id(all_types$1, i);
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) do
        throw [
              Compilation_error,
              --[ Programatic_error ]--Block.__(4, [--[ No_type_found_for_id ]--2])
            ];
      end
      throw exn;
    end
    if (is_empty_message(t)) do
      return --[ Ft_unit ]--0;
    end else do
      var udt_nested;
      udt_nested = t.spec.tag ? true : false;
      var field_type_module = module_of_file_name(t.file_name);
      var match$6 = type_scope_of_type(t);
      var udt_type_name = type_name(match$6.message_names, type_name_of_type(t));
      if (field_type_module == module_) do
        return --[ Ft_user_defined_type ]--Block.__(1, [do
                    udt_module: undefined,
                    udt_type_name: udt_type_name,
                    udt_nested: udt_nested
                  end]);
      end else do
        return --[ Ft_user_defined_type ]--Block.__(1, [do
                    udt_module: field_type_module,
                    udt_type_name: udt_type_name,
                    udt_nested: udt_nested
                  end]);
      end
    end
  end
end

function is_mutable(field_name, field_options) do
  var match = find_field_option(field_options, "ocaml_mutable");
  if (match ~= undefined) do
    var match$1 = match;
    if (match$1.tag == --[ Constant_bool ]--1) do
      return match$1[0];
    end else do
      throw [
            Compilation_error,
            --[ Invalid_mutable_option ]--Block.__(11, [field_name])
          ];
    end
  end else do
    return false;
  end
end

function ocaml_container(field_options) do
  var match = find_field_option(field_options, "ocaml_container");
  if (match ~= undefined) do
    var match$1 = match;
    if (match$1.tag == --[ Constant_litteral ]--4) do
      return match$1[0];
    end else do
      return ;
    end
  end
  
end

function variant_of_oneof(include_oneof_name, outer_message_names, all_types, file_options, file_name, oneof_field) do
  var v_constructors = List.map((function (field) do
          var pbtt_field_type = field_type(field);
          var field_type$1 = compile_field_type(field_name(field), all_types, file_options, field_options(field), file_name, pbtt_field_type);
          var match = encoding_of_field(all_types, field);
          var vc_constructor = constructor_name(field_name(field));
          return do
                  vc_constructor: vc_constructor,
                  vc_field_type: typeof field_type$1 == "number" ? --[ Vct_nullary ]--0 : --[ Vct_non_nullary_constructor ]--[field_type$1],
                  vc_encoding_number: match[1],
                  vc_payload_kind: match[0]
                end;
        end), oneof_field.oneof_fields);
  var v_name = include_oneof_name ~= undefined ? type_name(outer_message_names, oneof_field.oneof_name) : type_name(outer_message_names, "");
  return do
          v_name: v_name,
          v_constructors: v_constructors
        end;
end

function compile_enum(file_name, scope, param) do
  var module_ = module_of_file_name(file_name);
  var cv_constructors = List.map((function (param) do
          return --[ tuple ]--[
                  constructor_name(param.enum_value_name),
                  param.enum_value_int
                ];
        end), param.enum_values);
  return do
          module_: module_,
          spec: --[ Const_variant ]--Block.__(2, [do
                cv_name: type_name(scope.message_names, param.enum_name),
                cv_constructors: cv_constructors
              end])
        end;
end

var all_code_gen_001 = --[ :: ]--[
  Codegen_default,
  --[ :: ]--[
    Codegen_decode,
    --[ :: ]--[
      Codegen_encode,
      --[ :: ]--[
        Codegen_pp,
        --[ [] ]--0
      ]
    ]
  ]
];

var all_code_gen = --[ :: ]--[
  Codegen_type,
  all_code_gen_001
];

function compile(proto_definition) do
  var lexbuf = Lexing.from_string(proto_definition);
  var proto;
  try do
    proto = proto_(lexer, lexbuf);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    throw add_loc(from_lexbuf(lexbuf), exn);
  end
  var all_pbtt_msgs = compile_proto_p1("tmp.proto", proto);
  var all_pbtt_msgs$1 = List.map((function (param) do
          var all_types = all_pbtt_msgs;
          var t = param;
          var spec = t.spec;
          var file_options = t.file_options;
          var file_name = t.file_name;
          var id = t.id;
          var scope = t.scope;
          if (spec.tag) do
            return do
                    scope: scope,
                    id: id,
                    file_name: file_name,
                    file_options: file_options,
                    spec: --[ Message ]--Block.__(1, [compile_message_p2(all_types, scope, spec[0])])
                  end;
          end else do
            return do
                    scope: scope,
                    id: id,
                    file_name: file_name,
                    file_options: file_options,
                    spec: spec
                  end;
          end
        end), all_pbtt_msgs);
  var grouped_pbtt_msgs = List.rev(group(all_pbtt_msgs$1));
  var grouped_ocaml_types = List.map((function (pbtt_msgs) do
          return List.map((function (pbtt_msg) do
                        var all_types = all_pbtt_msgs$1;
                        var param = pbtt_msg;
                        var match = param.spec;
                        var file_name = param.file_name;
                        var scope = param.scope;
                        if (match.tag) do
                          var file_options = param.file_options;
                          var all_types$1 = all_types;
                          var file_name$1 = file_name;
                          var scope$1 = scope;
                          var message = match[0];
                          var module_ = module_of_file_name(file_name$1);
                          var message_names = scope$1.message_names;
                          var message_body = message.message_body;
                          var message_name = message.message_name;
                          if (message_body) do
                            var match$1 = message_body[0];
                            switch (match$1.tag | 0) do
                              case --[ Message_oneof_field ]--1 :
                                  if (!message_body[1]) do
                                    var outer_message_names = Pervasives.$at(message_names, --[ :: ]--[
                                          message_name,
                                          --[ [] ]--0
                                        ]);
                                    var variant = variant_of_oneof(undefined, outer_message_names, all_types$1, file_options, file_name$1, match$1[0]);
                                    return --[ :: ]--[
                                            do
                                              module_: module_,
                                              spec: --[ Variant ]--Block.__(1, [variant])
                                            end,
                                            --[ [] ]--0
                                          ];
                                  end
                                  break;
                              case --[ Message_field ]--0 :
                              case --[ Message_map_field ]--2 :
                                  break;
                              
                            end
                          end else do
                            return --[ [] ]--0;
                          end
                          var match$2 = List.fold_left((function (param, param$1) do
                                  var fields = param[1];
                                  var variants = param[0];
                                  switch (param$1.tag | 0) do
                                    case --[ Message_field ]--0 :
                                        var field = param$1[0];
                                        var match = encoding_of_field(all_types$1, field);
                                        var encoding_number = match[1];
                                        var pk = match[0];
                                        var field_name$1 = field_name(field);
                                        var field_options$1 = field_options(field);
                                        var field_type$1 = compile_field_type(field_name$1, all_types$1, file_options, field_options$1, file_name$1, field_type(field));
                                        var field_default$1 = field_default(field);
                                        var mutable_ = is_mutable(field_name$1, field_options$1);
                                        var match$1 = field_label(field);
                                        var record_field_type;
                                        if (match$1 ~= -132092992) do
                                          if (match$1 >= 202657151) do
                                            record_field_type = --[ Rft_required ]--Block.__(0, [--[ tuple ]--[
                                                  field_type$1,
                                                  encoding_number,
                                                  pk,
                                                  field_default$1
                                                ]]);
                                          end else do
                                            var match$2 = ocaml_container(field_options$1);
                                            var repeated_type;
                                            if (match$2 ~= undefined) do
                                              if (match$2 == "repeated_field") do
                                                repeated_type = --[ Rt_repeated_field ]--1;
                                              end else do
                                                throw [
                                                      Caml_builtin_exceptions.failure,
                                                      "Invalid ocaml_container attribute value"
                                                    ];
                                              end
                                            end else do
                                              repeated_type = --[ Rt_list ]--0;
                                            end
                                            record_field_type = --[ Rft_repeated_field ]--Block.__(2, [--[ tuple ]--[
                                                  repeated_type,
                                                  field_type$1,
                                                  encoding_number,
                                                  pk,
                                                  match[2]
                                                ]]);
                                          end
                                        end else do
                                          record_field_type = --[ Rft_optional ]--Block.__(1, [--[ tuple ]--[
                                                field_type$1,
                                                encoding_number,
                                                pk,
                                                field_default$1
                                              ]]);
                                        end
                                        var record_field_rf_label = label_name_of_field_name(field_name$1);
                                        var record_field = do
                                          rf_label: record_field_rf_label,
                                          rf_field_type: record_field_type,
                                          rf_mutable: mutable_
                                        end;
                                        return --[ tuple ]--[
                                                variants,
                                                --[ :: ]--[
                                                  record_field,
                                                  fields
                                                ]
                                              ];
                                    case --[ Message_oneof_field ]--1 :
                                        var field$1 = param$1[0];
                                        var outer_message_names = Pervasives.$at(message_names, --[ :: ]--[
                                              message_name,
                                              --[ [] ]--0
                                            ]);
                                        var variant = variant_of_oneof(--[ () ]--0, outer_message_names, all_types$1, file_options, file_name$1, field$1);
                                        var record_field_rf_label$1 = label_name_of_field_name(field$1.oneof_name);
                                        var record_field_rf_field_type = --[ Rft_variant_field ]--Block.__(4, [variant]);
                                        var record_field$1 = do
                                          rf_label: record_field_rf_label$1,
                                          rf_field_type: record_field_rf_field_type,
                                          rf_mutable: false
                                        end;
                                        var variants_000 = do
                                          module_: module_,
                                          spec: --[ Variant ]--Block.__(1, [variant])
                                        end;
                                        var variants$1 = --[ :: ]--[
                                          variants_000,
                                          variants
                                        ];
                                        var fields$1 = --[ :: ]--[
                                          record_field$1,
                                          fields
                                        ];
                                        return --[ tuple ]--[
                                                variants$1,
                                                fields$1
                                              ];
                                    case --[ Message_map_field ]--2 :
                                        var mf = param$1[0];
                                        var map_options = mf.map_options;
                                        var map_value_type = mf.map_value_type;
                                        var map_key_type = mf.map_key_type;
                                        var map_name = mf.map_name;
                                        var key_type = compile_field_type(Curry._1(Printf.sprintf(--[ Format ]--[
                                                      --[ String_literal ]--Block.__(11, [
                                                          "key of ",
                                                          --[ String ]--Block.__(2, [
                                                              --[ No_padding ]--0,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ]),
                                                      "key of %s"
                                                    ]), map_name), all_types$1, file_options, map_options, file_name$1, map_key_type);
                                        var key_pk = encoding_info_of_field_type(all_types$1, map_key_type);
                                        var key_type$1;
                                        if (typeof key_type == "number") do
                                          throw [
                                                Caml_builtin_exceptions.failure,
                                                "Only Basic Types are supported for map keys"
                                              ];
                                        end else if (key_type.tag) do
                                          throw [
                                                Caml_builtin_exceptions.failure,
                                                "Only Basic Types are supported for map keys"
                                              ];
                                        end else do
                                          key_type$1 = key_type[0];
                                        end
                                        var value_type = compile_field_type(Curry._1(Printf.sprintf(--[ Format ]--[
                                                      --[ String_literal ]--Block.__(11, [
                                                          "value of ",
                                                          --[ String ]--Block.__(2, [
                                                              --[ No_padding ]--0,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ]),
                                                      "value of %s"
                                                    ]), map_name), all_types$1, file_options, map_options, file_name$1, map_value_type);
                                        var value_pk = encoding_info_of_field_type(all_types$1, map_value_type);
                                        var match$3 = ocaml_container(map_options);
                                        var associative_type;
                                        if (match$3 ~= undefined) do
                                          if (match$3 == "hashtbl") do
                                            associative_type = --[ At_hashtable ]--1;
                                          end else do
                                            throw [
                                                  Caml_builtin_exceptions.failure,
                                                  "Invalid ocaml_container attribute value for map"
                                                ];
                                          end
                                        end else do
                                          associative_type = --[ At_list ]--0;
                                        end
                                        var record_field_type$1 = --[ Rft_associative_field ]--Block.__(3, [--[ tuple ]--[
                                              associative_type,
                                              mf.map_number,
                                              --[ tuple ]--[
                                                key_type$1,
                                                key_pk
                                              ],
                                              --[ tuple ]--[
                                                value_type,
                                                value_pk
                                              ]
                                            ]]);
                                        var record_field_rf_label$2 = label_name_of_field_name(map_name);
                                        var record_field_rf_mutable = is_mutable(map_name, map_options);
                                        var record_field$2 = do
                                          rf_label: record_field_rf_label$2,
                                          rf_field_type: record_field_type$1,
                                          rf_mutable: record_field_rf_mutable
                                        end;
                                        return --[ tuple ]--[
                                                variants,
                                                --[ :: ]--[
                                                  record_field$2,
                                                  fields
                                                ]
                                              ];
                                    
                                  end
                                end), --[ tuple ]--[
                                --[ [] ]--0,
                                --[ [] ]--0
                              ], message_body);
                          var record_r_name = type_name(message_names, message_name);
                          var record_r_fields = List.rev(match$2[1]);
                          var record = do
                            r_name: record_r_name,
                            r_fields: record_r_fields
                          end;
                          var type__spec = --[ Record ]--Block.__(0, [record]);
                          var type_ = do
                            module_: module_,
                            spec: type__spec
                          end;
                          return List.rev(--[ :: ]--[
                                      type_,
                                      match$2[0]
                                    ]);
                        end else do
                          return --[ :: ]--[
                                  compile_enum(file_name, scope, match[0]),
                                  --[ [] ]--0
                                ];
                        end
                      end), pbtt_msgs);
        end), grouped_pbtt_msgs);
  var all_ocaml_types = List.flatten(grouped_ocaml_types);
  var otypes = all_ocaml_types;
  var proto_file_name = "tmp.proto";
  var gen = function (otypes, sc, fs) do
    return List.iter((function (param) do
                  var ocamldoc_title = param[1];
                  var f = param[0];
                  if (ocamldoc_title ~= undefined) do
                    line$1(sc, "");
                    line$1(sc, Curry._1(Printf.sprintf(--[ Format ]--[
                                  --[ String_literal ]--Block.__(11, [
                                      "(** {2 ",
                                      --[ String ]--Block.__(2, [
                                          --[ No_padding ]--0,
                                          --[ String_literal ]--Block.__(11, [
                                              "} *)",
                                              --[ End_of_format ]--0
                                            ])
                                        ])
                                    ]),
                                  "(** {2 %s} *)"
                                ]), ocamldoc_title));
                    line$1(sc, "");
                  end
                  return List.iter((function (types) do
                                List.fold_left((function (first, type_) do
                                        var has_encoded = first ? Curry._3(f, undefined, type_, sc) : Curry._3(f, --[ () ]--0, type_, sc);
                                        line$1(sc, "");
                                        if (first) do
                                          return !has_encoded;
                                        end else do
                                          return false;
                                        end
                                      end), true, types);
                                return --[ () ]--0;
                              end), otypes);
                end), fs);
  end;
  var sc = do
    items: --[ [] ]--0
  end;
  line$1(sc, "[@@@ocaml.warning \"-30\"]");
  line$1(sc, "");
  gen(otypes, sc, List.map((function (m) do
              return --[ tuple ]--[
                      m.gen_struct,
                      undefined
                    ];
            end), all_code_gen));
  var struct_string = print(sc);
  var sc$1 = do
    items: --[ [] ]--0
  end;
  line$1(sc$1, Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "(** ",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            " Generated Types and Encoding *)",
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "(** %s Generated Types and Encoding *)"
              ]), Curry._1(Filename.basename, proto_file_name)));
  gen(otypes, sc$1, List.map((function (m) do
              return --[ tuple ]--[
                      m.gen_sig,
                      m.ocamldoc_title
                    ];
            end), all_code_gen));
  var sig_string = print(sc$1);
  return --[ tuple ]--[
          sig_string,
          struct_string
        ];
end

var match = compile("message T {required int32 j = 1; }");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
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

eq("File \"ocaml_protc_test.ml\", line 10, characters 5-12", match[0], "(** tmp.proto Generated Types and Encoding *)\n\n(** {2 Types} *)\n\ntype t = {\n  j : int32;\n}\n\n\n(** {2 Default values} *)\n\nval default_t : \n  ?j:int32 ->\n  unit ->\n  t\n(** [default_t ()] is the default value for type [t] *)\n\n\n(** {2 Protobuf Decoding} *)\n\nval decode_t : Pbrt.Decoder.t -> t\n(** [decode_t decoder] decodes a [t] value from [decoder] *)\n\n\n(** {2 Protobuf Toding} *)\n\nval encode_t : t -> Pbrt.Encoder.t -> unit\n(** [encode_t v encoder] encodes [v] with the given [encoder] *)\n\n\n(** {2 Formatters} *)\n\nval pp_t : Format.formatter -> t -> unit \n(** [pp_t v] formats v] *)\n");

eq("File \"ocaml_protc_test.ml\", line 46, characters 5-12", match[1], "[@@@ocaml.warning \"-30\"]\n\ntype t = {\n  j : int32;\n}\n\nand t_mutable = {\n  mutable j : int32;\n}\n\nlet rec default_t \n  ?j:((j:int32) = 0l)\n  () : t  = {\n  j;\n}\n\nand default_t_mutable () : t_mutable = {\n  j = 0l;\n}\n\nlet rec decode_t d =\n  let v = default_t_mutable () in\n  let rec loop () = \n    match Pbrt.Decoder.key d with\n    | None -> (\n    )\n    | Some (1, Pbrt.Varint) -> (\n      v.j <- Pbrt.Decoder.int32_as_varint d;\n      loop ()\n    )\n    | Some (1, pk) -> raise (\n      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (\"Message(t), field(1)\", pk))\n    )\n    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()\n  in\n  loop ();\n  let v:t = Obj.magic v in\n  v\n\nlet rec encode_t (v:t) encoder = \n  Pbrt.Encoder.key (1, Pbrt.Varint) encoder; \n  Pbrt.Encoder.int32_as_varint v.j encoder;\n  ()\n\nlet rec pp_t fmt (v:t) = \n  let pp_i fmt () =\n    Format.pp_open_vbox fmt 1;\n    Pbrt.Pp.pp_record_field \"j\" Pbrt.Pp.pp_int32 fmt v.j;\n    Format.pp_close_box fmt ()\n  in\n  Pbrt.Pp.pp_brk pp_i fmt ()\n");

Mt.from_pair_suites("Ocaml_proto_test", suites.contents);

--[  Not a pure module ]--
