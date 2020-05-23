

import * as Sys from "./sys.js";
import * as List from "./list.js";
import * as $$Array from "./array.js";
import * as Block from "./block.js";
import * as Bytes from "./bytes.js";
import * as Curry from "./curry.js";
import * as $$Buffer from "./buffer.js";
import * as Printf from "./printf.js";
import * as $$String from "./string.js";
import * as Caml_io from "./caml_io.js";
import * as Caml_obj from "./caml_obj.js";
import * as Caml_array from "./caml_array.js";
import * as Caml_bytes from "./caml_bytes.js";
import * as Pervasives from "./pervasives.js";
import * as Caml_format from "./caml_format.js";
import * as Caml_string from "./caml_string.js";
import * as Caml_primitive from "./caml_primitive.js";
import * as Caml_exceptions from "./caml_exceptions.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as Caml_external_polyfill from "./caml_external_polyfill.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

var Bad = Caml_exceptions.create("Arg.Bad");

var Help = Caml_exceptions.create("Arg.Help");

var Stop = Caml_exceptions.create("Arg.Stop");

function assoc3(x, _l) do
  while(true) do
    var l = _l;
    if (l) do
      var match = l[0];
      if (Caml_obj.caml_equal(match[0], x)) do
        return match[1];
      end else do
        _l = l[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function split(s) do
  var i = $$String.index(s, --[ "=" ]--61);
  var len = #s;
  return --[ tuple ]--[
          $$String.sub(s, 0, i),
          $$String.sub(s, i + 1 | 0, len - (i + 1 | 0) | 0)
        ];
end

function make_symlist(prefix, sep, suffix, l) do
  if (l) do
    return List.fold_left((function (x, y) do
                  return x .. (sep .. y);
                end), prefix .. l[0], l[1]) .. suffix;
  end else do
    return "<none>";
  end
end

function help_action(param) do
  throw [
        Stop,
        --[ Unknown ]--Block.__(0, ["-help"])
      ];
end

function add_help(speclist) do
  var add1;
  try do
    assoc3("-help", speclist);
    add1 = --[ [] ]--0;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      add1 = --[ :: ]--[
        --[ tuple ]--[
          "-help",
          --[ Unit ]--Block.__(0, [help_action]),
          " Display this list of options"
        ],
        --[ [] ]--0
      ];
    end else do
      throw exn;
    end
  end
  var add2;
  try do
    assoc3("--help", speclist);
    add2 = --[ [] ]--0;
  end
  catch (exn$1)do
    if (exn$1 == Caml_builtin_exceptions.not_found) do
      add2 = --[ :: ]--[
        --[ tuple ]--[
          "--help",
          --[ Unit ]--Block.__(0, [help_action]),
          " Display this list of options"
        ],
        --[ [] ]--0
      ];
    end else do
      throw exn$1;
    end
  end
  return Pervasives.$at(speclist, Pervasives.$at(add1, add2));
end

function usage_b(buf, speclist, errmsg) do
  Curry._1(Printf.bprintf(buf, --[ Format ]--[
            --[ String ]--Block.__(2, [
                --[ No_padding ]--0,
                --[ Char_literal ]--Block.__(12, [
                    --[ "\n" ]--10,
                    --[ End_of_format ]--0
                  ])
              ]),
            "%s\n"
          ]), errmsg);
  return List.iter((function (param) do
                var buf$1 = buf;
                var param$1 = param;
                var doc = param$1[2];
                if (#doc ~= 0) do
                  var spec = param$1[1];
                  var key = param$1[0];
                  if (spec.tag == --[ Symbol ]--11) do
                    return Curry._3(Printf.bprintf(buf$1, --[ Format ]--[
                                    --[ String_literal ]--Block.__(11, [
                                        "  ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ Char_literal ]--Block.__(12, [
                                                --[ " " ]--32,
                                                --[ String ]--Block.__(2, [
                                                    --[ No_padding ]--0,
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
                                      ]),
                                    "  %s %s%s\n"
                                  ]), key, make_symlist("{", "|", "}", spec[0]), doc);
                  end else do
                    return Curry._2(Printf.bprintf(buf$1, --[ Format ]--[
                                    --[ String_literal ]--Block.__(11, [
                                        "  ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ Char_literal ]--Block.__(12, [
                                                --[ " " ]--32,
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
                                    "  %s %s\n"
                                  ]), key, doc);
                  end
                end else do
                  return 0;
                end
              end), add_help(speclist));
end

function usage_string(speclist, errmsg) do
  var b = $$Buffer.create(200);
  usage_b(b, speclist, errmsg);
  return $$Buffer.contents(b);
end

function usage(speclist, errmsg) do
  return Curry._1(Printf.eprintf(--[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%s"
                ]), usage_string(speclist, errmsg));
end

var current = do
  contents: 0
end;

function bool_of_string_opt(x) do
  try do
    return Pervasives.bool_of_string(x);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.invalid_argument) do
      return ;
    end else do
      throw exn;
    end
  end
end

function int_of_string_opt(x) do
  try do
    return Caml_format.caml_int_of_string(x);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) do
      return ;
    end else do
      throw exn;
    end
  end
end

function float_of_string_opt(x) do
  try do
    return Caml_format.caml_float_of_string(x);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) do
      return ;
    end else do
      throw exn;
    end
  end
end

function parse_and_expand_argv_dynamic_aux(allow_expand, current, argv, speclist, anonfun, errmsg) do
  var initpos = current.contents;
  var convert_error = function (error) do
    var b = $$Buffer.create(200);
    var progname = initpos < #argv.contents ? Caml_array.caml_array_get(argv.contents, initpos) : "(?)";
    switch (error.tag | 0) do
      case --[ Unknown ]--0 :
          var s = error[0];
          switch (s) do
            case "--help" :
            case "-help" :
                break;
            default:
              Curry._2(Printf.bprintf(b, --[ Format ]--[
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": unknown option '",
                                --[ String ]--Block.__(2, [
                                    --[ No_padding ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        "'.\n",
                                        --[ End_of_format ]--0
                                      ])
                                  ])
                              ])
                          ]),
                        "%s: unknown option '%s'.\n"
                      ]), progname, s);
          end
          break;
      case --[ Wrong ]--1 :
          Curry._4(Printf.bprintf(b, --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ": wrong argument '",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    "'; option '",
                                    --[ String ]--Block.__(2, [
                                        --[ No_padding ]--0,
                                        --[ String_literal ]--Block.__(11, [
                                            "' expects ",
                                            --[ String ]--Block.__(2, [
                                                --[ No_padding ]--0,
                                                --[ String_literal ]--Block.__(11, [
                                                    ".\n",
                                                    --[ End_of_format ]--0
                                                  ])
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "%s: wrong argument '%s'; option '%s' expects %s.\n"
                  ]), progname, error[1], error[0], error[2]);
          break;
      case --[ Missing ]--2 :
          Curry._2(Printf.bprintf(b, --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ": option '",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    "' needs an argument.\n",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ]),
                    "%s: option '%s' needs an argument.\n"
                  ]), progname, error[0]);
          break;
      case --[ Message ]--3 :
          Curry._2(Printf.bprintf(b, --[ Format ]--[
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ": ",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    ".\n",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ]),
                    "%s: %s.\n"
                  ]), progname, error[0]);
          break;
      
    end
    usage_b(b, speclist.contents, errmsg);
    if (Caml_obj.caml_equal(error, --[ Unknown ]--Block.__(0, ["-help"])) or Caml_obj.caml_equal(error, --[ Unknown ]--Block.__(0, ["--help"]))) do
      return [
              Help,
              $$Buffer.contents(b)
            ];
    end else do
      return [
              Bad,
              $$Buffer.contents(b)
            ];
    end
  end;
  current.contents = current.contents + 1 | 0;
  while(current.contents < #argv.contents) do
    try do
      var s = Caml_array.caml_array_get(argv.contents, current.contents);
      if (#s >= 1 and Caml_string.get(s, 0) == --[ "-" ]--45) do
        var match;
        try do
          match = --[ tuple ]--[
            assoc3(s, speclist.contents),
            undefined
          ];
        end
        catch (exn)do
          if (exn == Caml_builtin_exceptions.not_found) do
            try do
              var match$1 = split(s);
              match = --[ tuple ]--[
                assoc3(match$1[0], speclist.contents),
                match$1[1]
              ];
            end
            catch (exn$1)do
              if (exn$1 == Caml_builtin_exceptions.not_found) do
                throw [
                      Stop,
                      --[ Unknown ]--Block.__(0, [s])
                    ];
              end
              throw exn$1;
            end
          end else do
            throw exn;
          end
        end
        var follow = match[1];
        var no_arg = (function(s,follow)do
        return function no_arg(param) do
          if (follow ~= undefined) do
            throw [
                  Stop,
                  --[ Wrong ]--Block.__(1, [
                      s,
                      follow,
                      "no argument"
                    ])
                ];
          end else do
            return --[ () ]--0;
          end
        end
        end(s,follow));
        var get_arg = (function(s,follow)do
        return function get_arg(param) do
          if (follow ~= undefined) do
            return follow;
          end else if ((current.contents + 1 | 0) < #argv.contents) do
            return Caml_array.caml_array_get(argv.contents, current.contents + 1 | 0);
          end else do
            throw [
                  Stop,
                  --[ Missing ]--Block.__(2, [s])
                ];
          end
        end
        end(s,follow));
        var consume_arg = (function(follow)do
        return function consume_arg(param) do
          if (follow ~= undefined) do
            return --[ () ]--0;
          end else do
            current.contents = current.contents + 1 | 0;
            return --[ () ]--0;
          end
        end
        end(follow));
        var treat_action = (function(s)do
        return function treat_action(param) do
          switch (param.tag | 0) do
            case --[ Unit ]--0 :
                return Curry._1(param[0], --[ () ]--0);
            case --[ Bool ]--1 :
                var arg = get_arg(--[ () ]--0);
                var match = bool_of_string_opt(arg);
                if (match ~= undefined) do
                  Curry._1(param[0], match);
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg,
                            "a boolean"
                          ])
                      ];
                end
                return consume_arg(--[ () ]--0);
            case --[ Set ]--2 :
                no_arg(--[ () ]--0);
                param[0].contents = true;
                return --[ () ]--0;
            case --[ Clear ]--3 :
                no_arg(--[ () ]--0);
                param[0].contents = false;
                return --[ () ]--0;
            case --[ String ]--4 :
                var arg$1 = get_arg(--[ () ]--0);
                Curry._1(param[0], arg$1);
                return consume_arg(--[ () ]--0);
            case --[ Set_string ]--5 :
                param[0].contents = get_arg(--[ () ]--0);
                return consume_arg(--[ () ]--0);
            case --[ Int ]--6 :
                var arg$2 = get_arg(--[ () ]--0);
                var match$1 = int_of_string_opt(arg$2);
                if (match$1 ~= undefined) do
                  Curry._1(param[0], match$1);
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg$2,
                            "an integer"
                          ])
                      ];
                end
                return consume_arg(--[ () ]--0);
            case --[ Set_int ]--7 :
                var arg$3 = get_arg(--[ () ]--0);
                var match$2 = int_of_string_opt(arg$3);
                if (match$2 ~= undefined) do
                  param[0].contents = match$2;
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg$3,
                            "an integer"
                          ])
                      ];
                end
                return consume_arg(--[ () ]--0);
            case --[ Float ]--8 :
                var arg$4 = get_arg(--[ () ]--0);
                var match$3 = float_of_string_opt(arg$4);
                if (match$3 ~= undefined) do
                  Curry._1(param[0], match$3);
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg$4,
                            "a float"
                          ])
                      ];
                end
                return consume_arg(--[ () ]--0);
            case --[ Set_float ]--9 :
                var arg$5 = get_arg(--[ () ]--0);
                var match$4 = float_of_string_opt(arg$5);
                if (match$4 ~= undefined) do
                  param[0].contents = match$4;
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg$5,
                            "a float"
                          ])
                      ];
                end
                return consume_arg(--[ () ]--0);
            case --[ Tuple ]--10 :
                return List.iter(treat_action, param[0]);
            case --[ Symbol ]--11 :
                var symb = param[0];
                var arg$6 = get_arg(--[ () ]--0);
                if (List.mem(arg$6, symb)) do
                  Curry._1(param[1], arg$6);
                  return consume_arg(--[ () ]--0);
                end else do
                  throw [
                        Stop,
                        --[ Wrong ]--Block.__(1, [
                            s,
                            arg$6,
                            "one of: " .. make_symlist("", " ", "", symb)
                          ])
                      ];
                end
            case --[ Rest ]--12 :
                var f = param[0];
                while(current.contents < (#argv.contents - 1 | 0)) do
                  Curry._1(f, Caml_array.caml_array_get(argv.contents, current.contents + 1 | 0));
                  consume_arg(--[ () ]--0);
                end;
                return --[ () ]--0;
            case --[ Expand ]--13 :
                if (!allow_expand) do
                  throw [
                        Caml_builtin_exceptions.invalid_argument,
                        "Arg.Expand is is only allowed with Arg.parse_and_expand_argv_dynamic"
                      ];
                end
                var arg$7 = get_arg(--[ () ]--0);
                var newarg = Curry._1(param[0], arg$7);
                consume_arg(--[ () ]--0);
                var before = $$Array.sub(argv.contents, 0, current.contents + 1 | 0);
                var after = $$Array.sub(argv.contents, current.contents + 1 | 0, (#argv.contents - current.contents | 0) - 1 | 0);
                argv.contents = Caml_array.caml_array_concat(--[ :: ]--[
                      before,
                      --[ :: ]--[
                        newarg,
                        --[ :: ]--[
                          after,
                          --[ [] ]--0
                        ]
                      ]
                    ]);
                return --[ () ]--0;
            
          end
        end
        end(s));
        treat_action(match[0]);
      end else do
        Curry._1(anonfun, s);
      end
    end
    catch (raw_exn)do
      var exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn);
      if (exn$2[0] == Bad) do
        throw convert_error(--[ Message ]--Block.__(3, [exn$2[1]]));
      end
      if (exn$2[0] == Stop) do
        throw convert_error(exn$2[1]);
      end
      throw exn$2;
    end
    current.contents = current.contents + 1 | 0;
  end;
  return --[ () ]--0;
end

function parse_and_expand_argv_dynamic(current, argv, speclist, anonfun, errmsg) do
  return parse_and_expand_argv_dynamic_aux(true, current, argv, speclist, anonfun, errmsg);
end

function parse_argv_dynamic(currentOpt, argv, speclist, anonfun, errmsg) do
  var current$1 = currentOpt ~= undefined ? currentOpt : current;
  return parse_and_expand_argv_dynamic_aux(false, current$1, do
              contents: argv
            end, speclist, anonfun, errmsg);
end

function parse_argv(currentOpt, argv, speclist, anonfun, errmsg) do
  var current$1 = currentOpt ~= undefined ? currentOpt : current;
  return parse_argv_dynamic(current$1, argv, do
              contents: speclist
            end, anonfun, errmsg);
end

function parse(l, f, msg) do
  try do
    return parse_argv(undefined, Sys.argv, l, f, msg);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) do
      Curry._1(Printf.eprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) do
      Curry._1(Printf.printf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(0);
    end else do
      throw exn;
    end
  end
end

function parse_dynamic(l, f, msg) do
  try do
    return parse_argv_dynamic(undefined, Sys.argv, l, f, msg);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) do
      Curry._1(Printf.eprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) do
      Curry._1(Printf.printf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(0);
    end else do
      throw exn;
    end
  end
end

function parse_expand(l, f, msg) do
  try do
    var argv = do
      contents: Sys.argv
    end;
    var spec = do
      contents: l
    end;
    var current$1 = do
      contents: current.contents
    end;
    return parse_and_expand_argv_dynamic(current$1, argv, spec, f, msg);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Bad) do
      Curry._1(Printf.eprintf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(2);
    end else if (exn[0] == Help) do
      Curry._1(Printf.printf(--[ Format ]--[
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ End_of_format ]--0
                  ]),
                "%s"
              ]), exn[1]);
      return Pervasives.exit(0);
    end else do
      throw exn;
    end
  end
