

import * as List from "./list.js";
import * as Block from "./block.js";
import * as Curry from "./curry.js";
import * as $$Buffer from "./buffer.js";
import * as Printf from "./printf.js";
import * as $$String from "./string.js";
import * as Caml_bytes from "./caml_bytes.js";
import * as Caml_int32 from "./caml_int32.js";
import * as Pervasives from "./pervasives.js";
import * as Caml_format from "./caml_format.js";
import * as Caml_string from "./caml_string.js";
import * as Caml_exceptions from "./caml_exceptions.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as CamlinternalFormat from "./camlinternalFormat.js";
import * as Caml_external_polyfill from "./caml_external_polyfill.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";
import * as CamlinternalFormatBasics from "./camlinternalFormatBasics.js";

function next_char(ib) do
  try do
    var c = Curry._1(ib.ic_get_next_char, --[ () ]--0);
    ib.ic_current_char = c;
    ib.ic_current_char_is_valid = true;
    ib.ic_char_count = ib.ic_char_count + 1 | 0;
    if (c == --[ "\n" ]--10) then do
      ib.ic_line_count = ib.ic_line_count + 1 | 0;
    end
     end 
    return c;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.end_of_file) then do
      ib.ic_current_char = --[ "\000" ]--0;
      ib.ic_current_char_is_valid = false;
      ib.ic_eof = true;
      return --[ "\000" ]--0;
    end else do
      throw exn;
    end end 
  end
end

function peek_char(ib) do
  if (ib.ic_current_char_is_valid) then do
    return ib.ic_current_char;
  end else do
    return next_char(ib);
  end end 
end

function checked_peek_char(ib) do
  var c = peek_char(ib);
  if (ib.ic_eof) then do
    throw Caml_builtin_exceptions.end_of_file;
  end
   end 
  return c;
end

function end_of_input(ib) do
  peek_char(ib);
  return ib.ic_eof;
end

function beginning_of_input(ib) do
  return ib.ic_char_count == 0;
end

function name_of_input(ib) do
  var match = ib.ic_input_name;
  if (typeof match == "number") then do
    if (match == --[ From_function ]--0) then do
      return "unnamed function";
    end else do
      return "unnamed character string";
    end end 
  end else if (match.tag) then do
    return match[0];
  end else do
    return "unnamed Pervasives input channel";
  end end  end 
end

function char_count(ib) do
  if (ib.ic_current_char_is_valid) then do
    return ib.ic_char_count - 1 | 0;
  end else do
    return ib.ic_char_count;
  end end 
end

function token(ib) do
  var token_buffer = ib.ic_token_buffer;
  var tok = $$Buffer.contents(token_buffer);
  token_buffer.position = 0;
  ib.ic_token_count = ib.ic_token_count + 1 | 0;
  return tok;
end

function ignore_char(width, ib) do
  var width$1 = width - 1 | 0;
  ib.ic_current_char_is_valid = false;
  return width$1;
end

function store_char(width, ib, c) do
  $$Buffer.add_char(ib.ic_token_buffer, c);
  return ignore_char(width, ib);
end

function create(iname, next) do
  return do
          ic_eof: false,
          ic_current_char: --[ "\000" ]--0,
          ic_current_char_is_valid: false,
          ic_char_count: 0,
          ic_line_count: 0,
          ic_token_count: 0,
          ic_get_next_char: next,
          ic_token_buffer: $$Buffer.create(1024),
          ic_input_name: iname
        end;
end

function from_string(s) do
  var i = do
    contents: 0
  end;
  var len = #s;
  var next = function (param) do
    if (i.contents >= len) then do
      throw Caml_builtin_exceptions.end_of_file;
    end
     end 
    var c = Caml_string.get(s, i.contents);
    i.contents = i.contents + 1 | 0;
    return c;
  end;
  return create(--[ From_string ]--1, next);
end

function from_function(param) do
  return create(--[ From_function ]--0, param);
end

var file_buffer_size = do
  contents: 1024
end;

function scan_close_at_end(ic) do
  Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  throw Caml_builtin_exceptions.end_of_file;
end

function scan_raise_at_end(_ic) do
  throw Caml_builtin_exceptions.end_of_file;
end

function from_ic(scan_close_ic, iname, ic) do
  var len = file_buffer_size.contents;
  var buf = Caml_bytes.caml_create_bytes(len);
  var i = do
    contents: 0
  end;
  var lim = do
    contents: 0
  end;
  var eof = do
    contents: false
  end;
  var next = function (param) do
    if (i.contents < lim.contents) then do
      var c = Caml_bytes.get(buf, i.contents);
      i.contents = i.contents + 1 | 0;
      return c;
    end else do
      if (eof.contents) then do
        throw Caml_builtin_exceptions.end_of_file;
      end
       end 
      lim.contents = Pervasives.input(ic, buf, 0, len);
      if (lim.contents == 0) then do
        eof.contents = true;
        return Curry._1(scan_close_ic, ic);
      end else do
        i.contents = 1;
        return Caml_bytes.get(buf, 0);
      end end 
    end end 
  end;
  return create(iname, next);
end

var stdin = from_ic(scan_raise_at_end, --[ From_file ]--Block.__(1, [
        "-",
        Pervasives.stdin
      ]), Pervasives.stdin);

function open_in_file(open_in, fname) do
  if (fname == "-") then do
    return stdin;
  end else do
    var ic = Curry._1(open_in, fname);
    return from_ic(scan_close_at_end, --[ From_file ]--Block.__(1, [
                  fname,
                  ic
                ]), ic);
  end end 
end

function open_in(param) do
  return open_in_file(Pervasives.open_in, param);
end

function open_in_bin(param) do
  return open_in_file(Pervasives.open_in_bin, param);
end

function from_channel(ic) do
  return from_ic(scan_raise_at_end, --[ From_channel ]--Block.__(0, [ic]), ic);
end

function close_in(ib) do
  var match = ib.ic_input_name;
  if (typeof match == "number") then do
    return --[ () ]--0;
  end else if (match.tag) then do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(match[1]);
  end else do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(match[0]);
  end end  end 
end

var memo = do
  contents: --[ [] ]--0
end;

function memo_from_ic(scan_close_ic, ic) do
  try do
    return List.assq(ic, memo.contents);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var ib = from_ic(scan_close_ic, --[ From_channel ]--Block.__(0, [ic]), ic);
      memo.contents = --[ :: ]--[
        --[ tuple ]--[
          ic,
          ib
        ],
        memo.contents
      ];
      return ib;
    end else do
      throw exn;
    end end 
  end
end

var Scan_failure = Caml_exceptions.create("Scanf.Scan_failure");

function bad_input_escape(c) do
  var s = Curry._1(Printf.sprintf(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "illegal escape character ",
                --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0])
              ]),
            "illegal escape character %C"
          ]), c);
  throw [
        Scan_failure,
        s
      ];
end

function bad_token_length(message) do
  var s = Curry._1(Printf.sprintf(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "scanning of ",
                --[ String ]--Block.__(2, [
                    --[ No_padding ]--0,
                    --[ String_literal ]--Block.__(11, [
                        " failed: the specified length was too short for token",
                        --[ End_of_format ]--0
                      ])
                  ])
              ]),
            "scanning of %s failed: the specified length was too short for token"
          ]), message);
  throw [
        Scan_failure,
        s
      ];
end

function bad_hex_float(param) do
  throw [
        Scan_failure,
        "not a valid float in hexadecimal notation"
      ];
end

