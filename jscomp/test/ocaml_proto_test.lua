__console = {log = print};

Mt = require "..mt";
Char = require "......lib.js.char";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Bytes = require "......lib.js.bytes";
Curry = require "......lib.js.curry";
Lexing = require "......lib.js.lexing";
Printf = require "......lib.js.printf";
__String = require "......lib.js.string";
Parsing = require "......lib.js.parsing";
Caml_obj = require "......lib.js.caml_obj";
Filename = require "......lib.js.filename";
Printexc = require "......lib.js.printexc";
Caml_bytes = require "......lib.js.caml_bytes";
Pervasives = require "......lib.js.pervasives";
Caml_format = require "......lib.js.caml_format";
Caml_option = require "......lib.js.caml_option";
Caml_string = require "......lib.js.caml_string";
Caml_exceptions = require "......lib.js.caml_exceptions";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function field(optionsOpt, label, number, type_, name) do
  options = optionsOpt ~= nil and optionsOpt or --[[ [] ]]0;
  return {
          field_name = name,
          field_number = number,
          field_label = label,
          field_type = type_,
          field_options = options
        };
end end

function map(map_optionsOpt, number, key_type, value_type, name) do
  map_options = map_optionsOpt ~= nil and map_optionsOpt or --[[ [] ]]0;
  return {
          map_name = name,
          map_number = number,
          map_key_type = key_type,
          map_value_type = value_type,
          map_options = map_options
        };
end end

function oneof_field(optionsOpt, number, type_, name) do
  options = optionsOpt ~= nil and optionsOpt or --[[ [] ]]0;
  return {
          field_name = name,
          field_number = number,
          field_label = --[[ Oneof ]]-978693923,
          field_type = type_,
          field_options = options
        };
end end

message_counter = {
  contents = 0
};

function extension_range_range(from, to_) do
  to__1 = type(to_) == "number" and --[[ To_max ]]0 or --[[ To_number ]]{to_[2]};
  return --[[ Extension_range ]]Block.__(1, {
            from,
            to__1
          });
end end

function message(content, message_name) do
  message_counter.contents = message_counter.contents + 1 | 0;
  return {
          id = message_counter.contents,
          message_name = message_name,
          message_body = content
        };
end end

function __import(__public, file_name) do
  return {
          file_name = file_name,
          public = __public ~= nil
        };
end end

function extend(extend_name, extend_body) do
  message_counter.contents = message_counter.contents + 1 | 0;
  return {
          id = message_counter.contents,
          extend_name = extend_name,
          extend_body = extend_body
        };
end end

function proto(syntax, file_option, __package, __import, message, __enum, proto_1, extend, param) do
  proto_2 = proto_1 ~= nil and proto_1 or ({
        syntax = syntax,
        imports = --[[ [] ]]0,
        file_options = --[[ [] ]]0,
        package = nil,
        messages = --[[ [] ]]0,
        enums = --[[ [] ]]0,
        extends = --[[ [] ]]0
      });
  proto_3 = syntax ~= nil and ({
        syntax = syntax,
        imports = proto_2.imports,
        file_options = proto_2.file_options,
        package = proto_2.__package,
        messages = proto_2.messages,
        enums = proto_2.enums,
        extends = proto_2.__extends
      }) or proto_2;
  proto_4 = __package ~= nil and ({
        syntax = proto_3.syntax,
        imports = proto_3.imports,
        file_options = proto_3.file_options,
        package = __package,
        messages = proto_3.messages,
        enums = proto_3.enums,
        extends = proto_3.__extends
      }) or proto_3;
  proto_5 = message ~= nil and ({
        syntax = proto_4.syntax,
        imports = proto_4.imports,
        file_options = proto_4.file_options,
        package = proto_4.__package,
        messages = --[[ :: ]]{
          message,
          proto_2.messages
        },
        enums = proto_4.enums,
        extends = proto_4.__extends
      }) or proto_4;
  proto_6 = __enum ~= nil and ({
        syntax = proto_5.syntax,
        imports = proto_5.imports,
        file_options = proto_5.file_options,
        package = proto_5.__package,
        messages = proto_5.messages,
        enums = --[[ :: ]]{
          __enum,
          proto_2.enums
        },
        extends = proto_5.__extends
      }) or proto_5;
  proto_7 = __import ~= nil and ({
        syntax = proto_6.syntax,
        imports = --[[ :: ]]{
          __import,
          proto_2.imports
        },
        file_options = proto_6.file_options,
        package = proto_6.__package,
        messages = proto_6.messages,
        enums = proto_6.enums,
        extends = proto_6.__extends
      }) or proto_6;
  proto_8 = file_option ~= nil and ({
        syntax = proto_7.syntax,
        imports = proto_7.imports,
        file_options = --[[ :: ]]{
          file_option,
          proto_2.file_options
        },
        package = proto_7.__package,
        messages = proto_7.messages,
        enums = proto_7.enums,
        extends = proto_7.__extends
      }) or proto_7;
  if (extend ~= nil) then do
    return {
            syntax = proto_8.syntax,
            imports = proto_8.imports,
            file_options = proto_8.file_options,
            package = proto_8.__package,
            messages = proto_8.messages,
            enums = proto_8.enums,
            extends = --[[ :: ]]{
              extend,
              proto_2.__extends
            }
          };
  end else do
    return proto_8;
  end end 
end end

function file_option(file_options, name) do
  x;
  xpcall(function() do
    x = List.assoc(name, file_options);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
  return x;
end end

function rev_split_by_char(c, s) do
  loop = function(i, l) do
    xpcall(function() do
      i_prime = __String.index_from(s, i, c);
      s_prime = __String.sub(s, i, i_prime - i | 0);
      return loop(i_prime + 1 | 0, s_prime == "" and l or --[[ :: ]]{
                    s_prime,
                    l
                  });
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        return --[[ :: ]]{
                __String.sub(s, i, #s - i | 0),
                l
              };
      end else do
        error(exn)
      end end 
    end end)
  end end;
  return loop(0, --[[ [] ]]0);
end end

function pop_last(param) do
  if (param) then do
    tl = param[2];
    if (tl) then do
      return --[[ :: ]]{
              param[1],
              pop_last(tl)
            };
    end else do
      return --[[ [] ]]0;
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Invalid argument [] for pop_last"
    })
  end end 
end end

function apply_until(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      x = Curry._1(f, param[1]);
      if (x ~= nil) then do
        return x;
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function string_of_string_list(l) do
  return Curry._1(Printf.sprintf(--[[ Format ]]{
                  --[[ Char_literal ]]Block.__(12, {
                      --[[ "[" ]]91,
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ "]" ]]93,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "[%s]"
                }), __String.concat(",", l));
end end

function string_fold_lefti(f, e0, s) do
  len = #s;
  _acc = e0;
  _i = 0;
  while(true) do
    i = _i;
    acc = _acc;
    if (i == len) then do
      return acc;
    end else do
      _i = i + 1 | 0;
      _acc = Curry._3(f, acc, i, s.charCodeAt(i));
      ::continue:: ;
    end end 
  end;
end end

function option_default(x, param) do
  if (param ~= nil) then do
    return Caml_option.valFromOption(param);
  end else do
    return x;
  end end 
end end

function from_lexbuf(lexbuf) do
  x = lexbuf.lex_curr_p.pos_fname;
  file_name = x == "" and nil or x;
  line = lexbuf.lex_curr_p.pos_lnum;
  return {
          file_name = file_name,
          line = line
        };
end end

function file_name(param) do
  return param.file_name;
end end

function line(param) do
  return param.line;
end end

function to_string(param) do
  return Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "File ",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ", line ",
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_i ]]3,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ":\n",
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        })
                    }),
                  "File %s, line %i:\n"
                }), option_default("", param.file_name), param.line);
end end

function string_of_programmatic_error(e) do
  tmp;
  local ___conditional___=(e);
  do
     if ___conditional___ == 0--[[ Invalid_string_split ]] then do
        tmp = "string split error"; end else 
     if ___conditional___ == 1--[[ Unexpected_field_type ]] then do
        tmp = "unexpected field type"; end else 
     if ___conditional___ == 2--[[ No_type_found_for_id ]] then do
        tmp = "no type was found for type id"; end else 
     if ___conditional___ == 3--[[ One_of_should_be_inlined_in_message ]] then do
        tmp = "one of variant encoding must be inlined in message"; end else 
     end end end end end end end end
    
  end
  return "Programatic_error" .. tmp;
end end

Compilation_error = Caml_exceptions.create("Ocaml_proto_test.Exception.Compilation_error");

