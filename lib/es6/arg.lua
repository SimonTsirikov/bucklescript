

import * as Sys from "./sys.lua";
import * as List from "./list.lua";
import * as __Array from "./array.lua";
import * as Block from "./block.lua";
import * as Bytes from "./bytes.lua";
import * as Curry from "./curry.lua";
import * as __Buffer from "./buffer.lua";
import * as Printf from "./printf.lua";
import * as __String from "./string.lua";
import * as Caml_io from "./caml_io.lua";
import * as Caml_obj from "./caml_obj.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_format from "./caml_format.lua";
import * as Caml_string from "./caml_string.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";
import * as Caml_js_exceptions from "./caml_js_exceptions.lua";
import * as Caml_external_polyfill from "./caml_external_polyfill.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

Bad = Caml_exceptions.create("Arg.Bad");

Help = Caml_exceptions.create("Arg.Help");

Stop = Caml_exceptions.create("Arg.Stop");

function assoc3(x, _l) do
  while(true) do
    l = _l;
    if (l) then do
      match = l[0];
      if (Caml_obj.caml_equal(match[0], x)) then do
        return match[1];
      end else do
        _l = l[1];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function split(s) do
  i = __String.index(s, --[[ "=" ]]61);
  len = #s;
  return --[[ tuple ]]{
          __String.sub(s, 0, i),
          __String.sub(s, i + 1 | 0, len - (i + 1 | 0) | 0)
        };
end end

function make_symlist(prefix, sep, suffix, l) do
  if (l) then do
    return List.fold_left((function(x, y) do
                  return x .. (sep .. y);
                end end), prefix .. l[0], l[1]) .. suffix;
  end else do
    return "<none>";
  end end 
end end

function help_action(param) do
  error({
    Stop,
    --[[ Unknown ]]Block.__(0, {"-help"})
  })
end end

function add_help(speclist) do
  add1;
  xpcall(function() do
    assoc3("-help", speclist);
    add1 = --[[ [] ]]0;
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      add1 = --[[ :: ]]{
        --[[ tuple ]]{
          "-help",
          --[[ Unit ]]Block.__(0, {help_action}),
          " Display this list of options"
        },
        --[[ [] ]]0
      };
    end else do
      error(exn)
    end end 
  end end)
  add2;
  xpcall(function() do
    assoc3("--help", speclist);
    add2 = --[[ [] ]]0;
  end end,function(exn_1) do
    if (exn_1 == Caml_builtin_exceptions.not_found) then do
      add2 = --[[ :: ]]{
        --[[ tuple ]]{
          "--help",
          --[[ Unit ]]Block.__(0, {help_action}),
          " Display this list of options"
        },
        --[[ [] ]]0
      };
    end else do
      error(exn_1)
    end end 
  end end)
  return Pervasives.$at(speclist, Pervasives.$at(add1, add2));
end end