function character_mismatch_err(c, ci) do
  return Curry._2(Printf.sprintf(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "looking for ",
                      --[ Caml_char ]--Block.__(1, [--[ String_literal ]--Block.__(11, [
                              ", found ",
                              --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0])
                            ])])
                    ]),
                  "looking for %C, found %C"
                ]), c, ci);
end

function check_this_char(ib, c) do
  var ci = checked_peek_char(ib);
  if (ci == c) then do
    ib.ic_current_char_is_valid = false;
    return --[ () ]--0;
  end else do
    var s = character_mismatch_err(c, ci);
    throw [
          Scan_failure,
          s
        ];
  end end 
end

function check_char(ib, c) do
  if (c ~= 10) then do
    if (c ~= 32) then do
      return check_this_char(ib, c);
    end else do
      var ib$1 = ib;
      while(true) do
        var c$1 = peek_char(ib$1);
        if (ib$1.ic_eof) then do
          return 0;
        end else do
          var switcher = c$1 - 9 | 0;
          if (switcher > 4 or switcher < 0) then do
            if (switcher ~= 23) then do
              return --[ () ]--0;
            end else do
              ib$1.ic_current_char_is_valid = false;
              continue ;
            end end 
          end else if (switcher == 3 or switcher == 2) then do
            return --[ () ]--0;
          end else do
            ib$1.ic_current_char_is_valid = false;
            continue ;
          end end  end 
        end end 
      end;
    end end 
  end else do
    var ib$2 = ib;
    var ci = checked_peek_char(ib$2);
    if (ci ~= 10) then do
      if (ci ~= 13) then do
        var s = character_mismatch_err(--[ "\n" ]--10, ci);
        throw [
              Scan_failure,
              s
            ];
      end else do
        ib$2.ic_current_char_is_valid = false;
        return check_this_char(ib$2, --[ "\n" ]--10);
      end end 
    end else do
      ib$2.ic_current_char_is_valid = false;
      return --[ () ]--0;
    end end 
  end end 
end

function token_bool(ib) do
  var s = token(ib);
  switch (s) do
    case "false" :
        return false;
    case "true" :
        return true;
    default:
      var s$1 = Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "invalid boolean '",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ Char_literal ]--Block.__(12, [
                            --[ "'" ]--39,
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "invalid boolean '%s'"
              ]), s);
      throw [
            Scan_failure,
            s$1
          ];
  end
end

function integer_conversion_of_char(param) do
  switch (param) do
    case 98 :
        return --[ B_conversion ]--0;
    case 100 :
        return --[ D_conversion ]--1;
    case 105 :
        return --[ I_conversion ]--2;
    case 111 :
        return --[ O_conversion ]--3;
    case 117 :
        return --[ U_conversion ]--4;
    case 89 :
    case 90 :
    case 91 :
    case 92 :
    case 93 :
    case 94 :
    case 95 :
    case 96 :
    case 97 :
    case 99 :
    case 101 :
    case 102 :
    case 103 :
    case 104 :
    case 106 :
    case 107 :
    case 108 :
    case 109 :
    case 110 :
    case 112 :
    case 113 :
    case 114 :
    case 115 :
    case 116 :
    case 118 :
    case 119 :
        break;
    case 88 :
    case 120 :
        return --[ X_conversion ]--5;
    default:
      
  end
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "scanf.ml",
          555,
          9
        ]
      ];
end

function token_int_literal(conv, ib) do
  var tok;
  switch (conv) do
    case --[ B_conversion ]--0 :
        tok = "0b" .. token(ib);
        break;
    case --[ D_conversion ]--1 :
    case --[ I_conversion ]--2 :
        tok = token(ib);
        break;
    case --[ O_conversion ]--3 :
        tok = "0o" .. token(ib);
        break;
    case --[ U_conversion ]--4 :
        tok = "0u" .. token(ib);
        break;
    case --[ X_conversion ]--5 :
        tok = "0x" .. token(ib);
        break;
    
  end
  var l = #tok;
  if (l == 0 or Caml_string.get(tok, 0) ~= --[ "+" ]--43) then do
    return tok;
  end else do
    return $$String.sub(tok, 1, l - 1 | 0);
  end end 
end

function token_float(ib) do
  return Caml_format.caml_float_of_string(token(ib));
end

function scan_decimal_digit_star(_width, ib) do
  while(true) do
    var width = _width;
    if (width == 0) then do
      return width;
    end else do
      var c = peek_char(ib);
      if (ib.ic_eof) then do
        return width;
      end else if (c >= 58) then do
        if (c ~= 95) then do
          return width;
        end else do
          var width$1 = ignore_char(width, ib);
          _width = width$1;
          continue ;
        end end 
      end else if (c >= 48) then do
        var width$2 = store_char(width, ib, c);
        _width = width$2;
        continue ;
      end else do
        return width;
      end end  end  end 
    end end 
  end;
end

function scan_decimal_digit_plus(width, ib) do
  if (width == 0) then do
    return bad_token_length("decimal digits");
  end else do
    var c = checked_peek_char(ib);
    if (c > 57 or c < 48) then do
      var s = Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "character ",
                    --[ Caml_char ]--Block.__(1, [--[ String_literal ]--Block.__(11, [
                            " is not a decimal digit",
                            --[ End_of_format ]--0
                          ])])
                  ]),
                "character %C is not a decimal digit"
              ]), c);
      throw [
            Scan_failure,
            s
          ];
    end else do
      var width$1 = store_char(width, ib, c);
      return scan_decimal_digit_star(width$1, ib);
    end end 
  end end 
end

function scan_digit_plus(basis, digitp, width, ib) do
  if (width == 0) then do
    return bad_token_length("digits");
  end else do
    var c = checked_peek_char(ib);
    if (Curry._1(digitp, c)) then do
      var width$1 = store_char(width, ib, c);
      var digitp$1 = digitp;
      var width$2 = width$1;
      var ib$1 = ib;
      var _width = width$2;
      var ib$2 = ib$1;
      while(true) do
        var width$3 = _width;
        if (width$3 == 0) then do
          return width$3;
        end else do
          var c$1 = peek_char(ib$2);
          if (ib$2.ic_eof) then do
            return width$3;
          end else if (Curry._1(digitp$1, c$1)) then do
            var width$4 = store_char(width$3, ib$2, c$1);
            _width = width$4;
            continue ;
          end else if (c$1 ~= 95) then do
            return width$3;
          end else do
            var width$5 = ignore_char(width$3, ib$2);
            _width = width$5;
            continue ;
          end end  end  end 
        end end 
      end;
    end else do
      var s = Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "character ",
                    --[ Caml_char ]--Block.__(1, [--[ String_literal ]--Block.__(11, [
                            " is not a valid ",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    " digit",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])])
                  ]),
                "character %C is not a valid %s digit"
              ]), c, basis);
      throw [
            Scan_failure,
            s
          ];
    end end 
  end end 
end

function is_binary_digit(param) do
  return param == 49 or param == 48;
end

function scan_binary_int(param, param$1) do
  return scan_digit_plus("binary", is_binary_digit, param, param$1);
end

function is_octal_digit(param) do
  return !(param > 55 or param < 48);
end

function scan_octal_int(param, param$1) do
  return scan_digit_plus("octal", is_octal_digit, param, param$1);
end

function is_hexa_digit(param) do
  var switcher = param - 48 | 0;
  if (switcher > 22 or switcher < 0) then do
    return !(switcher > 54 or switcher < 49);
  end else do
    return switcher > 16 or switcher < 10;
  end end 
end

function scan_hexadecimal_int(param, param$1) do
  return scan_digit_plus("hexadecimal", is_hexa_digit, param, param$1);