function prepare_error(param) do
  if (type(param) == "number") then do
    return Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "Syntax error",
                    --[[ End_of_format ]]0
                  }),
                "Syntax error"
              });
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Unresolved_type ]] then do
          match = param[1];
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "unresolved type for field name : ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " (type:",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ", in message: ",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ Char_literal ]]Block.__(12, {
                                                      --[[ ")" ]]41,
                                                      --[[ End_of_format ]]0
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "unresolved type for field name : %s (type:%s, in message: %s)"
                        }), match.field_name, match.type_, match.message_name); end end 
       if ___conditional___ == 1--[[ Duplicated_field_number ]] then do
          match_1 = param[1];
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "duplicated field number for field name: ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " (previous field name:",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ", message: ",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ Char_literal ]]Block.__(12, {
                                                      --[[ ")" ]]41,
                                                      --[[ End_of_format ]]0
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "duplicated field number for field name: %s (previous field name:%s, message: %s)"
                        }), match_1.field_name, match_1.previous_field_name, match_1.message_name); end end 
       if ___conditional___ == 2--[[ Invalid_default_value ]] then do
          match_2 = param[1];
          return Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "invalid default value for field name:",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " (info: ",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ ")" ]]41,
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    })
                                })
                            }),
                          "invalid default value for field name:%s (info: %s)"
                        }), option_default("", match_2.field_name), match_2.info); end end 
       if ___conditional___ == 3--[[ Unsupported_field_type ]] then do
          match_3 = param[1];
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "unsupported field type for field name:",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " with type:",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              " in bakend: ",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "unsupported field type for field name:%s with type:%s in bakend: %s"
                        }), option_default("", match_3.field_name), match_3.field_type, match_3.backend_name); end end 
       if ___conditional___ == 4--[[ Programatic_error ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "programmatic error: ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "programmatic error: %s"
                        }), string_of_programmatic_error(param[1])); end end 
       if ___conditional___ == 5--[[ Invalid_import_qualifier ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Invalid import qualified, only 'public' supported",
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "%sInvalid import qualified, only 'public' supported"
                        }), to_string(param[1])); end end 
       if ___conditional___ == 6--[[ Invalid_file_name ]] then do
          return Curry._1(Printf.sprintf(Pervasives._caret_caret(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "Invalid file name: ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          ", ",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "Invalid file name: %s, "
                            }, --[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "format must <name>.proto",
                                  --[[ End_of_format ]]0
                                }),
                              "format must <name>.proto"
                            })), param[1]); end end 
       if ___conditional___ == 7--[[ Import_file_not_found ]] then do
          return Curry._1(Printf.sprintf(Pervasives._caret_caret(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "File: ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          ", ",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "File: %s, "
                            }, --[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "could not be found.",
                                  --[[ End_of_format ]]0
                                }),
                              "could not be found."
                            })), param[1]); end end 
       if ___conditional___ == 8--[[ Invalid_packed_option ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Invalid packed option for field: ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "Invalid packed option for field: %s"
                        }), param[1]); end end 
       if ___conditional___ == 9--[[ Missing_semicolon_for_enum_value ]] then do
          return Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Missing semicolon for enum value: ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "%sMissing semicolon for enum value: %s"
                        }), to_string(param[2]), param[1]); end end 
       if ___conditional___ == 10--[[ Invalid_enum_specification ]] then do
          return Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Missing enum specification (<identifier> = <id>;) for enum value: ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "%sMissing enum specification (<identifier> = <id>;) for enum value: %s"
                        }), to_string(param[2]), param[1]); end end 
       if ___conditional___ == 11--[[ Invalid_mutable_option ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Invalid mutable option for field ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "Invalid mutable option for field %s"
                        }), option_default("", param[1])); end end 
       if ___conditional___ == 12--[[ Missing_one_of_name ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Missing oneof name",
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "%sMissing oneof name"
                        }), to_string(param[1])); end end 
       if ___conditional___ == 13--[[ Invalid_field_label ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Invalid field label. [required|repeated|optional] expected",
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "%sInvalid field label. [required|repeated|optional] expected"
                        }), to_string(param[1])); end end 
       if ___conditional___ == 14--[[ Missing_field_label ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  "Missing field label. [required|repeated|optional] expected",
                                  --[[ End_of_format ]]0
                                })
                            }),
                          "%sMissing field label. [required|repeated|optional] expected"
                        }), to_string(param[1])); end end 
       if ___conditional___ == 15--[[ Parsing_error ]] then do
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "File ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ", line ",
                                      --[[ Int ]]Block.__(4, {
                                          --[[ Int_i ]]3,
                                          --[[ No_padding ]]0,
                                          --[[ No_precision ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ":\n",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "File %s, line %i:\n%s"
                        }), param[1], param[2], param[3]); end end 
      
    end
  end end 
end end

function add_loc(loc, exn) do
  if (exn[1] == Compilation_error) then do
    tmp = exn[2];
    if (type(tmp) ~= "number") then do
      local ___conditional___=(tmp.tag | 0);
      do
         if ___conditional___ == 5--[[ Invalid_import_qualifier ]]
         or ___conditional___ == 9--[[ Missing_semicolon_for_enum_value ]]
         or ___conditional___ == 10--[[ Invalid_enum_specification ]]
         or ___conditional___ == 12--[[ Missing_one_of_name ]]
         or ___conditional___ == 13--[[ Invalid_field_label ]]
         or ___conditional___ == 14--[[ Missing_field_label ]] then do
            return exn; end end 
        
      end
    end
     end 
  end
   end 
  file_name_1 = option_default("", file_name(loc));
  line_1 = line(loc);
  detail = Printexc.to_string(exn);
  return {
          Compilation_error,
          --[[ Parsing_error ]]Block.__(15, {
              file_name_1,
              line_1,
              detail
            })
        };
end end

Printexc.register_printer((function(exn) do
        if (exn[1] == Compilation_error) then do
          return prepare_error(exn[2]);
        end
         end 
      end end));

function invalid_default_value(field_name, info, param) do
  error({
    Compilation_error,
    --[[ Invalid_default_value ]]Block.__(2, {{
          field_name = field_name,
          info = info
        }})
  })
end end

function unsupported_field_type(field_name, field_type, backend_name, param) do
  error({
    Compilation_error,
    --[[ Unsupported_field_type ]]Block.__(3, {{
          field_name = field_name,
          field_type = field_type,
          backend_name = backend_name
        }})
  })
end end

function invalid_enum_specification(enum_name, loc) do
  error({
    Compilation_error,
    --[[ Invalid_enum_specification ]]Block.__(10, {
        enum_name,
        loc
      })
  })
end end

yytransl_const = {
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
};

yytransl_block = {
  260,
  264,
  284,
  285,
  286,
  287,
  0
};

yyact = {
  (function(param) do
      error({
        Caml_builtin_exceptions.failure,
        "parser"
      })
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(_1, nil, nil, nil, nil, nil, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, _1, nil, nil, nil, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, _1, nil, nil, nil, nil, nil, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, _1, nil, nil, nil, nil, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, _1, nil, nil, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, nil, _1, nil, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, nil, nil, nil, _1, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, _1, nil, nil, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, _1, nil, nil, nil, nil, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, _1, nil, nil, nil, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, _1, nil, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, nil, _1, _2, nil, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return proto(nil, nil, nil, nil, nil, nil, _2, _1, --[[ () ]]0);
    end end),
  (function(__caml_parser_env) do
      _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _3;
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 2);
      _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return __import(nil, _2);
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 3);
      _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return __import(--[[ () ]]0, _3);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      error({
        Compilation_error,
        --[[ Invalid_import_qualifier ]]Block.__(5, {_1})
      })
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _2[2];
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return message(_4, _2[2]);
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      return message(--[[ [] ]]0, _2[2]);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              --[[ [] ]]0
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _2
            };
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_field ]]Block.__(0, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_map_field ]]Block.__(1, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_oneof_field ]]Block.__(2, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_sub ]]Block.__(3, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_enum ]]Block.__(4, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      return --[[ Message_extension ]]Block.__(5, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      error({
        Compilation_error,
        --[[ Syntax_error ]]0
      })
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return extend(_2[2], _4);
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      return extend(_2[2], --[[ [] ]]0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              --[[ [] ]]0
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _2
            };
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return _2;
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              --[[ [] ]]0
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _3
            };
    end end),
  (function(__caml_parser_env) do
      return --[[ Extension_single_number ]]Block.__(0, {Parsing.peek_val(__caml_parser_env, 0)});
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      _3 = Parsing.peek_val(__caml_parser_env, 0);
      return extension_range_range(_1, --[[ `Number ]]{
                  -703661335,
                  _3
                });
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      return extension_range_range(_1, --[[ Max ]]3850884);
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 4);
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return {
              oneof_name = _2[2],
              oneof_fields = _4
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      error({
        Compilation_error,
        --[[ Missing_one_of_name ]]Block.__(12, {_1})
      })
    end end),
  (function(__caml_parser_env) do
      return --[[ [] ]]0;
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _2
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 5);
      _2 = Parsing.peek_val(__caml_parser_env, 4);
      _4 = Parsing.peek_val(__caml_parser_env, 2);
      _5 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return oneof_field(_5, _4, _1[2], _2);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 4);
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return oneof_field(nil, _4, _1[2], _2);
    end end),
  (function(__caml_parser_env) do
      _3 = Parsing.peek_val(__caml_parser_env, 7);
      _5 = Parsing.peek_val(__caml_parser_env, 5);
      _7 = Parsing.peek_val(__caml_parser_env, 3);
      _9 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return map(nil, _9, _3[2], _5[2], _7);
    end end),
  (function(__caml_parser_env) do
      _3 = Parsing.peek_val(__caml_parser_env, 8);
      _5 = Parsing.peek_val(__caml_parser_env, 6);
      _7 = Parsing.peek_val(__caml_parser_env, 4);
      _9 = Parsing.peek_val(__caml_parser_env, 2);
      _10 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return map(_10, _9, _3[2], _5[2], _7);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 6);
      _2 = Parsing.peek_val(__caml_parser_env, 5);
      _3 = Parsing.peek_val(__caml_parser_env, 4);
      _5 = Parsing.peek_val(__caml_parser_env, 2);
      _6 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return field(_6, _1, _5, _2[2], _3);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 5);
      _2 = Parsing.peek_val(__caml_parser_env, 4);
      _3 = Parsing.peek_val(__caml_parser_env, 3);
      _5 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return field(nil, _1, _5, _2[2], _3);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 5);
      Parsing.peek_val(__caml_parser_env, 4);
      Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      error({
        Compilation_error,
        --[[ Missing_field_label ]]Block.__(14, {_1[1]})
      })
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 4);
      Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      error({
        Compilation_error,
        --[[ Missing_field_label ]]Block.__(14, {_1[1]})
      })
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0)[2];
    end end),
  (function(__caml_parser_env) do
      return "required";
    end end),
  (function(__caml_parser_env) do
      return "optional";
    end end),
  (function(__caml_parser_env) do
      return "repeated";
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 0);
      return "oneof";
    end end),
  (function(__caml_parser_env) do
      return "enum";
    end end),
  (function(__caml_parser_env) do
      return "package";
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 0);
      return "import";
    end end),
  (function(__caml_parser_env) do
      return "public";
    end end),
  (function(__caml_parser_env) do
      return "option";
    end end),
  (function(__caml_parser_env) do
      return "extensions";
    end end),
  (function(__caml_parser_env) do
      return "extend";
    end end),
  (function(__caml_parser_env) do
      return "syntax";
    end end),
  (function(__caml_parser_env) do
      return "message";
    end end),
  (function(__caml_parser_env) do
      return "to";
    end end),
  (function(__caml_parser_env) do
      return "max";
    end end),
  (function(__caml_parser_env) do
      return "map";
    end end),
  (function(__caml_parser_env) do
      return --[[ Required ]]202657151;
    end end),
  (function(__caml_parser_env) do
      return --[[ Repeated ]]-368609126;
    end end),
  (function(__caml_parser_env) do
      return --[[ Optional ]]-132092992;
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      error({
        Compilation_error,
        --[[ Invalid_field_label ]]Block.__(13, {_1[1]})
      })
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1);
    end end),
  (function(__caml_parser_env) do
      return --[[ [] ]]0;
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              --[[ [] ]]0
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _3
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      _3 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ tuple ]]{
              _1[2],
              _3
            };
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _5 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ tuple ]]{
              _2[2],
              _5
            };
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0)[2];
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 1)[2];
    end end),
  (function(__caml_parser_env) do
      return Parsing.peek_val(__caml_parser_env, 0);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return _1 .. _2[2];
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return --[[ tuple ]]{
              _2,
              _4
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ Constant_int ]]Block.__(2, {_1});
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ Constant_float ]]Block.__(3, {_1});
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      litteral = _1[2];
      local ___conditional___=(litteral);
      do
         if ___conditional___ == "false" then do
            return --[[ Constant_bool ]]Block.__(1, {false}); end end 
         if ___conditional___ == "true" then do
            return --[[ Constant_bool ]]Block.__(1, {true}); end end 
        return --[[ Constant_litteral ]]Block.__(4, {litteral});
          
      end
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ Constant_string ]]Block.__(0, {_1});
    end end),
  (function(__caml_parser_env) do
      _2 = Parsing.peek_val(__caml_parser_env, 3);
      _4 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      enum_valuesOpt = _4;
      enum_name = _2[2];
      enum_values = enum_valuesOpt ~= nil and enum_valuesOpt or --[[ [] ]]0;
      message_counter.contents = message_counter.contents + 1 | 0;
      return {
              enum_id = message_counter.contents,
              enum_name = enum_name,
              enum_values = enum_values
            };
    end end),
  (function(__caml_parser_env) do
      return --[[ [] ]]0;
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      _2 = Parsing.peek_val(__caml_parser_env, 0);
      return --[[ :: ]]{
              _1,
              _2
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 3);
      _3 = Parsing.peek_val(__caml_parser_env, 1);
      Parsing.peek_val(__caml_parser_env, 0);
      return {
              enum_value_name = _1[2],
              enum_value_int = _3
            };
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 2);
      Parsing.peek_val(__caml_parser_env, 0);
      enum_value = _1[2];
      loc = _1[1];
      error({
        Compilation_error,
        --[[ Missing_semicolon_for_enum_value ]]Block.__(9, {
            enum_value,
            loc
          })
      })
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 3);
      Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[2], _1[1]);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[2], _1[1]);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 1);
      return invalid_enum_specification(_1[2], _1[1]);
    end end),
  (function(__caml_parser_env) do
      _1 = Parsing.peek_val(__caml_parser_env, 0);
      return invalid_enum_specification(_1[2], _1[1]);
    end end),
  (function(__caml_parser_env) do
      return --[[ () ]]0;
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 1);
      return --[[ () ]]0;
    end end),
  (function(__caml_parser_env) do
      return --[[ () ]]0;
    end end),
  (function(__caml_parser_env) do
      Parsing.peek_val(__caml_parser_env, 1);
      return --[[ () ]]0;
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end),
  (function(__caml_parser_env) do
      error({
        Parsing.YYexit,
        Parsing.peek_val(__caml_parser_env, 0)
      })
    end end)
};

yytables = {
  actions = yyact,
  transl_const = yytransl_const,
  transl_block = yytransl_block,
  lhs = "\xff\xff\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\b\0\t\0\n\0\x0b\0\f\0\x07\0\x18\0\x18\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x19\0\x13\0\x13\0\x13\0\x1b\0\x12\0\x12\0\x1d\0\x1d\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x17\0\x17\0!\0!\0\x16\0\x15\0\x15\0\"\0\"\0\"\0\x11\0\x11\0#\0#\0$\0$\0 \0 \0\x0e\0\x0e\0\x0e\0\x0e\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0&\0&\0&\0&\0\r\0\r\0'\0'\0(\0(\0*\0*\0+\0+\0\x14\0)\0)\0)\0)\0\x10\0,\0,\0\x0f\0\x0f\0\x0f\0\x0f\0\x0f\0\x0f\0\x1c\0\x1c\0\x1e\0\x1e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  len = "\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x04\0\x03\0\x04\0\x04\0\x03\0\x05\0\x04\0\x01\0\x02\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x05\0\x04\0\x01\0\x02\0\x03\0\x01\0\x03\0\x01\0\x03\0\x03\0\x05\0\x04\0\0\0\x02\0\x06\0\x05\0\n\0\x0b\0\x07\0\x06\0\x06\0\x05\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x03\0\x02\0\x01\0\x03\0\x03\0\x05\0\x01\0\x03\0\x01\0\x02\0\x05\0\x01\0\x01\0\x01\0\x01\0\x05\0\0\0\x02\0\x04\0\x03\0\x04\0\x02\0\x02\0\x01\0\x01\0\x02\0\x01\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0\x02\0",
  defred = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0r\0\0\0R\0T\0S\0\0\0s\0\0\0\0\0\0\0t\0\0\0\0\0u\0\0\0\0\0v\0\0\0\0\0w\0\0\0\0\0\0\0\0\0\0\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0y\0\0\0z\0\0\0\0\0{\0\0\0\0\0\0\0|\0\0\0}\0\0\0W\0\0\0\0\0\0\0\0\0\x01\0B\0C\0D\0E\0N\0F\0G\0H\0I\0J\0K\0L\0M\0O\0P\0Q\0A\0\0\0\x02\0\0\0\0\0l\0k\0\x03\0\0\0\x04\0\0\0\0\0\x05\0\0\0\x06\0\0\0\0\0\0\0\0\0\0\0\\\0^\0\0\0\0\0\0\0\x19\0\x18\0\x15\0\x16\0\x1a\0\f\0\r\0\x17\0\x07\0\b\0\0\0\t\0\0\0\0\0\n\0\x0b\0\0\0\0\0V\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0n\0\0\0\0\0\0\0\0\0\0\0\0\0_\0\0\0\0\x004\x003\x001\0\0\0\0\0d\0a\0b\0c\0Z\0Y\0\0\0\0\0j\0\0\0\0\0\0\0\0\0p\0\0\x008\0\0\0*\0\0\0$\0(\0&\0'\0)\0\0\0\0\0\0\0%\0o\0\0\0\0\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0\0\0\0\0q\0\0\0\0\0\0\0#\0\0\0.\0\0\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  dgoto = "\r\0\x0f\0\x15\0\x19\0\x1c\0\x1f\0\"\0)\x003\x005\x008\0<\0>\0\x10\0\xae\0\xa5\0*\0\xb0\0+\0,\0-\x009\0\xb2\0.\0/\x000\x001\x002\0\x8d\0\xb3\0\xa9\0\xb5\0\xb6\0\xbe\0:\0\x88\0\x89\0W\0\x17\0C\0D\0\x9f\0k\0l\0\xa6\0",
  sindex = "\xd2\0\xf5\xfe\x13\xff\xed\xfe\n\xff\x1e\xff4\xff\x89\xff:\xffF\xff5\xffV\xff[\xff\0\0\x18\xff\0\0b\0\0\0\0\0\0\0\xe1\xff\0\0i\0K\xffB\xff\0\0k\0M\xff\0\0z\0\x06\xff\0\0{\0]\xff\0\0\x7f\0a\xff\xfe\xfe\r\xffd\xffl\xff\0\0\x89\xff\x89\xff\x89\xff\x89\xff\x89\xff\x86\0\xa0\xff\0\0\x89\xff\0\0\x88\0\0\0\x8b\0\x86\xff\0\0\x97\0}\xff5\xff\0\0\x9a\0\0\0\x9c\0\0\0~\xff\x97\xff\x9f\xff\x96\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9a\xff\0\0\xe1\xff\x98\xff\0\0\0\0\0\0\xa4\xff\0\0\x9c\xff\xa7\xff\0\0\xaa\xff\0\0\xa5\xff\xa2\xff\xa5\xff\xb3\xff\xa1\xff\0\0\0\0\x05\xff\xbf\xff\xc3\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xfe\0\x005\xff\xa5\xff\0\0\0\0\xcb\xff9\xff\0\0\x1f\xff\xda\xff\xdf\xff,\xff\xed\xfe\xe1\xff\xe8\xff\x9c\xff\x9c\xffI\xff\0\0\xe2\xff\xa5\xff\xe2\xff\xa5\xff\xe6\xff9\xff\0\0\x10\xff\xa5\xff\0\0\0\0\0\0\xe2\xff\xe4\xff\0\0\0\0\0\0\0\0\0\0\0\0)\xff\xed\xff\0\0\xe2\xff\xed\xfe\xe8\xff\xe5\xff\0\0\xf5\xff\0\0\xe8\xff\0\0\xe7\xff\0\0\0\0\0\0\0\0\0\0\xe8\xff\xf5\xff\xc2\xff\0\0\0\0\xe2\xff\xe2\xff\0\0\xa5\xff\x13\xff\xf5\xff\xe8\xff\xe2\xff9\xff\xa5\xff\xe2\xff)\xff\0\0\xf5\xff\xf3\xff\0\0\xf5\xff\xf4\xff\xf5\xff\0\0\xe2\xff\0\0\xf5\xff\0\0\xe2\xff\xa5\xff\xe2\xff)\xff\xf9\xff\xe2\xff\xa5\xff\xe2\xff\xf6\xff\xe2\xff\x13\0\xe1\xff\xfd\xff\x0e\0)\xff\xa5\xff\xe2\xff\xe2\xff",
  rindex = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0,\x01<\x01F\x01G\x01H\x01\0\0\0\0\0\0N\x01\0\0\0\0\0\0\0\0\x0b\0\0\0\0\0\x0f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0I\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0:\0L\0\0\0\0\0I\0I\0\0\0\0\0e\0\0\0w\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0?\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0L\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0N\0\0\0\0\0\x89\0\x9b\0\0\0\0\0O\0\xad\0\0\0\xc4\xff\0\0\0\0c\0\0\0\0\0\x17\0\0\0\0\0u\0\0\0-\0\0\0\xb8\0\0\0\xc1\0\0\0\x87\0\0\0\x99\0\0\0\0\0\xab\0\0\0\xfc\xfe\0\0\b\xff\0\0\0\0\0\0\0\0\0\0\0\0m\xff\x9e\xff",
  gindex = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\xff\xfe\xff\xbe\x01\xff\xff\xc7\x01\x02\0\xbb\x01\xc6\x01\xca\xff\xc5\x01\xc8\x01\xc8\0\0\0\xa1\x01\0\0\xa3\xff\x1d\x01\x95\xff\0\0\0\0\x17\x01\0\0\xd6\xff\0\0\xa9\xff\0\0S\x01\0\0t\xff\0\0\0\x001\x01",
  tablesize = 470,
  table = "\x16\0!\0\x84\0\x1d\0\xc1\0|\0\xbb\0f\0#\0\x0e\0\x8f\x002\0\x18\0:\0\x96\x000\0\x1b\0\x11\0\x12\0\x13\0\x11\0\x12\0\x13\0e\0`\x009\0g\0:\0\x97\0h\0\x92\0\x99\0\xb4\0\xa8\0\x1e\0i\0\x93\0a\0\xd1\x009\0\xa4\0\xbd\0m\0@\0j\0 \0A\0\x14\0\xa7\0\xb8\0\x14\0\xb9\0\xcf\0A\0\xd6\0B\0\xbf\0!\0i\0\xc5\0h\0\x0e\0B\0/\0\xc8\0\xdf\0%\0\x8c\0\xc2\0\x98\0\x8c\0\xa3\0\xca\0\xac\0\x11\0\x12\0\x13\0\x1e\0!\0\x1b\0&\x006\x007\0\xce\0;\0\x9b\0\x9c\0\x9d\0\x9e\0\xad\0\xa8\0Z\0[\0\\\0\xcc\0\xaa\0\xab\0;\0E\0@\0\xd0\0\x1f\0\xd2\0'\0\x14\0X\0Y\0]\0^\0;\0;\0;\0;\0;\0;\0;\0\xd5\x005\0\xd7\0\x1c\0;\0\xd9\0_\0b\0c\0;\0;\0d\0e\0\xe0\0\xe1\0m\0\xdc\0n\0t\0?\0w\0\x1d\0\xaf\0x\0;\0\xb1\0!\0\x1b\0$\0%\0\xbc\0&\0y\0'\0(\0z\0{\0>\0}\0\x1e\0~\0\x7f\0<\0<\0<\0<\0<\0<\0<\0!\0\x1b\0$\0%\0<\0&\0=\0'\0,\0<\0<\0\x80\0\x82\0\x81\0\x83\0\xaf\0\x85\0\x86\0\xb1\0`\0\x8a\0\xbc\0\x87\0\x8b\0<\0\x8e\0\x8c\0\x91\0+\0\xac\0\x11\0\x12\0\x13\0\x1e\0!\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0;\0\x1b\0\x90\0\x1b\0\x94\0\xad\0\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\x07\0\b\0\t\0\n\0\x0b\0\f\0\x95\0\x9a\0\x14\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R\0S\0T\0U\0o\0p\0q\0r\0s\0\xa1\0\xa2\0\xa8\0v\0\xba\0\xb7\0\xc0\0\xc6\0\xc9\0V\0!\0!\0!\0!\0!\0!\0!\0!\0!\0\xc3\0!\0!\0!\0!\0\xc7\0\xd3\0!\0!\0\xd4\0\xd8\0\xda\0\xdd\0e\0e\0e\0e\0e\0e\0e\0e\0e\0!\0e\0e\0e\0e\x002\x002\0e\0e\x000\0\xdb\0\xde\0\x13\0 \0 \0 \0 \0 \0 \0 \0 \0 \0e\0 \0 \0 \0 \0m\0\x12\0 \0 \0/\0/\0/\0/\0/\0/\0/\0\x0f\0\x10\0\x14\0m\0/\0i\0 \0h\0\x11\0/\0/\x006\x006\x006\x006\x006\x006\x006\0X\0i\x007\0h\x006\0f\0/\0\"\0-\x006\x006\0@\0@\0@\0@\0@\0@\0@\0\x1f\0\x1f\0\x1f\0\x1f\0@\0\x1f\x006\0\x1f\0\x1f\0@\0@\x005\x005\x005\x005\x005\x005\x005\0\x1c\0\x1c\0\x1c\0\x1c\x005\0\x1c\0@\0\x1c\0\x1c\x005\x005\0?\0?\0?\0?\0?\0?\0?\0\x1d\0\x1d\0\x1d\0\x1d\0?\0\x1d\x005\0\x1d\0\x1d\0?\0?\0>\0>\0>\0>\0>\0>\0>\0\x1e\0\x1e\0\x1e\0\x1e\0>\0\x1e\0?\0\x1e\0\x1e\0>\0>\0=\0=\0=\0=\0=\0=\0=\0,\0,\0,\0,\0=\0,\0>\0,\0,\0=\0=\0`\0`\0`\0`\0\x1a\0`\x004\0`\0`\0+\0+\0+\0+\0=\0+\0 \0+\0+\x006\0=\0u\0\xcb\0\xcd\0?\0\xa0\0\xc4\0",
  check = "\x02\0\0\0Y\0\x04\0\xa1\0;\0\x92\0\t\x01\x06\0\x14\x01g\0\0\0\x1f\x01\x11\x01\x0f\x01\0\0\x06\x01\x01\x01\x02\x01\x03\x01\x01\x01\x02\x01\x03\x01\0\0\x12\x01\x11\x01\x1c\x01\x1f\x01\x1d\x01\x1f\x01\x19\x01|\0\x8b\0\x11\x01\x04\x01\x16\x01\x1f\x01\x1f\x01\xc3\0\x1f\x01\x85\0\x94\0\0\0\x13\x01\x1f\x01\0\0\x16\x01\x1f\x01\x87\0\x8e\0\x1f\x01\x90\0\xc0\0\x16\x01\xd3\0\x1f\x01\x95\0\x05\x01\0\0\xa6\0\0\0\x14\x01\x1f\x01\0\0\xab\0\xde\0\b\x01\x1a\x01\xa1\0{\0\x1a\x01\x1b\x01\xb3\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\n\x01\0\0\x1d\x01\xbe\0\x0b\x01\x1c\x01\x1d\x01\x1e\x01\x1f\x01\x10\x01\x11\x01\x19\x01\x1a\x01\x1b\x01\xbb\0\x89\0\x8a\0\x0b\x01\0\0\0\0\xc1\0\0\0\xc3\0\f\x01\x1f\x01\0\0\x1f\x01\0\0\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\xd1\0\0\0\xd3\0\0\0\x0b\x01\xd6\0\0\0\0\0\x1f\x01\x10\x01\x11\x01\0\0\x1f\x01\xde\0\xdf\0\x1f\x01\xdb\0\x19\x01\0\0\0\0\0\0\0\0\x8b\0\0\0\x1f\x01\x8b\0\x05\x01\x06\x01\x07\x01\b\x01\x94\0\n\x01\x0e\x01\f\x01\r\x01\0\0\x1b\x01\0\0\0\0\0\0\0\0\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\0\0\f\x01\0\0\x10\x01\x11\x01\x19\x01\x1b\x01\x13\x01\x19\x01\xb5\0\x1d\x01\x12\x01\xb5\0\0\0\x12\x01\xbc\0\x1f\x01\x12\x01\x1f\x01\x1c\x01\x1a\x01\x1f\x01\0\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1c\x01\f\x01\x12\x01\x10\x01\x01\0\x02\0\x03\0\x04\0\x05\0\x06\0\x07\0\b\0\t\0\n\0\x0b\0\f\0\x1c\x01\x15\x01\x1f\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\t\x01\n\x01\x0b\x01\f\x01\r\x01\x0e\x01\x0f\x01\x10\x01*\0+\0,\0-\0.\0\x1d\x01\x19\x01\x11\x012\0\x15\x01\x1a\x01\x19\x01\x19\x01\x18\x01\x1f\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1d\x01\n\x01\x0b\x01\f\x01\r\x01\x1a\x01\x1d\x01\x10\x01\x11\x01\x1f\x01\x1b\x01\x1f\x01\x19\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x0b\x01\f\x01\r\x01\x1a\x01\x1b\x01\x10\x01\x11\x01\x1a\x01\x17\x01\x1d\x01\0\0\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x0b\x01\f\x01\r\x01\x11\x01\0\0\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\0\0\0\0\0\0\x1f\x01\x0b\x01\x11\x01\x1f\x01\x11\x01\0\0\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x13\x01\x1f\x01\x11\x01\x1f\x01\x0b\x01\x11\x01\x1f\x01\x11\x01\x11\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\0\x01\x01\x01\x02\x01\x03\x01\x04\x01\x05\x01\x06\x01\x05\x01\x06\x01\x07\x01\b\x01\x0b\x01\n\x01\x1f\x01\f\x01\r\x01\x10\x01\x11\x01\x05\x01\x06\x01\x07\x01\b\x01\x03\0\n\x01\b\0\f\x01\r\x01\x05\x01\x06\x01\x07\x01\b\x01\x1f\x01\n\x01\x05\0\f\x01\r\x01\t\0\x0b\x000\0\xb5\0\xbc\0\f\0\x82\0\xa5\0",
  error_function = Parsing.parse_error,
  names_const = "REQUIRED\0OPTIONAL\0REPEATED\0MESSAGE\0ENUM\0PACKAGE\0PUBLIC\0OPTION\0EXTENSIONS\0EXTEND\0SYNTAX\0TO\0MAX\0MAP\0RBRACE\0LBRACE\0RBRACKET\0LBRACKET\0RPAREN\0LPAREN\0RANGLEB\0LANGLEB\0EQUAL\0SEMICOLON\0COMMA\0EOF\0",
  names_block = "ONE_OF\0IMPORT\0STRING\0INT\0FLOAT\0IDENT\0"
};

function proto_(lexfun, lexbuf) do
  return Parsing.yyparse(yytables, 7, lexfun, lexbuf);
end end

function update_loc(lexbuf) do
  pos = lexbuf.lex_curr_p;
  lexbuf.lex_curr_p = {
    pos_fname = pos.pos_fname,
    pos_lnum = pos.pos_lnum + 1 | 0,
    pos_bol = pos.pos_cnum,
    pos_cnum = pos.pos_cnum
  };
  return --[[ () ]]0;
end end

__ocaml_lex_tables = {
  lex_base = "\0\0\xea\xff\xeb\xffN\0\xed\xff\xee\xff\x01\0\xa0\0\xf0\0;\x01\x88\x01\x9e\x01\xf2\xff\x10\0\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xf9\xff\xfa\xff\xfb\xff\xfc\xff\xfd\xff\xfe\xff\xff\xff\xf3\xff\xf4\xff\x1a\0\xbe\x01\xc8\x01\x92\x01\xa8\x01#\0\xef\xff\xed\x01:\x02\x87\x02\xd4\x02!\x03n\x03\x05\0\x12\x01\xfd\xff\xfe\xff\xff\xff\x06\0\x07\0!\x01\xfc\xff\xfd\xff\x11\0\xff\xff\x0b\0\f\0\xfe\xff\xc2\x01\xfc\xff\xfd\xff\xfe\xff\xc9\x03\xff\xff",
  lex_backtrk = "\x0f\0\xff\xff\xff\xff\x13\0\xff\xff\xff\xff\x15\0\x13\0\x13\0\x0f\0\x0e\0\x0f\0\xff\xff\x15\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0f\0\x0f\0\xff\xff\xff\xff\xff\xff\xff\xff\x13\0\x0f\0\x13\0\x13\0\x10\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\x02\0\xff\xff\x02\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x02\0\xff\xff",
  lex_default = "\x01\0\0\0\0\0\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff+\0\0\0\0\0\0\0\xff\xff\xff\xff1\0\0\0\0\0\xff\xff\0\0\xff\xff\xff\xff\0\x009\0\0\0\0\0\0\0\xff\xff\0\0",
  lex_trans = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\x05\0\x05\0\x04\0\x06\0(\0\x05\0,\0,\0(\0.\0.\x003\x003\0\0\x005\x005\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\x13\0\x14\0\0\0\x0b\0\x0e\0\x0b\0\t\0\r\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x19\0\x0f\0\x12\0\x10\0\x11\0\x1a\x006\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x16\0\0\0\x15\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x07\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x18\0\"\0\x17\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0 \0!\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\"\0\0\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\x02\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0&\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\x1f\0,\0\x1f\0\"\0-\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\0\x003\0\0\0\0\x004\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\x002\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x03\0\x03\0\x03\0\b\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x1d\0\0\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1d\0\x1c\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\0\0\x1c\0:\0\0\0\0\0\0\0\0\0\x1f\0\0\0\x1f\0\0\0\x1c\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\0\0\x1c\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\0\0\0\0\0\0*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"\0\0\0\0\0;\0\0\0\0\x000\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1c\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0\0\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\0\x008\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\x03\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\0\0\0\0\0\0\0\0%\0\0\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0'\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\"\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\0\0\0\0\0\0\0\0#\0\0\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0<\0\0\0<\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<\0\0\0\0\0\0\0<\0\0\0<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_check = "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\x06\0\0\0\0\0\x06\0(\0-\0.\0(\0-\0.\x004\x005\0\xff\xff4\x005\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0\0\0\0\r\x002\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x1b\0 \0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\xff\xff\xff\xff\xff\xff\xff\xff\x03\0\xff\xff\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\x03\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\xff\xff\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\xff\xff\xff\xff\xff\xff\xff\xff\x07\0\0\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\x07\0\b\0)\0\b\0\b\0)\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\xff\xff/\0\xff\xff\xff\xff/\0\xff\xff\xff\xff\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0/\0\xff\xff\xff\xff\xff\xff\b\0\xff\xff\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\b\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\n\0\xff\xff\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\n\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x1e\0\x0b\0\n\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\x1f\0\xff\xff\x0b\x007\0\xff\xff\xff\xff\xff\xff\xff\xff\x1c\0\xff\xff\x1c\0\xff\xff\n\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\xff\xff\x0b\0\xff\xff\xff\xff\xff\xff\x0b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1d\0\xff\xff\xff\xff\xff\xff\xff\xff)\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\"\0\xff\xff\xff\xff7\0\xff\xff\xff\xff/\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1d\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0\"\0#\0\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0\xff\xff\xff\xff\xff\xff\xff\xff#\0\xff\xff#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0#\0$\0\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\xff\xff7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0\xff\xff\xff\xff\xff\xff\xff\xff$\0\xff\xff$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0$\0%\0\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0\xff\xff\xff\xff\xff\xff\xff\xff%\0\xff\xff%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0%\0&\0\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0\xff\xff\xff\xff\xff\xff\xff\xff&\0\xff\xff&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0'\0\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0\xff\xff\xff\xff\xff\xff\xff\xff'\0\xff\xff'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0'\0;\0\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff;\0\xff\xff\xff\xff\xff\xff;\0\xff\xff;\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_base_code = "",
  lex_backtrk_code = "",
  lex_default_code = "",
  lex_trans_code = "",
  lex_check_code = "",
  lex_code = ""
};

function __ocaml_lex_string_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    l = _l;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          c = Lexing.lexeme_char(lexbuf, 1);
          ___ocaml_lex_state = 55;
          _l = --[[ :: ]]{
            Char.escaped(c),
            l
          };
          ::continue:: ; end end 
       if ___conditional___ == 1 then do
          return --[[ String_value ]]{__String.concat("", List.rev(l))}; end end 
       if ___conditional___ == 2 then do
          ___ocaml_lex_state = 55;
          _l = --[[ :: ]]{
            Lexing.lexeme(lexbuf),
            l
          };
          ::continue:: ; end end 
       if ___conditional___ == 3 then do
          return --[[ String_eof ]]0; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function __ocaml_lex_comment_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    l = _l;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          update_loc(lexbuf);
          return --[[ Comment_value ]]{__String.concat("", List.rev(l))}; end end 
       if ___conditional___ == 1 then do
          ___ocaml_lex_state = 41;
          _l = --[[ :: ]]{
            Lexing.lexeme(lexbuf),
            l
          };
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          return --[[ Comment_eof ]]0; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function __ocaml_lex_multi_line_comment_rec(_l, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    l = _l;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          update_loc(lexbuf);
          ___ocaml_lex_state = 47;
          ::continue:: ; end end 
       if ___conditional___ == 1 then do
          Lexing.lexeme(lexbuf);
          return --[[ Comment_value ]]{__String.concat("", List.rev(l))}; end end 
       if ___conditional___ == 2 then do
          ___ocaml_lex_state = 47;
          _l = --[[ :: ]]{
            Lexing.lexeme(lexbuf),
            l
          };
          ::continue:: ; end end 
       if ___conditional___ == 3 then do
          return --[[ Comment_eof ]]0; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function lexer(lexbuf) do
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 0;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return --[[ LBRACE ]]15; end end 
       if ___conditional___ == 1 then do
          return --[[ RBRACE ]]14; end end 
       if ___conditional___ == 2 then do
          return --[[ LBRACKET ]]17; end end 
       if ___conditional___ == 3 then do
          return --[[ RBRACKET ]]16; end end 
       if ___conditional___ == 4 then do
          return --[[ RPAREN ]]18; end end 
       if ___conditional___ == 5 then do
          return --[[ LPAREN ]]19; end end 
       if ___conditional___ == 6 then do
          return --[[ LANGLEB ]]21; end end 
       if ___conditional___ == 7 then do
          return --[[ RANGLEB ]]20; end end 
       if ___conditional___ == 8 then do
          return --[[ EQUAL ]]22; end end 
       if ___conditional___ == 9 then do
          return --[[ SEMICOLON ]]23; end end 
       if ___conditional___ == 10 then do
          return --[[ COMMA ]]24; end end 
       if ___conditional___ == 11 then do
          match = __ocaml_lex_comment_rec(--[[ [] ]]0, lexbuf_1, 41);
          if (match) then do
            ___ocaml_lex_state = 0;
            ::continue:: ;
          end else do
            return --[[ EOF ]]25;
          end end  end end 
       if ___conditional___ == 12 then do
          match_1 = __ocaml_lex_multi_line_comment_rec(--[[ [] ]]0, lexbuf_1, 47);
          if (match_1) then do
            ___ocaml_lex_state = 0;
            ::continue:: ;
          end else do
            return --[[ EOF ]]25;
          end end  end end 
       if ___conditional___ == 13 then do
          match_2 = __ocaml_lex_string_rec(--[[ [] ]]0, lexbuf_1, 55);
          if (match_2) then do
            return --[[ STRING ]]Block.__(2, {match_2[1]});
          end else do
            return --[[ EOF ]]25;
          end end  end end 
       if ___conditional___ == 14 then do
          return --[[ INT ]]Block.__(3, {Caml_format.caml_int_of_string(Lexing.lexeme(lexbuf_1))}); end end 
       if ___conditional___ == 15 then do
          return --[[ FLOAT ]]Block.__(4, {Caml_format.caml_float_of_string(Lexing.lexeme(lexbuf_1))}); end end 
       if ___conditional___ == 16 then do
          return --[[ FLOAT ]]Block.__(4, {__Number.__NaN}); end end 
       if ___conditional___ == 17 then do
          update_loc(lexbuf_1);
          ___ocaml_lex_state = 0;
          ::continue:: ; end end 
       if ___conditional___ == 18 then do
          ___ocaml_lex_state = 0;
          ::continue:: ; end end 
       if ___conditional___ == 19 then do
          loc = from_lexbuf(lexbuf_1);
          ident = Lexing.lexeme(lexbuf_1);
          local ___conditional___=(ident);
          do
             if ___conditional___ == "enum" then do
                return --[[ ENUM ]]4; end end 
             if ___conditional___ == "extend" then do
                return --[[ EXTEND ]]9; end end 
             if ___conditional___ == "extensions" then do
                return --[[ EXTENSIONS ]]8; end end 
             if ___conditional___ == "import" then do
                return --[[ IMPORT ]]Block.__(1, {loc}); end end 
             if ___conditional___ == "map" then do
                return --[[ MAP ]]13; end end 
             if ___conditional___ == "max" then do
                return --[[ MAX ]]12; end end 
             if ___conditional___ == "message" then do
                return --[[ MESSAGE ]]3; end end 
             if ___conditional___ == "oneof" then do
                return --[[ ONE_OF ]]Block.__(0, {loc}); end end 
             if ___conditional___ == "option" then do
                return --[[ OPTION ]]7; end end 
             if ___conditional___ == "optional" then do
                return --[[ OPTIONAL ]]1; end end 
             if ___conditional___ == "package" then do
                return --[[ PACKAGE ]]5; end end 
             if ___conditional___ == "public" then do
                return --[[ PUBLIC ]]6; end end 
             if ___conditional___ == "repeated" then do
                return --[[ REPEATED ]]2; end end 
             if ___conditional___ == "required" then do
                return --[[ REQUIRED ]]0; end end 
             if ___conditional___ == "syntax" then do
                return --[[ SYNTAX ]]10; end end 
             if ___conditional___ == "to" then do
                return --[[ TO ]]11; end end 
            return --[[ IDENT ]]Block.__(5, {--[[ tuple ]]{
                          loc,
                          ident
                        }});
              
          end end end 
       if ___conditional___ == 20 then do
          return --[[ EOF ]]25; end end 
       if ___conditional___ == 21 then do
          s = Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "Unknown character found ",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ End_of_format ]]0
                          })
                      }),
                    "Unknown character found %s"
                  }), Lexing.lexeme(lexbuf_1));
          error({
            Caml_builtin_exceptions.failure,
            s
          }) end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function let_decl_of_and(param) do
  if (param ~= nil) then do
    return "and";
  end else do
    return "let rec";
  end end 
