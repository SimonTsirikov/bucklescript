--[['use strict';]]

Sys = require "../../lib/js/sys.lua";
Char = require "../../lib/js/char.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";
Bytes = require "../../lib/js/bytes.lua";
Curry = require "../../lib/js/curry.lua";
$$Buffer = require "../../lib/js/buffer.lua";
Format = require "../../lib/js/format.lua";
Printf = require "../../lib/js/printf.lua";
$$String = require "../../lib/js/string.lua";
Caml_io = require "../../lib/js/caml_io.lua";
Printexc = require "../../lib/js/printexc.lua";
Caml_bytes = require "../../lib/js/caml_bytes.lua";
Caml_int32 = require "../../lib/js/caml_int32.lua";
Pervasives = require "../../lib/js/pervasives.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions.lua";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function _with_in(filename, f) do
  ic = Pervasives.open_in_bin(filename);
  try do
    x = Curry._1(f, ic);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    return x;
  end
  catch (raw_e)do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
    return --[[ `Error ]][
            106380200,
            Printexc.to_string(e)
          ];
  end
end end

function _must_escape(s) do
  try do
    for i = 0 , #s - 1 | 0 , 1 do
      c = s.charCodeAt(i);
      exit = 0;
      if (c >= 42) then do
        if (c ~= 59) then do
          if (c ~= 92) then do
            exit = 1;
          end else do
            throw Pervasives.Exit;
          end end 
        end else do
          throw Pervasives.Exit;
        end end 
      end else if (c >= 11) then do
        if (c >= 32) then do
          local ___conditional___=(c - 32 | 0);
          do
             if ___conditional___ = 1
             or ___conditional___ = 3
             or ___conditional___ = 4
             or ___conditional___ = 5
             or ___conditional___ = 6
             or ___conditional___ = 7 then do
                exit = 1;end else 
             if ___conditional___ = 0
             or ___conditional___ = 2
             or ___conditional___ = 8
             or ___conditional___ = 9 then do
                throw Pervasives.Exit;end end end 
             do end
            
          end
        end else do
          exit = 1;
        end end 
      end else do
        if (c >= 9) then do
          throw Pervasives.Exit;
        end
         end 
        exit = 1;
      end end  end 
      if (exit == 1 and c > 127) then do
        throw Pervasives.Exit;
      end
       end 
    end
    return false;
  end
  catch (exn)do
    if (exn == Pervasives.Exit) then do
      return true;
    end else do
      throw exn;
    end end 
  end
end end

function to_buf(b, t) do
  if (t[0] >= 848054398) then do
    l = t[1];
    if (l) then do
      if (l[1]) then do
        $$Buffer.add_char(b, --[[ "(" ]]40);
        List.iteri((function (i, t$prime) do
                if (i > 0) then do
                  $$Buffer.add_char(b, --[[ " " ]]32);
                end
                 end 
                return to_buf(b, t$prime);
              end end), l);
        return $$Buffer.add_char(b, --[[ ")" ]]41);
      end else do
        return Curry._2(Printf.bprintf(b, --[[ Format ]][
                        --[[ Char_literal ]]Block.__(12, [
                            --[[ "(" ]]40,
                            --[[ Alpha ]]Block.__(15, [--[[ Char_literal ]]Block.__(12, [
                                    --[[ ")" ]]41,
                                    --[[ End_of_format ]]0
                                  ])])
                          ]),
                        "(%a)"
                      ]), to_buf, l[0]);
      end end 
    end else do
      return $$Buffer.add_string(b, "()");
    end end 
  end else do
    s = t[1];
    if (_must_escape(s)) then do
      return Curry._1(Printf.bprintf(b, --[[ Format ]][
                      --[[ Char_literal ]]Block.__(12, [
                          --[[ "\"" ]]34,
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ "\"" ]]34,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return $$Buffer.add_string(b, s);
    end end 
  end end 
end end

function to_string(t) do
  b = $$Buffer.create(128);
  to_buf(b, t);
  return $$Buffer.contents(b);
end end

function print(fmt, t) do
  if (t[0] >= 848054398) then do
    l = t[1];
    if (l) then do
      if (l[1]) then do
        Format.fprintf(fmt, --[[ Format ]][
              --[[ Formatting_gen ]]Block.__(18, [
                  --[[ Open_box ]]Block.__(1, [--[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "<hov1>",
                            --[[ End_of_format ]]0
                          ]),
                        "<hov1>"
                      ]]),
                  --[[ Char_literal ]]Block.__(12, [
                      --[[ "(" ]]40,
                      --[[ End_of_format ]]0
                    ])
                ]),
              "@[<hov1>("
            ]);
        List.iteri((function (i, t$prime) do
                if (i > 0) then do
                  Format.fprintf(fmt, --[[ Format ]][
                        --[[ Formatting_lit ]]Block.__(17, [
                            --[[ Break ]]Block.__(0, [
                                "@ ",
                                1,
                                0
                              ]),
                            --[[ End_of_format ]]0
                          ]),
                        "@ "
                      ]);
                end
                 end 
                return print(fmt, t$prime);
              end end), l);
        return Format.fprintf(fmt, --[[ Format ]][
                    --[[ Char_literal ]]Block.__(12, [
                        --[[ ")" ]]41,
                        --[[ Formatting_lit ]]Block.__(17, [
                            --[[ Close_box ]]0,
                            --[[ End_of_format ]]0
                          ])
                      ]),
                    ")@]"
                  ]);
      end else do
        return Curry._2(Format.fprintf(fmt, --[[ Format ]][
                        --[[ Formatting_gen ]]Block.__(18, [
                            --[[ Open_box ]]Block.__(1, [--[[ Format ]][
                                  --[[ String_literal ]]Block.__(11, [
                                      "<hov2>",
                                      --[[ End_of_format ]]0
                                    ]),
                                  "<hov2>"
                                ]]),
                            --[[ Char_literal ]]Block.__(12, [
                                --[[ "(" ]]40,
                                --[[ Alpha ]]Block.__(15, [--[[ Char_literal ]]Block.__(12, [
                                        --[[ ")" ]]41,
                                        --[[ Formatting_lit ]]Block.__(17, [
                                            --[[ Close_box ]]0,
                                            --[[ End_of_format ]]0
                                          ])
                                      ])])
                              ])
                          ]),
                        "@[<hov2>(%a)@]"
                      ]), print, l[0]);
      end end 
    end else do
      return Format.pp_print_string(fmt, "()");
    end end 
  end else do
    s = t[1];
    if (_must_escape(s)) then do
      return Curry._1(Format.fprintf(fmt, --[[ Format ]][
                      --[[ Char_literal ]]Block.__(12, [
                          --[[ "\"" ]]34,
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ "\"" ]]34,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return Format.pp_print_string(fmt, s);
    end end 
  end end 
end end

function print_noindent(fmt, t) do
  if (t[0] >= 848054398) then do
    l = t[1];
    if (l) then do
      if (l[1]) then do
        Format.pp_print_char(fmt, --[[ "(" ]]40);
        List.iteri((function (i, t$prime) do
                if (i > 0) then do
                  Format.pp_print_char(fmt, --[[ " " ]]32);
                end
                 end 
                return print_noindent(fmt, t$prime);
              end end), l);
        return Format.pp_print_char(fmt, --[[ ")" ]]41);
      end else do
        return Curry._2(Format.fprintf(fmt, --[[ Format ]][
                        --[[ Char_literal ]]Block.__(12, [
                            --[[ "(" ]]40,
                            --[[ Alpha ]]Block.__(15, [--[[ Char_literal ]]Block.__(12, [
                                    --[[ ")" ]]41,
                                    --[[ End_of_format ]]0
                                  ])])
                          ]),
                        "(%a)"
                      ]), print_noindent, l[0]);
      end end 
    end else do
      return Format.pp_print_string(fmt, "()");
    end end 
  end else do
    s = t[1];
    if (_must_escape(s)) then do
      return Curry._1(Format.fprintf(fmt, --[[ Format ]][
                      --[[ Char_literal ]]Block.__(12, [
                          --[[ "\"" ]]34,
                          --[[ String ]]Block.__(2, [
                              --[[ No_padding ]]0,
                              --[[ Char_literal ]]Block.__(12, [
                                  --[[ "\"" ]]34,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ]),
                      "\"%s\""
                    ]), $$String.escaped(s));
    end else do
      return Format.pp_print_string(fmt, s);
    end end 
  end end 
end end

function to_chan(oc, t) do
  fmt = Format.formatter_of_out_channel(oc);
  print(fmt, t);
  return Format.pp_print_flush(fmt, --[[ () ]]0);
end end

function to_file_seq(filename, seq) do
  filename$1 = filename;
  f = function (oc) do
    return Curry._1(seq, (function (t) do
                  to_chan(oc, t);
                  return Caml_io.caml_ml_output_char(oc, --[[ "\n" ]]10);
                end end));
  end end;
  oc = Pervasives.open_out(filename$1);
  try do
    x = Curry._1(f, oc);
    Caml_io.caml_ml_flush(oc);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
    return x;
  end
  catch (e)do
    Caml_io.caml_ml_flush(oc);
    Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
    throw e;
  end
end end

function to_file(filename, t) do
  return to_file_seq(filename, (function (k) do
                return Curry._1(k, t);
              end end));
end end

function $$return(x) do
  return x;
end end

function $great$great$eq(x, f) do
  return Curry._1(f, x);
end end

ID_MONAD = do
  $$return: $$return,
  $great$great$eq: $great$great$eq
end;

function make(bufsizeOpt, refill) do
  bufsize = bufsizeOpt ~= undefined and bufsizeOpt or 1024;
  bufsize$1 = Caml_primitive.caml_int_min(bufsize > 16 and bufsize or 16, Sys.max_string_length);
  return do
          buf: Caml_bytes.caml_create_bytes(bufsize$1),
          refill: refill,
          atom: $$Buffer.create(32),
          i: 0,
          len: 0,
          line: 1,
          col: 1
        end;
end end

function _is_digit(c) do
  if (--[[ "0" ]]48 <= c) then do
    return c <= --[[ "9" ]]57;
  end else do
    return false;
  end end 
end end

function _refill(t, k_succ, k_fail) do
  n = Curry._3(t.refill, t.buf, 0, #t.buf);
  t.i = 0;
  t.len = n;
  if (n == 0) then do
    return Curry._1(k_fail, t);
  end else do
    return Curry._1(k_succ, t);
  end end 
end end

function _get(t) do
  if (t.i >= t.len) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "sexpm.ml",
            152,
            4
          ]
        ];
  end
   end 
  c = Caml_bytes.get(t.buf, t.i);
  t.i = t.i + 1 | 0;
  if (c == --[[ "\n" ]]10) then do
    t.col = 1;
    t.line = t.line + 1 | 0;
  end else do
    t.col = t.col + 1 | 0;
  end end 
  return c;
end end

function _error(t, msg) do
  b = $$Buffer.create(32);
  Curry._2(Printf.bprintf(b, --[[ Format ]][
            --[[ String_literal ]]Block.__(11, [
                "at ",
                --[[ Int ]]Block.__(4, [
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ String_literal ]]Block.__(11, [
                        ", ",
                        --[[ Int ]]Block.__(4, [
                            --[[ Int_d ]]0,
                            --[[ No_padding ]]0,
                            --[[ No_precision ]]0,
                            --[[ String_literal ]]Block.__(11, [
                                ": ",
                                --[[ End_of_format ]]0
                              ])
                          ])
                      ])
                  ])
              ]),
            "at %d, %d: "
          ]), t.line, t.col);
  return Printf.kbprintf((function (b) do
                msg$prime = $$Buffer.contents(b);
                return --[[ `Error ]][
                        106380200,
                        msg$prime
                      ];
              end end), b, msg);