end

function scan_sign(width, ib) do
  var c = checked_peek_char(ib);
  if (c ~= 43 and c ~= 45) then do
    return width;
  end else do
    return store_char(width, ib, c);
  end end 
end

function scan_optionally_signed_decimal_int(width, ib) do
  var width$1 = scan_sign(width, ib);
  return scan_decimal_digit_plus(width$1, ib);
end

function scan_int_conversion(conv, width, ib) do
  switch (conv) do
    case --[ B_conversion ]--0 :
        return scan_binary_int(width, ib);
    case --[ D_conversion ]--1 :
        return scan_optionally_signed_decimal_int(width, ib);
    case --[ I_conversion ]--2 :
        var width$1 = width;
        var ib$1 = ib;
        var width$2 = scan_sign(width$1, ib$1);
        var width$3 = width$2;
        var ib$2 = ib$1;
        var c = checked_peek_char(ib$2);
        if (c ~= 48) then do
          return scan_decimal_digit_plus(width$3, ib$2);
        end else do
          var width$4 = store_char(width$3, ib$2, c);
          if (width$4 == 0) then do
            return width$4;
          end else do
            var c$1 = peek_char(ib$2);
            if (ib$2.ic_eof) then do
              return width$4;
            end else if (c$1 >= 99) then do
              if (c$1 ~= 111) then do
                if (c$1 ~= 120) then do
                  return scan_decimal_digit_star(width$4, ib$2);
                end else do
                  return scan_hexadecimal_int(store_char(width$4, ib$2, c$1), ib$2);
                end end 
              end else do
                return scan_octal_int(store_char(width$4, ib$2, c$1), ib$2);
              end end 
            end else if (c$1 ~= 88) then do
              if (c$1 >= 98) then do
                return scan_binary_int(store_char(width$4, ib$2, c$1), ib$2);
              end else do
                return scan_decimal_digit_star(width$4, ib$2);
              end end 
            end else do
              return scan_hexadecimal_int(store_char(width$4, ib$2, c$1), ib$2);
            end end  end  end 
          end end 
        end end 
    case --[ O_conversion ]--3 :
        return scan_octal_int(width, ib);
    case --[ U_conversion ]--4 :
        return scan_decimal_digit_plus(width, ib);
    case --[ X_conversion ]--5 :
        return scan_hexadecimal_int(width, ib);
    
  end
end

function scan_fractional_part(width, ib) do
  if (width == 0) then do
    return width;
  end else do
    var c = peek_char(ib);
    if (ib.ic_eof or c > 57 or c < 48) then do
      return width;
    end else do
      return scan_decimal_digit_star(store_char(width, ib, c), ib);
    end end 
  end end 
end

function scan_exponent_part(width, ib) do
  if (width == 0) then do
    return width;
  end else do
    var c = peek_char(ib);
    if (ib.ic_eof or c ~= 69 and c ~= 101) then do
      return width;
    end else do
      return scan_optionally_signed_decimal_int(store_char(width, ib, c), ib);
    end end 
  end end 
end

function scan_integer_part(width, ib) do
  var width$1 = scan_sign(width, ib);
  return scan_decimal_digit_star(width$1, ib);
end

function scan_float(width, precision, ib) do
  var width$1 = scan_integer_part(width, ib);
  if (width$1 == 0) then do
    return --[ tuple ]--[
            width$1,
            precision
          ];
  end else do
    var c = peek_char(ib);
    if (ib.ic_eof) then do
      return --[ tuple ]--[
              width$1,
              precision
            ];
    end else if (c ~= 46) then do
      return --[ tuple ]--[
              scan_exponent_part(width$1, ib),
              precision
            ];
    end else do
      var width$2 = store_char(width$1, ib, c);
      var precision$1 = width$2 < precision ? width$2 : precision;
      var width$3 = width$2 - (precision$1 - scan_fractional_part(precision$1, ib) | 0) | 0;
      return --[ tuple ]--[
              scan_exponent_part(width$3, ib),
              precision$1
            ];
    end end  end 
  end end 
end

function check_case_insensitive_string(width, ib, error, str) do
  var lowercase = function (c) do
    if (c > 90 or c < 65) then do
      return c;
    end else do
      return Pervasives.char_of_int((c - --[ "A" ]--65 | 0) + --[ "a" ]--97 | 0);
    end end 
  end;
  var len = #str;
  var width$1 = width;
  for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
    var c = peek_char(ib);
    if (lowercase(c) ~= lowercase(Caml_string.get(str, i))) then do
      Curry._1(error, --[ () ]--0);
    end
     end 
    if (width$1 == 0) then do
      Curry._1(error, --[ () ]--0);
    end
     end 
    width$1 = store_char(width$1, ib, c);
  end
  return width$1;
end

function scan_hex_float(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "not a valid float in hexadecimal notation"
        ];
  end
   end 
  var width$1 = scan_sign(width, ib);
  if (width$1 == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "not a valid float in hexadecimal notation"
        ];
  end
   end 
  var c = peek_char(ib);
  if (c >= 78) then do
    var switcher = c - 79 | 0;
    if (switcher > 30 or switcher < 0) then do
      if (switcher >= 32) then do
        throw [
              Scan_failure,
              "not a valid float in hexadecimal notation"
            ];
      end else do
        var width$2 = store_char(width$1, ib, c);
        if (width$2 == 0 or end_of_input(ib)) then do
          throw [
                Scan_failure,
                "not a valid float in hexadecimal notation"
              ];
        end
         end 
        return check_case_insensitive_string(width$2, ib, bad_hex_float, "an");
      end end 
    end else if (switcher ~= 26) then do
      throw [
            Scan_failure,
            "not a valid float in hexadecimal notation"
          ];
    end
     end  end 
  end else if (c ~= 48) then do
    if (c ~= 73) then do
      throw [
            Scan_failure,
            "not a valid float in hexadecimal notation"
          ];
    end
     end 
  end else do
    var width$3 = store_char(width$1, ib, c);
    if (width$3 == 0 or end_of_input(ib)) then do
      throw [
            Scan_failure,
            "not a valid float in hexadecimal notation"
          ];
    end
     end 
    var width$4 = check_case_insensitive_string(width$3, ib, bad_hex_float, "x");
    if (width$4 == 0 or end_of_input(ib)) then do
      return width$4;
    end else do
      var match = peek_char(ib);
      var switcher$1 = match - 46 | 0;
      var width$5 = switcher$1 > 34 or switcher$1 < 0 ? (
          switcher$1 ~= 66 ? scan_hexadecimal_int(width$4, ib) : width$4
        ) : (
          switcher$1 > 33 or switcher$1 < 1 ? width$4 : scan_hexadecimal_int(width$4, ib)
        );
      if (width$5 == 0 or end_of_input(ib)) then do
        return width$5;
      end else do
        var c$1 = peek_char(ib);
        var width$6;
        if (c$1 ~= 46) then do
          width$6 = width$5;
        end else do
          var width$7 = store_char(width$5, ib, c$1);
          if (width$7 == 0 or end_of_input(ib)) then do
            width$6 = width$7;
          end else do
            var match$1 = peek_char(ib);
            if (match$1 ~= 80 and match$1 ~= 112) then do
              var precision$1 = width$7 < precision ? width$7 : precision;
              width$6 = width$7 - (precision$1 - scan_hexadecimal_int(precision$1, ib) | 0) | 0;
            end else do
              width$6 = width$7;
            end end 
          end end 
        end end 
        if (width$6 == 0 or end_of_input(ib)) then do
          return width$6;
        end else do
          var c$2 = peek_char(ib);
          var exit = 0;
          if (c$2 ~= 80 and c$2 ~= 112) then do
            return width$6;
          end else do
            exit = 2;
          end end 
          if (exit == 2) then do
            var width$8 = store_char(width$6, ib, c$2);
            if (width$8 == 0 or end_of_input(ib)) then do
              throw [
                    Scan_failure,
                    "not a valid float in hexadecimal notation"
                  ];
            end
             end 
            return scan_optionally_signed_decimal_int(width$8, ib);
          end
           end 
        end end 
      end end 
    end end 
  end end  end 
  var width$9 = store_char(width$1, ib, c);
  if (width$9 == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "not a valid float in hexadecimal notation"
        ];
  end
   end 
  return check_case_insensitive_string(width$9, ib, bad_hex_float, "nfinity");