end end

function string_of_basic_type(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == 0--[[ Bt_string ]] then do
        return "string"; end end 
     if ___conditional___ == 1--[[ Bt_float ]] then do
        return "float"; end end 
     if ___conditional___ == 2--[[ Bt_int ]] then do
        return "int"; end end 
     if ___conditional___ == 3--[[ Bt_int32 ]] then do
        return "int32"; end end 
     if ___conditional___ == 4--[[ Bt_int64 ]] then do
        return "int64"; end end 
     if ___conditional___ == 5--[[ Bt_bytes ]] then do
        return "bytes"; end end 
     if ___conditional___ == 6--[[ Bt_bool ]] then do
        return "bool"; end end 
    
  end
end end

function string_of_field_type(param) do
  if (type(param) == "number") then do
    return "unit";
  end else if (param.tag) then do
    param_1 = param[1];
    match = param_1.udt_module;
    if (match ~= nil) then do
      return match .. ("." .. param_1.udt_type_name);
    end else do
      return param_1.udt_type_name;
    end end 
  end else do
    return string_of_basic_type(param[1]);
  end end  end 
end end

function string_of_record_field_type(param) do
  local ___conditional___=(param.tag | 0);
  do
     if ___conditional___ == 0--[[ Rft_required ]] then do
        return string_of_field_type(param[1][1]); end end 
     if ___conditional___ == 1--[[ Rft_optional ]] then do
        return string_of_field_type(param[1][1]) .. " option"; end end 
     if ___conditional___ == 2--[[ Rft_repeated_field ]] then do
        match = param[1];
        return string_of_field_type(match[2]) .. (" " .. (
                  match[1] and "Pbrt.Repeated_field.t" or "list"
                )); end end 
     if ___conditional___ == 3--[[ Rft_associative_field ]] then do
        match_1 = param[1];
        if (match_1[1]) then do
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ "(" ]]40,
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ", ",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ") ",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "(%s, %s) %s"
                        }), string_of_basic_type(match_1[3][1]), string_of_field_type(match_1[4][1]), "Hashtbl.t");
        end else do
          return Curry._3(Printf.sprintf(--[[ Format ]]{
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ "(" ]]40,
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " * ",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ") ",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "(%s * %s) %s"
                        }), string_of_basic_type(match_1[3][1]), string_of_field_type(match_1[4][1]), "list");
        end end  end end 
     if ___conditional___ == 4--[[ Rft_variant_field ]] then do
        return param[1].v_name; end end 
    
  end
end end

function function_name_of_user_defined(prefix, param) do
  match = param.udt_module;
  if (match ~= nil) then do
    return Curry._3(Printf.sprintf(--[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "." ]]46,
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ Char_literal ]]Block.__(12, {
                                    --[[ "_" ]]95,
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      }),
                    "%s.%s_%s"
                  }), match, prefix, param.udt_type_name);
  end else do
    return Curry._2(Printf.sprintf(--[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "_" ]]95,
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "%s_%s"
                  }), prefix, param.udt_type_name);
  end end 
end end

function string_of_payload_kind(capitalize, payload_kind, packed) do
  s;
  if (type(payload_kind) == "number") then do
    local ___conditional___=(payload_kind);
    do
       if ___conditional___ == 0--[[ Pk_bits32 ]] then do
          s = packed and "bytes" or "bits32"; end else 
       if ___conditional___ == 1--[[ Pk_bits64 ]] then do
          s = packed and "bytes" or "bits64"; end else 
       if ___conditional___ == 2--[[ Pk_bytes ]] then do
          s = "bytes"; end else 
       end end end end end end
      
    end
  end else do
    s = packed and "bytes" or "varint";
  end end 
  if (capitalize ~= nil) then do
    return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
  end else do
    return s;
  end end 
end end

function line_1(scope, s) do
  scope.items = --[[ :: ]]{
    --[[ Line ]]Block.__(0, {s}),
    scope.items
  };
  return --[[ () ]]0;
end end

function scope(scope_1, f) do
  sub_scope = {
    items = --[[ [] ]]0
  };
  Curry._1(f, sub_scope);
  scope_1.items = --[[ :: ]]{
    --[[ Scope ]]Block.__(1, {sub_scope}),
    scope_1.items
  };
  return --[[ () ]]0;
end end

function indentation_prefix(n) do
  local ___conditional___=(n);
  do
     if ___conditional___ == 0 then do
        return ""; end end 
     if ___conditional___ == 1 then do
        return "  "; end end 
     if ___conditional___ == 2 then do
        return "    "; end end 
     if ___conditional___ == 3 then do
        return "      "; end end 
     if ___conditional___ == 4 then do
        return "        "; end end 
     if ___conditional___ == 5 then do
        return "          "; end end 
     if ___conditional___ == 6 then do
        return "            "; end end 
     if ___conditional___ == 7 then do
        return "              "; end end 
     if ___conditional___ == 8 then do
        return "                "; end end 
    return Caml_bytes.bytes_to_string(Bytes.make(n, --[[ " " ]]32));
      
  end
end end

function print(scope) do
  loop = function(_acc, i, _param) do
    while(true) do
      param = _param;
      acc = _acc;
      if (param) then do
        match = param[1];
        if (match.tag) then do
          items = match[1].items;
          sub = loop(--[[ [] ]]0, i + 1 | 0, items);
          _param = param[2];
          _acc = Pervasives._at(sub, acc);
          ::continue:: ;
        end else do
          _param = param[2];
          _acc = --[[ :: ]]{
            indentation_prefix(i) .. match[1],
            acc
          };
          ::continue:: ;
        end end 
      end else do
        return acc;
      end end 
    end;
  end end;
  return __String.concat("\n", loop(--[[ [] ]]0, 0, scope.items));
end end

function runtime_function(param) do
  match = param[1];
  if (match ~= 427938126) then do
    if (match ~= 779642422) then do
      error({
        Caml_builtin_exceptions.failure,
        "Invalid encoding/OCaml type combination"
      })
    end
     end 
    match_1 = param[2];
    if (type(match_1) == "number") then do
      local ___conditional___=(match_1);
      do
         if ___conditional___ == 0--[[ Pk_bits32 ]] then do
            local ___conditional___=(param[3]);
            do
               if ___conditional___ == 1--[[ Bt_float ]] then do
                  return "Pbrt.Encoder.float_as_bits32"; end end 
               if ___conditional___ == 2--[[ Bt_int ]] then do
                  return "Pbrt.Encoder.int_as_bits32"; end end 
               if ___conditional___ == 3--[[ Bt_int32 ]] then do
                  return "Pbrt.Encoder.int32_as_bits32"; end end 
               if ___conditional___ == 0--[[ Bt_string ]]
               or ___conditional___ == 4--[[ Bt_int64 ]]
               or ___conditional___ == 5--[[ Bt_bytes ]]
               or ___conditional___ == 6--[[ Bt_bool ]] then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Invalid encoding/OCaml type combination"
                  }) end end 
              
            end end end 
         if ___conditional___ == 1--[[ Pk_bits64 ]] then do
            local ___conditional___=(param[3]);
            do
               if ___conditional___ == 1--[[ Bt_float ]] then do
                  return "Pbrt.Encoder.float_as_bits64"; end end 
               if ___conditional___ == 2--[[ Bt_int ]] then do
                  return "Pbrt.Encoder.int_as_bits64"; end end 
               if ___conditional___ == 4--[[ Bt_int64 ]] then do
                  return "Pbrt.Encoder.int64_as_bits64"; end end 
               if ___conditional___ == 0--[[ Bt_string ]]
               or ___conditional___ == 3--[[ Bt_int32 ]]
               or ___conditional___ == 5--[[ Bt_bytes ]]
               or ___conditional___ == 6--[[ Bt_bool ]] then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Invalid encoding/OCaml type combination"
                  }) end end 
              
            end end end 
         if ___conditional___ == 2--[[ Pk_bytes ]] then do
            match_2 = param[3];
            if (match_2 ~= 5) then do
              if (match_2 ~= 0) then do
                error({
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                })
              end else do
                return "Pbrt.Encoder.string";
              end end 
            end else do
              return "Pbrt.Encoder.bytes";
            end end  end end 
        
      end
    end else if (match_1[1]) then do
      local ___conditional___=(param[3]);
      do
         if ___conditional___ == 2--[[ Bt_int ]] then do
            return "Pbrt.Encoder.int_as_zigzag"; end end 
         if ___conditional___ == 3--[[ Bt_int32 ]] then do
            return "Pbrt.Encoder.int32_as_zigzag"; end end 
         if ___conditional___ == 4--[[ Bt_int64 ]] then do
            return "Pbrt.Encoder.int64_as_zigzag"; end end 
         if ___conditional___ == 0--[[ Bt_string ]]
         or ___conditional___ == 1--[[ Bt_float ]]
         or ___conditional___ == 5--[[ Bt_bytes ]]
         or ___conditional___ == 6--[[ Bt_bool ]] then do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid encoding/OCaml type combination"
            }) end end 
        
      end
    end else do
      local ___conditional___=(param[3]);
      do
         if ___conditional___ == 2--[[ Bt_int ]] then do
            return "Pbrt.Encoder.int_as_varint"; end end 
         if ___conditional___ == 3--[[ Bt_int32 ]] then do
            return "Pbrt.Encoder.int32_as_varint"; end end 
         if ___conditional___ == 4--[[ Bt_int64 ]] then do
            return "Pbrt.Encoder.int64_as_varint"; end end 
         if ___conditional___ == 0--[[ Bt_string ]]
         or ___conditional___ == 1--[[ Bt_float ]]
         or ___conditional___ == 5--[[ Bt_bytes ]] then do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid encoding/OCaml type combination"
            }) end end 
         if ___conditional___ == 6--[[ Bt_bool ]] then do
            return "Pbrt.Encoder.bool"; end end 
        
      end
    end end  end 
  end else do
    match_3 = param[2];
    if (type(match_3) == "number") then do
      local ___conditional___=(match_3);
      do
         if ___conditional___ == 0--[[ Pk_bits32 ]] then do
            local ___conditional___=(param[3]);
            do
               if ___conditional___ == 1--[[ Bt_float ]] then do
                  return "Pbrt.Decoder.float_as_bits32"; end end 
               if ___conditional___ == 2--[[ Bt_int ]] then do
                  return "Pbrt.Decoder.int_as_bits32"; end end 
               if ___conditional___ == 3--[[ Bt_int32 ]] then do
                  return "Pbrt.Decoder.int32_as_bits32"; end end 
               if ___conditional___ == 0--[[ Bt_string ]]
               or ___conditional___ == 4--[[ Bt_int64 ]]
               or ___conditional___ == 5--[[ Bt_bytes ]]
               or ___conditional___ == 6--[[ Bt_bool ]] then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Invalid encoding/OCaml type combination"
                  }) end end 
              
            end end end 
         if ___conditional___ == 1--[[ Pk_bits64 ]] then do
            local ___conditional___=(param[3]);
            do
               if ___conditional___ == 1--[[ Bt_float ]] then do
                  return "Pbrt.Decoder.float_as_bits64"; end end 
               if ___conditional___ == 2--[[ Bt_int ]] then do
                  return "Pbrt.Decoder.int_as_bits64"; end end 
               if ___conditional___ == 4--[[ Bt_int64 ]] then do
                  return "Pbrt.Decoder.int64_as_bits64"; end end 
               if ___conditional___ == 0--[[ Bt_string ]]
               or ___conditional___ == 3--[[ Bt_int32 ]]
               or ___conditional___ == 5--[[ Bt_bytes ]]
               or ___conditional___ == 6--[[ Bt_bool ]] then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Invalid encoding/OCaml type combination"
                  }) end end 
              
            end end end 
         if ___conditional___ == 2--[[ Pk_bytes ]] then do
            match_4 = param[3];
            if (match_4 ~= 5) then do
              if (match_4 ~= 0) then do
                error({
                  Caml_builtin_exceptions.failure,
                  "Invalid encoding/OCaml type combination"
                })
              end else do
                return "Pbrt.Decoder.string";
              end end 
            end else do
              return "Pbrt.Decoder.bytes";
            end end  end end 
        
      end
    end else if (match_3[1]) then do
      local ___conditional___=(param[3]);
      do
         if ___conditional___ == 2--[[ Bt_int ]] then do
            return "Pbrt.Decoder.int_as_zigzag"; end end 
         if ___conditional___ == 3--[[ Bt_int32 ]] then do
            return "Pbrt.Decoder.int32_as_zigzag"; end end 
         if ___conditional___ == 4--[[ Bt_int64 ]] then do
            return "Pbrt.Decoder.int64_as_zigzag"; end end 
         if ___conditional___ == 0--[[ Bt_string ]]
         or ___conditional___ == 1--[[ Bt_float ]]
         or ___conditional___ == 5--[[ Bt_bytes ]]
         or ___conditional___ == 6--[[ Bt_bool ]] then do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid encoding/OCaml type combination"
            }) end end 
        
      end
    end else do
      local ___conditional___=(param[3]);
      do
         if ___conditional___ == 2--[[ Bt_int ]] then do
            return "Pbrt.Decoder.int_as_varint"; end end 
         if ___conditional___ == 3--[[ Bt_int32 ]] then do
            return "Pbrt.Decoder.int32_as_varint"; end end 
         if ___conditional___ == 4--[[ Bt_int64 ]] then do
            return "Pbrt.Decoder.int64_as_varint"; end end 
         if ___conditional___ == 0--[[ Bt_string ]]
         or ___conditional___ == 1--[[ Bt_float ]]
         or ___conditional___ == 5--[[ Bt_bytes ]] then do
            error({
              Caml_builtin_exceptions.failure,
              "Invalid encoding/OCaml type combination"
            }) end end 
         if ___conditional___ == 6--[[ Bt_bool ]] then do
            return "Pbrt.Decoder.bool"; end end 
        
      end
    end end  end 
  end end 
end end

function decode_basic_type(bt, pk) do
  return runtime_function(--[[ tuple ]]{
              --[[ Decode ]]427938126,
              pk,
              bt
            });
end end

function decode_field_f(field_type, pk) do
  if (type(field_type) == "number") then do
    return "Pbrt.Decoder.empty_nested d";
  end else if (field_type.tag) then do
    t = field_type[1];
    f_name = function_name_of_user_defined("decode", t);
    if (t.udt_nested) then do
      return f_name .. " (Pbrt.Decoder.nested d)";
    end else do
      return f_name .. " d";
    end end 
  end else do
    return decode_basic_type(field_type[1], pk) .. " d";
  end end  end 
end end