function usage_b(buf, speclist, errmsg) do
  Curry._1(Printf.bprintf(buf, --[[ Format ]]{
            --[[ String ]]Block.__(2, {
                --[[ No_padding ]]0,
                --[[ Char_literal ]]Block.__(12, {
                    --[[ "\n" ]]10,
                    --[[ End_of_format ]]0
                  })
              }),
            "%s\n"
          }), errmsg);
  return List.iter((function(param) do
                buf_1 = buf;
                param_1 = param;
                doc = param_1[2];
                if (#doc ~= 0) then do
                  spec = param_1[1];
                  key = param_1[0];
                  if (spec.tag == --[[ Symbol ]]11) then do
                    return Curry._3(Printf.bprintf(buf_1, --[[ Format ]]{
                                    --[[ String_literal ]]Block.__(11, {
                                        "  ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ Char_literal ]]Block.__(12, {
                                                --[[ " " ]]32,
                                                --[[ String ]]Block.__(2, {
                                                    --[[ No_padding ]]0,
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
                                      }),
                                    "  %s %s%s\n"
                                  }), key, make_symlist("{", "|", "}", spec[0]), doc);
                  end else do
                    return Curry._2(Printf.bprintf(buf_1, --[[ Format ]]{
                                    --[[ String_literal ]]Block.__(11, {
                                        "  ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ Char_literal ]]Block.__(12, {
                                                --[[ " " ]]32,
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
                                    "  %s %s\n"
                                  }), key, doc);
                  end end 
                end else do
                  return 0;
                end end 
              end end), add_help(speclist));
end end

function usage_string(speclist, errmsg) do
  b = __Buffer.create(200);
  usage_b(b, speclist, errmsg);
  return __Buffer.contents(b);
end end

function usage(speclist, errmsg) do
  return Curry._1(Printf.eprintf(--[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ End_of_format ]]0
                    }),
                  "%s"
                }), usage_string(speclist, errmsg));
end end

current = do
  contents: 0
end;

function bool_of_string_opt(x) do
  xpcall(function() do
    return Pervasives.bool_of_string(x);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

function int_of_string_opt(x) do
  xpcall(function() do
    return Caml_format.caml_int_of_string(x);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

function float_of_string_opt(x) do
  xpcall(function() do
    return Caml_format.caml_float_of_string(x);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

function parse_and_expand_argv_dynamic_aux(allow_expand, current, argv, speclist, anonfun, errmsg) do
  initpos = current.contents;
  convert_error = function(error) do
    b = __Buffer.create(200);
    progname = initpos < #argv.contents and Caml_array.caml_array_get(argv.contents, initpos) or "(?)";
    local ___conditional___=(error.tag | 0);
    do
       if ___conditional___ == 0--[[ Unknown ]] then do
          s = error[0];
          local ___conditional___=(s);
          do
             if ___conditional___ == "--help"
             or ___conditional___ == "-help"
             end
            Curry._2(Printf.bprintf(b, --[[ Format ]]{
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": unknown option '",
                                --[[ String ]]Block.__(2, {
                                    --[[ No_padding ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        "'.\n",
                                        --[[ End_of_format ]]0
                                      })
                                  })
                              })
                          }),
                        "%s: unknown option '%s'.\n"
                      }), progname, s);
              
          end end else 
       if ___conditional___ == 1--[[ Wrong ]] then do
          Curry._4(Printf.bprintf(b, --[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            ": wrong argument '",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    "'; option '",
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            "' expects ",
                                            --[[ String ]]Block.__(2, {
                                                --[[ No_padding ]]0,
                                                --[[ String_literal ]]Block.__(11, {
                                                    ".\n",
                                                    --[[ End_of_format ]]0
                                                  })
                                              })
                                          })
                                      })
                                  })
                              })
                          })
                      }),
                    "%s: wrong argument '%s'; option '%s' expects %s.\n"
                  }), progname, error[1], error[0], error[2]); end else 
       if ___conditional___ == 2--[[ Missing ]] then do
          Curry._2(Printf.bprintf(b, --[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            ": option '",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    "' needs an argument.\n",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          })
                      }),
                    "%s: option '%s' needs an argument.\n"
                  }), progname, error[0]); end else 
       if ___conditional___ == 3--[[ Message ]] then do
          Curry._2(Printf.bprintf(b, --[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            ": ",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    ".\n",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          })
                      }),
                    "%s: %s.\n"
                  }), progname, error[0]); end else 
       end end end end end end end end
      
    end
    usage_b(b, speclist.contents, errmsg);
    if (Caml_obj.caml_equal(error, --[[ Unknown ]]Block.__(0, {"-help"})) or Caml_obj.caml_equal(error, --[[ Unknown ]]Block.__(0, {"--help"}))) then do
      return {
              Help,
              __Buffer.contents(b)
            };
    end else do
      return {
              Bad,
              __Buffer.contents(b)
            };
    end end 
  end end;
  current.contents = current.contents + 1 | 0;
  while(current.contents < #argv.contents) do
    xpcall(function() do
      s = Caml_array.caml_array_get(argv.contents, current.contents);
      if (#s >= 1 and Caml_string.get(s, 0) == --[[ "-" ]]45) then do
        match;
        xpcall(function() do
          match = --[[ tuple ]]{
            assoc3(s, speclist.contents),
            undefined
          };
        end end,function(exn) do
          if (exn == Caml_builtin_exceptions.not_found) then do
            xpcall(function() do
              match_1 = split(s);
              match = --[[ tuple ]]{
                assoc3(match_1[0], speclist.contents),
                match_1[1]
              };
            end end,function(exn_1) do
              if (exn_1 == Caml_builtin_exceptions.not_found) then do
                error({
                  Stop,
                  --[[ Unknown ]]Block.__(0, {s})
                })
              end
               end 
              error(exn_1)
            end end)
          end else do
            error(exn)
          end end 
        end end)
        follow = match[1];
        no_arg = (function(s,follow)do
        return function no_arg(param) do
          if (follow ~= undefined) then do
            error({
              Stop,
              --[[ Wrong ]]Block.__(1, {
                  s,
                  follow,
                  "no argument"
                })
            })
          end else do
            return --[[ () ]]0;
          end end 
        end end
        end end)(s,follow);
        get_arg = (function(s,follow)do
        return function get_arg(param) do
          if (follow ~= undefined) then do
            return follow;
          end else if ((current.contents + 1 | 0) < #argv.contents) then do
            return Caml_array.caml_array_get(argv.contents, current.contents + 1 | 0);
          end else do
            error({
              Stop,
              --[[ Missing ]]Block.__(2, {s})
            })
          end end  end 
        end end
        end end)(s,follow);
        consume_arg = (function(follow)do
        return function consume_arg(param) do
          if (follow ~= undefined) then do
            return --[[ () ]]0;
          end else do
            current.contents = current.contents + 1 | 0;
            return --[[ () ]]0;
          end end 
        end end
        end end)(follow);
        treat_action = (function(s)do
        return function treat_action(param) do
          local ___conditional___=(param.tag | 0);
          do
             if ___conditional___ == 0--[[ Unit ]] then do
                return Curry._1(param[0], --[[ () ]]0); end end 
             if ___conditional___ == 1--[[ Bool ]] then do
                arg = get_arg(--[[ () ]]0);
                match = bool_of_string_opt(arg);
                if (match ~= undefined) then do
                  Curry._1(param[0], match);
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg,
                        "a boolean"
                      })
                  })
                end end 
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 2--[[ Set ]] then do
                no_arg(--[[ () ]]0);
                param[0].contents = true;
                return --[[ () ]]0; end end 
             if ___conditional___ == 3--[[ Clear ]] then do
                no_arg(--[[ () ]]0);
                param[0].contents = false;
                return --[[ () ]]0; end end 
             if ___conditional___ == 4--[[ String ]] then do
                arg_1 = get_arg(--[[ () ]]0);
                Curry._1(param[0], arg_1);
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 5--[[ Set_string ]] then do
                param[0].contents = get_arg(--[[ () ]]0);
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 6--[[ Int ]] then do
                arg_2 = get_arg(--[[ () ]]0);
                match_1 = int_of_string_opt(arg_2);
                if (match_1 ~= undefined) then do
                  Curry._1(param[0], match_1);
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg_2,
                        "an integer"
                      })
                  })
                end end 
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 7--[[ Set_int ]] then do
                arg_3 = get_arg(--[[ () ]]0);
                match_2 = int_of_string_opt(arg_3);
                if (match_2 ~= undefined) then do
                  param[0].contents = match_2;
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg_3,
                        "an integer"
                      })
                  })
                end end 
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 8--[[ Float ]] then do
                arg_4 = get_arg(--[[ () ]]0);
                match_3 = float_of_string_opt(arg_4);
                if (match_3 ~= undefined) then do
                  Curry._1(param[0], match_3);
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg_4,
                        "a float"
                      })
                  })
                end end 
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 9--[[ Set_float ]] then do
                arg_5 = get_arg(--[[ () ]]0);
                match_4 = float_of_string_opt(arg_5);
                if (match_4 ~= undefined) then do
                  param[0].contents = match_4;
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg_5,
                        "a float"
                      })
                  })
                end end 
                return consume_arg(--[[ () ]]0); end end 
             if ___conditional___ == 10--[[ Tuple ]] then do
                return List.iter(treat_action, param[0]); end end 
             if ___conditional___ == 11--[[ Symbol ]] then do
                symb = param[0];
                arg_6 = get_arg(--[[ () ]]0);
                if (List.mem(arg_6, symb)) then do
                  Curry._1(param[1], arg_6);
                  return consume_arg(--[[ () ]]0);
                end else do
                  error({
                    Stop,
                    --[[ Wrong ]]Block.__(1, {
                        s,
                        arg_6,
                        "one of: " .. make_symlist("", " ", "", symb)
                      })
                  })
                end end  end end 
             if ___conditional___ == 12--[[ Rest ]] then do
                f = param[0];
                while(current.contents < (#argv.contents - 1 | 0)) do
                  Curry._1(f, Caml_array.caml_array_get(argv.contents, current.contents + 1 | 0));
                  consume_arg(--[[ () ]]0);
                end;
                return --[[ () ]]0; end end 
             if ___conditional___ == 13--[[ Expand ]] then do
                if (not allow_expand) then do
                  error({
                    Caml_builtin_exceptions.invalid_argument,
                    "Arg.Expand is is only allowed with Arg.parse_and_expand_argv_dynamic"
                  })
                end
                 end 
                arg_7 = get_arg(--[[ () ]]0);
                newarg = Curry._1(param[0], arg_7);
                consume_arg(--[[ () ]]0);
                before = __Array.sub(argv.contents, 0, current.contents + 1 | 0);
                after = __Array.sub(argv.contents, current.contents + 1 | 0, (#argv.contents - current.contents | 0) - 1 | 0);
                argv.contents = Caml_array.caml_array_concat(--[[ :: ]]{
                      before,
                      --[[ :: ]]{
                        newarg,
                        --[[ :: ]]{
                          after,
                          --[[ [] ]]0
                        }
                      }
                    });
                return --[[ () ]]0; end end 
            
          end
        end end
        end end)(s);
        treat_action(match[0]);
      end else do
        Curry._1(anonfun, s);
      end end 
    end end,function(raw_exn) do
      exn_2 = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn_2[0] == Bad) then do
        error(convert_error(--[[ Message ]]Block.__(3, {exn_2[1]})))
      end
       end 
      if (exn_2[0] == Stop) then do
        error(convert_error(exn_2[1]))
      end
       end 
      error(exn_2)
    end end)
    current.contents = current.contents + 1 | 0;
  end;
  return --[[ () ]]0;
end end

function parse_and_expand_argv_dynamic(current, argv, speclist, anonfun, errmsg) do
  return parse_and_expand_argv_dynamic_aux(true, current, argv, speclist, anonfun, errmsg);
end end

function parse_argv_dynamic(currentOpt, argv, speclist, anonfun, errmsg) do
  current_1 = currentOpt ~= undefined and currentOpt or current;
  return parse_and_expand_argv_dynamic_aux(false, current_1, do
              contents: argv
            end, speclist, anonfun, errmsg);
end end

function parse_argv(currentOpt, argv, speclist, anonfun, errmsg) do
  current_1 = currentOpt ~= undefined and currentOpt or current;
  return parse_argv_dynamic(current_1, argv, do
              contents: speclist
            end, anonfun, errmsg);
end end

function parse(l, f, msg) do
  xpcall(function() do
    return parse_argv(undefined, Sys.argv, l, f, msg);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) then do
      Curry._1(Printf.eprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) then do
      Curry._1(Printf.printf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(0);
    end else do
      error(exn)
    end end  end 
  end end)
end end

function parse_dynamic(l, f, msg) do
  xpcall(function() do
    return parse_argv_dynamic(undefined, Sys.argv, l, f, msg);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) then do
      Curry._1(Printf.eprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) then do
      Curry._1(Printf.printf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(0);
    end else do
      error(exn)
    end end  end 
  end end)
end end

function parse_expand(l, f, msg) do
  xpcall(function() do
    argv = do
      contents: Sys.argv
    end;
    spec = do
      contents: l
    end;
    current_1 = do
      contents: current.contents
    end;
    return parse_and_expand_argv_dynamic(current_1, argv, spec, f, msg);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) then do
      Curry._1(Printf.eprintf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) then do
      Curry._1(Printf.printf(--[[ Format ]]{
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ End_of_format ]]0
                  }),
                "%s"
              }), exn[1]);
      return Pervasives.exit(0);
    end else do
      error(exn)
    end end  end 
  end end)