end

function scan_caml_float_rest(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end
   end 
  var width$1 = scan_decimal_digit_star(width, ib);
  if (width$1 == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end
   end 
  var c = peek_char(ib);
  var switcher = c - 69 | 0;
  if (switcher > 32 or switcher < 0) then do
    if (switcher ~= -23) then do
      throw [
            Scan_failure,
            "no dot or exponent part found in float token"
          ];
    end else do
      var width$2 = store_char(width$1, ib, c);
      var precision$1 = width$2 < precision ? width$2 : precision;
      var width_precision = scan_fractional_part(precision$1, ib);
      var frac_width = precision$1 - width_precision | 0;
      var width$3 = width$2 - frac_width | 0;
      return scan_exponent_part(width$3, ib);
    end end 
  end else if (switcher > 31 or switcher < 1) then do
    return scan_exponent_part(width$1, ib);
  end else do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end end  end 
end

function scan_caml_float(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end
   end 
  var width$1 = scan_sign(width, ib);
  if (width$1 == 0 or end_of_input(ib)) then do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end
   end 
  var c = peek_char(ib);
  if (c >= 49) then do
    if (c >= 58) then do
      throw [
            Scan_failure,
            "no dot or exponent part found in float token"
          ];
    end else do
      var width$2 = store_char(width$1, ib, c);
      if (width$2 == 0 or end_of_input(ib)) then do
        throw [
              Scan_failure,
              "no dot or exponent part found in float token"
            ];
      end
       end 
      return scan_caml_float_rest(width$2, precision, ib);
    end end 
  end else if (c >= 48) then do
    var width$3 = store_char(width$1, ib, c);
    if (width$3 == 0 or end_of_input(ib)) then do
      throw [
            Scan_failure,
            "no dot or exponent part found in float token"
          ];
    end
     end 
    var c$1 = peek_char(ib);
    var exit = 0;
    if (c$1 ~= 88 and c$1 ~= 120) then do
      return scan_caml_float_rest(width$3, precision, ib);
    end else do
      exit = 1;
    end end 
    if (exit == 1) then do
      var width$4 = store_char(width$3, ib, c$1);
      if (width$4 == 0 or end_of_input(ib)) then do
        throw [
              Scan_failure,
              "no dot or exponent part found in float token"
            ];
      end
       end 
      var width$5 = scan_hexadecimal_int(width$4, ib);
      if (width$5 == 0 or end_of_input(ib)) then do
        throw [
              Scan_failure,
              "no dot or exponent part found in float token"
            ];
      end
       end 
      var c$2 = peek_char(ib);
      var switcher = c$2 - 80 | 0;
      var width$6;
      if (switcher > 32 or switcher < 0) then do
        if (switcher ~= -34) then do
          throw [
                Scan_failure,
                "no dot or exponent part found in float token"
              ];
        end else do
          var width$7 = store_char(width$5, ib, c$2);
          if (width$7 == 0 or end_of_input(ib)) then do
            width$6 = width$7;
          end else do
            var match = peek_char(ib);
            if (match ~= 80 and match ~= 112) then do
              var precision$1 = width$7 < precision ? width$7 : precision;
              width$6 = width$7 - (precision$1 - scan_hexadecimal_int(precision$1, ib) | 0) | 0;
            end else do
              width$6 = width$7;
            end end 
          end end 
        end end 
      end else if (switcher > 31 or switcher < 1) then do
        width$6 = width$5;
      end else do
        throw [
              Scan_failure,
              "no dot or exponent part found in float token"
            ];
      end end  end 
      if (width$6 == 0 or end_of_input(ib)) then do
        return width$6;
      end else do
        var c$3 = peek_char(ib);
        if (c$3 ~= 80 and c$3 ~= 112) then do
          return width$6;
        end
         end 
        var width$8 = store_char(width$6, ib, c$3);
        if (width$8 == 0 or end_of_input(ib)) then do
          throw [
                Scan_failure,
                "not a valid float in hexadecimal notation"
              ];
        end
         end 
        return scan_optionally_signed_decimal_int(width$8, ib);
      end end 
    end
     end 
  end else do
    throw [
          Scan_failure,
          "no dot or exponent part found in float token"
        ];
  end end  end 
end

function scan_string(stp, width, ib) do
  var _width = width;
  while(true) do
    var width$1 = _width;
    if (width$1 == 0) then do
      return width$1;
    end else do
      var c = peek_char(ib);
      if (ib.ic_eof) then do
        return width$1;
      end else if (stp ~= undefined) then do
        if (c == stp) then do
          ib.ic_current_char_is_valid = false;
          return width$1;
        end else do
          _width = store_char(width$1, ib, c);
          continue ;
        end end 
      end else do
        var switcher = c - 9 | 0;
        if (switcher > 4 or switcher < 0) then do
          if (switcher ~= 23) then do
            _width = store_char(width$1, ib, c);
            continue ;
          end else do
            return width$1;
          end end 
        end else if (switcher == 3 or switcher == 2) then do
          _width = store_char(width$1, ib, c);
          continue ;
        end else do
          return width$1;
        end end  end 
      end end  end 
    end end 
  end;
end

function scan_char(width, ib) do
  return store_char(width, ib, checked_peek_char(ib));
end

function char_for_backslash(c) do
  if (c >= 110) then do
    if (c >= 117) then do
      return c;
    end else do
      switch (c - 110 | 0) do
        case 0 :
            return --[ "\n" ]--10;
        case 4 :
            return --[ "\r" ]--13;
        case 1 :
        case 2 :
        case 3 :
        case 5 :
            return c;
        case 6 :
            return --[ "\t" ]--9;
        
      end
    end end 
  end else if (c ~= 98) then do
    return c;
  end else do
    return --[ "\b" ]--8;
  end end  end 
end

function char_for_decimal_code(c0, c1, c2) do
  var c = (Caml_int32.imul(100, c0 - --[ "0" ]--48 | 0) + Caml_int32.imul(10, c1 - --[ "0" ]--48 | 0) | 0) + (c2 - --[ "0" ]--48 | 0) | 0;
  if (c < 0 or c > 255) then do
    var s = Curry._3(Printf.sprintf(--[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "bad character decimal encoding \\",
                  --[ Char ]--Block.__(0, [--[ Char ]--Block.__(0, [--[ Char ]--Block.__(0, [--[ End_of_format ]--0])])])
                ]),
              "bad character decimal encoding \\%c%c%c"
            ]), c0, c1, c2);
    throw [
          Scan_failure,
          s
        ];
  end else do
    return Pervasives.char_of_int(c);
  end end 
end

function hexadecimal_value_of_char(c) do
  if (c >= --[ "a" ]--97) then do
    return c - 87 | 0;
  end else if (c >= --[ "A" ]--65) then do
    return c - 55 | 0;
  end else do
    return c - --[ "0" ]--48 | 0;
  end end  end 
end

function char_for_hexadecimal_code(c1, c2) do
  var c = (hexadecimal_value_of_char(c1) << 4) + hexadecimal_value_of_char(c2) | 0;
  if (c < 0 or c > 255) then do
    var s = Curry._2(Printf.sprintf(--[ Format ]--[
              --[ String_literal ]--Block.__(11, [
                  "bad character hexadecimal encoding \\",
                  --[ Char ]--Block.__(0, [--[ Char ]--Block.__(0, [--[ End_of_format ]--0])])
                ]),
              "bad character hexadecimal encoding \\%c%c"
            ]), c1, c2);
    throw [
          Scan_failure,
          s
        ];
  end else do
    return Pervasives.char_of_int(c);
  end end 
end

function check_next_char(message, width, ib) do
  if (width == 0) then do
    return bad_token_length(message);
  end else do
    var c = peek_char(ib);
    if (ib.ic_eof) then do
      var message$1 = message;
      var s = Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "scanning of ",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            " failed: premature end of file occurred before end of token",
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "scanning of %s failed: premature end of file occurred before end of token"
              ]), message$1);
      throw [
            Scan_failure,
            s
          ];
    end else do
      return c;
    end end 
  end end 