function gen_decode_record(and_, param, sc) do
  r_fields = param.r_fields;
  r_name = param.r_name;
  all_lists = List.fold_left((function(acc, param) do
          rf_field_type = param.rf_field_type;
          local ___conditional___=(rf_field_type.tag | 0);
          do
             if ___conditional___ == 2--[[ Rft_repeated_field ]]
             or ___conditional___ == 3--[[ Rft_associative_field ]]
             end
            return acc;
              
          end
          if (rf_field_type[1][1]) then do
            return acc;
          end else do
            return --[[ :: ]]{
                    param.rf_label,
                    acc
                  };
          end end 
        end end), --[[ [] ]]0, r_fields);
  process_field_common = function(sc, encoding_number, pk_as_string, f) do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "| Some (",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_i ]]3,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ", Pbrt.",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ") -> (",
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        })
                    }),
                  "| Some (%i, Pbrt.%s) -> ("
                }), encoding_number, pk_as_string));
    scope(sc, (function(sc) do
            Curry._1(f, sc);
            return line_1(sc, "loop ()");
          end end));
    line_1(sc, ")");
    line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "| Some (",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_i ]]3,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ", pk) -> raise (",
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "| Some (%i, pk) -> raise ("
                }), encoding_number));
    scope(sc, (function(sc) do
            return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                --[[ String_literal ]]Block.__(11, {
                                    "Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (",
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            ", pk))",
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  }),
                                "Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (%s, pk))"
                              }), Curry._2(Printf.sprintf(--[[ Format ]]{
                                    --[[ String_literal ]]Block.__(11, {
                                        "\"Message(",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ String_literal ]]Block.__(11, {
                                                "), field(",
                                                --[[ Int ]]Block.__(4, {
                                                    --[[ Int_i ]]3,
                                                    --[[ No_padding ]]0,
                                                    --[[ No_precision ]]0,
                                                    --[[ String_literal ]]Block.__(11, {
                                                        ")\"",
                                                        --[[ End_of_format ]]0
                                                      })
                                                  })
                                              })
                                          })
                                      }),
                                    "\"Message(%s), field(%i)\""
                                  }), r_name, encoding_number)));
          end end));
    return line_1(sc, ")");
  end end;
  mutable_record_name = r_name .. "_mutable";
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " decode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " d =",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s decode_%s d ="
              }), let_decl_of_and(and_), r_name));
  return scope(sc, (function(sc) do
                line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "let v = default_",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " () in",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "let v = default_%s () in"
                            }), mutable_record_name));
                line_1(sc, "let rec loop () = ");
                scope(sc, (function(sc) do
                        line_1(sc, "match Pbrt.Decoder.key d with");
                        line_1(sc, "| None -> (");
                        scope(sc, (function(sc) do
                                return List.iter((function(field_name) do
                                              return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                  --[[ String_literal ]]Block.__(11, {
                                                                      "v.",
                                                                      --[[ String ]]Block.__(2, {
                                                                          --[[ No_padding ]]0,
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              " <- List.rev v.",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                      --[[ ";" ]]59,
                                                                                      --[[ End_of_format ]]0
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    }),
                                                                  "v.%s <- List.rev v.%s;"
                                                                }), field_name, field_name));
                                            end end), all_lists);
                              end end));
                        line_1(sc, ")");
                        List.iter((function(param) do
                                rf_field_type = param.rf_field_type;
                                rf_label = param.rf_label;
                                local ___conditional___=(rf_field_type.tag | 0);
                                do
                                   if ___conditional___ == 0--[[ Rft_required ]] then do
                                      sc_1 = sc;
                                      rf_label_1 = rf_label;
                                      param_1 = rf_field_type[1];
                                      pk = param_1[3];
                                      field_type = param_1[1];
                                      return process_field_common(sc_1, param_1[2], string_of_payload_kind(--[[ () ]]0, pk, false), (function(sc) do
                                                    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                        --[[ String_literal ]]Block.__(11, {
                                                                            "v.",
                                                                            --[[ String ]]Block.__(2, {
                                                                                --[[ No_padding ]]0,
                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                    " <- ",
                                                                                    --[[ String ]]Block.__(2, {
                                                                                        --[[ No_padding ]]0,
                                                                                        --[[ Char_literal ]]Block.__(12, {
                                                                                            --[[ ";" ]]59,
                                                                                            --[[ End_of_format ]]0
                                                                                          })
                                                                                      })
                                                                                  })
                                                                              })
                                                                          }),
                                                                        "v.%s <- %s;"
                                                                      }), rf_label_1, decode_field_f(field_type, pk)));
                                                  end end)); end end 
                                   if ___conditional___ == 1--[[ Rft_optional ]] then do
                                      sc_2 = sc;
                                      rf_label_2 = rf_label;
                                      param_2 = rf_field_type[1];
                                      pk_1 = param_2[3];
                                      field_type_1 = param_2[1];
                                      return process_field_common(sc_2, param_2[2], string_of_payload_kind(--[[ () ]]0, pk_1, false), (function(sc) do
                                                    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                        --[[ String_literal ]]Block.__(11, {
                                                                            "v.",
                                                                            --[[ String ]]Block.__(2, {
                                                                                --[[ No_padding ]]0,
                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                    " <- Some (",
                                                                                    --[[ String ]]Block.__(2, {
                                                                                        --[[ No_padding ]]0,
                                                                                        --[[ String_literal ]]Block.__(11, {
                                                                                            ");",
                                                                                            --[[ End_of_format ]]0
                                                                                          })
                                                                                      })
                                                                                  })
                                                                              })
                                                                          }),
                                                                        "v.%s <- Some (%s);"
                                                                      }), rf_label_2, decode_field_f(field_type_1, pk_1)));
                                                  end end)); end end 
                                   if ___conditional___ == 2--[[ Rft_repeated_field ]] then do
                                      sc_3 = sc;
                                      rf_label_3 = rf_label;
                                      param_3 = rf_field_type[1];
                                      is_packed = param_3[5];
                                      pk_2 = param_3[4];
                                      encoding_number = param_3[3];
                                      field_type_2 = param_3[2];
                                      if (param_3[1]) then do
                                        if (is_packed) then do
                                          return process_field_common(sc_3, encoding_number, "Bytes", (function(sc) do
                                                        line_1(sc, "Pbrt.Decoder.packed_fold (fun () d -> ");
                                                        scope(sc, (function(sc) do
                                                                return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                                    --[[ String_literal ]]Block.__(11, {
                                                                                        "Pbrt.Repeated_field.add (",
                                                                                        --[[ String ]]Block.__(2, {
                                                                                            --[[ No_padding ]]0,
                                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                                ") v.",
                                                                                                --[[ String ]]Block.__(2, {
                                                                                                    --[[ No_padding ]]0,
                                                                                                    --[[ Char_literal ]]Block.__(12, {
                                                                                                        --[[ ";" ]]59,
                                                                                                        --[[ End_of_format ]]0
                                                                                                      })
                                                                                                  })
                                                                                              })
                                                                                          })
                                                                                      }),
                                                                                    "Pbrt.Repeated_field.add (%s) v.%s;"
                                                                                  }), decode_field_f(field_type_2, pk_2), rf_label_3));
                                                              end end));
                                                        return line_1(sc, ") () d;");
                                                      end end));
                                        end else do
                                          return process_field_common(sc_3, encoding_number, string_of_payload_kind(--[[ () ]]0, pk_2, false), (function(sc) do
                                                        return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                "Pbrt.Repeated_field.add (",
                                                                                --[[ String ]]Block.__(2, {
                                                                                    --[[ No_padding ]]0,
                                                                                    --[[ String_literal ]]Block.__(11, {
                                                                                        ") v.",
                                                                                        --[[ String ]]Block.__(2, {
                                                                                            --[[ No_padding ]]0,
                                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                                "; ",
                                                                                                --[[ End_of_format ]]0
                                                                                              })
                                                                                          })
                                                                                      })
                                                                                  })
                                                                              }),
                                                                            "Pbrt.Repeated_field.add (%s) v.%s; "
                                                                          }), decode_field_f(field_type_2, pk_2), rf_label_3));
                                                      end end));
                                        end end 
                                      end else if (is_packed) then do
                                        return process_field_common(sc_3, encoding_number, "Bytes", (function(sc) do
                                                      return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              "v.",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ String_literal ]]Block.__(11, {
                                                                                      " <- Pbrt.Decoder.packed_fold (fun l d -> (",
                                                                                      --[[ String ]]Block.__(2, {
                                                                                          --[[ No_padding ]]0,
                                                                                          --[[ String_literal ]]Block.__(11, {
                                                                                              ")::l) [] d;",
                                                                                              --[[ End_of_format ]]0
                                                                                            })
                                                                                        })
                                                                                    })
                                                                                })
                                                                            }),
                                                                          "v.%s <- Pbrt.Decoder.packed_fold (fun l d -> (%s)::l) [] d;"
                                                                        }), rf_label_3, decode_field_f(field_type_2, pk_2)));
                                                    end end));
                                      end else do
                                        return process_field_common(sc_3, encoding_number, string_of_payload_kind(--[[ () ]]0, pk_2, false), (function(sc) do
                                                      return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              "v.",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ String_literal ]]Block.__(11, {
                                                                                      " <- (",
                                                                                      --[[ String ]]Block.__(2, {
                                                                                          --[[ No_padding ]]0,
                                                                                          --[[ String_literal ]]Block.__(11, {
                                                                                              ") :: v.",
                                                                                              --[[ String ]]Block.__(2, {
                                                                                                  --[[ No_padding ]]0,
                                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                                      --[[ ";" ]]59,
                                                                                                      --[[ End_of_format ]]0
                                                                                                    })
                                                                                                })
                                                                                            })
                                                                                        })
                                                                                    })
                                                                                })
                                                                            }),
                                                                          "v.%s <- (%s) :: v.%s;"
                                                                        }), rf_label_3, decode_field_f(field_type_2, pk_2), rf_label_3));
                                                    end end));
                                      end end  end  end end 
                                   if ___conditional___ == 3--[[ Rft_associative_field ]] then do
                                      sc_4 = sc;
                                      rf_label_4 = rf_label;
                                      param_4 = rf_field_type[1];
                                      match = param_4[4];
                                      value_pk = match[2];
                                      value_type = match[1];
                                      match_1 = param_4[3];
                                      at = param_4[1];
                                      decode_key_f = decode_basic_type(match_1[1], match_1[2]);
                                      return process_field_common(sc_4, param_4[2], "Bytes", (function(sc) do
                                                    line_1(sc, "let decode_value = (fun d ->");
                                                    scope(sc, (function(sc) do
                                                            return line_1(sc, decode_field_f(value_type, value_pk));
                                                          end end));
                                                    line_1(sc, ") in");
                                                    decode_expression = Curry._1(Printf.sprintf(--[[ Format ]]{
                                                              --[[ String_literal ]]Block.__(11, {
                                                                  "(Pbrt.Decoder.map_entry d ~decode_key:",
                                                                  --[[ String ]]Block.__(2, {
                                                                      --[[ No_padding ]]0,
                                                                      --[[ String_literal ]]Block.__(11, {
                                                                          " ~decode_value)",
                                                                          --[[ End_of_format ]]0
                                                                        })
                                                                    })
                                                                }),
                                                              "(Pbrt.Decoder.map_entry d ~decode_key:%s ~decode_value)"
                                                            }), decode_key_f);
                                                    if (at) then do
                                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "let a, b = ",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                " in",
                                                                                --[[ End_of_format ]]0
                                                                              })
                                                                          })
                                                                      }),
                                                                    "let a, b = %s in"
                                                                  }), decode_expression));
                                                      return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              "Hashtbl.add v.",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ String_literal ]]Block.__(11, {
                                                                                      " a b;",
                                                                                      --[[ End_of_format ]]0
                                                                                    })
                                                                                })
                                                                            }),
                                                                          "Hashtbl.add v.%s a b;"
                                                                        }), rf_label_4));
                                                    end else do
                                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "v.",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                " <- (",
                                                                                --[[ End_of_format ]]0
                                                                              })
                                                                          })
                                                                      }),
                                                                    "v.%s <- ("
                                                                  }), rf_label_4));
                                                      scope(sc, (function(sc) do
                                                              return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                                  --[[ String ]]Block.__(2, {
                                                                                      --[[ No_padding ]]0,
                                                                                      --[[ String_literal ]]Block.__(11, {
                                                                                          "::v.",
                                                                                          --[[ String ]]Block.__(2, {
                                                                                              --[[ No_padding ]]0,
                                                                                              --[[ Char_literal ]]Block.__(12, {
                                                                                                  --[[ ";" ]]59,
                                                                                                  --[[ End_of_format ]]0
                                                                                                })
                                                                                            })
                                                                                        })
                                                                                    }),
                                                                                  "%s::v.%s;"
                                                                                }), decode_expression, rf_label_4));
                                                            end end));
                                                      return line_1(sc, ");");
                                                    end end 
                                                  end end)); end end 
                                   if ___conditional___ == 4--[[ Rft_variant_field ]] then do
                                      sc_5 = sc;
                                      rf_label_5 = rf_label;
                                      param_5 = rf_field_type[1];
                                      return List.iter((function(param) do
                                                    pk = param.vc_payload_kind;
                                                    vc_field_type = param.vc_field_type;
                                                    vc_constructor = param.vc_constructor;
                                                    return process_field_common(sc_5, param.vc_encoding_number, string_of_payload_kind(--[[ () ]]0, pk, false), (function(sc) do
                                                                  if (vc_field_type) then do
                                                                    return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                                                        --[[ String_literal ]]Block.__(11, {
                                                                                            "v.",
                                                                                            --[[ String ]]Block.__(2, {
                                                                                                --[[ No_padding ]]0,
                                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                                    " <- ",
                                                                                                    --[[ String ]]Block.__(2, {
                                                                                                        --[[ No_padding ]]0,
                                                                                                        --[[ String_literal ]]Block.__(11, {
                                                                                                            " (",
                                                                                                            --[[ String ]]Block.__(2, {
                                                                                                                --[[ No_padding ]]0,
                                                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                                                    ");",
                                                                                                                    --[[ End_of_format ]]0
                                                                                                                  })
                                                                                                              })
                                                                                                          })
                                                                                                      })
                                                                                                  })
                                                                                              })
                                                                                          }),
                                                                                        "v.%s <- %s (%s);"
                                                                                      }), rf_label_5, vc_constructor, decode_field_f(vc_field_type[1], pk)));
                                                                  end else do
                                                                    line_1(sc, "Pbrt.Decoder.empty_nested d;");
                                                                    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                                                        --[[ String_literal ]]Block.__(11, {
                                                                                            "v.",
                                                                                            --[[ String ]]Block.__(2, {
                                                                                                --[[ No_padding ]]0,
                                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                                    " <- ",
                                                                                                    --[[ String ]]Block.__(2, {
                                                                                                        --[[ No_padding ]]0,
                                                                                                        --[[ Char_literal ]]Block.__(12, {
                                                                                                            --[[ ";" ]]59,
                                                                                                            --[[ End_of_format ]]0
                                                                                                          })
                                                                                                      })
                                                                                                  })
                                                                                              })
                                                                                          }),
                                                                                        "v.%s <- %s;"
                                                                                      }), rf_label_5, vc_constructor));
                                                                  end end 
                                                                end end));
                                                  end end), param_5.v_constructors); end end 
                                  
                                end
                              end end), r_fields);
                        return line_1(sc, "| Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()");
                      end end));
                line_1(sc, "in");
                line_1(sc, "loop ();");
                line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "let v:",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " = Obj.magic v in",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "let v:%s = Obj.magic v in"
                            }), r_name));
                return line_1(sc, "v");
              end end));
end end

function gen_decode_variant(and_, param, sc) do
  v_constructors = param.v_constructors;
  v_name = param.v_name;
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " decode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " d = ",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s decode_%s d = "
              }), let_decl_of_and(and_), v_name));
  return scope(sc, (function(sc) do
                line_1(sc, Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "let rec loop () = ",
                              --[[ End_of_format ]]0
                            }),
                          "let rec loop () = "
                        }));
                scope(sc, (function(sc) do
                        line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                      --[[ String_literal ]]Block.__(11, {
                                          "let ret:",
                                          --[[ String ]]Block.__(2, {
                                              --[[ No_padding ]]0,
                                              --[[ String_literal ]]Block.__(11, {
                                                  " = match Pbrt.Decoder.key d with",
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        }),
                                      "let ret:%s = match Pbrt.Decoder.key d with"
                                    }), v_name));
                        scope(sc, (function(sc) do
                                line_1(sc, "| None -> failwith \"None of the known key is found\"");
                                List.iter((function(ctor) do
                                        sc_1 = sc;
                                        param = ctor;
                                        vc_encoding_number = param.vc_encoding_number;
                                        vc_field_type = param.vc_field_type;
                                        vc_constructor = param.vc_constructor;
                                        if (vc_field_type) then do
                                          return line_1(sc_1, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                              --[[ String_literal ]]Block.__(11, {
                                                                  "| Some (",
                                                                  --[[ Int ]]Block.__(4, {
                                                                      --[[ Int_i ]]3,
                                                                      --[[ No_padding ]]0,
                                                                      --[[ No_precision ]]0,
                                                                      --[[ String_literal ]]Block.__(11, {
                                                                          ", _) -> ",
                                                                          --[[ String ]]Block.__(2, {
                                                                              --[[ No_padding ]]0,
                                                                              --[[ String_literal ]]Block.__(11, {
                                                                                  " (",
                                                                                  --[[ String ]]Block.__(2, {
                                                                                      --[[ No_padding ]]0,
                                                                                      --[[ Char_literal ]]Block.__(12, {
                                                                                          --[[ ")" ]]41,
                                                                                          --[[ End_of_format ]]0
                                                                                        })
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                }),
                                                              "| Some (%i, _) -> %s (%s)"
                                                            }), vc_encoding_number, vc_constructor, decode_field_f(vc_field_type[1], param.vc_payload_kind)));
                                        end else do
                                          return line_1(sc_1, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                              --[[ String_literal ]]Block.__(11, {
                                                                  "| Some (",
                                                                  --[[ Int ]]Block.__(4, {
                                                                      --[[ Int_i ]]3,
                                                                      --[[ No_padding ]]0,
                                                                      --[[ No_precision ]]0,
                                                                      --[[ String_literal ]]Block.__(11, {
                                                                          ", _) -> (Pbrt.Decoder.empty_nested d ; ",
                                                                          --[[ String ]]Block.__(2, {
                                                                              --[[ No_padding ]]0,
                                                                              --[[ Char_literal ]]Block.__(12, {
                                                                                  --[[ ")" ]]41,
                                                                                  --[[ End_of_format ]]0
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                }),
                                                              "| Some (%i, _) -> (Pbrt.Decoder.empty_nested d ; %s)"
                                                            }), vc_encoding_number, vc_constructor));
                                        end end 
                                      end end), v_constructors);
                                line_1(sc, "| Some (n, payload_kind) -> (");
                                line_1(sc, "  Pbrt.Decoder.skip d payload_kind; ");
                                line_1(sc, "  loop () ");
                                return line_1(sc, ")");
                              end end));
                        line_1(sc, "in");
                        return line_1(sc, "ret");
                      end end));
                line_1(sc, "in");
                return line_1(sc, "loop ()");
              end end));
end end

function gen_decode_const_variant(and_, param, sc) do
  cv_constructors = param.cv_constructors;
  cv_name = param.cv_name;
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " decode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " d = ",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s decode_%s d = "
              }), let_decl_of_and(and_), cv_name));
  return scope(sc, (function(sc) do
                line_1(sc, "match Pbrt.Decoder.int_as_varint d with");
                List.iter((function(param) do
                        return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                            --[[ String_literal ]]Block.__(11, {
                                                "| ",
                                                --[[ Int ]]Block.__(4, {
                                                    --[[ Int_i ]]3,
                                                    --[[ No_padding ]]0,
                                                    --[[ No_precision ]]0,
                                                    --[[ String_literal ]]Block.__(11, {
                                                        " -> (",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ Char_literal ]]Block.__(12, {
                                                                --[[ ":" ]]58,
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ Char_literal ]]Block.__(12, {
                                                                        --[[ ")" ]]41,
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      })
                                                  })
                                              }),
                                            "| %i -> (%s:%s)"
                                          }), param[2], param[1], cv_name));
                      end end), cv_constructors);
                return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                    --[[ String_literal ]]Block.__(11, {
                                        "| _ -> failwith \"Unknown value for enum ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ Char_literal ]]Block.__(12, {
                                                --[[ "\"" ]]34,
                                                --[[ End_of_format ]]0
                                              })
                                          })
                                      }),
                                    "| _ -> failwith \"Unknown value for enum %s\""
                                  }), cv_name));
              end end));
end end

function gen_struct(and_, t, sc) do
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        tmp = --[[ tuple ]]{
          gen_decode_record(and_, match[1], sc),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          gen_decode_variant(and_, match[1], sc),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          gen_decode_const_variant(and_, match[1], sc),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

function gen_sig(and_, t, sc) do
  f = function(type_name) do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "val decode_",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " : Pbrt.Decoder.t -> ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            })
                        })
                    }),
                  "val decode_%s : Pbrt.Decoder.t -> %s"
                }), type_name, type_name));
    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "(** [decode_",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " decoder] decodes a [",
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            "] value from [decoder] *)",
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  })
                              })
                          }),
                        "(** [decode_%s decoder] decodes a [%s] value from [decoder] *)"
                      }), type_name, type_name));
  end end;
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].r_name),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].v_name),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].cv_name),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

Codegen_decode = {
  gen_sig = gen_sig,
  gen_struct = gen_struct,
  ocamldoc_title = "Protobuf Decoding"
};

__log__ = {
  contents = nil
};

function log(x) do
  match = __log__.contents;
  if (match ~= nil) then do
    return Printf.fprintf(Caml_option.valFromOption(match), x);
  end else do
    return Printf.ifprintf(Pervasives.stdout, x);
  end end 
end end

function endline(s) do
  return Curry._1(log(--[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    }),
                  "%s\n"
                }), s);
end end

function gen_pp_field(field_type) do
  if (type(field_type) ~= "number" and field_type.tag) then do
    return function_name_of_user_defined("pp", field_type[1]);
  end
   end 
  return Curry._1(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "Pbrt.Pp.pp_",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ End_of_format ]]0
                        })
                    }),
                  "Pbrt.Pp.pp_%s"
                }), string_of_field_type(field_type));
end end

function gen_pp_record(and_, param, sc) do
  r_fields = param.r_fields;
  r_name = param.r_name;
  Curry._1(log(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "gen_pp, record_name: ",
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "gen_pp, record_name: %s\n"
          }), r_name);
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " pp_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " fmt (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") = ",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s pp_%s fmt (v:%s) = "
              }), let_decl_of_and(and_), r_name, r_name));
  return scope(sc, (function(sc) do
                line_1(sc, "let pp_i fmt () =");
                scope(sc, (function(sc) do
                        line_1(sc, "Format.pp_open_vbox fmt 1;");
                        List.iter((function(record_field) do
                                rf_field_type = record_field.rf_field_type;
                                rf_label = record_field.rf_label;
                                var_name = Curry._1(Printf.sprintf(--[[ Format ]]{
                                          --[[ String_literal ]]Block.__(11, {
                                              "v.",
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ End_of_format ]]0
                                                })
                                            }),
                                          "v.%s"
                                        }), rf_label);
                                local ___conditional___=(rf_field_type.tag | 0);
                                do
                                   if ___conditional___ == 0--[[ Rft_required ]] then do
                                      field_string_of = gen_pp_field(rf_field_type[1][1]);
                                      return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                          --[[ String_literal ]]Block.__(11, {
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[[ String ]]Block.__(2, {
                                                                  --[[ No_padding ]]0,
                                                                  --[[ String_literal ]]Block.__(11, {
                                                                      "\" ",
                                                                      --[[ String ]]Block.__(2, {
                                                                          --[[ No_padding ]]0,
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              " fmt ",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                      --[[ ";" ]]59,
                                                                                      --[[ End_of_format ]]0
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                })
                                                            }),
                                                          "Pbrt.Pp.pp_record_field \"%s\" %s fmt %s;"
                                                        }), rf_label, field_string_of, var_name)); end end 
                                   if ___conditional___ == 1--[[ Rft_optional ]] then do
                                      field_string_of_1 = gen_pp_field(rf_field_type[1][1]);
                                      return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                          --[[ String_literal ]]Block.__(11, {
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[[ String ]]Block.__(2, {
                                                                  --[[ No_padding ]]0,
                                                                  --[[ String_literal ]]Block.__(11, {
                                                                      "\" (Pbrt.Pp.pp_option ",
                                                                      --[[ String ]]Block.__(2, {
                                                                          --[[ No_padding ]]0,
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              ") fmt ",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                      --[[ ";" ]]59,
                                                                                      --[[ End_of_format ]]0
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                })
                                                            }),
                                                          "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_option %s) fmt %s;"
                                                        }), rf_label, field_string_of_1, var_name)); end end 
                                   if ___conditional___ == 2--[[ Rft_repeated_field ]] then do
                                      match = rf_field_type[1];
                                      field_string_of_2 = gen_pp_field(match[2]);
                                      if (match[1]) then do
                                        return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                            --[[ String_literal ]]Block.__(11, {
                                                                "Pbrt.Pp.pp_record_field \"",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "\" (Pbrt.Pp.pp_list ",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                ") fmt (Pbrt.Repeated_field.to_list ",
                                                                                --[[ String ]]Block.__(2, {
                                                                                    --[[ No_padding ]]0,
                                                                                    --[[ String_literal ]]Block.__(11, {
                                                                                        ");",
                                                                                        --[[ End_of_format ]]0
                                                                                      })
                                                                                  })
                                                                              })
                                                                          })
                                                                      })
                                                                  })
                                                              }),
                                                            "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_list %s) fmt (Pbrt.Repeated_field.to_list %s);"
                                                          }), rf_label, field_string_of_2, var_name));
                                      end else do
                                        return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                            --[[ String_literal ]]Block.__(11, {
                                                                "Pbrt.Pp.pp_record_field \"",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "\" (Pbrt.Pp.pp_list ",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                ") fmt ",
                                                                                --[[ String ]]Block.__(2, {
                                                                                    --[[ No_padding ]]0,
                                                                                    --[[ Char_literal ]]Block.__(12, {
                                                                                        --[[ ";" ]]59,
                                                                                        --[[ End_of_format ]]0
                                                                                      })
                                                                                  })
                                                                              })
                                                                          })
                                                                      })
                                                                  })
                                                              }),
                                                            "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.pp_list %s) fmt %s;"
                                                          }), rf_label, field_string_of_2, var_name));
                                      end end  end end 
                                   if ___conditional___ == 3--[[ Rft_associative_field ]] then do
                                      match_1 = rf_field_type[1];
                                      pp_runtime_function = match_1[1] and "pp_hastable" or "pp_associative_list";
                                      pp_key = gen_pp_field(--[[ Ft_basic_type ]]Block.__(0, {match_1[3][1]}));
                                      pp_value = gen_pp_field(match_1[4][1]);
                                      return line_1(sc, Curry._5(Printf.sprintf(--[[ Format ]]{
                                                          --[[ String_literal ]]Block.__(11, {
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[[ String ]]Block.__(2, {
                                                                  --[[ No_padding ]]0,
                                                                  --[[ String_literal ]]Block.__(11, {
                                                                      "\" (Pbrt.Pp.",
                                                                      --[[ String ]]Block.__(2, {
                                                                          --[[ No_padding ]]0,
                                                                          --[[ Char_literal ]]Block.__(12, {
                                                                              --[[ " " ]]32,
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                      --[[ " " ]]32,
                                                                                      --[[ String ]]Block.__(2, {
                                                                                          --[[ No_padding ]]0,
                                                                                          --[[ String_literal ]]Block.__(11, {
                                                                                              ") fmt ",
                                                                                              --[[ String ]]Block.__(2, {
                                                                                                  --[[ No_padding ]]0,
                                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                                      --[[ ";" ]]59,
                                                                                                      --[[ End_of_format ]]0
                                                                                                    })
                                                                                                })
                                                                                            })
                                                                                        })
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                })
                                                            }),
                                                          "Pbrt.Pp.pp_record_field \"%s\" (Pbrt.Pp.%s %s %s) fmt %s;"
                                                        }), rf_label, pp_runtime_function, pp_key, pp_value, var_name)); end end 
                                   if ___conditional___ == 4--[[ Rft_variant_field ]] then do
                                      return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                          --[[ String_literal ]]Block.__(11, {
                                                              "Pbrt.Pp.pp_record_field \"",
                                                              --[[ String ]]Block.__(2, {
                                                                  --[[ No_padding ]]0,
                                                                  --[[ String_literal ]]Block.__(11, {
                                                                      "\" ",
                                                                      --[[ String ]]Block.__(2, {
                                                                          --[[ No_padding ]]0,
                                                                          --[[ String_literal ]]Block.__(11, {
                                                                              " fmt ",
                                                                              --[[ String ]]Block.__(2, {
                                                                                  --[[ No_padding ]]0,
                                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                                      --[[ ";" ]]59,
                                                                                      --[[ End_of_format ]]0
                                                                                    })
                                                                                })
                                                                            })
                                                                        })
                                                                    })
                                                                })
                                                            }),
                                                          "Pbrt.Pp.pp_record_field \"%s\" %s fmt %s;"
                                                        }), rf_label, "pp_" .. rf_field_type[1].v_name, var_name)); end end 
                                  
                                end
                              end end), r_fields);
                        return line_1(sc, "Format.pp_close_box fmt ()");
                      end end));
                line_1(sc, "in");
                return line_1(sc, "Pbrt.Pp.pp_brk pp_i fmt ()");
              end end));
end end

function gen_pp_variant(and_, param, sc) do
  v_constructors = param.v_constructors;
  v_name = param.v_name;
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " pp_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " fmt (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") =",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s pp_%s fmt (v:%s) ="
              }), let_decl_of_and(and_), v_name, v_name));
  return scope(sc, (function(sc) do
                line_1(sc, "match v with");
                return List.iter((function(param) do
                              vc_field_type = param.vc_field_type;
                              vc_constructor = param.vc_constructor;
                              if (vc_field_type) then do
                                field_string_of = gen_pp_field(vc_field_type[1]);
                                return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " x -> Format.fprintf fmt \"",
                                                                --[[ Formatting_gen ]]Block.__(18, {
                                                                    --[[ Open_box ]]Block.__(1, {--[[ Format ]]{
                                                                          --[[ End_of_format ]]0,
                                                                          ""
                                                                        }}),
                                                                    --[[ String ]]Block.__(2, {
                                                                        --[[ No_padding ]]0,
                                                                        --[[ Char_literal ]]Block.__(12, {
                                                                            --[[ "(" ]]40,
                                                                            --[[ Char_literal ]]Block.__(12, {
                                                                                --[[ "%" ]]37,
                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                    "a)",
                                                                                    --[[ Formatting_lit ]]Block.__(17, {
                                                                                        --[[ Close_box ]]0,
                                                                                        --[[ String_literal ]]Block.__(11, {
                                                                                            "\" ",
                                                                                            --[[ String ]]Block.__(2, {
                                                                                                --[[ No_padding ]]0,
                                                                                                --[[ String_literal ]]Block.__(11, {
                                                                                                    " x",
                                                                                                    --[[ End_of_format ]]0
                                                                                                  })
                                                                                              })
                                                                                          })
                                                                                      })
                                                                                  })
                                                                              })
                                                                          })
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "| %s x -> Format.fprintf fmt \"@[%s(%%a)@]\" %s x"
                                                  }), vc_constructor, vc_constructor, field_string_of));
                              end else do
                                return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                "  -> Format.fprintf fmt \"",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ Char_literal ]]Block.__(12, {
                                                                        --[[ "\"" ]]34,
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "| %s  -> Format.fprintf fmt \"%s\""
                                                  }), vc_constructor, vc_constructor));
                              end end 
                            end end), v_constructors);
              end end));