end end

function _error_eof(t) do
  return _error(t, --[[ Format ]][
              --[[ String_literal ]]Block.__(11, [
                  "unexpected end of input",
                  --[[ End_of_format ]]0
                ]),
              "unexpected end of input"
            ]);
end end

function expr(k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return expr(k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      if (c >= 11) then do
        if (c ~= 32) then do
          return expr_starting_with(c, k, t);
        end else do
          continue ;
        end end 
      end else if (c >= 9) then do
        continue ;
      end else do
        return expr_starting_with(c, k, t);
      end end  end 
    end end 
  end;
end end

function expr_starting_with(c, k, t) do
  if (c >= 42) then do
    if (c ~= 59) then do
      if (c == 92) then do
        return _error(t, --[[ Format ]][
                    --[[ String_literal ]]Block.__(11, [
                        "unexpected '\\'",
                        --[[ End_of_format ]]0
                      ]),
                    "unexpected '\\'"
                  ]);
      end
       end 
    end else do
      return skip_comment((function (param, param$1) do
                    return expr(k, t);
                  end end), t);
    end end 
  end else if (c >= 11) then do
    if (c >= 32) then do
      local ___conditional___=(c - 32 | 0);
      do
         if ___conditional___ = 0 then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]][
                    "sexpm.ml",
                    183,
                    27
                  ]
                ];end end end 
         if ___conditional___ = 2 then do
            return quoted(k, t);end end end 
         if ___conditional___ = 1
         or ___conditional___ = 3
         or ___conditional___ = 4
         or ___conditional___ = 5
         or ___conditional___ = 6
         or ___conditional___ = 7
         or ___conditional___ = 8 then do
            return expr_list(--[[ [] ]]0, k, t);end end end 
         if ___conditional___ = 9 then do
            return _error(t, --[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "unexpected ')'",
                            --[[ End_of_format ]]0
                          ]),
                        "unexpected ')'"
                      ]);end end end 
         do
        
      end
    end
     end 
  end else if (c >= 9) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "sexpm.ml",
            183,
            27
          ]
        ];
  end
   end  end  end 
  $$Buffer.add_char(t.atom, c);
  return atom(k, t);