end

function scan_backslash_char(width, ib) do
  var c = check_next_char("a Char", width, ib);
  if (c >= 40) then do
    if (c >= 58) then do
      switch (c) do
        case 92 :
        case 98 :
        case 110 :
        case 114 :
        case 116 :
            break;
        case 93 :
        case 94 :
        case 95 :
        case 96 :
        case 97 :
        case 99 :
        case 100 :
        case 101 :
        case 102 :
        case 103 :
        case 104 :
        case 105 :
        case 106 :
        case 107 :
        case 108 :
        case 109 :
        case 111 :
        case 112 :
        case 113 :
        case 115 :
        case 117 :
        case 118 :
        case 119 :
            return bad_input_escape(c);
        case 120 :
            var get_digit = function (param) do
              var c = next_char(ib);
              var switcher = c - 48 | 0;
              if (switcher > 22 or switcher < 0) then do
                if (switcher > 54 or switcher < 49) then do
                  return bad_input_escape(c);
                end else do
                  return c;
                end end 
              end else if (switcher > 16 or switcher < 10) then do
                return c;
              end else do
                return bad_input_escape(c);
              end end  end 
            end;
            var c1 = get_digit(--[ () ]--0);
            var c2 = get_digit(--[ () ]--0);
            return store_char(width - 2 | 0, ib, char_for_hexadecimal_code(c1, c2));
        default:
          return bad_input_escape(c);
      end
    end else if (c >= 48) then do
      var get_digit$1 = function (param) do
        var c = next_char(ib);
        if (c > 57 or c < 48) then do
          return bad_input_escape(c);
        end else do
          return c;
        end end 
      end;
      var c1$1 = get_digit$1(--[ () ]--0);
      var c2$1 = get_digit$1(--[ () ]--0);
      return store_char(width - 2 | 0, ib, char_for_decimal_code(c, c1$1, c2$1));
    end else do
      return bad_input_escape(c);
    end end  end 
  end else if (c ~= 34 and c < 39) then do
    return bad_input_escape(c);
  end
   end  end 
  return store_char(width, ib, char_for_backslash(c));
end

function scan_caml_char(width, ib) do
  var find_stop = function (width) do
    var c = check_next_char("a Char", width, ib);
    if (c ~= 39) then do
      var s = character_mismatch_err(--[ "'" ]--39, c);
      throw [
            Scan_failure,
            s
          ];
    end else do
      return ignore_char(width, ib);
    end end 
  end;
  var width$1 = width;
  var c = checked_peek_char(ib);
  if (c ~= 39) then do
    var s = character_mismatch_err(--[ "'" ]--39, c);
    throw [
          Scan_failure,
          s
        ];
  end else do
    var width$2 = ignore_char(width$1, ib);
    var c$1 = check_next_char("a Char", width$2, ib);
    if (c$1 ~= 92) then do
      return find_stop(store_char(width$2, ib, c$1));
    end else do
      return find_stop(scan_backslash_char(ignore_char(width$2, ib), ib));
    end end 
  end end 
end

function scan_caml_string(width, ib) do
  var find_stop = function (_width) do
    while(true) do
      var width = _width;
      var c = check_next_char("a String", width, ib);
      if (c ~= 34) then do
        if (c ~= 92) then do
          _width = store_char(width, ib, c);
          continue ;
        end else do
          var width$1 = ignore_char(width, ib);
          var match = check_next_char("a String", width$1, ib);
          if (match ~= 10) then do
            if (match ~= 13) then do
              return find_stop(scan_backslash_char(width$1, ib));
            end else do
              var width$2 = ignore_char(width$1, ib);
              var match$1 = check_next_char("a String", width$2, ib);
              if (match$1 ~= 10) then do
                return find_stop(store_char(width$2, ib, --[ "\r" ]--13));
              end else do
                return skip_spaces(ignore_char(width$2, ib));
              end end 
            end end 
          end else do
            return skip_spaces(ignore_char(width$1, ib));
          end end 
        end end 
      end else do
        return ignore_char(width, ib);
      end end 
    end;
  end;
  var skip_spaces = function (_width) do
    while(true) do
      var width = _width;
      var match = check_next_char("a String", width, ib);
      if (match ~= 32) then do
        return find_stop(width);
      end else do
        _width = ignore_char(width, ib);
        continue ;
      end end 
    end;
  end;
  var width$1 = width;
  var c = checked_peek_char(ib);
  if (c ~= 34) then do
    var s = character_mismatch_err(--[ "\"" ]--34, c);
    throw [
          Scan_failure,
          s
        ];
  end else do
    return find_stop(ignore_char(width$1, ib));
  end end 
end

function scan_chars_in_char_set(char_set, scan_indic, width, ib) do
  var scan_chars = function (_i, stp) do
    while(true) do
      var i = _i;
      var c = peek_char(ib);
      if (i > 0 and !ib.ic_eof and CamlinternalFormat.is_in_char_set(char_set, c) and c ~= stp) then do
        store_char(Pervasives.max_int, ib, c);
        _i = i - 1 | 0;
        continue ;
      end else do
        return 0;
      end end 
    end;
  end;
  if (scan_indic ~= undefined) then do
    var c = scan_indic;
    scan_chars(width, c);
    if (ib.ic_eof) then do
      return 0;
    end else do
      var ci = peek_char(ib);
      if (c == ci) then do
        ib.ic_current_char_is_valid = false;
        return --[ () ]--0;
      end else do
        var s = character_mismatch_err(c, ci);
        throw [
              Scan_failure,
              s
            ];
      end end 
    end end 
  end else do
    return scan_chars(width, -1);
  end end 
end

function scanf_bad_input(ib, x) do
  var s;
  if (x[0] == Scan_failure or x[0] == Caml_builtin_exceptions.failure) then do
    s = x[1];
  end else do
    throw x;
  end end 
  var i = char_count(ib);
  var s$1 = Curry._2(Printf.sprintf(--[ Format ]--[
            --[ String_literal ]--Block.__(11, [
                "scanf: bad input at char number ",
                --[ Int ]--Block.__(4, [
                    --[ Int_i ]--3,
                    --[ No_padding ]--0,
                    --[ No_precision ]--0,
                    --[ String_literal ]--Block.__(11, [
                        ": ",
                        --[ String ]--Block.__(2, [
                            --[ No_padding ]--0,
                            --[ End_of_format ]--0
                          ])
                      ])
                  ])
              ]),
            "scanf: bad input at char number %i: %s"
          ]), i, s);
  throw [
        Scan_failure,
        s$1
      ];