end end

function gen_pp_const_variant(and_, param, sc) do
  cv_constructors = param.cv_constructors;
  cv_name = param.cv_name;
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " pp_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " fmt (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") =",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s pp_%s fmt (v:%s) ="
              }), let_decl_of_and(and_), cv_name, cv_name));
  return scope(sc, (function(sc) do
                line_1(sc, "match v with");
                return List.iter((function(param) do
                              name = param[1];
                              return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                  --[[ String_literal ]]Block.__(11, {
                                                      "| ",
                                                      --[[ String ]]Block.__(2, {
                                                          --[[ No_padding ]]0,
                                                          --[[ String_literal ]]Block.__(11, {
                                                              " -> Format.fprintf fmt \"",
                                                              --[[ String ]]Block.__(2, {
                                                                  --[[ No_padding ]]0,
                                                                  --[[ Char_literal ]]Block.__(12, {
                                                                      --[[ "\"" ]]34,
                                                                      --[[ End_of_format ]]0
                                                                    })
                                                                })
                                                            })
                                                        })
                                                    }),
                                                  "| %s -> Format.fprintf fmt \"%s\""
                                                }), name, name));
                            end end), cv_constructors);
              end end));
end end

function gen_struct_1(and_, t, sc) do
  match = t.spec;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        gen_pp_record(and_, match[1], sc); end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        gen_pp_variant(and_, match[1], sc); end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        gen_pp_const_variant(and_, match[1], sc); end else 
     end end end end end end
    
  end
  return true;
end end

function gen_sig_1(and_, t, sc) do
  f = function(type_name) do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "val pp_",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " : Format.formatter -> ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " -> unit ",
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        })
                    }),
                  "val pp_%s : Format.formatter -> %s -> unit "
                }), type_name, type_name));
    return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "(** [pp_",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " v] formats v] *)",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          }),
                        "(** [pp_%s v] formats v] *)"
                      }), type_name));
  end end;
  match = t.spec;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        f(match[1].r_name); end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        f(match[1].v_name); end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        f(match[1].cv_name); end else 
     end end end end end end
    
  end
  return true;
end end

Codegen_pp = {
  gen_sig = gen_sig_1,
  gen_struct = gen_struct_1,
  ocamldoc_title = "Formatters"
};

function height(param) do
  if (param) then do
    return param[--[[ h ]]5];
  end else do
    return 0;
  end end 
end end

function create(l, x, d, r) do
  hl = height(l);
  hr = height(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, x, d, r) do
  hl = l and l[--[[ h ]]5] or 0;
  hr = r and r[--[[ h ]]5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]4];
      ld = l[--[[ d ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[--[[ l ]]1]), lr[--[[ v ]]2], lr[--[[ d ]]3], create(lr[--[[ r ]]4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]4];
      rd = r[--[[ d ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[[ l ]]1]), rl[--[[ v ]]2], rl[--[[ d ]]3], create(rl[--[[ r ]]4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]4];
    d = m[--[[ d ]]3];
    v = m[--[[ v ]]2];
    l = m[--[[ l ]]1];
    c = Caml_obj.caml_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[[ Node ]]{
                --[[ l ]]l,
                --[[ v ]]x,
                --[[ d ]]data,
                --[[ r ]]r,
                --[[ h ]]m[--[[ h ]]5]
              };
      end end 
    end else if (c < 0) then do
      ll = add(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      rr = add(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]data,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_obj.caml_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return param[--[[ d ]]3];
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function map_1(f, param) do
  if (param) then do
    l_prime = map_1(f, param[--[[ l ]]1]);
    d_prime = Curry._1(f, param[--[[ d ]]3]);
    r_prime = map_1(f, param[--[[ r ]]4]);
    return --[[ Node ]]{
            --[[ l ]]l_prime,
            --[[ v ]]param[--[[ v ]]2],
            --[[ d ]]d_prime,
            --[[ r ]]r_prime,
            --[[ h ]]param[--[[ h ]]5]
          };
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function fold(f, _m, _accu) do
  while(true) do
    accu = _accu;
    m = _m;
    if (m) then do
      _accu = Curry._3(f, m[--[[ v ]]2], m[--[[ d ]]3], fold(f, m[--[[ l ]]1], accu));
      _m = m[--[[ r ]]4];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function min_value(param) do
  match = param[1];
  if (match ~= nil) then do
    match_1 = param[2];
    if (match_1 ~= nil) then do
      return Caml_option.some(Caml_obj.caml_min(Caml_option.valFromOption(match), Caml_option.valFromOption(match_1)));
    end else do
      error({
        Caml_builtin_exceptions.failure,
        "min_value error"
      })
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "min_value error"
    })
  end end 
end end

function eq_value(param) do
  match = param[1];
  if (match ~= nil) then do
    match_1 = param[2];
    if (match_1 ~= nil) then do
      return Caml_obj.caml_equal(Caml_option.valFromOption(match), Caml_option.valFromOption(match_1));
    end else do
      error({
        Caml_builtin_exceptions.failure,
        "eq_value error"
      })
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "eq_value error"
    })
  end end 
end end

function string_of_option(f, param) do
  if (param ~= nil) then do
    return Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "Some(",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ ")" ]]41,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "Some(%s)"
                  }), Curry._1(f, Caml_option.valFromOption(param)));
  end else do
    return "None";
  end end 
end end

function reset(g) do
  return map_1((function(core) do
                return {
                        core = core,
                        index = nil,
                        lowlink = nil,
                        on_stack = false
                      };
              end end), g);
end end

function strong_connect(g, sccs, stack, index, v) do
  Curry._2(log(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "[Graph] processing v [",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_i ]]3,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        "], index: ",
                        --[[ Int ]]Block.__(4, {
                            --[[ Int_i ]]3,
                            --[[ No_padding ]]0,
                            --[[ No_precision ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ "\n" ]]10,
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  })
              }),
            "[Graph] processing v [%i], index: %i\n"
          }), v.core.id, index);
  v.index = index;
  v.lowlink = index;
  stack_1 = --[[ :: ]]{
    v,
    stack
  };
  v.on_stack = true;
  match = List.fold_left((function(param, id) do
          index = param[3];
          stack = param[2];
          sccs = param[1];
          w = find(id, g);
          Curry._2(log(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "[Graph] sub w [",
                        --[[ Int ]]Block.__(4, {
                            --[[ Int_i ]]3,
                            --[[ No_padding ]]0,
                            --[[ No_precision ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                "], w.index: ",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ Char_literal ]]Block.__(12, {
                                        --[[ "\n" ]]10,
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      }),
                    "[Graph] sub w [%i], w.index: %s\n"
                  }), w.core.id, string_of_option((function(prim) do
                      return __String(prim);
                    end end), w.index));
          match = w.index;
          if (match ~= nil) then do
            if (w.on_stack) then do
              v.lowlink = min_value(--[[ tuple ]]{
                    v.lowlink,
                    w.index
                  });
            end
             end 
            return --[[ tuple ]]{
                    sccs,
                    stack,
                    index
                  };
          end else do
            match_1 = strong_connect(g, sccs, stack, index + 1 | 0, w);
            v.lowlink = min_value(--[[ tuple ]]{
                  v.lowlink,
                  w.lowlink
                });
            return --[[ tuple ]]{
                    match_1[1],
                    match_1[2],
                    match_1[3]
                  };
          end end 
        end end), --[[ tuple ]]{
        sccs,
        stack_1,
        index
      }, v.core.sub);
  index_1 = match[3];
  stack_2 = match[2];
  sccs_1 = match[1];
  Curry._3(log(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "[Graph] after sub for v [",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_i ]]3,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        "], lowlink: ",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ", index: ",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ Char_literal ]]Block.__(12, {
                                        --[[ "\n" ]]10,
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  })
              }),
            "[Graph] after sub for v [%i], lowlink: %s, index: %s\n"
          }), v.core.id, string_of_option((function(prim) do
              return __String(prim);
            end end), v.lowlink), string_of_option((function(prim) do
              return __String(prim);
            end end), v.index));
  Curry._1(log(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "[Graph]   -> stack : ",
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "[Graph]   -> stack : %s\n"
          }), "[" .. (__String.concat(";", List.map((function(param) do
                    return __String(param.core.id);
                  end end), stack_2)) .. "]"));
  if (eq_value(--[[ tuple ]]{
          v.lowlink,
          v.index
        })) then do
    match_1 = List.fold_left((function(param, n) do
            splitted = param[3];
            stack = param[2];
            scc = param[1];
            if (splitted) then do
              return --[[ tuple ]]{
                      scc,
                      --[[ :: ]]{
                        n,
                        stack
                      },
                      splitted
                    };
            end else do
              n.on_stack = false;
              if (n.core.id == v.core.id) then do
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          n.core.id,
                          scc
                        },
                        stack,
                        true
                      };
              end else do
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          n.core.id,
                          scc
                        },
                        stack,
                        false
                      };
              end end 
            end end 
          end end), --[[ tuple ]]{
          --[[ [] ]]0,
          --[[ [] ]]0,
          false
        }, stack_2);
    return --[[ tuple ]]{
            --[[ :: ]]{
              match_1[1],
              sccs_1
            },
            List.rev(match_1[2]),
            index_1
          };
  end else do
    return --[[ tuple ]]{
            sccs_1,
            stack_2,
            index_1
          };
  end end 
end end

function tarjan(g) do
  g_1 = reset(g);
  return fold((function(param, n, param_1) do
                  index = param_1[3];
                  stack = param_1[2];
                  sccs = param_1[1];
                  match = n.index;
                  if (match ~= nil) then do
                    return --[[ tuple ]]{
                            sccs,
                            stack,
                            index
                          };
                  end else do
                    return strong_connect(g_1, sccs, stack, index, n);
                  end end 
                end end), g_1, --[[ tuple ]]{
                --[[ [] ]]0,
                --[[ [] ]]0,
                0
              })[1];
end end

function field_name(param) do
  return param.field_parsed.field_name;
end end

function field_number(param) do
  return param.field_parsed.field_number;
end end

function field_type(param) do
  return param.field_type;
end end

function field_label(param) do
  return param.field_parsed.field_label;
end end

function field_default(param) do
  return param.field_default;
end end

function field_options(param) do
  return param.field_options;
end end

function find_field_option(field_options, option_name) do
  x;
  xpcall(function() do
    x = List.assoc(option_name, field_options);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
  return Caml_option.some(x);
end end

function field_option(param, option_name) do
  return find_field_option(param.field_options, option_name);
end end

function type_id_of_type(param) do
  return param.id;
end end

function type_of_id(all_types, id) do
  return List.find((function(t) do
                return type_id_of_type(t) == id;
              end end), all_types);
end end

function string_of_unresolved(param) do
  return Curry._3(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "unresolved:{scope ",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ", type_name: ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ", from_root: ",
                                      --[[ Bool ]]Block.__(9, {
                                          --[[ No_padding ]]0,
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ "}" ]]125,
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    }),
                  "unresolved:{scope %s, type_name: %s, from_root: %b}"
                }), string_of_string_list(param.scope), param.type_name, param.from_root);
end end

function scope_of_package(param) do
  if (param ~= nil) then do
    return {
            packages = List.rev(rev_split_by_char(--[[ "." ]]46, param)),
            message_names = --[[ [] ]]0
          };
  end else do
    return {
            packages = --[[ [] ]]0,
            message_names = --[[ [] ]]0
          };
  end end 
end end

function unresolved_of_string(s) do
  match = rev_split_by_char(--[[ "." ]]46, s);
  if (match) then do
    return {
            scope = List.rev(match[2]),
            type_name = match[1],
            from_root = Caml_string.get(s, 0) == --[[ "." ]]46
          };
  end else do
    error({
      Compilation_error,
      --[[ Programatic_error ]]Block.__(4, {--[[ Invalid_string_split ]]0})
    })
  end end 
end end

function field_type_of_string(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ == "bool" then do
        return --[[ Field_type_bool ]]12; end end 
     if ___conditional___ == "bytes" then do
        return --[[ Field_type_bytes ]]14; end end 
     if ___conditional___ == "double" then do
        return --[[ Field_type_double ]]0; end end 
     if ___conditional___ == "fixed32" then do
        return --[[ Field_type_fixed32 ]]8; end end 
     if ___conditional___ == "fixed64" then do
        return --[[ Field_type_fixed64 ]]9; end end 
     if ___conditional___ == "float" then do
        return --[[ Field_type_float ]]1; end end 
     if ___conditional___ == "int32" then do
        return --[[ Field_type_int32 ]]2; end end 
     if ___conditional___ == "int64" then do
        return --[[ Field_type_int64 ]]3; end end 
     if ___conditional___ == "sfixed32" then do
        return --[[ Field_type_sfixed32 ]]10; end end 
     if ___conditional___ == "sfixed64" then do
        return --[[ Field_type_sfixed64 ]]11; end end 
     if ___conditional___ == "sint32" then do
        return --[[ Field_type_sint32 ]]6; end end 
     if ___conditional___ == "sint64" then do
        return --[[ Field_type_sint64 ]]7; end end 
     if ___conditional___ == "string" then do
        return --[[ Field_type_string ]]13; end end 
     if ___conditional___ == "uint32" then do
        return --[[ Field_type_uint32 ]]4; end end 
     if ___conditional___ == "uint64" then do
        return --[[ Field_type_uint64 ]]5; end end 
    return --[[ Field_type_type ]]{unresolved_of_string(s)};
      
  end
end end

function compile_default_p2(all_types, field) do
  field_name_1 = field_name(field);
  field_type_1 = field_type(field);
  field_default_1 = field_default(field);
  if (field_default_1 ~= nil) then do
    constant = field_default_1;
    exit = 0;
    if (type(field_type_1) == "number") then do
      local ___conditional___=(field_type_1);
      do
         if ___conditional___ == 0--[[ Field_type_double ]]
         or ___conditional___ == 1--[[ Field_type_float ]] then do
            exit = 1; end else 
         if ___conditional___ == 4--[[ Field_type_uint32 ]]
         or ___conditional___ == 5--[[ Field_type_uint64 ]] then do
            exit = 3; end else 
         if ___conditional___ == 2--[[ Field_type_int32 ]]
         or ___conditional___ == 3--[[ Field_type_int64 ]]
         or ___conditional___ == 6--[[ Field_type_sint32 ]]
         or ___conditional___ == 7--[[ Field_type_sint64 ]]
         or ___conditional___ == 8--[[ Field_type_fixed32 ]]
         or ___conditional___ == 9--[[ Field_type_fixed64 ]]
         or ___conditional___ == 10--[[ Field_type_sfixed32 ]]
         or ___conditional___ == 11--[[ Field_type_sfixed64 ]] then do
            exit = 2; end else 
         if ___conditional___ == 12--[[ Field_type_bool ]] then do
            if (constant.tag == --[[ Constant_bool ]]1) then do
              return constant;
            end else do
              return invalid_default_value(field_name_1, "invalid default type (bool expected)", --[[ () ]]0);
            end end  end end end end end end end end 
         if ___conditional___ == 13--[[ Field_type_string ]] then do
            if (constant.tag) then do
              return invalid_default_value(field_name_1, "invalid default type (string expected)", --[[ () ]]0);
            end else do
              return constant;
            end end  end end 
         if ___conditional___ == 14--[[ Field_type_bytes ]] then do
            return invalid_default_value(field_name_1, "default value not supported for bytes", --[[ () ]]0); end end 
        
      end
    end else if (constant.tag == --[[ Constant_litteral ]]4) then do
      default_enum_value = constant[1];
      match = type_of_id(all_types, field_type_1[1]);
      spec = match.spec;
      if (spec.tag) then do
        return invalid_default_value(field_name_1, "field of type message cannot have a default litteral value", --[[ () ]]0);
      end else do
        default_enum_value_1 = apply_until((function(param) do
                enum_value_name = param.enum_value_name;
                if (enum_value_name == default_enum_value) then do
                  return enum_value_name;
                end
                 end 
              end end), spec[1].enum_values);
        if (default_enum_value_1 ~= nil) then do
          return constant;
        end else do
          return invalid_default_value(field_name_1, "Invalid default enum value", --[[ () ]]0);
        end end 
      end end 
    end else do
      return invalid_default_value(field_name_1, "default value not supported for message", --[[ () ]]0);
    end end  end 
    local ___conditional___=(exit);
    do
       if ___conditional___ == 1 then do
          local ___conditional___=(constant.tag | 0);
          do
             if ___conditional___ == 2--[[ Constant_int ]] then do
                return --[[ Constant_float ]]Block.__(3, {constant[1]}); end end 
             if ___conditional___ == 3--[[ Constant_float ]] then do
                return constant; end end 
            return invalid_default_value(field_name_1, "invalid default type (float/int expected)", --[[ () ]]0);
              
          end end end 
       if ___conditional___ == 2 then do
          if (constant.tag == --[[ Constant_int ]]2) then do
            return constant;
          end else do
            return invalid_default_value(field_name_1, "invalid default type (int expected)", --[[ () ]]0);
          end end  end end 
       if ___conditional___ == 3 then do
          if (constant.tag == --[[ Constant_int ]]2) then do
            if (constant[1] >= 0) then do
              return constant;
            end else do
              return invalid_default_value(field_name_1, "negative default value for unsigned int", --[[ () ]]0);
            end end 
          end else do
            return invalid_default_value(field_name_1, "invalid default type (int expected)", --[[ () ]]0);
          end end  end end 
      
    end
  end
   end 
end end

function get_default(field_name, field_options, field_type) do
  constant;
  xpcall(function() do
    constant = List.assoc("default", field_options);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
  return Caml_option.some(constant);
end end

function compile_field_p1(field_parsed) do
  field_options = field_parsed.field_options;
  field_type = field_type_of_string(field_parsed.field_type);
  field_default = get_default(field_parsed.field_name, field_options, field_type);
  return {
          field_parsed = field_parsed,
          field_type = field_type,
          field_default = field_default,
          field_options = field_options
        };
end end

function compile_map_p1(param) do
  return {
          map_name = param.map_name,
          map_number = param.map_number,
          map_key_type = field_type_of_string(param.map_key_type),
          map_value_type = field_type_of_string(param.map_value_type),
          map_options = param.map_options
        };
end end

function compile_oneof_p1(param) do
  return {
          oneof_name = param.oneof_name,
          oneof_fields = List.map(compile_field_p1, param.oneof_fields)
        };
end end

function not_found(f) do
  xpcall(function() do
    Curry._1(f, --[[ () ]]0);
    return false;
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return true;
    end else do
      error(exn)
    end end 
  end end)
end end

function list_assoc2(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[1];
      if (Caml_obj.caml_equal(match[2], x)) then do
        return match[1];
      end else do
        _param = param[2];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function type_of_spec(file_name, file_options, id, scope, spec) do
  return {
          scope = scope,
          id = id,
          file_name = file_name,
          file_options = file_options,
          spec = spec
        };
end end

function compile_enum_p1(file_name, file_options, scope, param) do
  enum_values = List.map((function(enum_value) do
          return {
                  enum_value_name = enum_value.enum_value_name,
                  enum_value_int = enum_value.enum_value_int
                };
        end end), param.enum_values);
  return type_of_spec(file_name, file_options, param.enum_id, scope, --[[ Enum ]]Block.__(0, {{
                  enum_name = param.enum_name,
                  enum_values = enum_values
                }}));
end end

function compile_message_p1(file_name, file_options, message_scope, param) do
  message_name = param.message_name;
  sub_scope_packages = message_scope.packages;
  sub_scope_message_names = Pervasives._at(message_scope.message_names, --[[ :: ]]{
        message_name,
        --[[ [] ]]0
      });
  sub_scope = {
    packages = sub_scope_packages,
    message_names = sub_scope_message_names
  };
  match = List.fold_left((function(param, param_1) do
          all_types = param[3];
          extensions = param[2];
          message_body = param[1];
          local ___conditional___=(param_1.tag | 0);
          do
             if ___conditional___ == 0--[[ Message_field ]] then do
                field = --[[ Message_field ]]Block.__(0, {compile_field_p1(param_1[1])});
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          field,
                          message_body
                        },
                        extensions,
                        all_types
                      }; end end 
             if ___conditional___ == 1--[[ Message_map_field ]] then do
                field_1 = --[[ Message_map_field ]]Block.__(2, {compile_map_p1(param_1[1])});
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          field_1,
                          message_body
                        },
                        extensions,
                        all_types
                      }; end end 
             if ___conditional___ == 2--[[ Message_oneof_field ]] then do
                field_2 = --[[ Message_oneof_field ]]Block.__(1, {compile_oneof_p1(param_1[1])});
                return --[[ tuple ]]{
                        --[[ :: ]]{
                          field_2,
                          message_body
                        },
                        extensions,
                        all_types
                      }; end end 
             if ___conditional___ == 3--[[ Message_sub ]] then do
                all_sub_types = compile_message_p1(file_name, file_options, sub_scope, param_1[1]);
                return --[[ tuple ]]{
                        message_body,
                        extensions,
                        Pervasives._at(all_types, all_sub_types)
                      }; end end 
             if ___conditional___ == 4--[[ Message_enum ]] then do
                return --[[ tuple ]]{
                        message_body,
                        extensions,
                        Pervasives._at(all_types, --[[ :: ]]{
                              compile_enum_p1(file_name, file_options, sub_scope, param_1[1]),
                              --[[ [] ]]0
                            })
                      }; end end 
             if ___conditional___ == 5--[[ Message_extension ]] then do
                return --[[ tuple ]]{
                        message_body,
                        Pervasives._at(extensions, param_1[1]),
                        all_types
                      }; end end 
            
          end
        end end), --[[ tuple ]]{
        --[[ [] ]]0,
        --[[ [] ]]0,
        --[[ [] ]]0
      }, param.message_body);
  message_body = List.rev(match[1]);
  validate_duplicate = function(number_index, field) do
    number = field_number(field);
    name = field_name(field);
    if (not_found((function(param) do
              List.assoc(number, number_index);
              return --[[ () ]]0;
            end end)) and not_found((function(param) do
              list_assoc2(name, number_index);
              return --[[ () ]]0;
            end end))) then do
      return --[[ :: ]]{
              --[[ tuple ]]{
                number,
                name
              },
              number_index
            };
    end else do
      field_name_1 = name;
      previous_field_name = "";
      message_name_1 = message_name;
      error({
        Compilation_error,
        --[[ Duplicated_field_number ]]Block.__(1, {{
              field_name = field_name_1,
              previous_field_name = previous_field_name,
              message_name = message_name_1
            }})
      })
    end end 
  end end;
  List.fold_left((function(number_index, param) do
          local ___conditional___=(param.tag | 0);
          do
             if ___conditional___ == 0--[[ Message_field ]] then do
                return validate_duplicate(number_index, param[1]); end end 
             if ___conditional___ == 1--[[ Message_oneof_field ]] then do
                return List.fold_left(validate_duplicate, number_index, param[1].oneof_fields); end end 
             if ___conditional___ == 2--[[ Message_map_field ]] then do
                return number_index; end end 
            
          end
        end end), --[[ [] ]]0, message_body);
  return Pervasives._at(match[3], --[[ :: ]]{
              type_of_spec(file_name, file_options, param.id, message_scope, --[[ Message ]]Block.__(1, {{
                        extensions = match[2],
                        message_name = message_name,
                        message_body = message_body
                      }})),
              --[[ [] ]]0
            });
end end

function compile_proto_p1(file_name, param) do
  file_options = param.file_options;
  scope = scope_of_package(param.__package);
  pbtt_msgs = List.fold_right((function(e, pbtt_msgs) do
          return --[[ :: ]]{
                  compile_enum_p1(file_name, file_options, scope, e),
                  pbtt_msgs
                };
        end end), param.enums, --[[ [] ]]0);
  return List.fold_left((function(pbtt_msgs, pbpt_msg) do
                return Pervasives._at(pbtt_msgs, compile_message_p1(file_name, file_options, scope, pbpt_msg));
              end end), pbtt_msgs, param.messages);
end end

function type_scope_of_type(param) do
  return param.scope;
end end