end end

function second_word(s) do
  len = #s;
  loop = function(_n) do
    while(true) do
      n = _n;
      if (n >= len) then do
        return len;
      end else if (Caml_string.get(s, n) == --[[ " " ]]32) then do
        _n = n + 1 | 0;
        ::continue:: ;
      end else do
        return n;
      end end  end 
    end;
  end end;
  n;
  xpcall(function() do
    n = __String.index(s, --[[ "\t" ]]9);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      exit = 0;
      n_1;
      xpcall(function() do
        n_1 = __String.index(s, --[[ " " ]]32);
        exit = 2;
      end end,function(exn_1) do
        if (exn_1 == Caml_builtin_exceptions.not_found) then do
          return len;
        end else do
          error(exn_1)
        end end 
      end end)
      if (exit == 2) then do
        return loop(n_1 + 1 | 0);
      end
       end 
    end else do
      error(exn)
    end end 
  end end)
  return loop(n + 1 | 0);
end end

function max_arg_len(cur, param) do
  kwd = param[0];
  if (param[1].tag == --[[ Symbol ]]11) then do
    return Caml_primitive.caml_int_max(cur, #kwd);
  end else do
    return Caml_primitive.caml_int_max(cur, #kwd + second_word(param[2]) | 0);
  end end 
end end

function replace_leading_tab(s) do
  seen = do
    contents: false
  end;
  return __String.map((function(c) do
                if (c ~= 9 or seen.contents) then do
                  return c;
                end else do
                  seen.contents = true;
                  return --[[ " " ]]32;
                end end 
              end end), s);
end end

function align(limitOpt, speclist) do
  limit = limitOpt ~= undefined and limitOpt or Pervasives.max_int;
  completed = add_help(speclist);
  len = List.fold_left(max_arg_len, 0, completed);
  len_1 = len < limit and len or limit;
  return List.map((function(param) do
                len_2 = len_1;
                ksd = param;
                spec = ksd[1];
                kwd = ksd[0];
                if (ksd[2] == "") then do
                  return ksd;
                end else if (spec.tag == --[[ Symbol ]]11) then do
                  msg = ksd[2];
                  cutcol = second_word(msg);
                  n = Caml_primitive.caml_int_max(0, len_2 - cutcol | 0) + 3 | 0;
                  spaces = Caml_bytes.bytes_to_string(Bytes.make(n, --[[ " " ]]32));
                  return --[[ tuple ]]{
                          kwd,
                          spec,
                          "\n" .. (spaces .. replace_leading_tab(msg))
                        };
                end else do
                  msg_1 = ksd[2];
                  cutcol_1 = second_word(msg_1);
                  kwd_len = #kwd;
                  diff = (len_2 - kwd_len | 0) - cutcol_1 | 0;
                  if (diff <= 0) then do
                    return --[[ tuple ]]{
                            kwd,
                            spec,
                            replace_leading_tab(msg_1)
                          };
                  end else do
                    spaces_1 = Caml_bytes.bytes_to_string(Bytes.make(diff, --[[ " " ]]32));
                    prefix = __String.sub(replace_leading_tab(msg_1), 0, cutcol_1);
                    suffix = __String.sub(msg_1, cutcol_1, #msg_1 - cutcol_1 | 0);
                    return --[[ tuple ]]{
                            kwd,
                            spec,
                            prefix .. (spaces_1 .. suffix)
                          };
                  end end 
                end end  end 
              end end), completed);
end end

function trim_cr(s) do
  len = #s;
  if (len > 0 and Caml_string.get(s, len - 1 | 0) == --[[ "\r" ]]13) then do
    return __String.sub(s, 0, len - 1 | 0);
  end else do
    return s;
  end end 
end end

function read_aux(trim, sep, file) do
  ic = Pervasives.open_in_bin(file);
  buf = __Buffer.create(200);
  words = do
    contents: --[[ [] ]]0
  end;
  stash = function(param) do
    word = __Buffer.contents(buf);
    word_1 = trim and trim_cr(word) or word;
    words.contents = --[[ :: ]]{
      word_1,
      words.contents
    };
    buf.position = 0;
    return --[[ () ]]0;
  end end;
  read = function(param) do
    xpcall(function() do
      c = Caml_external_polyfill.resolve("caml_ml_input_char")(ic);
      if (c == sep) then do
        stash(--[[ () ]]0);
        return read(--[[ () ]]0);
      end else do
        __Buffer.add_char(buf, c);
        return read(--[[ () ]]0);
      end end 
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.end_of_file) then do
        if (buf.position > 0) then do
          return stash(--[[ () ]]0);
        end else do
          return 0;
        end end 
      end else do
        error(exn)
      end end 
    end end)
  end end;
  read(--[[ () ]]0);
  Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  return __Array.of_list(List.rev(words.contents));
end end

function read_arg(param) do
  return read_aux(true, --[[ "\n" ]]10, param);
end end

function read_arg0(param) do
  return read_aux(false, --[[ "\000" ]]0, param);
end end

function write_aux(sep, file, args) do
  oc = Pervasives.open_out_bin(file);
  __Array.iter((function(s) do
          return Curry._2(Printf.fprintf(oc, --[[ Format ]]{
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ Char ]]Block.__(0, {--[[ End_of_format ]]0})
                            }),
                          "%s%c"
                        }), s, sep);
        end end), args);
  Caml_io.caml_ml_flush(oc);
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
end end

function write_arg(param, param_1) do
  return write_aux(--[[ "\n" ]]10, param, param_1);
end end

function write_arg0(param, param_1) do
  return write_aux(--[[ "\000" ]]0, param, param_1);
end end

export do
  parse ,
  parse_dynamic ,
  parse_argv ,
  parse_argv_dynamic ,
  parse_and_expand_argv_dynamic ,
  parse_expand ,
  Help ,
  Bad ,
  usage ,
  usage_string ,
  align ,
  current ,
  read_arg ,
  read_arg0 ,
  write_arg ,
  write_arg0 ,
  
end
--[[ No side effect ]]