end

function get_counter(ib, counter) do
  switch (counter) do
    case --[ Line_counter ]--0 :
        return ib.ic_line_count;
    case --[ Char_counter ]--1 :
        return char_count(ib);
    case --[ Token_counter ]--2 :
        return ib.ic_token_count;
    
  end
end

function width_of_pad_opt(pad_opt) do
  if (pad_opt ~= undefined) then do
    return pad_opt;
  end else do
    return Pervasives.max_int;
  end end 
end

function stopper_of_formatting_lit(fmting) do
  if (fmting == --[ Escaped_percent ]--6) then do
    return --[ tuple ]--[
            --[ "%" ]--37,
            ""
          ];
  end else do
    var str = CamlinternalFormat.string_of_formatting_lit(fmting);
    var stp = Caml_string.get(str, 1);
    var sub_str = $$String.sub(str, 2, #str - 2 | 0);
    return --[ tuple ]--[
            stp,
            sub_str
          ];
  end end 
end

function take_format_readers(k, _fmt) do
  while(true) do
    var fmt = _fmt;
    if (typeof fmt == "number") then do
      return Curry._1(k, --[ Nil ]--0);
    end else do
      switch (fmt.tag | 0) do
        case --[ Int ]--4 :
        case --[ Int32 ]--5 :
        case --[ Nativeint ]--6 :
        case --[ Int64 ]--7 :
        case --[ Float ]--8 :
            _fmt = fmt[3];
            continue ;
        case --[ Format_subst ]--14 :
            return take_fmtty_format_readers(k, CamlinternalFormatBasics.erase_rel(CamlinternalFormat.symm(fmt[1])), fmt[2]);
        case --[ Formatting_gen ]--18 :
            _fmt = CamlinternalFormatBasics.concat_fmt(fmt[0][0][0], fmt[1]);
            continue ;
        case --[ Reader ]--19 :
            var fmt_rest = fmt[0];
            return (function(fmt_rest)do
            return function (reader) do
              var new_k = function (readers_rest) do
                return Curry._1(k, --[ Cons ]--[
                            reader,
                            readers_rest
                          ]);
              end;
              return take_format_readers(new_k, fmt_rest);
            end
            end(fmt_rest));
        case --[ Char ]--0 :
        case --[ Caml_char ]--1 :
        case --[ Flush ]--10 :
        case --[ Alpha ]--15 :
        case --[ Theta ]--16 :
        case --[ Scan_next_char ]--22 :
            _fmt = fmt[0];
            continue ;
        case --[ Ignored_param ]--23 :
            var k$1 = k;
            var ign = fmt[0];
            var fmt$1 = fmt[1];
            if (typeof ign == "number") then do
              if (ign == --[ Ignored_reader ]--2) then do
                return (function(k$1,fmt$1)do
                return function (reader) do
                  var new_k = function (readers_rest) do
                    return Curry._1(k$1, --[ Cons ]--[
                                reader,
                                readers_rest
                              ]);
                  end;
                  return take_format_readers(new_k, fmt$1);
                end
                end(k$1,fmt$1));
              end else do
                return take_format_readers(k$1, fmt$1);
              end end 
            end else if (ign.tag == --[ Ignored_format_subst ]--9) then do
              return take_fmtty_format_readers(k$1, ign[1], fmt$1);
            end else do
              return take_format_readers(k$1, fmt$1);
            end end  end 
        case --[ Format_arg ]--13 :
        case --[ Scan_char_set ]--20 :
        case --[ Custom ]--24 :
            _fmt = fmt[2];
            continue ;
        default:
          _fmt = fmt[1];
          continue ;
      end
    end end 
  end;
end

function take_fmtty_format_readers(k, _fmtty, fmt) do
  while(true) do
    var fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return take_format_readers(k, fmt);
    end else do
      switch (fmtty.tag | 0) do
        case --[ Format_arg_ty ]--8 :
            _fmtty = fmtty[1];
            continue ;
        case --[ Format_subst_ty ]--9 :
            var ty = CamlinternalFormat.trans(CamlinternalFormat.symm(fmtty[0]), fmtty[1]);
            _fmtty = CamlinternalFormatBasics.concat_fmtty(ty, fmtty[2]);
            continue ;
        case --[ Reader_ty ]--13 :
            var fmt_rest = fmtty[0];
            return (function(fmt_rest)do
            return function (reader) do
              var new_k = function (readers_rest) do
                return Curry._1(k, --[ Cons ]--[
                            reader,
                            readers_rest
                          ]);
              end;
              return take_fmtty_format_readers(new_k, fmt_rest, fmt);
            end
            end(fmt_rest));
        case --[ Ignored_reader_ty ]--14 :
            var fmt_rest$1 = fmtty[0];
            return (function(fmt_rest$1)do
            return function (reader) do
              var new_k = function (readers_rest) do
                return Curry._1(k, --[ Cons ]--[
                            reader,
                            readers_rest
                          ]);
              end;
              return take_fmtty_format_readers(new_k, fmt_rest$1, fmt);
            end
            end(fmt_rest$1));
        default:
          _fmtty = fmtty[0];
          continue ;
      end
    end end 
  end;
end

function make_scanf(ib, _fmt, readers) do
  while(true) do
    var fmt = _fmt;
    if (typeof fmt == "number") then do
      return --[ Nil ]--0;
    end else do
      switch (fmt.tag | 0) do
        case --[ Char ]--0 :
            scan_char(0, ib);
            var c = Caml_string.get(token(ib), 0);
            return --[ Cons ]--[
                    c,
                    make_scanf(ib, fmt[0], readers)
                  ];
        case --[ Caml_char ]--1 :
            scan_caml_char(0, ib);
            var c$1 = Caml_string.get(token(ib), 0);
            return --[ Cons ]--[
                    c$1,
                    make_scanf(ib, fmt[0], readers)
                  ];
        case --[ String ]--2 :
            var rest = fmt[1];
            var pad = fmt[0];
            if (typeof rest ~= "number") then do
              switch (rest.tag | 0) do
                case --[ Formatting_lit ]--17 :
                    var match = stopper_of_formatting_lit(rest[0]);
                    var stp = match[0];
                    var scan = (function(stp)do
                    return function scan(width, param, ib) do
                      return scan_string(stp, width, ib);
                    end
                    end(stp));
                    var str_rest_000 = match[1];
                    var str_rest_001 = rest[1];
                    var str_rest = --[ String_literal ]--Block.__(11, [
                        str_rest_000,
                        str_rest_001
                      ]);
                    return pad_prec_scanf(ib, str_rest, readers, pad, --[ No_precision ]--0, scan, token);
                case --[ Formatting_gen ]--18 :
                    var match$1 = rest[0];
                    if (match$1.tag) then do
                      var scan$1 = function (width, param, ib) do
                        return scan_string(--[ "[" ]--91, width, ib);
                      end;
                      return pad_prec_scanf(ib, CamlinternalFormatBasics.concat_fmt(match$1[0][0], rest[1]), readers, pad, --[ No_precision ]--0, scan$1, token);
                    end else do
                      var scan$2 = function (width, param, ib) do
                        return scan_string(--[ "{" ]--123, width, ib);
                      end;
                      return pad_prec_scanf(ib, CamlinternalFormatBasics.concat_fmt(match$1[0][0], rest[1]), readers, pad, --[ No_precision ]--0, scan$2, token);
                    end end 
                default:
                  
              end
            end
             end 
            var scan$3 = function (width, param, ib) do
              return scan_string(undefined, width, ib);
            end;
            return pad_prec_scanf(ib, rest, readers, pad, --[ No_precision ]--0, scan$3, token);
        case --[ Caml_string ]--3 :
            var scan$4 = function (width, param, ib) do
              return scan_caml_string(width, ib);
            end;
            return pad_prec_scanf(ib, fmt[1], readers, fmt[0], --[ No_precision ]--0, scan$4, token);
        case --[ Int ]--4 :
            var c$2 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            var scan$5 = (function(c$2)do
            return function scan$5(width, param, ib) do
              return scan_int_conversion(c$2, width, ib);
            end
            end(c$2));
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan$5, (function(c$2)do
                      return function (param) do
                        return Caml_format.caml_int_of_string(token_int_literal(c$2, param));
                      end
                      end(c$2)));
        case --[ Int32 ]--5 :
            var c$3 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            var scan$6 = (function(c$3)do
            return function scan$6(width, param, ib) do
              return scan_int_conversion(c$3, width, ib);
            end
            end(c$3));
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan$6, (function(c$3)do
                      return function (param) do
                        return Caml_format.caml_int32_of_string(token_int_literal(c$3, param));
                      end
                      end(c$3)));
        case --[ Nativeint ]--6 :
            var c$4 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            var scan$7 = (function(c$4)do
            return function scan$7(width, param, ib) do
              return scan_int_conversion(c$4, width, ib);
            end
            end(c$4));
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan$7, (function(c$4)do
                      return function (param) do
                        return Caml_format.caml_nativeint_of_string(token_int_literal(c$4, param));
                      end
                      end(c$4)));
        case --[ Int64 ]--7 :
            var c$5 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            var scan$8 = (function(c$5)do
            return function scan$8(width, param, ib) do
              return scan_int_conversion(c$5, width, ib);
            end
            end(c$5));
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan$8, (function(c$5)do
                      return function (param) do
                        return Caml_format.caml_int64_of_string(token_int_literal(c$5, param));
                      end
                      end(c$5)));
        case --[ Float ]--8 :
            var match$2 = fmt[0];
            if (match$2 ~= 15) then do
              if (match$2 >= 16) then do
                return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_hex_float, token_float);
              end else do
                return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_float, token_float);
              end end 
            end else do
              return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_caml_float, token_float);
            end end 
        case --[ Bool ]--9 :
            var scan$9 = function (param, param$1, ib) do
              var ib$1 = ib;
              var c = checked_peek_char(ib$1);
              var m;
              if (c ~= 102) then do
                if (c ~= 116) then do
                  var s = Curry._1(Printf.sprintf(--[ Format ]--[
                            --[ String_literal ]--Block.__(11, [
                                "the character ",
                                --[ Caml_char ]--Block.__(1, [--[ String_literal ]--Block.__(11, [
                                        " cannot start a boolean",
                                        --[ End_of_format ]--0
                                      ])])
                              ]),
                            "the character %C cannot start a boolean"
                          ]), c);
                  throw [
                        Scan_failure,
                        s
                      ];
                end else do
                  m = 4;
                end end 
              end else do
                m = 5;
              end end 
              return scan_string(undefined, m, ib$1);
            end;
            return pad_prec_scanf(ib, fmt[1], readers, fmt[0], --[ No_precision ]--0, scan$9, token_bool);
        case --[ Flush ]--10 :
            if (end_of_input(ib)) then do
              _fmt = fmt[0];
              continue ;
            end else do
              throw [
                    Scan_failure,
                    "end of input not found"
                  ];
            end end 
        case --[ String_literal ]--11 :
            $$String.iter((function (param) do
                    return check_char(ib, param);
                  end), fmt[0]);
            _fmt = fmt[1];
            continue ;
        case --[ Char_literal ]--12 :
            check_char(ib, fmt[0]);
            _fmt = fmt[1];
            continue ;
        case --[ Format_arg ]--13 :
            scan_caml_string(width_of_pad_opt(fmt[0]), ib);
            var s = token(ib);
            var fmt$1;
            try do
              fmt$1 = CamlinternalFormat.format_of_string_fmtty(s, fmt[1]);
            end
            catch (raw_exn)do
              var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
              if (exn[0] == Caml_builtin_exceptions.failure) then do
                throw [
                      Scan_failure,
                      exn[1]
                    ];
              end
               end 
              throw exn;
            end
            return --[ Cons ]--[
                    fmt$1,
                    make_scanf(ib, fmt[2], readers)
                  ];
        case --[ Format_subst ]--14 :
            var fmtty = fmt[1];
            scan_caml_string(width_of_pad_opt(fmt[0]), ib);
            var s$1 = token(ib);
            var match$3;
            try do
              var match$4 = CamlinternalFormat.fmt_ebb_of_string(undefined, s$1);
              var match$5 = CamlinternalFormat.fmt_ebb_of_string(undefined, s$1);
              match$3 = --[ tuple ]--[
                CamlinternalFormat.type_format(match$4[0], CamlinternalFormatBasics.erase_rel(fmtty)),
                CamlinternalFormat.type_format(match$5[0], CamlinternalFormatBasics.erase_rel(CamlinternalFormat.symm(fmtty)))
              ];
            end
            catch (raw_exn$1)do
              var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
              if (exn$1[0] == Caml_builtin_exceptions.failure) then do
                throw [
                      Scan_failure,
                      exn$1[1]
                    ];
              end
               end 
              throw exn$1;
            end
            return --[ Cons ]--[
                    --[ Format ]--[
                      match$3[0],
                      s$1
                    ],
                    make_scanf(ib, CamlinternalFormatBasics.concat_fmt(match$3[1], fmt[2]), readers)
                  ];
        case --[ Alpha ]--15 :
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  "scanf: bad conversion \"%a\""
                ];
        case --[ Theta ]--16 :
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  "scanf: bad conversion \"%t\""
                ];
        case --[ Formatting_lit ]--17 :
            $$String.iter((function (param) do
                    return check_char(ib, param);
                  end), CamlinternalFormat.string_of_formatting_lit(fmt[0]));
            _fmt = fmt[1];
            continue ;
        case --[ Formatting_gen ]--18 :
            var match$6 = fmt[0];
            check_char(ib, --[ "@" ]--64);
            if (match$6.tag) then do
              check_char(ib, --[ "[" ]--91);
              _fmt = CamlinternalFormatBasics.concat_fmt(match$6[0][0], fmt[1]);
              continue ;
            end else do
              check_char(ib, --[ "{" ]--123);
              _fmt = CamlinternalFormatBasics.concat_fmt(match$6[0][0], fmt[1]);
              continue ;
            end end 
        case --[ Reader ]--19 :
            if (readers) then do
              var x = Curry._1(readers[0], ib);
              return --[ Cons ]--[
                      x,
                      make_scanf(ib, fmt[0], readers[1])
                    ];
            end else do
              throw [
                    Caml_builtin_exceptions.invalid_argument,
                    "scanf: missing reader"
                  ];
            end end 
        case --[ Scan_char_set ]--20 :
            var rest$1 = fmt[2];
            var char_set = fmt[1];
            var width_opt = fmt[0];
            if (typeof rest$1 ~= "number" and rest$1.tag == --[ Formatting_lit ]--17) then do
              var match$7 = stopper_of_formatting_lit(rest$1[0]);
              var width = width_of_pad_opt(width_opt);
              scan_chars_in_char_set(char_set, match$7[0], width, ib);
              var s$2 = token(ib);
              var str_rest_000$1 = match$7[1];
              var str_rest_001$1 = rest$1[1];
              var str_rest$1 = --[ String_literal ]--Block.__(11, [
                  str_rest_000$1,
                  str_rest_001$1
                ]);
              return --[ Cons ]--[
                      s$2,
                      make_scanf(ib, str_rest$1, readers)
                    ];
            end
             end 
            var width$1 = width_of_pad_opt(width_opt);
            scan_chars_in_char_set(char_set, undefined, width$1, ib);
            var s$3 = token(ib);
            return --[ Cons ]--[
                    s$3,
                    make_scanf(ib, rest$1, readers)
                  ];
        case --[ Scan_get_counter ]--21 :
            var count = get_counter(ib, fmt[0]);
            return --[ Cons ]--[
                    count,
                    make_scanf(ib, fmt[1], readers)
                  ];
        case --[ Scan_next_char ]--22 :
            var c$6 = checked_peek_char(ib);
            return --[ Cons ]--[
                    c$6,
                    make_scanf(ib, fmt[0], readers)
                  ];
        case --[ Ignored_param ]--23 :
            var match$8 = CamlinternalFormat.param_format_of_ignored_format(fmt[0], fmt[1]);
            var match$9 = make_scanf(ib, match$8[0], readers);
            if (match$9) then do
              return match$9[1];
            end else do
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[ tuple ]--[
                      "scanf.ml",
                      1455,
                      13
                    ]
                  ];
            end end 
        case --[ Custom ]--24 :
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  "scanf: bad conversion \"%?\" (custom converter)"
                ];
        
      end
    end end 
  end;