function is_empty_message(param) do
  match = param.spec;
  if (match.tag) then do
    return 0 == List.length(match[1].message_body);
  end else do
    return false;
  end end 
end end

function type_name_of_type(param) do
  match = param.spec;
  if (match.tag) then do
    return match[1].message_name;
  end else do
    return match[1].enum_name;
  end end 
end end

function find_all_types_in_field_scope(all_types, scope) do
  return List.filter((function(t) do
                  match = type_scope_of_type(t);
                  dec_scope = Pervasives._at(match.packages, match.message_names);
                  return Caml_obj.caml_equal(dec_scope, scope);
                end end))(all_types);
end end

function compile_message_p2(types, param, message) do
  message_name = message.message_name;
  message_scope = Pervasives._at(param.packages, Pervasives._at(param.message_names, --[[ :: ]]{
            message_name,
            --[[ [] ]]0
          }));
  search_scopes = function(field_scope, from_root) do
    if (from_root) then do
      return --[[ :: ]]{
              field_scope,
              --[[ [] ]]0
            };
    end else do
      loop = function(_scopes, _l) do
        while(true) do
          l = _l;
          scopes = _scopes;
          if (l) then do
            _l = pop_last(l);
            _scopes = --[[ :: ]]{
              Pervasives._at(l, field_scope),
              scopes
            };
            ::continue:: ;
          end else do
            return --[[ :: ]]{
                    field_scope,
                    scopes
                  };
          end end 
        end;
      end end;
      return List.rev(loop(--[[ [] ]]0, message_scope));
    end end 
  end end;
  compile_field_p2 = function(field_name, field_type) do
    Curry._1(log(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "[pbtt] field_name: ",
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    })
                }),
              "[pbtt] field_name: %s\n"
            }), field_name);
    if (type(field_type) == "number") then do
      param = field_type;
      if (type(param) == "number") then do
        return param;
      end else do
        error({
          Compilation_error,
          --[[ Programatic_error ]]Block.__(4, {--[[ Unexpected_field_type ]]1})
        })
      end end 
    end else do
      unresolved = field_type[1];
      type_name = unresolved.type_name;
      endline("[pbtt] " .. string_of_unresolved(unresolved));
      search_scopes_1 = search_scopes(unresolved.scope, unresolved.from_root);
      Curry._1(log(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "[pbtt] message scope: ",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "\n" ]]10,
                            --[[ End_of_format ]]0
                          })
                      })
                  }),
                "[pbtt] message scope: %s\n"
              }), string_of_string_list(message_scope));
      List.iteri((function(i, scope) do
              return Curry._2(log(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "[pbtt] search_scope[",
                                  --[[ Int ]]Block.__(4, {
                                      --[[ Int_i ]]3,
                                      --[[ Lit_padding ]]Block.__(0, {
                                          --[[ Right ]]1,
                                          2
                                        }),
                                      --[[ No_precision ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          "] : ",
                                          --[[ String ]]Block.__(2, {
                                              --[[ No_padding ]]0,
                                              --[[ Char_literal ]]Block.__(12, {
                                                  --[[ "\n" ]]10,
                                                  --[[ End_of_format ]]0
                                                })
                                            })
                                        })
                                    })
                                }),
                              "[pbtt] search_scope[%2i] : %s\n"
                            }), i, string_of_string_list(scope));
            end end), search_scopes_1);
      id = apply_until((function(scope) do
              types_1 = types;
              scope_1 = scope;
              type_name_1 = type_name;
              types_2 = find_all_types_in_field_scope(types_1, scope_1);
              xpcall(function() do
                t = List.find((function(t) do
                        return type_name_1 == type_name_of_type(t);
                      end end), types_2);
                return type_id_of_type(t);
              end end,function(exn) do
                if (exn == Caml_builtin_exceptions.not_found) then do
                  return ;
                end else do
                  error(exn)
                end end 
              end end)
            end end), search_scopes_1);
      if (id ~= nil) then do
        return --[[ Field_type_type ]]{id};
      end else do
        field_name_1 = field_name;
        type_ = type_name;
        message_name_1 = message_name;
        error({
          Compilation_error,
          --[[ Unresolved_type ]]Block.__(0, {{
                field_name = field_name_1,
                type_ = type_,
                message_name = message_name_1
              }})
        })
      end end 
    end end 
  end end;
  message_body = List.fold_left((function(message_body, param) do
          local ___conditional___=(param.tag | 0);
          do
             if ___conditional___ == 0--[[ Message_field ]] then do
                field = param[1];
                field_name_1 = field_name(field);
                field_type_1 = field_type(field);
                field_field_parsed = field.field_parsed;
                field_field_type = compile_field_p2(field_name_1, field_type_1);
                field_field_default = field.field_default;
                field_field_options = field.field_options;
                field_1 = {
                  field_parsed = field_field_parsed,
                  field_type = field_field_type,
                  field_default = field_field_default,
                  field_options = field_field_options
                };
                field_field_parsed_1 = field_field_parsed;
                field_field_type_1 = field_field_type;
                field_field_default_1 = compile_default_p2(types, field_1);
                field_field_options_1 = field_field_options;
                field_2 = {
                  field_parsed = field_field_parsed_1,
                  field_type = field_field_type_1,
                  field_default = field_field_default_1,
                  field_options = field_field_options_1
                };
                return --[[ :: ]]{
                        --[[ Message_field ]]Block.__(0, {field_2}),
                        message_body
                      }; end end 
             if ___conditional___ == 1--[[ Message_oneof_field ]] then do
                oneof = param[1];
                oneof_fields = List.fold_left((function(oneof_fields, field) do
                        field_name_2 = field_name(field);
                        field_type_2 = field_type(field);
                        field_type_3 = compile_field_p2(field_name_2, field_type_2);
                        return --[[ :: ]]{
                                {
                                  field_parsed = field.field_parsed,
                                  field_type = field_type_3,
                                  field_default = field.field_default,
                                  field_options = field.field_options
                                },
                                oneof_fields
                              };
                      end end), --[[ [] ]]0, oneof.oneof_fields);
                oneof_fields_1 = List.rev(oneof_fields);
                return --[[ :: ]]{
                        --[[ Message_oneof_field ]]Block.__(1, {{
                              oneof_name = oneof.oneof_name,
                              oneof_fields = oneof_fields_1
                            }}),
                        message_body
                      }; end end 
             if ___conditional___ == 2--[[ Message_map_field ]] then do
                map = param[1];
                map_name = map.map_name;
                map_key_type = compile_field_p2(map_name, map.map_key_type);
                map_value_type = compile_field_p2(map_name, map.map_value_type);
                resolved_map = --[[ Message_map_field ]]Block.__(2, {{
                      map_name = map_name,
                      map_number = map.map_number,
                      map_key_type = map_key_type,
                      map_value_type = map_value_type,
                      map_options = map.map_options
                    }});
                return --[[ :: ]]{
                        resolved_map,
                        message_body
                      }; end end 
            
          end
        end end), --[[ [] ]]0, message.message_body);
  message_body_1 = List.rev(message_body);
  return {
          extensions = message.extensions,
          message_name = message.message_name,
          message_body = message_body_1
        };
end end

function node_of_proto_type(param) do
  match = param.spec;
  id = param.id;
  if (match.tag) then do
    sub = List.flatten(List.map((function(param) do
                local ___conditional___=(param.tag | 0);
                do
                   if ___conditional___ == 0--[[ Message_field ]] then do
                      field_type = param[1].field_type;
                      if (type(field_type) == "number") then do
                        return --[[ [] ]]0;
                      end else do
                        return --[[ :: ]]{
                                field_type[1],
                                --[[ [] ]]0
                              };
                      end end  end end 
                   if ___conditional___ == 1--[[ Message_oneof_field ]] then do
                      return List.flatten(List.map((function(param) do
                                        field_type = param.field_type;
                                        if (type(field_type) == "number") then do
                                          return --[[ [] ]]0;
                                        end else do
                                          return --[[ :: ]]{
                                                  field_type[1],
                                                  --[[ [] ]]0
                                                };
                                        end end 
                                      end end), param[1].oneof_fields)); end end 
                   if ___conditional___ == 2--[[ Message_map_field ]] then do
                      map_value_type = param[1].map_value_type;
                      if (type(map_value_type) == "number") then do
                        return --[[ [] ]]0;
                      end else do
                        return --[[ :: ]]{
                                map_value_type[1],
                                --[[ [] ]]0
                              };
                      end end  end end 
                  
                end
              end end), match[1].message_body));
    return {
            id = id,
            sub = sub
          };
  end else do
    return {
            id = id,
            sub = --[[ [] ]]0
          };
  end end 
end end

function group(proto) do
  g = List.map(node_of_proto_type, proto);
  g_1 = List.fold_left((function(m, n) do
          n_1 = n;
          g = m;
          return add(n_1.id, n_1, g);
        end end), --[[ Empty ]]0, g);
  sccs = tarjan(g_1);
  return List.map((function(l) do
                return List.map((function(id) do
                              return List.find((function(param) do
                                            input_id = id;
                                            param_1 = param;
                                            return input_id == param_1.id;
                                          end end), proto);
                            end end), l);
              end end), sccs);
end end

function type_decl_of_and(param) do
  if (param ~= nil) then do
    return "and";
  end else do
    return "type";
  end end 
end end

function gen_type_record(mutable_, and_, param, sc) do
  r_fields = param.r_fields;
  r_name = param.r_name;
  mutable__1 = mutable_ ~= nil;
  is_imperative_type = function(param) do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 2--[[ Rft_repeated_field ]]
       or ___conditional___ == 3--[[ Rft_associative_field ]] then do
          if (param[1][1]) then do
            return true;
          end else do
            return false;
          end end  end end 
      return false;
        
    end
  end end;
  field_prefix = function(field_type, field_mutable) do
    if (field_mutable or not (is_imperative_type(field_type) or not mutable__1)) then do
      return "mutable ";
    end else do
      return "";
    end end 
  end end;
  r_name_1 = mutable__1 and r_name .. "_mutable" or r_name;
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ " " ]]32,
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " = {",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s %s = {"
              }), type_decl_of_and(and_), r_name_1));
  scope(sc, (function(sc) do
          return List.iter((function(param) do
                        rf_field_type = param.rf_field_type;
                        prefix = field_prefix(rf_field_type, param.rf_mutable);
                        type_string = string_of_record_field_type(rf_field_type);
                        return line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                                            --[[ String ]]Block.__(2, {
                                                --[[ No_padding ]]0,
                                                --[[ String ]]Block.__(2, {
                                                    --[[ No_padding ]]0,
                                                    --[[ String_literal ]]Block.__(11, {
                                                        " : ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ Char_literal ]]Block.__(12, {
                                                                --[[ ";" ]]59,
                                                                --[[ End_of_format ]]0
                                                              })
                                                          })
                                                      })
                                                  })
                                              }),
                                            "%s%s : %s;"
                                          }), prefix, param.rf_label, type_string));
                      end end), r_fields);
        end end));
  return line_1(sc, "}");
end end

function gen_type_variant(and_, variant, sc) do
  v_constructors = variant.v_constructors;
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ " " ]]32,
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " =",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s %s ="
              }), type_decl_of_and(and_), variant.v_name));
  return scope(sc, (function(sc) do
                return List.iter((function(param) do
                              vc_field_type = param.vc_field_type;
                              vc_constructor = param.vc_constructor;
                              if (vc_field_type) then do
                                type_string = string_of_field_type(vc_field_type[1]);
                                return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " of ",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ End_of_format ]]0
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "| %s of %s"
                                                  }), vc_constructor, type_string));
                              end else do
                                return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ End_of_format ]]0
                                                          })
                                                      }),
                                                    "| %s"
                                                  }), vc_constructor));
                              end end 
                            end end), v_constructors);
              end end));
end end

function gen_type_const_variant(and_, param, sc) do
  cv_constructors = param.cv_constructors;
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ " " ]]32,
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " =",
                                --[[ End_of_format ]]0
                              })
                          })
                      })
                  }),
                "%s %s ="
              }), type_decl_of_and(and_), param.cv_name));
  return scope(sc, (function(sc) do
                return List.iter((function(param) do
                              return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                  --[[ String_literal ]]Block.__(11, {
                                                      "| ",
                                                      --[[ String ]]Block.__(2, {
                                                          --[[ No_padding ]]0,
                                                          --[[ Char_literal ]]Block.__(12, {
                                                              --[[ " " ]]32,
                                                              --[[ End_of_format ]]0
                                                            })
                                                        })
                                                    }),
                                                  "| %s "
                                                }), param[1]));
                            end end), cv_constructors);
              end end));
end end

function gen_struct_2(and_, t, scope) do
  match = t.spec;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        r = match[1];
        gen_type_record(nil, and_, r, scope);
        line_1(scope, "");
        gen_type_record(--[[ () ]]0, --[[ () ]]0, r, scope); end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        gen_type_variant(and_, match[1], scope); end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        gen_type_const_variant(and_, match[1], scope); end else 
     end end end end end end
    
  end
  return true;
end end

function gen_sig_2(and_, t, scope) do
  match = t.spec;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        gen_type_record(nil, and_, match[1], scope); end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        gen_type_variant(and_, match[1], scope); end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        gen_type_const_variant(and_, match[1], scope); end else 
     end end end end end end
    
  end
  return true;
end end

Codegen_type = {
  gen_sig = gen_sig_2,
  gen_struct = gen_struct_2,
  ocamldoc_title = "Types"
};

function gen_encode_field_key(sc, number, pk, is_packed) do
  s = string_of_payload_kind(nil, pk, is_packed);
  s_1 = Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s)));
  return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "Pbrt.Encoder.key (",
                          --[[ Int ]]Block.__(4, {
                              --[[ Int_i ]]3,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  ", Pbrt.",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          ") encoder; ",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                })
                            })
                        }),
                      "Pbrt.Encoder.key (%i, Pbrt.%s) encoder; "
                    }), number, Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s_1)))));
end end

function encode_basic_type(bt, pk) do
  return runtime_function(--[[ tuple ]]{
              --[[ Encode ]]779642422,
              pk,
              bt
            });
end end

function gen_encode_field_type(with_key, sc, var_name, encoding_number, pk, is_packed, field_type) do
  encode_key = function(sc) do
    if (with_key ~= nil) then do
      return gen_encode_field_key(sc, encoding_number, pk, is_packed);
    end else do
      return --[[ () ]]0;
    end end 
  end end;
  if (type(field_type) == "number") then do
    encode_key(sc);
    return line_1(sc, "Pbrt.Encoder.empty_nested encoder;");
  end else if (field_type.tag) then do
    ud = field_type[1];
    encode_key(sc);
    f_name = function_name_of_user_defined("encode", ud);
    if (ud.udt_nested) then do
      return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Pbrt.Encoder.nested (",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ " " ]]32,
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ") encoder;",
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    })
                                })
                            }),
                          "Pbrt.Encoder.nested (%s %s) encoder;"
                        }), f_name, var_name));
    end else do
      return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, {
                                  --[[ " " ]]32,
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " encoder;",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                })
                            }),
                          "%s %s encoder;"
                        }), f_name, var_name));
    end end 
  end else do
    encode_key(sc);
    rt = encode_basic_type(field_type[1], pk);
    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ " " ]]32,
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        " encoder;",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          }),
                        "%s %s encoder;"
                      }), rt, var_name));
  end end  end 
end end

function gen_encode_record(and_, param, sc) do
  r_fields = param.r_fields;
  r_name = param.r_name;
  Curry._1(log(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "gen_encode_record record_name: ",
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "gen_encode_record record_name: %s\n"
          }), r_name);
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " encode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") encoder = ",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s encode_%s (v:%s) encoder = "
              }), let_decl_of_and(and_), r_name, r_name));
  return scope(sc, (function(sc) do
                List.iter((function(record_field) do
                        rf_field_type = record_field.rf_field_type;
                        rf_label = record_field.rf_label;
                        local ___conditional___=(rf_field_type.tag | 0);
                        do
                           if ___conditional___ == 0--[[ Rft_required ]] then do
                              match = rf_field_type[1];
                              var_name = Curry._1(Printf.sprintf(--[[ Format ]]{
                                        --[[ String_literal ]]Block.__(11, {
                                            "v.",
                                            --[[ String ]]Block.__(2, {
                                                --[[ No_padding ]]0,
                                                --[[ End_of_format ]]0
                                              })
                                          }),
                                        "v.%s"
                                      }), rf_label);
                              return gen_encode_field_type(--[[ () ]]0, sc, var_name, match[2], match[3], false, match[1]); end end 
                           if ___conditional___ == 1--[[ Rft_optional ]] then do
                              match_1 = rf_field_type[1];
                              pk = match_1[3];
                              encoding_number = match_1[2];
                              field_type = match_1[1];
                              line_1(sc, "(");
                              scope(sc, (function(sc) do
                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "match v.",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " with ",
                                                                --[[ End_of_format ]]0
                                                              })
                                                          })
                                                      }),
                                                    "match v.%s with "
                                                  }), rf_label));
                                      line_1(sc, Printf.sprintf(--[[ Format ]]{
                                                --[[ String_literal ]]Block.__(11, {
                                                    "| Some x -> (",
                                                    --[[ End_of_format ]]0
                                                  }),
                                                "| Some x -> ("
                                              }));
                                      scope(sc, (function(sc) do
                                              return gen_encode_field_type(--[[ () ]]0, sc, "x", encoding_number, pk, false, field_type);
                                            end end));
                                      line_1(sc, ")");
                                      return line_1(sc, "| None -> ();");
                                    end end));
                              return line_1(sc, ");"); end end 
                           if ___conditional___ == 2--[[ Rft_repeated_field ]] then do
                              match_2 = rf_field_type[1];
                              is_packed = match_2[5];
                              pk_1 = match_2[4];
                              encoding_number_1 = match_2[3];
                              field_type_1 = match_2[2];
                              if (match_2[1]) then do
                                if (is_packed) then do
                                  gen_encode_field_key(sc, encoding_number_1, pk_1, is_packed);
                                  line_1(sc, "Pbrt.Encoder.nested (fun encoder ->");
                                  scope(sc, (function(sc) do
                                          line_1(sc, "Pbrt.Repeated_field.iter (fun x -> ");
                                          scope(sc, (function(sc) do
                                                  return gen_encode_field_type(nil, sc, "x", encoding_number_1, pk_1, is_packed, field_type_1);
                                                end end));
                                          return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                              --[[ String_literal ]]Block.__(11, {
                                                                  ") v.",
                                                                  --[[ String ]]Block.__(2, {
                                                                      --[[ No_padding ]]0,
                                                                      --[[ Char_literal ]]Block.__(12, {
                                                                          --[[ ";" ]]59,
                                                                          --[[ End_of_format ]]0
                                                                        })
                                                                    })
                                                                }),
                                                              ") v.%s;"
                                                            }), rf_label));
                                        end end));
                                  return line_1(sc, ") encoder;");
                                end else do
                                  line_1(sc, "Pbrt.Repeated_field.iter (fun x -> ");
                                  scope(sc, (function(sc) do
                                          return gen_encode_field_type(--[[ () ]]0, sc, "x", encoding_number_1, pk_1, is_packed, field_type_1);
                                        end end));
                                  return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                      --[[ String_literal ]]Block.__(11, {
                                                          ") v.",
                                                          --[[ String ]]Block.__(2, {
                                                              --[[ No_padding ]]0,
                                                              --[[ Char_literal ]]Block.__(12, {
                                                                  --[[ ";" ]]59,
                                                                  --[[ End_of_format ]]0
                                                                })
                                                            })
                                                        }),
                                                      ") v.%s;"
                                                    }), rf_label));
                                end end 
                              end else if (is_packed) then do
                                gen_encode_field_key(sc, encoding_number_1, pk_1, is_packed);
                                line_1(sc, "Pbrt.Encoder.nested (fun encoder ->");
                                scope(sc, (function(sc) do
                                        line_1(sc, "List.iter (fun x -> ");
                                        scope(sc, (function(sc) do
                                                return gen_encode_field_type(nil, sc, "x", encoding_number_1, pk_1, is_packed, field_type_1);
                                              end end));
                                        return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                            --[[ String_literal ]]Block.__(11, {
                                                                ") v.",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ Char_literal ]]Block.__(12, {
                                                                        --[[ ";" ]]59,
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              }),
                                                            ") v.%s;"
                                                          }), rf_label));
                                      end end));
                                return line_1(sc, ") encoder;");
                              end else do
                                line_1(sc, "List.iter (fun x -> ");
                                scope(sc, (function(sc) do
                                        return gen_encode_field_type(--[[ () ]]0, sc, "x", encoding_number_1, pk_1, is_packed, field_type_1);
                                      end end));
                                return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        ") v.",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ Char_literal ]]Block.__(12, {
                                                                --[[ ";" ]]59,
                                                                --[[ End_of_format ]]0
                                                              })
                                                          })
                                                      }),
                                                    ") v.%s;"
                                                  }), rf_label));
                              end end  end  end end 
                           if ___conditional___ == 3--[[ Rft_associative_field ]] then do
                              match_3 = rf_field_type[1];
                              match_4 = match_3[4];
                              value_pk = match_4[2];
                              value_type = match_4[1];
                              match_5 = match_3[3];
                              key_pk = match_5[2];
                              encoding_number_2 = match_3[2];
                              line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                            --[[ String_literal ]]Block.__(11, {
                                                "let encode_key = ",
                                                --[[ String ]]Block.__(2, {
                                                    --[[ No_padding ]]0,
                                                    --[[ String_literal ]]Block.__(11, {
                                                        " in",
                                                        --[[ End_of_format ]]0
                                                      })
                                                  })
                                              }),
                                            "let encode_key = %s in"
                                          }), encode_basic_type(match_5[1], key_pk)));
                              line_1(sc, "let encode_value = (fun x encoder ->");
                              scope(sc, (function(sc) do
                                      return gen_encode_field_type(nil, sc, "x", -1, value_pk, false, value_type);
                                    end end));
                              line_1(sc, ") in");
                              if (match_3[1]) then do
                                line_1(sc, "Hashtbl.iter (fun k v ->");
                              end else do
                                line_1(sc, "List.iter (fun (k, v) ->");
                              end end 
                              scope(sc, (function(sc) do
                                      gen_encode_field_key(sc, encoding_number_2, --[[ Pk_bytes ]]2, false);
                                      line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "let map_entry = (k, Pbrt.",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                "), (v, Pbrt.",
                                                                --[[ String ]]Block.__(2, {
                                                                    --[[ No_padding ]]0,
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        ") in",
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "let map_entry = (k, Pbrt.%s), (v, Pbrt.%s) in"
                                                  }), string_of_payload_kind(--[[ () ]]0, key_pk, false), string_of_payload_kind(--[[ () ]]0, value_pk, false)));
                                      return line_1(sc, "Pbrt.Encoder.map_entry ~encode_key ~encode_value map_entry encoder");
                                    end end));
                              return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                  --[[ String_literal ]]Block.__(11, {
                                                      ") v.",
                                                      --[[ String ]]Block.__(2, {
                                                          --[[ No_padding ]]0,
                                                          --[[ Char_literal ]]Block.__(12, {
                                                              --[[ ";" ]]59,
                                                              --[[ End_of_format ]]0
                                                            })
                                                        })
                                                    }),
                                                  ") v.%s;"
                                                }), rf_label)); end end 
                           if ___conditional___ == 4--[[ Rft_variant_field ]] then do
                              v_constructors = rf_field_type[1].v_constructors;
                              line_1(sc, "(");
                              scope(sc, (function(sc) do
                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "match v.",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " with",
                                                                --[[ End_of_format ]]0
                                                              })
                                                          })
                                                      }),
                                                    "match v.%s with"
                                                  }), rf_label));
                                      return List.iter((function(param) do
                                                    vc_payload_kind = param.vc_payload_kind;
                                                    vc_encoding_number = param.vc_encoding_number;
                                                    vc_field_type = param.vc_field_type;
                                                    vc_constructor = param.vc_constructor;
                                                    if (vc_field_type) then do
                                                      field_type = vc_field_type[1];
                                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "| ",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                " x -> (",
                                                                                --[[ End_of_format ]]0
                                                                              })
                                                                          })
                                                                      }),
                                                                    "| %s x -> ("
                                                                  }), vc_constructor));
                                                      scope(sc, (function(sc) do
                                                              return gen_encode_field_type(--[[ () ]]0, sc, "x", vc_encoding_number, vc_payload_kind, false, field_type);
                                                            end end));
                                                      return line_1(sc, ")");
                                                    end else do
                                                      line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        "| ",
                                                                        --[[ String ]]Block.__(2, {
                                                                            --[[ No_padding ]]0,
                                                                            --[[ String_literal ]]Block.__(11, {
                                                                                " -> (",
                                                                                --[[ End_of_format ]]0
                                                                              })
                                                                          })
                                                                      }),
                                                                    "| %s -> ("
                                                                  }), vc_constructor));
                                                      scope(sc, (function(sc) do
                                                              gen_encode_field_key(sc, vc_encoding_number, vc_payload_kind, false);
                                                              return line_1(sc, "Pbrt.Encoder.empty_nested encoder");
                                                            end end));
                                                      return line_1(sc, ")");
                                                    end end 
                                                  end end), v_constructors);
                                    end end));
                              return line_1(sc, ");"); end end 
                          
                        end
                      end end), r_fields);
                return line_1(sc, "()");
              end end));