end

function second_word(s) do
  var len = #s;
  var loop = function (_n) do
    while(true) do
      var n = _n;
      if (n >= len) do
        return len;
      end else if (Caml_string.get(s, n) == --[ " " ]--32) do
        _n = n + 1 | 0;
        continue ;
      end else do
        return n;
      end
    end;
  end;
  var n;
  try do
    n = $$String.index(s, --[ "\t" ]--9);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      var exit = 0;
      var n$1;
      try do
        n$1 = $$String.index(s, --[ " " ]--32);
        exit = 2;
      end
      catch (exn$1)do
        if (exn$1 == Caml_builtin_exceptions.not_found) do
          return len;
        end else do
          throw exn$1;
        end
      end
      if (exit == 2) do
        return loop(n$1 + 1 | 0);
      end
      
    end else do
      throw exn;
    end
  end
  return loop(n + 1 | 0);
end

function max_arg_len(cur, param) do
  var kwd = param[0];
  if (param[1].tag == --[ Symbol ]--11) do
    return Caml_primitive.caml_int_max(cur, #kwd);
  end else do
    return Caml_primitive.caml_int_max(cur, #kwd + second_word(param[2]) | 0);
  end
end

function replace_leading_tab(s) do
  var seen = do
    contents: false
  end;
  return $$String.map((function (c) do
                if (c ~= 9 or seen.contents) do
                  return c;
                end else do
                  seen.contents = true;
                  return --[ " " ]--32;
                end
              end), s);
end

function align(limitOpt, speclist) do
  var limit = limitOpt ~= undefined ? limitOpt : Pervasives.max_int;
  var completed = add_help(speclist);
  var len = List.fold_left(max_arg_len, 0, completed);
  var len$1 = len < limit ? len : limit;
  return List.map((function (param) do
                var len$2 = len$1;
                var ksd = param;
                var spec = ksd[1];
                var kwd = ksd[0];
                if (ksd[2] == "") do
                  return ksd;
                end else if (spec.tag == --[ Symbol ]--11) do
                  var msg = ksd[2];
                  var cutcol = second_word(msg);
                  var n = Caml_primitive.caml_int_max(0, len$2 - cutcol | 0) + 3 | 0;
                  var spaces = Caml_bytes.bytes_to_string(Bytes.make(n, --[ " " ]--32));
                  return --[ tuple ]--[
                          kwd,
                          spec,
                          "\n" .. (spaces .. replace_leading_tab(msg))
                        ];
                end else do
                  var msg$1 = ksd[2];
                  var cutcol$1 = second_word(msg$1);
                  var kwd_len = #kwd;
                  var diff = (len$2 - kwd_len | 0) - cutcol$1 | 0;
                  if (diff <= 0) do
                    return --[ tuple ]--[
                            kwd,
                            spec,
                            replace_leading_tab(msg$1)
                          ];
                  end else do
                    var spaces$1 = Caml_bytes.bytes_to_string(Bytes.make(diff, --[ " " ]--32));
                    var prefix = $$String.sub(replace_leading_tab(msg$1), 0, cutcol$1);
                    var suffix = $$String.sub(msg$1, cutcol$1, #msg$1 - cutcol$1 | 0);
                    return --[ tuple ]--[
                            kwd,
                            spec,
                            prefix .. (spaces$1 .. suffix)
                          ];
                  end
                end
              end), completed);
end

function trim_cr(s) do
  var len = #s;
  if (len > 0 and Caml_string.get(s, len - 1 | 0) == --[ "\r" ]--13) do
    return $$String.sub(s, 0, len - 1 | 0);
  end else do
    return s;
  end
end

function read_aux(trim, sep, file) do
  var ic = Pervasives.open_in_bin(file);
  var buf = $$Buffer.create(200);
  var words = do
    contents: --[ [] ]--0
  end;
  var stash = function (param) do
    var word = $$Buffer.contents(buf);
    var word$1 = trim ? trim_cr(word) : word;
    words.contents = --[ :: ]--[
      word$1,
      words.contents
    ];
    buf.position = 0;
    return --[ () ]--0;
  end;
  var read = function (param) do
    try do
      var c = Caml_external_polyfill.resolve("caml_ml_input_char")(ic);
      if (c == sep) do
        stash(--[ () ]--0);
        return read(--[ () ]--0);
      end else do
        $$Buffer.add_char(buf, c);
        return read(--[ () ]--0);
      end
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.end_of_file) do
        if (buf.position > 0) do
          return stash(--[ () ]--0);
        end else do
          return 0;
        end
      end else do
        throw exn;
      end
    end
  end;
  read(--[ () ]--0);
  Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  return $$Array.of_list(List.rev(words.contents));
end

function read_arg(param) do
  return read_aux(true, --[ "\n" ]--10, param);
end

function read_arg0(param) do
  return read_aux(false, --[ "\000" ]--0, param);
end

function write_aux(sep, file, args) do
  var oc = Pervasives.open_out_bin(file);
  $$Array.iter((function (s) do
          return Curry._2(Printf.fprintf(oc, --[ Format ]--[
                          --[ String ]--Block.__(2, [
                              --[ No_padding ]--0,
                              --[ Char ]--Block.__(0, [--[ End_of_format ]--0])
                            ]),
                          "%s%c"
                        ]), s, sep);
        end), args);
  Caml_io.caml_ml_flush(oc);
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
end

function write_arg(param, param$1) do
  return write_aux(--[ "\n" ]--10, param, param$1);
end

function write_arg0(param, param$1) do
  return write_aux(--[ "\000" ]--0, param, param$1);
end

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
--[ No side effect ]--