end

function pad_prec_scanf(ib, fmt, readers, pad, prec, scan, token) do
  if (typeof pad == "number") then do
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "scanf: bad conversion \"%*\""
            ];
      end
       end 
      Curry._3(scan, Pervasives.max_int, Pervasives.max_int, ib);
      var x = Curry._1(token, ib);
      return --[ Cons ]--[
              x,
              make_scanf(ib, fmt, readers)
            ];
    end else do
      Curry._3(scan, Pervasives.max_int, prec[0], ib);
      var x$1 = Curry._1(token, ib);
      return --[ Cons ]--[
              x$1,
              make_scanf(ib, fmt, readers)
            ];
    end end 
  end else if (pad.tag) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "scanf: bad conversion \"%*\""
        ];
  end else if (pad[0] ~= 0) then do
    var w = pad[1];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "scanf: bad conversion \"%*\""
            ];
      end
       end 
      Curry._3(scan, w, Pervasives.max_int, ib);
      var x$2 = Curry._1(token, ib);
      return --[ Cons ]--[
              x$2,
              make_scanf(ib, fmt, readers)
            ];
    end else do
      Curry._3(scan, w, prec[0], ib);
      var x$3 = Curry._1(token, ib);
      return --[ Cons ]--[
              x$3,
              make_scanf(ib, fmt, readers)
            ];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "scanf: bad conversion \"%-\""
        ];
  end end  end  end 