end end

function gen_encode_variant(and_, variant, sc) do
  v_constructors = variant.v_constructors;
  v_name = variant.v_name;
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " encode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") encoder = ",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s encode_%s (v:%s) encoder = "
              }), let_decl_of_and(and_), v_name, v_name));
  return scope(sc, (function(sc) do
                line_1(sc, "match v with");
                return List.iter((function(param) do
                              vc_payload_kind = param.vc_payload_kind;
                              vc_encoding_number = param.vc_encoding_number;
                              vc_field_type = param.vc_field_type;
                              vc_constructor = param.vc_constructor;
                              if (vc_field_type) then do
                                field_type = vc_field_type[1];
                                line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                              --[[ String_literal ]]Block.__(11, {
                                                  "| ",
                                                  --[[ String ]]Block.__(2, {
                                                      --[[ No_padding ]]0,
                                                      --[[ String_literal ]]Block.__(11, {
                                                          " x -> (",
                                                          --[[ End_of_format ]]0
                                                        })
                                                    })
                                                }),
                                              "| %s x -> ("
                                            }), vc_constructor));
                                scope(sc, (function(sc) do
                                        return gen_encode_field_type(--[[ () ]]0, sc, "x", vc_encoding_number, vc_payload_kind, false, field_type);
                                      end end));
                                return line_1(sc, ")");
                              end else do
                                line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                              --[[ String_literal ]]Block.__(11, {
                                                  "| ",
                                                  --[[ String ]]Block.__(2, {
                                                      --[[ No_padding ]]0,
                                                      --[[ String_literal ]]Block.__(11, {
                                                          " -> (",
                                                          --[[ End_of_format ]]0
                                                        })
                                                    })
                                                }),
                                              "| %s -> ("
                                            }), vc_constructor));
                                scope(sc, (function(sc) do
                                        gen_encode_field_key(sc, vc_encoding_number, vc_payload_kind, false);
                                        return line_1(sc, "Pbrt.Encoder.empty_nested encoder");
                                      end end));
                                return line_1(sc, ")");
                              end end 
                            end end), v_constructors);
              end end));
end end

function gen_encode_const_variant(and_, param, sc) do
  cv_constructors = param.cv_constructors;
  cv_name = param.cv_name;
  line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " encode_",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                " (v:",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ") encoder =",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "%s encode_%s (v:%s) encoder ="
              }), let_decl_of_and(and_), cv_name, cv_name));
  return scope(sc, (function(sc) do
                line_1(sc, "match v with");
                return List.iter((function(param) do
                              value = param[2];
                              name = param[1];
                              return line_1(sc, value > 0 and Curry._2(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " -> Pbrt.Encoder.int_as_varint ",
                                                                --[[ Int ]]Block.__(4, {
                                                                    --[[ Int_i ]]3,
                                                                    --[[ No_padding ]]0,
                                                                    --[[ No_precision ]]0,
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        " encoder",
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "| %s -> Pbrt.Encoder.int_as_varint %i encoder"
                                                  }), name, value) or Curry._2(Printf.sprintf(--[[ Format ]]{
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "| ",
                                                        --[[ String ]]Block.__(2, {
                                                            --[[ No_padding ]]0,
                                                            --[[ String_literal ]]Block.__(11, {
                                                                " -> Pbrt.Encoder.int_as_varint (",
                                                                --[[ Int ]]Block.__(4, {
                                                                    --[[ Int_i ]]3,
                                                                    --[[ No_padding ]]0,
                                                                    --[[ No_precision ]]0,
                                                                    --[[ String_literal ]]Block.__(11, {
                                                                        ") encoder",
                                                                        --[[ End_of_format ]]0
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      }),
                                                    "| %s -> Pbrt.Encoder.int_as_varint (%i) encoder"
                                                  }), name, value));
                            end end), cv_constructors);
              end end));
end end

function gen_struct_3(and_, t, sc) do
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        tmp = --[[ tuple ]]{
          gen_encode_record(and_, match[1], sc),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          gen_encode_variant(and_, match[1], sc),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          gen_encode_const_variant(and_, match[1], sc),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

function gen_sig_3(and_, t, sc) do
  f = function(type_name) do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "val encode_",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " : ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " -> Pbrt.Encoder.t -> unit",
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        })
                    }),
                  "val encode_%s : %s -> Pbrt.Encoder.t -> unit"
                }), type_name, type_name));
    return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "(** [encode_",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " v encoder] encodes [v] with the given [encoder] *)",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          }),
                        "(** [encode_%s v encoder] encodes [v] with the given [encoder] *)"
                      }), type_name));
  end end;
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].r_name),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].v_name),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].cv_name),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

Codegen_encode = {
  gen_sig = gen_sig_3,
  gen_struct = gen_struct_3,
  ocamldoc_title = "Protobuf Toding"
};

function default_value_of_field_type(field_name, field_type, field_default) do
  if (type(field_type) == "number") then do
    return "()";
  end else if (field_type.tag) then do
    return function_name_of_user_defined("default", field_type[1]) .. " ()";
  end else do
    field_name_1 = field_name;
    basic_type = field_type[1];
    field_default_1 = field_default;
    local ___conditional___=(basic_type);
    do
       if ___conditional___ == 0--[[ Bt_string ]] then do
          if (field_default_1 ~= nil) then do
            match = field_default_1;
            if (match.tag) then do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end else do
              return Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ Char_literal ]]Block.__(12, {
                                  --[[ "\"" ]]34,
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ Char_literal ]]Block.__(12, {
                                          --[[ "\"" ]]34,
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "\"%s\""
                            }), match[1]);
            end end 
          end else do
            return "\"\"";
          end end  end end 
       if ___conditional___ == 1--[[ Bt_float ]] then do
          if (field_default_1 ~= nil) then do
            match_1 = field_default_1;
            if (match_1.tag == --[[ Constant_float ]]3) then do
              return Pervasives.string_of_float(match_1[1]);
            end else do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end end 
          end else do
            return "0.";
          end end  end end 
       if ___conditional___ == 2--[[ Bt_int ]] then do
          if (field_default_1 ~= nil) then do
            match_2 = field_default_1;
            if (match_2.tag == --[[ Constant_int ]]2) then do
              return __String(match_2[1]);
            end else do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end end 
          end else do
            return "0";
          end end  end end 
       if ___conditional___ == 3--[[ Bt_int32 ]] then do
          if (field_default_1 ~= nil) then do
            match_3 = field_default_1;
            if (match_3.tag == --[[ Constant_int ]]2) then do
              return Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_i ]]3,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "l" ]]108,
                                      --[[ End_of_format ]]0
                                    })
                                }),
                              "%il"
                            }), match_3[1]);
            end else do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end end 
          end else do
            return "0l";
          end end  end end 
       if ___conditional___ == 4--[[ Bt_int64 ]] then do
          if (field_default_1 ~= nil) then do
            match_4 = field_default_1;
            if (match_4.tag == --[[ Constant_int ]]2) then do
              return Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_i ]]3,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "L" ]]76,
                                      --[[ End_of_format ]]0
                                    })
                                }),
                              "%iL"
                            }), match_4[1]);
            end else do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end end 
          end else do
            return "0L";
          end end  end end 
       if ___conditional___ == 5--[[ Bt_bytes ]] then do
          if (field_default_1 ~= nil) then do
            match_5 = field_default_1;
            if (match_5.tag) then do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end else do
              return Curry._1(Printf.sprintf(--[[ Format ]]{
                              --[[ String_literal ]]Block.__(11, {
                                  "Bytes.of_string \"",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ Char_literal ]]Block.__(12, {
                                          --[[ "\"" ]]34,
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                }),
                              "Bytes.of_string \"%s\""
                            }), match_5[1]);
            end end 
          end else do
            return "Bytes.create 64";
          end end  end end 
       if ___conditional___ == 6--[[ Bt_bool ]] then do
          if (field_default_1 ~= nil) then do
            match_6 = field_default_1;
            if (match_6.tag == --[[ Constant_bool ]]1) then do
              b = match_6[1];
              if (b) then do
                return "true";
              end else do
                return "false";
              end end 
            end else do
              return invalid_default_value(field_name_1, "invalid default type", --[[ () ]]0);
            end end 
          end else do
            return "false";
          end end  end end 
      
    end
  end end  end 
end end

function record_field_default_info(record_field) do
  rf_field_type = record_field.rf_field_type;
  rf_label = record_field.rf_label;
  type_string = string_of_record_field_type(rf_field_type);
  dfvft = function(field_type, defalut_value) do
    return default_value_of_field_type(rf_label, field_type, defalut_value);
  end end;
  default_value;
  local ___conditional___=(rf_field_type.tag | 0);
  do
     if ___conditional___ == 0--[[ Rft_required ]] then do
        match = rf_field_type[1];
        default_value = dfvft(match[1], match[4]); end else 
     if ___conditional___ == 1--[[ Rft_optional ]] then do
        match_1 = rf_field_type[1];
        default_value_1 = match_1[4];
        default_value = default_value_1 ~= nil and Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "Some (",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ ")" ]]41,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "Some (%s)"
                  }), dfvft(match_1[1], default_value_1)) or "None"; end else 
     if ___conditional___ == 2--[[ Rft_repeated_field ]] then do
        match_2 = rf_field_type[1];
        default_value = match_2[1] and Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "Pbrt.Repeated_field.make (",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ ")" ]]41,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "Pbrt.Repeated_field.make (%s)"
                  }), dfvft(match_2[2], nil)) or "[]"; end else 
     if ___conditional___ == 3--[[ Rft_associative_field ]] then do
        default_value = rf_field_type[1][1] and "Hashtbl.create 128" or "[]"; end else 
     if ___conditional___ == 4--[[ Rft_variant_field ]] then do
        v_constructors = rf_field_type[1].v_constructors;
        if (v_constructors) then do
          match_3 = v_constructors[1];
          vc_field_type = match_3.vc_field_type;
          vc_constructor = match_3.vc_constructor;
          default_value = vc_field_type and Curry._2(Printf.sprintf(--[[ Format ]]{
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " (",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ ")" ]]41,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        }),
                      "%s (%s)"
                    }), vc_constructor, dfvft(vc_field_type[1], nil)) or vc_constructor;
        end else do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "codegen_default.ml",
              74,
              15
            }
          })
        end end  end else 
     end end end end end end end end end end
    
  end
  return --[[ tuple ]]{
          rf_label,
          default_value,
          type_string
        };
end end

function gen_default_record(mutable_, and_, param, sc) do
  r_name = param.r_name;
  fields_default_info = List.map(record_field_default_info, param.r_fields);
  if (mutable_ ~= nil) then do
    rn = r_name .. "_mutable";
    line_1(sc, Curry._3(Printf.sprintf(--[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ String_literal ]]Block.__(11, {
                          " default_",
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " () : ",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " = {",
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                })
                            })
                        })
                    }),
                  "%s default_%s () : %s = {"
                }), let_decl_of_and(and_), rn, rn));
    scope(sc, (function(sc) do
            return List.iter((function(param) do
                          return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ String_literal ]]Block.__(11, {
                                                      " = ",
                                                      --[[ String ]]Block.__(2, {
                                                          --[[ No_padding ]]0,
                                                          --[[ Char_literal ]]Block.__(12, {
                                                              --[[ ";" ]]59,
                                                              --[[ End_of_format ]]0
                                                            })
                                                        })
                                                    })
                                                }),
                                              "%s = %s;"
                                            }), param[1], param[2]));
                        end end), fields_default_info);
          end end));
  end else do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ String_literal ]]Block.__(11, {
                          " default_",
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, {
                                  --[[ " " ]]32,
                                  --[[ End_of_format ]]0
                                })
                            })
                        })
                    }),
                  "%s default_%s "
                }), let_decl_of_and(and_), r_name));
    scope(sc, (function(sc) do
            List.iter((function(param) do
                    fname = param[1];
                    return line_1(sc, Curry._4(Printf.sprintf(--[[ Format ]]{
                                        --[[ Char_literal ]]Block.__(12, {
                                            --[[ "?" ]]63,
                                            --[[ String ]]Block.__(2, {
                                                --[[ No_padding ]]0,
                                                --[[ String_literal ]]Block.__(11, {
                                                    ":((",
                                                    --[[ String ]]Block.__(2, {
                                                        --[[ No_padding ]]0,
                                                        --[[ Char_literal ]]Block.__(12, {
                                                            --[[ ":" ]]58,
                                                            --[[ String ]]Block.__(2, {
                                                                --[[ No_padding ]]0,
                                                                --[[ String_literal ]]Block.__(11, {
                                                                    ") = ",
                                                                    --[[ String ]]Block.__(2, {
                                                                        --[[ No_padding ]]0,
                                                                        --[[ Char_literal ]]Block.__(12, {
                                                                            --[[ ")" ]]41,
                                                                            --[[ End_of_format ]]0
                                                                          })
                                                                      })
                                                                  })
                                                              })
                                                          })
                                                      })
                                                  })
                                              })
                                          }),
                                        "?%s:((%s:%s) = %s)"
                                      }), fname, fname, param[3], param[2]));
                  end end), fields_default_info);
            return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                --[[ String_literal ]]Block.__(11, {
                                    "() : ",
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            "  = {",
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  }),
                                "() : %s  = {"
                              }), r_name));
          end end));
    scope(sc, (function(sc) do
            return List.iter((function(param) do
                          return line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ Char_literal ]]Block.__(12, {
                                                      --[[ ";" ]]59,
                                                      --[[ End_of_format ]]0
                                                    })
                                                }),
                                              "%s;"
                                            }), param[1]));
                        end end), fields_default_info);
          end end));
  end end 
  return line_1(sc, "}");
end end

function gen_default_variant(and_, param, sc) do
  v_constructors = param.v_constructors;
  v_name = param.v_name;
  if (v_constructors) then do
    match = v_constructors[1];
    vc_field_type = match.vc_field_type;
    vc_constructor = match.vc_constructor;
    decl = let_decl_of_and(and_);
    if (vc_field_type) then do
      default_value = default_value_of_field_type(v_name, vc_field_type[1], nil);
      return line_1(sc, Curry._5(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " default_",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " () : ",
                                          --[[ String ]]Block.__(2, {
                                              --[[ No_padding ]]0,
                                              --[[ String_literal ]]Block.__(11, {
                                                  " = ",
                                                  --[[ String ]]Block.__(2, {
                                                      --[[ No_padding ]]0,
                                                      --[[ String_literal ]]Block.__(11, {
                                                          " (",
                                                          --[[ String ]]Block.__(2, {
                                                              --[[ No_padding ]]0,
                                                              --[[ Char_literal ]]Block.__(12, {
                                                                  --[[ ")" ]]41,
                                                                  --[[ End_of_format ]]0
                                                                })
                                                            })
                                                        })
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "%s default_%s () : %s = %s (%s)"
                        }), decl, v_name, v_name, vc_constructor, default_value));
    end else do
      return line_1(sc, Curry._4(Printf.sprintf(--[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " default_",
                                  --[[ String ]]Block.__(2, {
                                      --[[ No_padding ]]0,
                                      --[[ String_literal ]]Block.__(11, {
                                          " (): ",
                                          --[[ String ]]Block.__(2, {
                                              --[[ No_padding ]]0,
                                              --[[ String_literal ]]Block.__(11, {
                                                  " = ",
                                                  --[[ String ]]Block.__(2, {
                                                      --[[ No_padding ]]0,
                                                      --[[ End_of_format ]]0
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            }),
                          "%s default_%s (): %s = %s"
                        }), decl, v_name, v_name, vc_constructor));
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "programmatic TODO error"
    })
  end end 
end end

function gen_default_const_variant(and_, param, sc) do
  cv_constructors = param.cv_constructors;
  cv_name = param.cv_name;
  first_constructor_name;
  if (cv_constructors) then do
    first_constructor_name = cv_constructors[1][1];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "programmatic TODO error"
    })
  end end 
  return line_1(sc, Curry._4(Printf.sprintf(--[[ Format ]]{
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " default_",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      " () = (",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ ":" ]]58,
                                              --[[ String ]]Block.__(2, {
                                                  --[[ No_padding ]]0,
                                                  --[[ Char_literal ]]Block.__(12, {
                                                      --[[ ")" ]]41,
                                                      --[[ End_of_format ]]0
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                            })
                        }),
                      "%s default_%s () = (%s:%s)"
                    }), let_decl_of_and(and_), cv_name, first_constructor_name, cv_name));
end end

function gen_struct_4(and_, t, sc) do
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        r = match[1];
        tmp = --[[ tuple ]]{
          (gen_default_record(nil, and_, r, sc), line_1(sc, ""), gen_default_record(--[[ () ]]0, --[[ () ]]0, r, sc)),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          gen_default_variant(and_, match[1], sc),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          gen_default_const_variant(nil, match[1], sc),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

function gen_sig_record(sc, param) do
  r_name = param.r_name;
  line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "val default_",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " : ",
                            --[[ End_of_format ]]0
                          })
                      })
                  }),
                "val default_%s : "
              }), r_name));
  fields_default_info = List.map(record_field_default_info, param.r_fields);
  scope(sc, (function(sc) do
          List.iter((function(param) do
                  return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                                      --[[ Char_literal ]]Block.__(12, {
                                          --[[ "?" ]]63,
                                          --[[ String ]]Block.__(2, {
                                              --[[ No_padding ]]0,
                                              --[[ Char_literal ]]Block.__(12, {
                                                  --[[ ":" ]]58,
                                                  --[[ String ]]Block.__(2, {
                                                      --[[ No_padding ]]0,
                                                      --[[ String_literal ]]Block.__(11, {
                                                          " ->",
                                                          --[[ End_of_format ]]0
                                                        })
                                                    })
                                                })
                                            })
                                        }),
                                      "?%s:%s ->"
                                    }), param[1], param[3]));
                end end), fields_default_info);
          line_1(sc, "unit ->");
          return line_1(sc, r_name);
        end end));
  line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "(** [default_",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " ()] is the default value for type [",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    "] *)",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          })
                      })
                  }),
                "(** [default_%s ()] is the default value for type [%s] *)"
              }), r_name, r_name));
  return --[[ () ]]0;
end end

function gen_sig_4(and_, t, sc) do
  f = function(type_name) do
    line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "val default_",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " : unit -> ",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ End_of_format ]]0
                                })
                            })
                        })
                    }),
                  "val default_%s : unit -> %s"
                }), type_name, type_name));
    return line_1(sc, Curry._2(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "(** [default_",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " ()] is the default value for type [",
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            "] *)",
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  })
                              })
                          }),
                        "(** [default_%s ()] is the default value for type [%s] *)"
                      }), type_name, type_name));
  end end;
  match = t.spec;
  tmp;
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Record ]] then do
        tmp = --[[ tuple ]]{
          gen_sig_record(sc, match[1]),
          true
        }; end else 
     if ___conditional___ == 1--[[ Variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].v_name),
          true
        }; end else 
     if ___conditional___ == 2--[[ Const_variant ]] then do
        tmp = --[[ tuple ]]{
          f(match[1].cv_name),
          true
        }; end else 
     end end end end end end
    
  end
  return tmp[2];
end end

Codegen_default = {
  gen_sig = gen_sig_4,
  gen_struct = gen_struct_4,
  ocamldoc_title = "Default values"
};

function rev_split_by_naming_convention(s) do
  is_uppercase = function(c) do
    if (64 < c) then do
      return c < 91;
    end else do
      return false;
    end end 
  end end;
  add_sub_string = function(start_i, end_i, l) do
    if (start_i == end_i) then do
      return l;
    end else do
      return --[[ :: ]]{
              __String.sub(s, start_i, end_i - start_i | 0),
              l
            };
    end end 
  end end;
  match = string_fold_lefti((function(param, i, c) do
          start_i = param[2];
          l = param[1];
          if (c ~= 95) then do
            if (param[3] or not is_uppercase(c)) then do
              return --[[ tuple ]]{
                      l,
                      start_i,
                      is_uppercase(c)
                    };
            end else do
              return --[[ tuple ]]{
                      add_sub_string(start_i, i, l),
                      i,
                      true
                    };
            end end 
          end else do
            return --[[ tuple ]]{
                    add_sub_string(start_i, i, l),
                    i + 1 | 0,
                    false
                  };
          end end 
        end end), --[[ tuple ]]{
        --[[ [] ]]0,
        0,
        false
      }, s);
  len = #s;
  return add_sub_string(match[2], len, match[1]);
end end

function fix_ocaml_keyword_conflict(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ == "and"
     or ___conditional___ == "as"
     or ___conditional___ == "asr"
     or ___conditional___ == "assert"
     or ___conditional___ == "begin"
     or ___conditional___ == "class"
     or ___conditional___ == "constraint"
     or ___conditional___ == "do"
     or ___conditional___ == "done"
     or ___conditional___ == "downto"
     or ___conditional___ == "else"
     or ___conditional___ == "end"
     or ___conditional___ == "exception"
     or ___conditional___ == "external"
     or ___conditional___ == "false"
     or ___conditional___ == "for"
     or ___conditional___ == "fun"
     or ___conditional___ == "function"
     or ___conditional___ == "functor"
     or ___conditional___ == "if"
     or ___conditional___ == "in"
     or ___conditional___ == "include"
     or ___conditional___ == "inherit"
     or ___conditional___ == "initializer"
     or ___conditional___ == "land"
     or ___conditional___ == "lazy"
     or ___conditional___ == "let"
     or ___conditional___ == "lor"
     or ___conditional___ == "lsl"
     or ___conditional___ == "lsr"
     or ___conditional___ == "lxor"
     or ___conditional___ == "match"
     or ___conditional___ == "method"
     or ___conditional___ == "mod"
     or ___conditional___ == "module"
     or ___conditional___ == "mutable"
     or ___conditional___ == "new"
     or ___conditional___ == "nonrec"
     or ___conditional___ == "object"
     or ___conditional___ == "of"
     or ___conditional___ == "open"
     or ___conditional___ == "or"
     or ___conditional___ == "private"
     or ___conditional___ == "rec"
     or ___conditional___ == "sig"
     or ___conditional___ == "struct"
     or ___conditional___ == "then"
     or ___conditional___ == "to"
     or ___conditional___ == "true"
     or ___conditional___ == "try"
     or ___conditional___ == "type"
     or ___conditional___ == "val"
     or ___conditional___ == "virtual"
     or ___conditional___ == "when"
     or ___conditional___ == "while"
     or ___conditional___ == "with" then do
        return s .. "_"; end end 
    return s;
      
  end
end end

function constructor_name(s) do
  s_1 = __String.concat("_", List.rev(rev_split_by_naming_convention(s)));
  s_2 = Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s_1)));
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s_2)));
end end

function label_name_of_field_name(s) do
  s_1 = __String.concat("_", List.rev(rev_split_by_naming_convention(s)));
  return fix_ocaml_keyword_conflict(Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s_1))));
end end

function module_of_file_name(file_name) do
  file_name_1 = Curry._1(Filename.basename, file_name);
  dot_index;
  xpcall(function() do
    dot_index = __String.rindex(file_name_1, --[[ "." ]]46);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      error({
        Compilation_error,
        --[[ Invalid_file_name ]]Block.__(6, {file_name_1})
      })
    end
     end 
    error(exn)
  end end)
  return constructor_name(__String.sub(file_name_1, 0, dot_index) .. "_pb");
end end

function type_name(message_scope, name) do
  all_names = Pervasives._at(message_scope, --[[ :: ]]{
        name,
        --[[ [] ]]0
      });
  all_names_1 = List.map((function(s) do
          return List.map(__String.lowercase, List.rev(rev_split_by_naming_convention(s)));
        end end), all_names);
  all_names_2 = List.flatten(all_names_1);
  if (all_names_2) then do
    if (all_names_2[2]) then do
      return __String.concat("_", all_names_2);
    end else do
      return fix_ocaml_keyword_conflict(all_names_2[1]);
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Programmatic error"
    })
  end end 