end end

function expr_list(acc, k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return expr_list(acc, k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      switcher = c - 9 | 0;
      if (switcher > 23 or switcher < 0) then do
        if (switcher == 32) then do
          return Curry._2(k, undefined, --[[ `List ]][
                      848054398,
                      List.rev(acc)
                    ]);
        end
         end 
      end else if (switcher > 22 or switcher < 2) then do
        continue ;
      end
       end  end 
      return expr_starting_with(c, (function (last, e) do
                    if (last ~= undefined) then do
                      match = last;
                      if (match ~= 40) then do
                        if (match ~= 41) then do
                          return expr_list(--[[ :: ]][
                                      e,
                                      acc
                                    ], k, t);
                        end else do
                          return Curry._2(k, undefined, --[[ `List ]][
                                      848054398,
                                      List.rev(--[[ :: ]][
                                            e,
                                            acc
                                          ])
                                    ]);
                        end end 
                      end else do
                        return expr_list(--[[ [] ]]0, (function (param, l) do
                                      return expr_list(--[[ :: ]][
                                                  l,
                                                  acc
                                                ], k, t);
                                    end end), t);
                      end end 
                    end else do
                      return expr_list(--[[ :: ]][
                                  e,
                                  acc
                                ], k, t);
                    end end 
                  end end), t);
    end end 
  end;