end

function kscanf(ib, ef, param) do
  var str = param[1];
  var fmt = param[0];
  var k = function (readers, f) do
    $$Buffer.reset(ib.ic_token_buffer);
    var match;
    try do
      match = --[ Args ]--Block.__(0, [make_scanf(ib, fmt, readers)]);
    end
    catch (raw_exc)do
      var exc = Caml_js_exceptions.internalToOCamlException(raw_exc);
      if (exc[0] == Scan_failure or exc[0] == Caml_builtin_exceptions.failure or exc == Caml_builtin_exceptions.end_of_file) then do
        match = --[ Exc ]--Block.__(1, [exc]);
      end else if (exc[0] == Caml_builtin_exceptions.invalid_argument) then do
        var s = exc[1] .. (" in format \"" .. ($$String.escaped(str) .. "\""));
        throw [
              Caml_builtin_exceptions.invalid_argument,
              s
            ];
      end else do
        throw exc;
      end end  end 
    end
    if (match.tag) then do
      return Curry._2(ef, ib, match[0]);
    end else do
      var _f = f;
      var _args = match[0];
      while(true) do
        var args = _args;
        var f$1 = _f;
        if (args) then do
          _args = args[1];
          _f = Curry._1(f$1, args[0]);
          continue ;
        end else do
          return f$1;
        end end 
      end;
    end end 
  end;
  return take_format_readers(k, fmt);
end

function bscanf(ib, fmt) do
  return kscanf(ib, scanf_bad_input, fmt);
end

function ksscanf(s, ef, fmt) do
  return kscanf(from_string(s), ef, fmt);
end

function sscanf(s, fmt) do
  return kscanf(from_string(s), scanf_bad_input, fmt);
end

function scanf(fmt) do
  return kscanf(stdin, scanf_bad_input, fmt);
end

function bscanf_format(ib, format, f) do
  scan_caml_string(Pervasives.max_int, ib);
  var str = token(ib);
  var tmp;
  try do
    tmp = CamlinternalFormat.format_of_string_format(str, format);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      throw [
            Scan_failure,
            exn[1]
          ];
    end
     end 
    throw exn;
  end
  return Curry._1(f, tmp);
end

function sscanf_format(s, format, f) do
  return bscanf_format(from_string(s), format, f);
end

function string_to_String(s) do
  var l = #s;
  var b = $$Buffer.create(l + 2 | 0);
  $$Buffer.add_char(b, --[ "\"" ]--34);
  for(var i = 0 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
    var c = Caml_string.get(s, i);
    if (c == --[ "\"" ]--34) then do
      $$Buffer.add_char(b, --[ "\\" ]--92);
    end
     end 
    $$Buffer.add_char(b, c);
  end
  $$Buffer.add_char(b, --[ "\"" ]--34);
  return $$Buffer.contents(b);
end

function format_from_string(s, fmt) do
  return sscanf_format(string_to_String(s), fmt, (function (x) do
                return x;
              end));
end

function unescaped(s) do
  return Curry._1(sscanf("\"" .. (s .. "\""), --[ Format ]--[
                  --[ Caml_string ]--Block.__(3, [
                      --[ No_padding ]--0,
                      --[ Flush ]--Block.__(10, [--[ End_of_format ]--0])
                    ]),
                  "%S%!"
                ]), (function (x) do
                return x;
              end));
end

function kfscanf(ic, ef, fmt) do
  return kscanf(memo_from_ic(scan_raise_at_end, ic), ef, fmt);
end

function fscanf(ic, fmt) do
  return kscanf(memo_from_ic(scan_raise_at_end, ic), scanf_bad_input, fmt);
end

var Scanning = do
  stdin: stdin,
  open_in: open_in,
  open_in_bin: open_in_bin,
  close_in: close_in,
  from_file: open_in,
  from_file_bin: open_in_bin,
  from_string: from_string,
  from_function: from_function,
  from_channel: from_channel,
  end_of_input: end_of_input,
  beginning_of_input: beginning_of_input,
  name_of_input: name_of_input,
  stdib: stdin
end;

export do
  Scanning ,
  Scan_failure ,
  bscanf ,
  sscanf ,
  scanf ,
  kscanf ,
  ksscanf ,
  bscanf_format ,
  sscanf_format ,
  format_from_string ,
  unescaped ,
  fscanf ,
  kfscanf ,
  
end
--[ stdin Not a pure module ]--