end end

function encoding_info_of_field_type(all_types, field_type) do
  if (type(field_type) == "number") then do
    local ___conditional___=(field_type);
    do
       if ___conditional___ == 6--[[ Field_type_sint32 ]]
       or ___conditional___ == 7--[[ Field_type_sint64 ]] then do
          return --[[ Pk_varint ]]{true}; end end 
       if ___conditional___ == 1--[[ Field_type_float ]]
       or ___conditional___ == 8--[[ Field_type_fixed32 ]]
       or ___conditional___ == 10--[[ Field_type_sfixed32 ]] then do
          return --[[ Pk_bits32 ]]0; end end 
       if ___conditional___ == 0--[[ Field_type_double ]]
       or ___conditional___ == 9--[[ Field_type_fixed64 ]]
       or ___conditional___ == 11--[[ Field_type_sfixed64 ]] then do
          return --[[ Pk_bits64 ]]1; end end 
       if ___conditional___ == 2--[[ Field_type_int32 ]]
       or ___conditional___ == 3--[[ Field_type_int64 ]]
       or ___conditional___ == 4--[[ Field_type_uint32 ]]
       or ___conditional___ == 5--[[ Field_type_uint64 ]]
       or ___conditional___ == 12--[[ Field_type_bool ]] then do
          return --[[ Pk_varint ]]{false}; end end 
       if ___conditional___ == 13--[[ Field_type_string ]]
       or ___conditional___ == 14--[[ Field_type_bytes ]] then do
          return --[[ Pk_bytes ]]2; end end 
      
    end
  end else do
    match = type_of_id(all_types, field_type[1]);
    if (match.spec.tag) then do
      return --[[ Pk_bytes ]]2;
    end else do
      return --[[ Pk_varint ]]{false};
    end end 
  end end 
end end

function encoding_of_field(all_types, field) do
  match = field_option(field, "packed");
  packed;
  if (match ~= nil) then do
    match_1 = match;
    if (match_1.tag == --[[ Constant_bool ]]1) then do
      packed = match_1[1];
    end else do
      field_name_1 = field_name(field);
      error({
        Compilation_error,
        --[[ Invalid_packed_option ]]Block.__(8, {field_name_1})
      })
    end end 
  end else do
    packed = false;
  end end 
  pk = encoding_info_of_field_type(all_types, field_type(field));
  return --[[ tuple ]]{
          pk,
          field_number(field),
          packed,
          field_default(field)
        };
end end

function compile_field_type(field_name, all_types, file_options, field_options, file_name, field_type) do
  match = find_field_option(field_options, "ocaml_type");
  ocaml_type;
  if (match ~= nil) then do
    match_1 = match;
    ocaml_type = match_1.tag == --[[ Constant_litteral ]]4 and match_1[1] == "int_t" and --[[ Int_t ]]-783406652 or --[[ None ]]870530776;
  end else do
    ocaml_type = --[[ None ]]870530776;
  end end 
  match_2 = file_option(file_options, "int32_type");
  int32_type;
  if (match_2 ~= nil) then do
    match_3 = match_2;
    int32_type = match_3.tag == --[[ Constant_litteral ]]4 and match_3[1] == "int_t" and --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int ]]2}) or --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int32 ]]3});
  end else do
    int32_type = --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int32 ]]3});
  end end 
  match_4 = file_option(file_options, "int64_type");
  int64_type;
  if (match_4 ~= nil) then do
    match_5 = match_4;
    int64_type = match_5.tag == --[[ Constant_litteral ]]4 and match_5[1] == "int_t" and --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int ]]2}) or --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int64 ]]4});
  end else do
    int64_type = --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int64 ]]4});
  end end 
  if (type(field_type) == "number") then do
    local ___conditional___=(field_type);
    do
       if ___conditional___ == 0--[[ Field_type_double ]]
       or ___conditional___ == 1--[[ Field_type_float ]] then do
          return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_float ]]1}); end end 
       if ___conditional___ == 2--[[ Field_type_int32 ]]
       or ___conditional___ == 4--[[ Field_type_uint32 ]]
       or ___conditional___ == 6--[[ Field_type_sint32 ]]
       or ___conditional___ == 8--[[ Field_type_fixed32 ]] then do
          if (ocaml_type ~= -783406652) then do
            return int32_type;
          end else do
            return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int ]]2});
          end end  end end 
       if ___conditional___ == 3--[[ Field_type_int64 ]]
       or ___conditional___ == 5--[[ Field_type_uint64 ]]
       or ___conditional___ == 7--[[ Field_type_sint64 ]]
       or ___conditional___ == 9--[[ Field_type_fixed64 ]] then do
          if (ocaml_type ~= -783406652) then do
            return int64_type;
          end else do
            return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_int ]]2});
          end end  end end 
       if ___conditional___ == 10--[[ Field_type_sfixed32 ]] then do
          return unsupported_field_type(field_name, "sfixed32", "OCaml", --[[ () ]]0); end end 
       if ___conditional___ == 11--[[ Field_type_sfixed64 ]] then do
          return unsupported_field_type(field_name, "sfixed64", "OCaml", --[[ () ]]0); end end 
       if ___conditional___ == 12--[[ Field_type_bool ]] then do
          return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_bool ]]6}); end end 
       if ___conditional___ == 13--[[ Field_type_string ]] then do
          return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_string ]]0}); end end 
       if ___conditional___ == 14--[[ Field_type_bytes ]] then do
          return --[[ Ft_basic_type ]]Block.__(0, {--[[ Bt_bytes ]]5}); end end 
      
    end
  end else do
    all_types_1 = all_types;
    file_name_1 = file_name;
    i = field_type[1];
    module_ = module_of_file_name(file_name_1);
    t;
    xpcall(function() do
      t = type_of_id(all_types_1, i);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        error({
          Compilation_error,
          --[[ Programatic_error ]]Block.__(4, {--[[ No_type_found_for_id ]]2})
        })
      end
       end 
      error(exn)
    end end)
    if (is_empty_message(t)) then do
      return --[[ Ft_unit ]]0;
    end else do
      udt_nested;
      udt_nested = t.spec.tag and true or false;
      field_type_module = module_of_file_name(t.file_name);
      match_6 = type_scope_of_type(t);
      udt_type_name = type_name(match_6.message_names, type_name_of_type(t));
      if (field_type_module == module_) then do
        return --[[ Ft_user_defined_type ]]Block.__(1, {{
                    udt_module = nil,
                    udt_type_name = udt_type_name,
                    udt_nested = udt_nested
                  }});
      end else do
        return --[[ Ft_user_defined_type ]]Block.__(1, {{
                    udt_module = field_type_module,
                    udt_type_name = udt_type_name,
                    udt_nested = udt_nested
                  }});
      end end 
    end end 
  end end 
end end

function is_mutable(field_name, field_options) do
  match = find_field_option(field_options, "ocaml_mutable");
  if (match ~= nil) then do
    match_1 = match;
    if (match_1.tag == --[[ Constant_bool ]]1) then do
      return match_1[1];
    end else do
      error({
        Compilation_error,
        --[[ Invalid_mutable_option ]]Block.__(11, {field_name})
      })
    end end 
  end else do
    return false;
  end end 
end end

function ocaml_container(field_options) do
  match = find_field_option(field_options, "ocaml_container");
  if (match ~= nil) then do
    match_1 = match;
    if (match_1.tag == --[[ Constant_litteral ]]4) then do
      return match_1[1];
    end else do
      return ;
    end end 
  end
   end 
end end

function variant_of_oneof(include_oneof_name, outer_message_names, all_types, file_options, file_name, oneof_field) do
  v_constructors = List.map((function(field) do
          pbtt_field_type = field_type(field);
          field_type_1 = compile_field_type(field_name(field), all_types, file_options, field_options(field), file_name, pbtt_field_type);
          match = encoding_of_field(all_types, field);
          vc_constructor = constructor_name(field_name(field));
          return {
                  vc_constructor = vc_constructor,
                  vc_field_type = type(field_type_1) == "number" and --[[ Vct_nullary ]]0 or --[[ Vct_non_nullary_constructor ]]{field_type_1},
                  vc_encoding_number = match[2],
                  vc_payload_kind = match[1]
                };
        end end), oneof_field.oneof_fields);
  v_name = include_oneof_name ~= nil and type_name(outer_message_names, oneof_field.oneof_name) or type_name(outer_message_names, "");
  return {
          v_name = v_name,
          v_constructors = v_constructors
        };
end end

function compile_enum(file_name, scope, param) do
  module_ = module_of_file_name(file_name);
  cv_constructors = List.map((function(param) do
          return --[[ tuple ]]{
                  constructor_name(param.enum_value_name),
                  param.enum_value_int
                };
        end end), param.enum_values);
  return {
          module_ = module_,
          spec = --[[ Const_variant ]]Block.__(2, {{
                cv_name = type_name(scope.message_names, param.enum_name),
                cv_constructors = cv_constructors
              }})
        };
end end

all_code_gen_001 = --[[ :: ]]{
  Codegen_default,
  --[[ :: ]]{
    Codegen_decode,
    --[[ :: ]]{
      Codegen_encode,
      --[[ :: ]]{
        Codegen_pp,
        --[[ [] ]]0
      }
    }
  }
};

all_code_gen = --[[ :: ]]{
  Codegen_type,
  all_code_gen_001
};

function compile(proto_definition) do
  lexbuf = Lexing.from_string(proto_definition);
  proto;
  xpcall(function() do
    proto = proto_(lexer, lexbuf);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    error(add_loc(from_lexbuf(lexbuf), exn))
  end end)
  all_pbtt_msgs = compile_proto_p1("tmp.proto", proto);
  all_pbtt_msgs_1 = List.map((function(param) do
          all_types = all_pbtt_msgs;
          t = param;
          spec = t.spec;
          file_options = t.file_options;
          file_name = t.file_name;
          id = t.id;
          scope = t.scope;
          if (spec.tag) then do
            return {
                    scope = scope,
                    id = id,
                    file_name = file_name,
                    file_options = file_options,
                    spec = --[[ Message ]]Block.__(1, {compile_message_p2(all_types, scope, spec[1])})
                  };
          end else do
            return {
                    scope = scope,
                    id = id,
                    file_name = file_name,
                    file_options = file_options,
                    spec = spec
                  };
          end end 
        end end), all_pbtt_msgs);
  grouped_pbtt_msgs = List.rev(group(all_pbtt_msgs_1));
  grouped_ocaml_types = List.map((function(pbtt_msgs) do
          return List.map((function(pbtt_msg) do
                        all_types = all_pbtt_msgs_1;
                        param = pbtt_msg;
                        match = param.spec;
                        file_name = param.file_name;
                        scope = param.scope;
                        if (match.tag) then do
                          file_options = param.file_options;
                          all_types_1 = all_types;
                          file_name_1 = file_name;
                          scope_1 = scope;
                          message = match[1];
                          module_ = module_of_file_name(file_name_1);
                          message_names = scope_1.message_names;
                          message_body = message.message_body;
                          message_name = message.message_name;
                          if (message_body) then do
                            match_1 = message_body[1];
                            local ___conditional___=(match_1.tag | 0);
                            do
                               if ___conditional___ == 1--[[ Message_oneof_field ]] then do
                                  if (not message_body[2]) then do
                                    outer_message_names = Pervasives._at(message_names, --[[ :: ]]{
                                          message_name,
                                          --[[ [] ]]0
                                        });
                                    variant = variant_of_oneof(nil, outer_message_names, all_types_1, file_options, file_name_1, match_1[1]);
                                    return --[[ :: ]]{
                                            {
                                              module_ = module_,
                                              spec = --[[ Variant ]]Block.__(1, {variant})
                                            },
                                            --[[ [] ]]0
                                          };
                                  end
                                   end  end else 
                               if ___conditional___ == 0--[[ Message_field ]]
                               or ___conditional___ == 2--[[ Message_map_field ]]
                               end end end
                              
                            end
                          end else do
                            return --[[ [] ]]0;
                          end end 
                          match_2 = List.fold_left((function(param, param_1) do
                                  fields = param[2];
                                  variants = param[1];
                                  local ___conditional___=(param_1.tag | 0);
                                  do
                                     if ___conditional___ == 0--[[ Message_field ]] then do
                                        field = param_1[1];
                                        match = encoding_of_field(all_types_1, field);
                                        encoding_number = match[2];
                                        pk = match[1];
                                        field_name_1 = field_name(field);
                                        field_options_1 = field_options(field);
                                        field_type_1 = compile_field_type(field_name_1, all_types_1, file_options, field_options_1, file_name_1, field_type(field));
                                        field_default_1 = field_default(field);
                                        mutable_ = is_mutable(field_name_1, field_options_1);
                                        match_1 = field_label(field);
                                        record_field_type;
                                        if (match_1 ~= -132092992) then do
                                          if (match_1 >= 202657151) then do
                                            record_field_type = --[[ Rft_required ]]Block.__(0, {--[[ tuple ]]{
                                                  field_type_1,
                                                  encoding_number,
                                                  pk,
                                                  field_default_1
                                                }});
                                          end else do
                                            match_2 = ocaml_container(field_options_1);
                                            repeated_type;
                                            if (match_2 ~= nil) then do
                                              if (match_2 == "repeated_field") then do
                                                repeated_type = --[[ Rt_repeated_field ]]1;
                                              end else do
                                                error({
                                                  Caml_builtin_exceptions.failure,
                                                  "Invalid ocaml_container attribute value"
                                                })
                                              end end 
                                            end else do
                                              repeated_type = --[[ Rt_list ]]0;
                                            end end 
                                            record_field_type = --[[ Rft_repeated_field ]]Block.__(2, {--[[ tuple ]]{
                                                  repeated_type,
                                                  field_type_1,
                                                  encoding_number,
                                                  pk,
                                                  match[3]
                                                }});
                                          end end 
                                        end else do
                                          record_field_type = --[[ Rft_optional ]]Block.__(1, {--[[ tuple ]]{
                                                field_type_1,
                                                encoding_number,
                                                pk,
                                                field_default_1
                                              }});
                                        end end 
                                        record_field_rf_label = label_name_of_field_name(field_name_1);
                                        record_field = {
                                          rf_label = record_field_rf_label,
                                          rf_field_type = record_field_type,
                                          rf_mutable = mutable_
                                        };
                                        return --[[ tuple ]]{
                                                variants,
                                                --[[ :: ]]{
                                                  record_field,
                                                  fields
                                                }
                                              }; end end 
                                     if ___conditional___ == 1--[[ Message_oneof_field ]] then do
                                        field_1 = param_1[1];
                                        outer_message_names = Pervasives._at(message_names, --[[ :: ]]{
                                              message_name,
                                              --[[ [] ]]0
                                            });
                                        variant = variant_of_oneof(--[[ () ]]0, outer_message_names, all_types_1, file_options, file_name_1, field_1);
                                        record_field_rf_label_1 = label_name_of_field_name(field_1.oneof_name);
                                        record_field_rf_field_type = --[[ Rft_variant_field ]]Block.__(4, {variant});
                                        record_field_1 = {
                                          rf_label = record_field_rf_label_1,
                                          rf_field_type = record_field_rf_field_type,
                                          rf_mutable = false
                                        };
                                        variants_000 = {
                                          module_ = module_,
                                          spec = --[[ Variant ]]Block.__(1, {variant})
                                        };
                                        variants_1 = --[[ :: ]]{
                                          variants_000,
                                          variants
                                        };
                                        fields_1 = --[[ :: ]]{
                                          record_field_1,
                                          fields
                                        };
                                        return --[[ tuple ]]{
                                                variants_1,
                                                fields_1
                                              }; end end 
                                     if ___conditional___ == 2--[[ Message_map_field ]] then do
                                        mf = param_1[1];
                                        map_options = mf.map_options;
                                        map_value_type = mf.map_value_type;
                                        map_key_type = mf.map_key_type;
                                        map_name = mf.map_name;
                                        key_type = compile_field_type(Curry._1(Printf.sprintf(--[[ Format ]]{
                                                      --[[ String_literal ]]Block.__(11, {
                                                          "key of ",
                                                          --[[ String ]]Block.__(2, {
                                                              --[[ No_padding ]]0,
                                                              --[[ End_of_format ]]0
                                                            })
                                                        }),
                                                      "key of %s"
                                                    }), map_name), all_types_1, file_options, map_options, file_name_1, map_key_type);
                                        key_pk = encoding_info_of_field_type(all_types_1, map_key_type);
                                        key_type_1;
                                        if (type(key_type) == "number") then do
                                          error({
                                            Caml_builtin_exceptions.failure,
                                            "Only Basic Types are supported for map keys"
                                          })
                                        end else if (key_type.tag) then do
                                          error({
                                            Caml_builtin_exceptions.failure,
                                            "Only Basic Types are supported for map keys"
                                          })
                                        end else do
                                          key_type_1 = key_type[1];
                                        end end  end 
                                        value_type = compile_field_type(Curry._1(Printf.sprintf(--[[ Format ]]{
                                                      --[[ String_literal ]]Block.__(11, {
                                                          "value of ",
                                                          --[[ String ]]Block.__(2, {
                                                              --[[ No_padding ]]0,
                                                              --[[ End_of_format ]]0
                                                            })
                                                        }),
                                                      "value of %s"
                                                    }), map_name), all_types_1, file_options, map_options, file_name_1, map_value_type);
                                        value_pk = encoding_info_of_field_type(all_types_1, map_value_type);
                                        match_3 = ocaml_container(map_options);
                                        associative_type;
                                        if (match_3 ~= nil) then do
                                          if (match_3 == "hashtbl") then do
                                            associative_type = --[[ At_hashtable ]]1;
                                          end else do
                                            error({
                                              Caml_builtin_exceptions.failure,
                                              "Invalid ocaml_container attribute value for map"
                                            })
                                          end end 
                                        end else do
                                          associative_type = --[[ At_list ]]0;
                                        end end 
                                        record_field_type_1 = --[[ Rft_associative_field ]]Block.__(3, {--[[ tuple ]]{
                                              associative_type,
                                              mf.map_number,
                                              --[[ tuple ]]{
                                                key_type_1,
                                                key_pk
                                              },
                                              --[[ tuple ]]{
                                                value_type,
                                                value_pk
                                              }
                                            }});
                                        record_field_rf_label_2 = label_name_of_field_name(map_name);
                                        record_field_rf_mutable = is_mutable(map_name, map_options);
                                        record_field_2 = {
                                          rf_label = record_field_rf_label_2,
                                          rf_field_type = record_field_type_1,
                                          rf_mutable = record_field_rf_mutable
                                        };
                                        return --[[ tuple ]]{
                                                variants,
                                                --[[ :: ]]{
                                                  record_field_2,
                                                  fields
                                                }
                                              }; end end 
                                    
                                  end
                                end end), --[[ tuple ]]{
                                --[[ [] ]]0,
                                --[[ [] ]]0
                              }, message_body);
                          record_r_name = type_name(message_names, message_name);
                          record_r_fields = List.rev(match_2[2]);
                          record = {
                            r_name = record_r_name,
                            r_fields = record_r_fields
                          };
                          type__spec = --[[ Record ]]Block.__(0, {record});
                          type_ = {
                            module_ = module_,
                            spec = type__spec
                          };
                          return List.rev(--[[ :: ]]{
                                      type_,
                                      match_2[1]
                                    });
                        end else do
                          return --[[ :: ]]{
                                  compile_enum(file_name, scope, match[1]),
                                  --[[ [] ]]0
                                };
                        end end 
                      end end), pbtt_msgs);
        end end), grouped_pbtt_msgs);
  all_ocaml_types = List.flatten(grouped_ocaml_types);
  otypes = all_ocaml_types;
  proto_file_name = "tmp.proto";
  gen = function(otypes, sc, fs) do
    return List.iter((function(param) do
                  ocamldoc_title = param[2];
                  f = param[1];
                  if (ocamldoc_title ~= nil) then do
                    line_1(sc, "");
                    line_1(sc, Curry._1(Printf.sprintf(--[[ Format ]]{
                                  --[[ String_literal ]]Block.__(11, {
                                      "(** {2 ",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              "} *)",
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    }),
                                  "(** {2 %s} *)"
                                }), ocamldoc_title));
                    line_1(sc, "");
                  end
                   end 
                  return List.iter((function(types) do
                                List.fold_left((function(first, type_) do
                                        has_encoded = first and Curry._3(f, nil, type_, sc) or Curry._3(f, --[[ () ]]0, type_, sc);
                                        line_1(sc, "");
                                        if (first) then do
                                          return not has_encoded;
                                        end else do
                                          return false;
                                        end end 
                                      end end), true, types);
                                return --[[ () ]]0;
                              end end), otypes);
                end end), fs);
  end end;
  sc = {
    items = --[[ [] ]]0
  };
  line_1(sc, "[@@@ocaml.warning \"-30\"]");
  line_1(sc, "");
  gen(otypes, sc, List.map((function(m) do
              return --[[ tuple ]]{
                      m.gen_struct,
                      nil
                    };
            end end), all_code_gen));
  struct_string = print(sc);
  sc_1 = {
    items = --[[ [] ]]0
  };
  line_1(sc_1, Curry._1(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "(** ",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " Generated Types and Encoding *)",
                            --[[ End_of_format ]]0
                          })
                      })
                  }),
                "(** %s Generated Types and Encoding *)"
              }), Curry._1(Filename.basename, proto_file_name)));
  gen(otypes, sc_1, List.map((function(m) do
              return --[[ tuple ]]{
                      m.gen_sig,
                      m.ocamldoc_title
                    };
            end end), all_code_gen));
  sig_string = print(sc_1);
  return --[[ tuple ]]{
          sig_string,
          struct_string
        };
end end

match = compile("message T {required int32 j = 1; }");

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

eq("File \"ocaml_protc_test.ml\", line 10, characters 5-12", match[1], "(** tmp.proto Generated Types and Encoding *)\n\n(** {2 Types} *)\n\ntype t = {\n  j : int32;\n}\n\n\n(** {2 Default values} *)\n\nval default_t : \n  ?j:int32 ->\n  unit ->\n  t\n(** [default_t ()] is the default value for type [t] *)\n\n\n(** {2 Protobuf Decoding} *)\n\nval decode_t : Pbrt.Decoder.t -> t\n(** [decode_t decoder] decodes a [t] value from [decoder] *)\n\n\n(** {2 Protobuf Toding} *)\n\nval encode_t : t -> Pbrt.Encoder.t -> unit\n(** [encode_t v encoder] encodes [v] with the given [encoder] *)\n\n\n(** {2 Formatters} *)\n\nval pp_t : Format.formatter -> t -> unit \n(** [pp_t v] formats v] *)\n");

eq("File \"ocaml_protc_test.ml\", line 46, characters 5-12", match[2], "[@@@ocaml.warning \"-30\"]\n\ntype t = {\n  j : int32;\n}\n\nand t_mutable = {\n  mutable j : int32;\n}\n\nlet rec default_t \n  ?j:((j:int32) = 0l)\n  () : t  = {\n  j;\n}\n\nand default_t_mutable () : t_mutable = {\n  j = 0l;\n}\n\nlet rec decode_t d =\n  let v = default_t_mutable () in\n  let rec loop () = \n    match Pbrt.Decoder.key d with\n    | None -> (\n    )\n    | Some (1, Pbrt.Varint) -> (\n      v.j <- Pbrt.Decoder.int32_as_varint d;\n      loop ()\n    )\n    | Some (1, pk) -> raise (\n      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload (\"Message(t), field(1)\", pk))\n    )\n    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()\n  in\n  loop ();\n  let v:t = Obj.magic v in\n  v\n\nlet rec encode_t (v:t) encoder = \n  Pbrt.Encoder.key (1, Pbrt.Varint) encoder; \n  Pbrt.Encoder.int32_as_varint v.j encoder;\n  ()\n\nlet rec pp_t fmt (v:t) = \n  let pp_i fmt () =\n    Format.pp_open_vbox fmt 1;\n    Pbrt.Pp.pp_record_field \"j\" Pbrt.Pp.pp_int32 fmt v.j;\n    Format.pp_close_box fmt ()\n  in\n  Pbrt.Pp.pp_brk pp_i fmt ()\n");

Mt.from_pair_suites("Ocaml_proto_test", suites.contents);

exports = {};
return exports;
--[[  Not a pure module ]]