end end

function _return_atom(last, k, t) do
  s = $$Buffer.contents(t.atom);
  t.atom.position = 0;
  return Curry._2(k, last, --[[ `Atom ]][
              726615281,
              s
            ]);
end end

function atom(k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return atom(k, param);
                  end end), (function (param) do
                    return _return_atom(undefined, k, param);
                  end end));
    end else do
      c = _get(t);
      exit = 0;
      if (c >= 35) then do
        if (c >= 42) then do
          if (c ~= 92) then do
            exit = 1;
          end else do
            return _error(t, --[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "unexpected '\\' in non-quoted string",
                            --[[ End_of_format ]]0
                          ]),
                        "unexpected '\\' in non-quoted string"
                      ]);
          end end 
        end else do
          exit = c >= 40 and 2 or 1;
        end end 
      end else if (c >= 11) then do
        if (c >= 32) then do
          local ___conditional___=(c - 32 | 0);
          do
             if ___conditional___ = 0 then do
                exit = 2;end else 
             if ___conditional___ = 1 then do
                exit = 1;end else 
             if ___conditional___ = 2 then do
                return _error(t, --[[ Format ]][
                            --[[ String_literal ]]Block.__(11, [
                                "unexpected '\"' in the middle of an atom",
                                --[[ End_of_format ]]0
                              ]),
                            "unexpected '\"' in the middle of an atom"
                          ]);end end end 
             do end end
            
          end
        end else do
          exit = 1;
        end end 
      end else do
        exit = c >= 9 and 2 or 1;
      end end  end 
      local ___conditional___=(exit);
      do
         if ___conditional___ = 1 then do
            $$Buffer.add_char(t.atom, c);
            continue ;end end end 
         if ___conditional___ = 2 then do
            return _return_atom(c, k, t);end end end 
         do
        
      end
    end end 
  end;
end end

function quoted(k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return quoted(k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      if (c ~= 34) then do
        if (c ~= 92) then do
          $$Buffer.add_char(t.atom, c);
          continue ;
        end else do
          return escaped((function (c) do
                        $$Buffer.add_char(t.atom, c);
                        return quoted(k, t);
                      end end), t);
        end end 
      end else do
        return _return_atom(undefined, k, t);
      end end 
    end end 
  end;
end end

function escaped(k, t) do
  if (t.i == t.len) then do
    return _refill(t, (function (param) do
                  return escaped(k, param);
                end end), _error_eof);
  end else do
    c = _get(t);
    if (c >= 92) then do
      if (c < 117) then do
        local ___conditional___=(c - 92 | 0);
        do
           if ___conditional___ = 0 then do
              return Curry._1(k, --[[ "\\" ]]92);end end end 
           if ___conditional___ = 6 then do
              return Curry._1(k, --[[ "\b" ]]8);end end end 
           if ___conditional___ = 18 then do
              return Curry._1(k, --[[ "\n" ]]10);end end end 
           if ___conditional___ = 22 then do
              return Curry._1(k, --[[ "\r" ]]13);end end end 
           if ___conditional___ = 1
           or ___conditional___ = 2
           or ___conditional___ = 3
           or ___conditional___ = 4
           or ___conditional___ = 5
           or ___conditional___ = 7
           or ___conditional___ = 8
           or ___conditional___ = 9
           or ___conditional___ = 10
           or ___conditional___ = 11
           or ___conditional___ = 12
           or ___conditional___ = 13
           or ___conditional___ = 14
           or ___conditional___ = 15
           or ___conditional___ = 16
           or ___conditional___ = 17
           or ___conditional___ = 19
           or ___conditional___ = 20
           or ___conditional___ = 21
           or ___conditional___ = 23
           or ___conditional___ = 24 then do
              return Curry._1(k, --[[ "\t" ]]9);end end end 
           do
          
        end
      end
       end 
    end else if (c == 34) then do
      return Curry._1(k, --[[ "\"" ]]34);
    end
     end  end 
    if (_is_digit(c)) then do
      return read2int(c - --[[ "0" ]]48 | 0, (function (n) do
                    return Curry._1(k, Char.chr(n));
                  end end), t);
    end else do
      return Curry._1(_error(t, --[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "unexpected escaped char '",
                          --[[ Char ]]Block.__(0, [--[[ Char_literal ]]Block.__(12, [
                                  --[[ "'" ]]39,
                                  --[[ End_of_format ]]0
                                ])])
                        ]),
                      "unexpected escaped char '%c'"
                    ]), c);
    end end 
  end end 
end end

function read2int(i, k, t) do
  if (t.i == t.len) then do
    return _refill(t, (function (param) do
                  return read2int(i, k, param);
                end end), _error_eof);
  end else do
    c = _get(t);
    if (_is_digit(c)) then do
      return read1int(Caml_int32.imul(10, i) + (c - --[[ "0" ]]48 | 0) | 0, k, t);
    end else do
      return Curry._1(_error(t, --[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "unexpected char '",
                          --[[ Char ]]Block.__(0, [--[[ String_literal ]]Block.__(11, [
                                  "' when reading byte",
                                  --[[ End_of_format ]]0
                                ])])
                        ]),
                      "unexpected char '%c' when reading byte"
                    ]), c);
    end end 
  end end 
end end

function read1int(i, k, t) do
  if (t.i == t.len) then do
    return _refill(t, (function (param) do
                  return read1int(i, k, param);
                end end), _error_eof);
  end else do
    c = _get(t);
    if (_is_digit(c)) then do
      return Curry._1(k, Caml_int32.imul(10, i) + (c - --[[ "0" ]]48 | 0) | 0);
    end else do
      return Curry._1(_error(t, --[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "unexpected char '",
                          --[[ Char ]]Block.__(0, [--[[ String_literal ]]Block.__(11, [
                                  "' when reading byte",
                                  --[[ End_of_format ]]0
                                ])])
                        ]),
                      "unexpected char '%c' when reading byte"
                    ]), c);
    end end 
  end end 
end end

function skip_comment(k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return skip_comment(k, param);
                  end end), _error_eof);
    end else do
      match = _get(t);
      if (match ~= 10) then do
        continue ;
      end else do
        return Curry._2(k, undefined, --[[ () ]]0);
      end end 
    end end 
  end;
end end

function expr_or_end(k, t) do
  while(true) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return expr_or_end(k, param);
                  end end), (function (param) do
                    return --[[ End ]]3455931;
                  end end));
    end else do
      c = _get(t);
      if (c >= 11) then do
        if (c ~= 32) then do
          return expr_starting_with(c, k, t);
        end else do
          continue ;
        end end 
      end else if (c >= 9) then do
        continue ;
      end else do
        return expr_starting_with(c, k, t);
      end end  end 
    end end 
  end;
end end

function next(t) do
  return expr_or_end((function (param, x) do
                return --[[ `Ok ]][
                        17724,
                        x
                      ];
              end end), t);
end end

function parse_string(s) do
  n = #s;
  stop = do
    contents: false
  end;
  refill = function (bytes, i, _len) do
    if (stop.contents) then do
      return 0;
    end else do
      stop.contents = true;
      Bytes.blit_string(s, 0, bytes, i, n);
      return n;
    end end 
  end end;
  d = make(n, refill);
  res = next(d);
  if (typeof res == "number") then do
    return --[[ `Error ]][
            106380200,
            "unexpected end of file"
          ];
  end else do
    return res;
  end end 
end end

function parse_chan(bufsize, ic) do
  d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end end));
  res = next(d);
  if (typeof res == "number") then do
    return --[[ `Error ]][
            106380200,
            "unexpected end of file"
          ];
  end else do
    return res;
  end end 
end end

function parse_chan_gen(bufsize, ic) do
  d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end end));
  return (function (param) do
      e = next(d);
      if (typeof e == "number") then do
        return ;
      end else do
        return e;
      end end 
    end end);
end end

function parse_chan_list(bufsize, ic) do
  d = make(bufsize, (function (param, param$1, param$2) do
          return Pervasives.input(ic, param, param$1, param$2);
        end end));
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    e = next(d);
    if (typeof e == "number") then do
      return --[[ `Ok ]][
              17724,
              List.rev(acc)
            ];
    end else if (e[0] >= 106380200) then do
      return e;
    end else do
      _acc = --[[ :: ]][
        e[1],
        acc
      ];
      continue ;
    end end  end 
  end;
end end

function parse_file(filename) do
  return _with_in(filename, (function (ic) do
                return parse_chan(undefined, ic);
              end end));
end end

function parse_file_list(filename) do
  return _with_in(filename, (function (ic) do
                return parse_chan_list(undefined, ic);
              end end));
end end

function MakeDecode(funarg) do
  $great$great$eq = funarg.$great$great$eq;
  make = function (bufsizeOpt, refill) do
    bufsize = bufsizeOpt ~= undefined and bufsizeOpt or 1024;
    bufsize$1 = Caml_primitive.caml_int_min(bufsize > 16 and bufsize or 16, Sys.max_string_length);
    return do
            buf: Caml_bytes.caml_create_bytes(bufsize$1),
            refill: refill,
            atom: $$Buffer.create(32),
            i: 0,
            len: 0,
            line: 1,
            col: 1
          end;
  end end;
  _is_digit = function (c) do
    if (--[[ "0" ]]48 <= c) then do
      return c <= --[[ "9" ]]57;
    end else do
      return false;
    end end 
  end end;
  _refill = function (t, k_succ, k_fail) do
    return Curry._2($great$great$eq, Curry._3(t.refill, t.buf, 0, #t.buf), (function (n) do
                  t.i = 0;
                  t.len = n;
                  if (n == 0) then do
                    return Curry._1(k_fail, t);
                  end else do
                    return Curry._1(k_succ, t);
                  end end 
                end end));
  end end;
  _get = function (t) do
    if (t.i >= t.len) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "sexpm.ml",
              152,
              4
            ]
          ];
    end
     end 
    c = Caml_bytes.get(t.buf, t.i);
    t.i = t.i + 1 | 0;
    if (c == --[[ "\n" ]]10) then do
      t.col = 1;
      t.line = t.line + 1 | 0;
    end else do
      t.col = t.col + 1 | 0;
    end end 
    return c;
  end end;
  _error = function (t, msg) do
    b = $$Buffer.create(32);
    Curry._2(Printf.bprintf(b, --[[ Format ]][
              --[[ String_literal ]]Block.__(11, [
                  "at ",
                  --[[ Int ]]Block.__(4, [
                      --[[ Int_d ]]0,
                      --[[ No_padding ]]0,
                      --[[ No_precision ]]0,
                      --[[ String_literal ]]Block.__(11, [
                          ", ",
                          --[[ Int ]]Block.__(4, [
                              --[[ Int_d ]]0,
                              --[[ No_padding ]]0,
                              --[[ No_precision ]]0,
                              --[[ String_literal ]]Block.__(11, [
                                  ": ",
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ])
                    ])
                ]),
              "at %d, %d: "
            ]), t.line, t.col);
    return Printf.kbprintf((function (b) do
                  msg$prime = $$Buffer.contents(b);
                  return Curry._1(funarg.$$return, --[[ `Error ]][
                              106380200,
                              msg$prime
                            ]);
                end end), b, msg);
  end end;
  _error_eof = function (t) do
    return _error(t, --[[ Format ]][
                --[[ String_literal ]]Block.__(11, [
                    "unexpected end of input",
                    --[[ End_of_format ]]0
                  ]),
                "unexpected end of input"
              ]);
  end end;
  expr = function (k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return expr(k, param);
                    end end), _error_eof);
      end else do
        c = _get(t);
        if (c >= 11) then do
          if (c ~= 32) then do
            return expr_starting_with(c, k, t);
          end else do
            continue ;
          end end 
        end else if (c >= 9) then do
          continue ;
        end else do
          return expr_starting_with(c, k, t);
        end end  end 
      end end 
    end;
  end end;
  expr_starting_with = function (c, k, t) do
    if (c >= 42) then do
      if (c ~= 59) then do
        if (c == 92) then do
          return _error(t, --[[ Format ]][
                      --[[ String_literal ]]Block.__(11, [
                          "unexpected '\\'",
                          --[[ End_of_format ]]0
                        ]),
                      "unexpected '\\'"
                    ]);
        end
         end 
      end else do
        return skip_comment((function (param, param$1) do
                      return expr(k, t);
                    end end), t);
      end end 
    end else if (c >= 11) then do
      if (c >= 32) then do
        local ___conditional___=(c - 32 | 0);
        do
           if ___conditional___ = 0 then do
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]][
                      "sexpm.ml",
                      183,
                      27
                    ]
                  ];end end end 
           if ___conditional___ = 2 then do
              return quoted(k, t);end end end 
           if ___conditional___ = 1
           or ___conditional___ = 3
           or ___conditional___ = 4
           or ___conditional___ = 5
           or ___conditional___ = 6
           or ___conditional___ = 7
           or ___conditional___ = 8 then do
              return expr_list(--[[ [] ]]0, k, t);end end end 
           if ___conditional___ = 9 then do
              return _error(t, --[[ Format ]][
                          --[[ String_literal ]]Block.__(11, [
                              "unexpected ')'",
                              --[[ End_of_format ]]0
                            ]),
                          "unexpected ')'"
                        ]);end end end 
           do
          
        end
      end
       end 
    end else if (c >= 9) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "sexpm.ml",
              183,
              27
            ]
          ];
    end
     end  end  end 
    $$Buffer.add_char(t.atom, c);
    return atom(k, t);
  end end;
  expr_list = function (acc, k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return expr_list(acc, k, param);
                    end end), _error_eof);
      end else do
        c = _get(t);
        switcher = c - 9 | 0;
        if (switcher > 23 or switcher < 0) then do
          if (switcher == 32) then do
            return Curry._2(k, undefined, --[[ `List ]][
                        848054398,
                        List.rev(acc)
                      ]);
          end
           end 
        end else if (switcher > 22 or switcher < 2) then do
          continue ;
        end
         end  end 
        return expr_starting_with(c, (function (last, e) do
                      if (last ~= undefined) then do
                        match = last;
                        if (match ~= 40) then do
                          if (match ~= 41) then do
                            return expr_list(--[[ :: ]][
                                        e,
                                        acc
                                      ], k, t);
                          end else do
                            return Curry._2(k, undefined, --[[ `List ]][
                                        848054398,
                                        List.rev(--[[ :: ]][
                                              e,
                                              acc
                                            ])
                                      ]);
                          end end 
                        end else do
                          return expr_list(--[[ [] ]]0, (function (param, l) do
                                        return expr_list(--[[ :: ]][
                                                    l,
                                                    acc
                                                  ], k, t);
                                      end end), t);
                        end end 
                      end else do
                        return expr_list(--[[ :: ]][
                                    e,
                                    acc
                                  ], k, t);
                      end end 
                    end end), t);
      end end 
    end;
  end end;
  _return_atom = function (last, k, t) do
    s = $$Buffer.contents(t.atom);
    t.atom.position = 0;
    return Curry._2(k, last, --[[ `Atom ]][
                726615281,
                s
              ]);
  end end;
  atom = function (k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return atom(k, param);
                    end end), (function (param) do
                      return _return_atom(undefined, k, param);
                    end end));
      end else do
        c = _get(t);
        exit = 0;
        if (c >= 35) then do
          if (c >= 42) then do
            if (c ~= 92) then do
              exit = 1;
            end else do
              return _error(t, --[[ Format ]][
                          --[[ String_literal ]]Block.__(11, [
                              "unexpected '\\' in non-quoted string",
                              --[[ End_of_format ]]0
                            ]),
                          "unexpected '\\' in non-quoted string"
                        ]);
            end end 
          end else do
            exit = c >= 40 and 2 or 1;
          end end 
        end else if (c >= 11) then do
          if (c >= 32) then do
            local ___conditional___=(c - 32 | 0);
            do
               if ___conditional___ = 0 then do
                  exit = 2;end else 
               if ___conditional___ = 1 then do
                  exit = 1;end else 
               if ___conditional___ = 2 then do
                  return _error(t, --[[ Format ]][
                              --[[ String_literal ]]Block.__(11, [
                                  "unexpected '\"' in the middle of an atom",
                                  --[[ End_of_format ]]0
                                ]),
                              "unexpected '\"' in the middle of an atom"
                            ]);end end end 
               do end end
              
            end
          end else do
            exit = 1;
          end end 
        end else do
          exit = c >= 9 and 2 or 1;
        end end  end 
        local ___conditional___=(exit);
        do
           if ___conditional___ = 1 then do
              $$Buffer.add_char(t.atom, c);
              continue ;end end end 
           if ___conditional___ = 2 then do
              return _return_atom(c, k, t);end end end 
           do
          
        end
      end end 
    end;
  end end;
  quoted = function (k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return quoted(k, param);
                    end end), _error_eof);
      end else do
        c = _get(t);
        if (c ~= 34) then do
          if (c ~= 92) then do
            $$Buffer.add_char(t.atom, c);
            continue ;
          end else do
            return escaped((function (c) do
                          $$Buffer.add_char(t.atom, c);
                          return quoted(k, t);
                        end end), t);
          end end 
        end else do
          return _return_atom(undefined, k, t);
        end end 
      end end 
    end;
  end end;
  escaped = function (k, t) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return escaped(k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      if (c >= 92) then do
        if (c < 117) then do
          local ___conditional___=(c - 92 | 0);
          do
             if ___conditional___ = 0 then do
                return Curry._1(k, --[[ "\\" ]]92);end end end 
             if ___conditional___ = 6 then do
                return Curry._1(k, --[[ "\b" ]]8);end end end 
             if ___conditional___ = 18 then do
                return Curry._1(k, --[[ "\n" ]]10);end end end 
             if ___conditional___ = 22 then do
                return Curry._1(k, --[[ "\r" ]]13);end end end 
             if ___conditional___ = 1
             or ___conditional___ = 2
             or ___conditional___ = 3
             or ___conditional___ = 4
             or ___conditional___ = 5
             or ___conditional___ = 7
             or ___conditional___ = 8
             or ___conditional___ = 9
             or ___conditional___ = 10
             or ___conditional___ = 11
             or ___conditional___ = 12
             or ___conditional___ = 13
             or ___conditional___ = 14
             or ___conditional___ = 15
             or ___conditional___ = 16
             or ___conditional___ = 17
             or ___conditional___ = 19
             or ___conditional___ = 20
             or ___conditional___ = 21
             or ___conditional___ = 23
             or ___conditional___ = 24 then do
                return Curry._1(k, --[[ "\t" ]]9);end end end 
             do
            
          end
        end
         end 
      end else if (c == 34) then do
        return Curry._1(k, --[[ "\"" ]]34);
      end
       end  end 
      if (_is_digit(c)) then do
        return read2int(c - --[[ "0" ]]48 | 0, (function (n) do
                      return Curry._1(k, Char.chr(n));
                    end end), t);
      end else do
        return Curry._1(_error(t, --[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "unexpected escaped char '",
                            --[[ Char ]]Block.__(0, [--[[ Char_literal ]]Block.__(12, [
                                    --[[ "'" ]]39,
                                    --[[ End_of_format ]]0
                                  ])])
                          ]),
                        "unexpected escaped char '%c'"
                      ]), c);
      end end 
    end end 
  end end;
  read2int = function (i, k, t) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return read2int(i, k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      if (_is_digit(c)) then do
        return read1int(Caml_int32.imul(10, i) + (c - --[[ "0" ]]48 | 0) | 0, k, t);
      end else do
        return Curry._1(_error(t, --[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "unexpected char '",
                            --[[ Char ]]Block.__(0, [--[[ String_literal ]]Block.__(11, [
                                    "' when reading byte",
                                    --[[ End_of_format ]]0
                                  ])])
                          ]),
                        "unexpected char '%c' when reading byte"
                      ]), c);
      end end 
    end end 
  end end;
  read1int = function (i, k, t) do
    if (t.i == t.len) then do
      return _refill(t, (function (param) do
                    return read1int(i, k, param);
                  end end), _error_eof);
    end else do
      c = _get(t);
      if (_is_digit(c)) then do
        return Curry._1(k, Caml_int32.imul(10, i) + (c - --[[ "0" ]]48 | 0) | 0);
      end else do
        return Curry._1(_error(t, --[[ Format ]][
                        --[[ String_literal ]]Block.__(11, [
                            "unexpected char '",
                            --[[ Char ]]Block.__(0, [--[[ String_literal ]]Block.__(11, [
                                    "' when reading byte",
                                    --[[ End_of_format ]]0
                                  ])])
                          ]),
                        "unexpected char '%c' when reading byte"
                      ]), c);
      end end 
    end end 
  end end;
  skip_comment = function (k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return skip_comment(k, param);
                    end end), _error_eof);
      end else do
        match = _get(t);
        if (match ~= 10) then do
          continue ;
        end else do
          return Curry._2(k, undefined, --[[ () ]]0);
        end end 
      end end 
    end;
  end end;
  expr_or_end = function (k, t) do
    while(true) do
      if (t.i == t.len) then do
        return _refill(t, (function (param) do
                      return expr_or_end(k, param);
                    end end), (function (param) do
                      return Curry._1(funarg.$$return, --[[ End ]]3455931);
                    end end));
      end else do
        c = _get(t);
        if (c >= 11) then do
          if (c ~= 32) then do
            return expr_starting_with(c, k, t);
          end else do
            continue ;
          end end 
        end else if (c >= 9) then do
          continue ;
        end else do
          return expr_starting_with(c, k, t);
        end end  end 
      end end 
    end;
  end end;
  next = function (t) do
    return expr_or_end((function (param, x) do
                  return Curry._1(funarg.$$return, --[[ `Ok ]][
                              17724,
                              x
                            ]);
                end end), t);
  end end;
  return do
          make: make,
          next: next
        end;
end end

D = do
  make: make,
  next: next
end;

exports.to_buf = to_buf;
exports.to_string = to_string;
exports.to_file = to_file;
exports.to_file_seq = to_file_seq;
exports.to_chan = to_chan;
exports.print = print;
exports.print_noindent = print_noindent;
exports.MakeDecode = MakeDecode;
exports.ID_MONAD = ID_MONAD;
exports.D = D;
exports.parse_string = parse_string;
exports.parse_chan = parse_chan;
exports.parse_chan_gen = parse_chan_gen;
exports.parse_chan_list = parse_chan_list;
exports.parse_file = parse_file;
exports.parse_file_list = parse_file_list;
--[[ Format Not a pure module ]]
