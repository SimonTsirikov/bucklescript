console = {log = print};

List = require "./list";
Block = require "./block";
Curry = require "./curry";
__Buffer = require "./buffer";
Printf = require "./printf";
__String = require "./string";
Caml_bytes = require "./caml_bytes";
Caml_int32 = require "./caml_int32";
Pervasives = require "./pervasives";
Caml_format = require "./caml_format";
Caml_string = require "./caml_string";
Caml_exceptions = require "./caml_exceptions";
Caml_js_exceptions = require "./caml_js_exceptions";
CamlinternalFormat = require "./camlinternalFormat";
Caml_external_polyfill = require "./caml_external_polyfill";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";
CamlinternalFormatBasics = require "./camlinternalFormatBasics";

function next_char(ib) do
  xpcall(function() do
    c = Curry._1(ib.ic_get_next_char, --[[ () ]]0);
    ib.ic_current_char = c;
    ib.ic_current_char_is_valid = true;
    ib.ic_char_count = ib.ic_char_count + 1 | 0;
    if (c == --[[ "\n" ]]10) then do
      ib.ic_line_count = ib.ic_line_count + 1 | 0;
    end
     end 
    return c;
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.end_of_file) then do
      ib.ic_current_char = --[[ "\000" ]]0;
      ib.ic_current_char_is_valid = false;
      ib.ic_eof = true;
      return --[[ "\000" ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

function peek_char(ib) do
  if (ib.ic_current_char_is_valid) then do
    return ib.ic_current_char;
  end else do
    return next_char(ib);
  end end 
end end

function checked_peek_char(ib) do
  c = peek_char(ib);
  if (ib.ic_eof) then do
    error(Caml_builtin_exceptions.end_of_file)
  end
   end 
  return c;
end end

function end_of_input(ib) do
  peek_char(ib);
  return ib.ic_eof;
end end

function beginning_of_input(ib) do
  return ib.ic_char_count == 0;
end end

function name_of_input(ib) do
  match = ib.ic_input_name;
  if (typeof match == "number") then do
    if (match == --[[ From_function ]]0) then do
      return "unnamed function";
    end else do
      return "unnamed character string";
    end end 
  end else if (match.tag) then do
    return match[0];
  end else do
    return "unnamed Pervasives input channel";
  end end  end 
end end

function char_count(ib) do
  if (ib.ic_current_char_is_valid) then do
    return ib.ic_char_count - 1 | 0;
  end else do
    return ib.ic_char_count;
  end end 
end end

function token(ib) do
  token_buffer = ib.ic_token_buffer;
  tok = __Buffer.contents(token_buffer);
  token_buffer.position = 0;
  ib.ic_token_count = ib.ic_token_count + 1 | 0;
  return tok;
end end

function ignore_char(width, ib) do
  width_1 = width - 1 | 0;
  ib.ic_current_char_is_valid = false;
  return width_1;
end end

function store_char(width, ib, c) do
  __Buffer.add_char(ib.ic_token_buffer, c);
  return ignore_char(width, ib);
end end

function create(iname, next) do
  return {
          ic_eof = false,
          ic_current_char = --[[ "\000" ]]0,
          ic_current_char_is_valid = false,
          ic_char_count = 0,
          ic_line_count = 0,
          ic_token_count = 0,
          ic_get_next_char = next,
          ic_token_buffer = __Buffer.create(1024),
          ic_input_name = iname
        };
end end

function from_string(s) do
  i = {
    contents = 0
  };
  len = #s;
  next = function(param) do
    if (i.contents >= len) then do
      error(Caml_builtin_exceptions.end_of_file)
    end
     end 
    c = Caml_string.get(s, i.contents);
    i.contents = i.contents + 1 | 0;
    return c;
  end end;
  return create(--[[ From_string ]]1, next);
end end

function from_function(param) do
  return create(--[[ From_function ]]0, param);
end end

file_buffer_size = {
  contents = 1024
};

function scan_close_at_end(ic) do
  Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  error(Caml_builtin_exceptions.end_of_file)
end end

function scan_raise_at_end(_ic) do
  error(Caml_builtin_exceptions.end_of_file)
end end

function from_ic(scan_close_ic, iname, ic) do
  len = file_buffer_size.contents;
  buf = Caml_bytes.caml_create_bytes(len);
  i = {
    contents = 0
  };
  lim = {
    contents = 0
  };
  eof = {
    contents = false
  };
  next = function(param) do
    if (i.contents < lim.contents) then do
      c = Caml_bytes.get(buf, i.contents);
      i.contents = i.contents + 1 | 0;
      return c;
    end else do
      if (eof.contents) then do
        error(Caml_builtin_exceptions.end_of_file)
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
  end end;
  return create(iname, next);
end end

stdin = from_ic(scan_raise_at_end, --[[ From_file ]]Block.__(1, {
        "-",
        Pervasives.stdin
      }), Pervasives.stdin);

function open_in_file(open_in, fname) do
  if (fname == "-") then do
    return stdin;
  end else do
    ic = Curry._1(open_in, fname);
    return from_ic(scan_close_at_end, --[[ From_file ]]Block.__(1, {
                  fname,
                  ic
                }), ic);
  end end 
end end

function open_in(param) do
  return open_in_file(Pervasives.open_in, param);
end end

function open_in_bin(param) do
  return open_in_file(Pervasives.open_in_bin, param);
end end

function from_channel(ic) do
  return from_ic(scan_raise_at_end, --[[ From_channel ]]Block.__(0, {ic}), ic);
end end

function close_in(ib) do
  match = ib.ic_input_name;
  if (typeof match == "number") then do
    return --[[ () ]]0;
  end else if (match.tag) then do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(match[1]);
  end else do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(match[0]);
  end end  end 
end end

memo = {
  contents = --[[ [] ]]0
};

function memo_from_ic(scan_close_ic, ic) do
  xpcall(function() do
    return List.assq(ic, memo.contents);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      ib = from_ic(scan_close_ic, --[[ From_channel ]]Block.__(0, {ic}), ic);
      memo.contents = --[[ :: ]]{
        --[[ tuple ]]{
          ic,
          ib
        },
        memo.contents
      };
      return ib;
    end else do
      error(exn)
    end end 
  end end)
end end

Scan_failure = Caml_exceptions.create("Scanf.Scan_failure");

function bad_input_escape(c) do
  s = Curry._1(Printf.sprintf(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "illegal escape character ",
                --[[ Caml_char ]]Block.__(1, {--[[ End_of_format ]]0})
              }),
            "illegal escape character %C"
          }), c);
  error({
    Scan_failure,
    s
  })
end end

function bad_token_length(message) do
  s = Curry._1(Printf.sprintf(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "scanning of ",
                --[[ String ]]Block.__(2, {
                    --[[ No_padding ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        " failed: the specified length was too short for token",
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "scanning of %s failed: the specified length was too short for token"
          }), message);
  error({
    Scan_failure,
    s
  })
end end

function bad_hex_float(param) do
  error({
    Scan_failure,
    "not a valid float in hexadecimal notation"
  })
end end

function character_mismatch_err(c, ci) do
  return Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "looking for ",
                      --[[ Caml_char ]]Block.__(1, {--[[ String_literal ]]Block.__(11, {
                              ", found ",
                              --[[ Caml_char ]]Block.__(1, {--[[ End_of_format ]]0})
                            })})
                    }),
                  "looking for %C, found %C"
                }), c, ci);
end end

function check_this_char(ib, c) do
  ci = checked_peek_char(ib);
  if (ci == c) then do
    ib.ic_current_char_is_valid = false;
    return --[[ () ]]0;
  end else do
    s = character_mismatch_err(c, ci);
    error({
      Scan_failure,
      s
    })
  end end 
end end

function check_char(ib, c) do
  if (c ~= 10) then do
    if (c ~= 32) then do
      return check_this_char(ib, c);
    end else do
      ib_1 = ib;
      while(true) do
        c_1 = peek_char(ib_1);
        if (ib_1.ic_eof) then do
          return 0;
        end else do
          switcher = c_1 - 9 | 0;
          if (switcher > 4 or switcher < 0) then do
            if (switcher ~= 23) then do
              return --[[ () ]]0;
            end else do
              ib_1.ic_current_char_is_valid = false;
              ::continue:: ;
            end end 
          end else if (switcher == 3 or switcher == 2) then do
            return --[[ () ]]0;
          end else do
            ib_1.ic_current_char_is_valid = false;
            ::continue:: ;
          end end  end 
        end end 
      end;
    end end 
  end else do
    ib_2 = ib;
    ci = checked_peek_char(ib_2);
    if (ci ~= 10) then do
      if (ci ~= 13) then do
        s = character_mismatch_err(--[[ "\n" ]]10, ci);
        error({
          Scan_failure,
          s
        })
      end else do
        ib_2.ic_current_char_is_valid = false;
        return check_this_char(ib_2, --[[ "\n" ]]10);
      end end 
    end else do
      ib_2.ic_current_char_is_valid = false;
      return --[[ () ]]0;
    end end 
  end end 
end end

function token_bool(ib) do
  s = token(ib);
  local ___conditional___=(s);
  do
     if ___conditional___ == "false" then do
        return false; end end 
     if ___conditional___ == "true" then do
        return true; end end 
    s_1 = Curry._1(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "invalid boolean '",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "'" ]]39,
                            --[[ End_of_format ]]0
                          })
                      })
                  }),
                "invalid boolean '%s'"
              }), s);
      error({
        Scan_failure,
        s_1
      })
      
  end
end end

function integer_conversion_of_char(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == 98 then do
        return --[[ B_conversion ]]0; end end 
     if ___conditional___ == 100 then do
        return --[[ D_conversion ]]1; end end 
     if ___conditional___ == 105 then do
        return --[[ I_conversion ]]2; end end 
     if ___conditional___ == 111 then do
        return --[[ O_conversion ]]3; end end 
     if ___conditional___ == 117 then do
        return --[[ U_conversion ]]4; end end 
     if ___conditional___ == 89
     or ___conditional___ == 90
     or ___conditional___ == 91
     or ___conditional___ == 92
     or ___conditional___ == 93
     or ___conditional___ == 94
     or ___conditional___ == 95
     or ___conditional___ == 96
     or ___conditional___ == 97
     or ___conditional___ == 99
     or ___conditional___ == 101
     or ___conditional___ == 102
     or ___conditional___ == 103
     or ___conditional___ == 104
     or ___conditional___ == 106
     or ___conditional___ == 107
     or ___conditional___ == 108
     or ___conditional___ == 109
     or ___conditional___ == 110
     or ___conditional___ == 112
     or ___conditional___ == 113
     or ___conditional___ == 114
     or ___conditional___ == 115
     or ___conditional___ == 116
     or ___conditional___ == 118
     or ___conditional___ == 119
     or ___conditional___ == 88
     or ___conditional___ == 120 then do
        return --[[ X_conversion ]]5; end end 
    
  end
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "scanf.ml",
      555,
      9
    }
  })
end end

function token_int_literal(conv, ib) do
  tok;
  local ___conditional___=(conv);
  do
     if ___conditional___ == 0--[[ B_conversion ]] then do
        tok = "0b" .. token(ib); end else 
     if ___conditional___ == 1--[[ D_conversion ]]
     or ___conditional___ == 2--[[ I_conversion ]] then do
        tok = token(ib); end else 
     if ___conditional___ == 3--[[ O_conversion ]] then do
        tok = "0o" .. token(ib); end else 
     if ___conditional___ == 4--[[ U_conversion ]] then do
        tok = "0u" .. token(ib); end else 
     if ___conditional___ == 5--[[ X_conversion ]] then do
        tok = "0x" .. token(ib); end else 
     end end end end end end end end end end
    
  end
  l = #tok;
  if (l == 0 or Caml_string.get(tok, 0) ~= --[[ "+" ]]43) then do
    return tok;
  end else do
    return __String.sub(tok, 1, l - 1 | 0);
  end end 
end end

function token_float(ib) do
  return Caml_format.caml_float_of_string(token(ib));
end end

function scan_decimal_digit_star(_width, ib) do
  while(true) do
    width = _width;
    if (width == 0) then do
      return width;
    end else do
      c = peek_char(ib);
      if (ib.ic_eof) then do
        return width;
      end else if (c >= 58) then do
        if (c ~= 95) then do
          return width;
        end else do
          width_1 = ignore_char(width, ib);
          _width = width_1;
          ::continue:: ;
        end end 
      end else if (c >= 48) then do
        width_2 = store_char(width, ib, c);
        _width = width_2;
        ::continue:: ;
      end else do
        return width;
      end end  end  end 
    end end 
  end;
end end

function scan_decimal_digit_plus(width, ib) do
  if (width == 0) then do
    return bad_token_length("decimal digits");
  end else do
    c = checked_peek_char(ib);
    if (c > 57 or c < 48) then do
      s = Curry._1(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "character ",
                    --[[ Caml_char ]]Block.__(1, {--[[ String_literal ]]Block.__(11, {
                            " is not a decimal digit",
                            --[[ End_of_format ]]0
                          })})
                  }),
                "character %C is not a decimal digit"
              }), c);
      error({
        Scan_failure,
        s
      })
    end else do
      width_1 = store_char(width, ib, c);
      return scan_decimal_digit_star(width_1, ib);
    end end 
  end end 
end end

function scan_digit_plus(basis, digitp, width, ib) do
  if (width == 0) then do
    return bad_token_length("digits");
  end else do
    c = checked_peek_char(ib);
    if (Curry._1(digitp, c)) then do
      width_1 = store_char(width, ib, c);
      digitp_1 = digitp;
      width_2 = width_1;
      ib_1 = ib;
      _width = width_2;
      ib_2 = ib_1;
      while(true) do
        width_3 = _width;
        if (width_3 == 0) then do
          return width_3;
        end else do
          c_1 = peek_char(ib_2);
          if (ib_2.ic_eof) then do
            return width_3;
          end else if (Curry._1(digitp_1, c_1)) then do
            width_4 = store_char(width_3, ib_2, c_1);
            _width = width_4;
            ::continue:: ;
          end else if (c_1 ~= 95) then do
            return width_3;
          end else do
            width_5 = ignore_char(width_3, ib_2);
            _width = width_5;
            ::continue:: ;
          end end  end  end 
        end end 
      end;
    end else do
      s = Curry._2(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "character ",
                    --[[ Caml_char ]]Block.__(1, {--[[ String_literal ]]Block.__(11, {
                            " is not a valid ",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " digit",
                                    --[[ End_of_format ]]0
                                  })
                              })
                          })})
                  }),
                "character %C is not a valid %s digit"
              }), c, basis);
      error({
        Scan_failure,
        s
      })
    end end 
  end end 
end end

function is_binary_digit(param) do
  return param == 49 or param == 48;
end end

function scan_binary_int(param, param_1) do
  return scan_digit_plus("binary", is_binary_digit, param, param_1);
end end

function is_octal_digit(param) do
  return not (param > 55 or param < 48);
end end

function scan_octal_int(param, param_1) do
  return scan_digit_plus("octal", is_octal_digit, param, param_1);
end end

function is_hexa_digit(param) do
  switcher = param - 48 | 0;
  if (switcher > 22 or switcher < 0) then do
    return not (switcher > 54 or switcher < 49);
  end else do
    return switcher > 16 or switcher < 10;
  end end 
end end

function scan_hexadecimal_int(param, param_1) do
  return scan_digit_plus("hexadecimal", is_hexa_digit, param, param_1);
end end

function scan_sign(width, ib) do
  c = checked_peek_char(ib);
  if (c ~= 43 and c ~= 45) then do
    return width;
  end else do
    return store_char(width, ib, c);
  end end 
end end

function scan_optionally_signed_decimal_int(width, ib) do
  width_1 = scan_sign(width, ib);
  return scan_decimal_digit_plus(width_1, ib);
end end

function scan_int_conversion(conv, width, ib) do
  local ___conditional___=(conv);
  do
     if ___conditional___ == 0--[[ B_conversion ]] then do
        return scan_binary_int(width, ib); end end 
     if ___conditional___ == 1--[[ D_conversion ]] then do
        return scan_optionally_signed_decimal_int(width, ib); end end 
     if ___conditional___ == 2--[[ I_conversion ]] then do
        width_1 = width;
        ib_1 = ib;
        width_2 = scan_sign(width_1, ib_1);
        width_3 = width_2;
        ib_2 = ib_1;
        c = checked_peek_char(ib_2);
        if (c ~= 48) then do
          return scan_decimal_digit_plus(width_3, ib_2);
        end else do
          width_4 = store_char(width_3, ib_2, c);
          if (width_4 == 0) then do
            return width_4;
          end else do
            c_1 = peek_char(ib_2);
            if (ib_2.ic_eof) then do
              return width_4;
            end else if (c_1 >= 99) then do
              if (c_1 ~= 111) then do
                if (c_1 ~= 120) then do
                  return scan_decimal_digit_star(width_4, ib_2);
                end else do
                  return scan_hexadecimal_int(store_char(width_4, ib_2, c_1), ib_2);
                end end 
              end else do
                return scan_octal_int(store_char(width_4, ib_2, c_1), ib_2);
              end end 
            end else if (c_1 ~= 88) then do
              if (c_1 >= 98) then do
                return scan_binary_int(store_char(width_4, ib_2, c_1), ib_2);
              end else do
                return scan_decimal_digit_star(width_4, ib_2);
              end end 
            end else do
              return scan_hexadecimal_int(store_char(width_4, ib_2, c_1), ib_2);
            end end  end  end 
          end end 
        end end  end end 
     if ___conditional___ == 3--[[ O_conversion ]] then do
        return scan_octal_int(width, ib); end end 
     if ___conditional___ == 4--[[ U_conversion ]] then do
        return scan_decimal_digit_plus(width, ib); end end 
     if ___conditional___ == 5--[[ X_conversion ]] then do
        return scan_hexadecimal_int(width, ib); end end 
    
  end
end end

function scan_fractional_part(width, ib) do
  if (width == 0) then do
    return width;
  end else do
    c = peek_char(ib);
    if (ib.ic_eof or c > 57 or c < 48) then do
      return width;
    end else do
      return scan_decimal_digit_star(store_char(width, ib, c), ib);
    end end 
  end end 
end end

function scan_exponent_part(width, ib) do
  if (width == 0) then do
    return width;
  end else do
    c = peek_char(ib);
    if (ib.ic_eof or c ~= 69 and c ~= 101) then do
      return width;
    end else do
      return scan_optionally_signed_decimal_int(store_char(width, ib, c), ib);
    end end 
  end end 
end end

function scan_integer_part(width, ib) do
  width_1 = scan_sign(width, ib);
  return scan_decimal_digit_star(width_1, ib);
end end

function scan_float(width, precision, ib) do
  width_1 = scan_integer_part(width, ib);
  if (width_1 == 0) then do
    return --[[ tuple ]]{
            width_1,
            precision
          };
  end else do
    c = peek_char(ib);
    if (ib.ic_eof) then do
      return --[[ tuple ]]{
              width_1,
              precision
            };
    end else if (c ~= 46) then do
      return --[[ tuple ]]{
              scan_exponent_part(width_1, ib),
              precision
            };
    end else do
      width_2 = store_char(width_1, ib, c);
      precision_1 = width_2 < precision and width_2 or precision;
      width_3 = width_2 - (precision_1 - scan_fractional_part(precision_1, ib) | 0) | 0;
      return --[[ tuple ]]{
              scan_exponent_part(width_3, ib),
              precision_1
            };
    end end  end 
  end end 
end end

function check_case_insensitive_string(width, ib, error, str) do
  lowercase = function(c) do
    if (c > 90 or c < 65) then do
      return c;
    end else do
      return Pervasives.char_of_int((c - --[[ "A" ]]65 | 0) + --[[ "a" ]]97 | 0);
    end end 
  end end;
  len = #str;
  width_1 = width;
  for i = 0 , len - 1 | 0 , 1 do
    c = peek_char(ib);
    if (lowercase(c) ~= lowercase(Caml_string.get(str, i))) then do
      Curry._1(error, --[[ () ]]0);
    end
     end 
    if (width_1 == 0) then do
      Curry._1(error, --[[ () ]]0);
    end
     end 
    width_1 = store_char(width_1, ib, c);
  end
  return width_1;
end end

function scan_hex_float(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "not a valid float in hexadecimal notation"
    })
  end
   end 
  width_1 = scan_sign(width, ib);
  if (width_1 == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "not a valid float in hexadecimal notation"
    })
  end
   end 
  c = peek_char(ib);
  if (c >= 78) then do
    switcher = c - 79 | 0;
    if (switcher > 30 or switcher < 0) then do
      if (switcher >= 32) then do
        error({
          Scan_failure,
          "not a valid float in hexadecimal notation"
        })
      end else do
        width_2 = store_char(width_1, ib, c);
        if (width_2 == 0 or end_of_input(ib)) then do
          error({
            Scan_failure,
            "not a valid float in hexadecimal notation"
          })
        end
         end 
        return check_case_insensitive_string(width_2, ib, bad_hex_float, "an");
      end end 
    end else if (switcher ~= 26) then do
      error({
        Scan_failure,
        "not a valid float in hexadecimal notation"
      })
    end
     end  end 
  end else if (c ~= 48) then do
    if (c ~= 73) then do
      error({
        Scan_failure,
        "not a valid float in hexadecimal notation"
      })
    end
     end 
  end else do
    width_3 = store_char(width_1, ib, c);
    if (width_3 == 0 or end_of_input(ib)) then do
      error({
        Scan_failure,
        "not a valid float in hexadecimal notation"
      })
    end
     end 
    width_4 = check_case_insensitive_string(width_3, ib, bad_hex_float, "x");
    if (width_4 == 0 or end_of_input(ib)) then do
      return width_4;
    end else do
      match = peek_char(ib);
      switcher_1 = match - 46 | 0;
      width_5 = switcher_1 > 34 or switcher_1 < 0 and (
          switcher_1 ~= 66 and scan_hexadecimal_int(width_4, ib) or width_4
        ) or (
          switcher_1 > 33 or switcher_1 < 1 and width_4 or scan_hexadecimal_int(width_4, ib)
        );
      if (width_5 == 0 or end_of_input(ib)) then do
        return width_5;
      end else do
        c_1 = peek_char(ib);
        width_6;
        if (c_1 ~= 46) then do
          width_6 = width_5;
        end else do
          width_7 = store_char(width_5, ib, c_1);
          if (width_7 == 0 or end_of_input(ib)) then do
            width_6 = width_7;
          end else do
            match_1 = peek_char(ib);
            if (match_1 ~= 80 and match_1 ~= 112) then do
              precision_1 = width_7 < precision and width_7 or precision;
              width_6 = width_7 - (precision_1 - scan_hexadecimal_int(precision_1, ib) | 0) | 0;
            end else do
              width_6 = width_7;
            end end 
          end end 
        end end 
        if (width_6 == 0 or end_of_input(ib)) then do
          return width_6;
        end else do
          c_2 = peek_char(ib);
          exit = 0;
          if (c_2 ~= 80 and c_2 ~= 112) then do
            return width_6;
          end else do
            exit = 2;
          end end 
          if (exit == 2) then do
            width_8 = store_char(width_6, ib, c_2);
            if (width_8 == 0 or end_of_input(ib)) then do
              error({
                Scan_failure,
                "not a valid float in hexadecimal notation"
              })
            end
             end 
            return scan_optionally_signed_decimal_int(width_8, ib);
          end
           end 
        end end 
      end end 
    end end 
  end end  end 
  width_9 = store_char(width_1, ib, c);
  if (width_9 == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "not a valid float in hexadecimal notation"
    })
  end
   end 
  return check_case_insensitive_string(width_9, ib, bad_hex_float, "nfinity");
end end

function scan_caml_float_rest(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end
   end 
  width_1 = scan_decimal_digit_star(width, ib);
  if (width_1 == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end
   end 
  c = peek_char(ib);
  switcher = c - 69 | 0;
  if (switcher > 32 or switcher < 0) then do
    if (switcher ~= -23) then do
      error({
        Scan_failure,
        "no dot or exponent part found in float token"
      })
    end else do
      width_2 = store_char(width_1, ib, c);
      precision_1 = width_2 < precision and width_2 or precision;
      width_precision = scan_fractional_part(precision_1, ib);
      frac_width = precision_1 - width_precision | 0;
      width_3 = width_2 - frac_width | 0;
      return scan_exponent_part(width_3, ib);
    end end 
  end else if (switcher > 31 or switcher < 1) then do
    return scan_exponent_part(width_1, ib);
  end else do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end end  end 
end end

function scan_caml_float(width, precision, ib) do
  if (width == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end
   end 
  width_1 = scan_sign(width, ib);
  if (width_1 == 0 or end_of_input(ib)) then do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end
   end 
  c = peek_char(ib);
  if (c >= 49) then do
    if (c >= 58) then do
      error({
        Scan_failure,
        "no dot or exponent part found in float token"
      })
    end else do
      width_2 = store_char(width_1, ib, c);
      if (width_2 == 0 or end_of_input(ib)) then do
        error({
          Scan_failure,
          "no dot or exponent part found in float token"
        })
      end
       end 
      return scan_caml_float_rest(width_2, precision, ib);
    end end 
  end else if (c >= 48) then do
    width_3 = store_char(width_1, ib, c);
    if (width_3 == 0 or end_of_input(ib)) then do
      error({
        Scan_failure,
        "no dot or exponent part found in float token"
      })
    end
     end 
    c_1 = peek_char(ib);
    exit = 0;
    if (c_1 ~= 88 and c_1 ~= 120) then do
      return scan_caml_float_rest(width_3, precision, ib);
    end else do
      exit = 1;
    end end 
    if (exit == 1) then do
      width_4 = store_char(width_3, ib, c_1);
      if (width_4 == 0 or end_of_input(ib)) then do
        error({
          Scan_failure,
          "no dot or exponent part found in float token"
        })
      end
       end 
      width_5 = scan_hexadecimal_int(width_4, ib);
      if (width_5 == 0 or end_of_input(ib)) then do
        error({
          Scan_failure,
          "no dot or exponent part found in float token"
        })
      end
       end 
      c_2 = peek_char(ib);
      switcher = c_2 - 80 | 0;
      width_6;
      if (switcher > 32 or switcher < 0) then do
        if (switcher ~= -34) then do
          error({
            Scan_failure,
            "no dot or exponent part found in float token"
          })
        end else do
          width_7 = store_char(width_5, ib, c_2);
          if (width_7 == 0 or end_of_input(ib)) then do
            width_6 = width_7;
          end else do
            match = peek_char(ib);
            if (match ~= 80 and match ~= 112) then do
              precision_1 = width_7 < precision and width_7 or precision;
              width_6 = width_7 - (precision_1 - scan_hexadecimal_int(precision_1, ib) | 0) | 0;
            end else do
              width_6 = width_7;
            end end 
          end end 
        end end 
      end else if (switcher > 31 or switcher < 1) then do
        width_6 = width_5;
      end else do
        error({
          Scan_failure,
          "no dot or exponent part found in float token"
        })
      end end  end 
      if (width_6 == 0 or end_of_input(ib)) then do
        return width_6;
      end else do
        c_3 = peek_char(ib);
        if (c_3 ~= 80 and c_3 ~= 112) then do
          return width_6;
        end
         end 
        width_8 = store_char(width_6, ib, c_3);
        if (width_8 == 0 or end_of_input(ib)) then do
          error({
            Scan_failure,
            "not a valid float in hexadecimal notation"
          })
        end
         end 
        return scan_optionally_signed_decimal_int(width_8, ib);
      end end 
    end
     end 
  end else do
    error({
      Scan_failure,
      "no dot or exponent part found in float token"
    })
  end end  end 
end end

function scan_string(stp, width, ib) do
  _width = width;
  while(true) do
    width_1 = _width;
    if (width_1 == 0) then do
      return width_1;
    end else do
      c = peek_char(ib);
      if (ib.ic_eof) then do
        return width_1;
      end else if (stp ~= undefined) then do
        if (c == stp) then do
          ib.ic_current_char_is_valid = false;
          return width_1;
        end else do
          _width = store_char(width_1, ib, c);
          ::continue:: ;
        end end 
      end else do
        switcher = c - 9 | 0;
        if (switcher > 4 or switcher < 0) then do
          if (switcher ~= 23) then do
            _width = store_char(width_1, ib, c);
            ::continue:: ;
          end else do
            return width_1;
          end end 
        end else if (switcher == 3 or switcher == 2) then do
          _width = store_char(width_1, ib, c);
          ::continue:: ;
        end else do
          return width_1;
        end end  end 
      end end  end 
    end end 
  end;
end end

function scan_char(width, ib) do
  return store_char(width, ib, checked_peek_char(ib));
end end

function char_for_backslash(c) do
  if (c >= 110) then do
    if (c >= 117) then do
      return c;
    end else do
      local ___conditional___=(c - 110 | 0);
      do
         if ___conditional___ == 0 then do
            return --[[ "\n" ]]10; end end 
         if ___conditional___ == 4 then do
            return --[[ "\r" ]]13; end end 
         if ___conditional___ == 1
         or ___conditional___ == 2
         or ___conditional___ == 3
         or ___conditional___ == 5 then do
            return c; end end 
         if ___conditional___ == 6 then do
            return --[[ "\t" ]]9; end end 
        
      end
    end end 
  end else if (c ~= 98) then do
    return c;
  end else do
    return --[[ "\b" ]]8;
  end end  end 
end end

function char_for_decimal_code(c0, c1, c2) do
  c = (Caml_int32.imul(100, c0 - --[[ "0" ]]48 | 0) + Caml_int32.imul(10, c1 - --[[ "0" ]]48 | 0) | 0) + (c2 - --[[ "0" ]]48 | 0) | 0;
  if (c < 0 or c > 255) then do
    s = Curry._3(Printf.sprintf(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "bad character decimal encoding \\",
                  --[[ Char ]]Block.__(0, {--[[ Char ]]Block.__(0, {--[[ Char ]]Block.__(0, {--[[ End_of_format ]]0})})})
                }),
              "bad character decimal encoding \\%c%c%c"
            }), c0, c1, c2);
    error({
      Scan_failure,
      s
    })
  end else do
    return Pervasives.char_of_int(c);
  end end 
end end

function hexadecimal_value_of_char(c) do
  if (c >= --[[ "a" ]]97) then do
    return c - 87 | 0;
  end else if (c >= --[[ "A" ]]65) then do
    return c - 55 | 0;
  end else do
    return c - --[[ "0" ]]48 | 0;
  end end  end 
end end

function char_for_hexadecimal_code(c1, c2) do
  c = (hexadecimal_value_of_char(c1) << 4) + hexadecimal_value_of_char(c2) | 0;
  if (c < 0 or c > 255) then do
    s = Curry._2(Printf.sprintf(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "bad character hexadecimal encoding \\",
                  --[[ Char ]]Block.__(0, {--[[ Char ]]Block.__(0, {--[[ End_of_format ]]0})})
                }),
              "bad character hexadecimal encoding \\%c%c"
            }), c1, c2);
    error({
      Scan_failure,
      s
    })
  end else do
    return Pervasives.char_of_int(c);
  end end 
end end

function check_next_char(message, width, ib) do
  if (width == 0) then do
    return bad_token_length(message);
  end else do
    c = peek_char(ib);
    if (ib.ic_eof) then do
      message_1 = message;
      s = Curry._1(Printf.sprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "scanning of ",
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " failed: premature end of file occurred before end of token",
                            --[[ End_of_format ]]0
                          })
                      })
                  }),
                "scanning of %s failed: premature end of file occurred before end of token"
              }), message_1);
      error({
        Scan_failure,
        s
      })
    end else do
      return c;
    end end 
  end end 
end end

function scan_backslash_char(width, ib) do
  c = check_next_char("a Char", width, ib);
  if (c >= 40) then do
    if (c >= 58) then do
      local ___conditional___=(c);
      do
         if ___conditional___ == 92
         or ___conditional___ == 98
         or ___conditional___ == 110
         or ___conditional___ == 114
         or ___conditional___ == 116
         or ___conditional___ == 93
         or ___conditional___ == 94
         or ___conditional___ == 95
         or ___conditional___ == 96
         or ___conditional___ == 97
         or ___conditional___ == 99
         or ___conditional___ == 100
         or ___conditional___ == 101
         or ___conditional___ == 102
         or ___conditional___ == 103
         or ___conditional___ == 104
         or ___conditional___ == 105
         or ___conditional___ == 106
         or ___conditional___ == 107
         or ___conditional___ == 108
         or ___conditional___ == 109
         or ___conditional___ == 111
         or ___conditional___ == 112
         or ___conditional___ == 113
         or ___conditional___ == 115
         or ___conditional___ == 117
         or ___conditional___ == 118
         or ___conditional___ == 119 then do
            return bad_input_escape(c); end end 
         if ___conditional___ == 120 then do
            get_digit = function(param) do
              c = next_char(ib);
              switcher = c - 48 | 0;
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
            end end;
            c1 = get_digit(--[[ () ]]0);
            c2 = get_digit(--[[ () ]]0);
            return store_char(width - 2 | 0, ib, char_for_hexadecimal_code(c1, c2)); end end 
        return bad_input_escape(c);
          
      end
    end else if (c >= 48) then do
      get_digit_1 = function(param) do
        c = next_char(ib);
        if (c > 57 or c < 48) then do
          return bad_input_escape(c);
        end else do
          return c;
        end end 
      end end;
      c1_1 = get_digit_1(--[[ () ]]0);
      c2_1 = get_digit_1(--[[ () ]]0);
      return store_char(width - 2 | 0, ib, char_for_decimal_code(c, c1_1, c2_1));
    end else do
      return bad_input_escape(c);
    end end  end 
  end else if (c ~= 34 and c < 39) then do
    return bad_input_escape(c);
  end
   end  end 
  return store_char(width, ib, char_for_backslash(c));
end end

function scan_caml_char(width, ib) do
  find_stop = function(width) do
    c = check_next_char("a Char", width, ib);
    if (c ~= 39) then do
      s = character_mismatch_err(--[[ "'" ]]39, c);
      error({
        Scan_failure,
        s
      })
    end else do
      return ignore_char(width, ib);
    end end 
  end end;
  width_1 = width;
  c = checked_peek_char(ib);
  if (c ~= 39) then do
    s = character_mismatch_err(--[[ "'" ]]39, c);
    error({
      Scan_failure,
      s
    })
  end else do
    width_2 = ignore_char(width_1, ib);
    c_1 = check_next_char("a Char", width_2, ib);
    if (c_1 ~= 92) then do
      return find_stop(store_char(width_2, ib, c_1));
    end else do
      return find_stop(scan_backslash_char(ignore_char(width_2, ib), ib));
    end end 
  end end 
end end

function scan_caml_string(width, ib) do
  find_stop = function(_width) do
    while(true) do
      width = _width;
      c = check_next_char("a String", width, ib);
      if (c ~= 34) then do
        if (c ~= 92) then do
          _width = store_char(width, ib, c);
          ::continue:: ;
        end else do
          width_1 = ignore_char(width, ib);
          match = check_next_char("a String", width_1, ib);
          if (match ~= 10) then do
            if (match ~= 13) then do
              return find_stop(scan_backslash_char(width_1, ib));
            end else do
              width_2 = ignore_char(width_1, ib);
              match_1 = check_next_char("a String", width_2, ib);
              if (match_1 ~= 10) then do
                return find_stop(store_char(width_2, ib, --[[ "\r" ]]13));
              end else do
                return skip_spaces(ignore_char(width_2, ib));
              end end 
            end end 
          end else do
            return skip_spaces(ignore_char(width_1, ib));
          end end 
        end end 
      end else do
        return ignore_char(width, ib);
      end end 
    end;
  end end;
  skip_spaces = function(_width) do
    while(true) do
      width = _width;
      match = check_next_char("a String", width, ib);
      if (match ~= 32) then do
        return find_stop(width);
      end else do
        _width = ignore_char(width, ib);
        ::continue:: ;
      end end 
    end;
  end end;
  width_1 = width;
  c = checked_peek_char(ib);
  if (c ~= 34) then do
    s = character_mismatch_err(--[[ "\"" ]]34, c);
    error({
      Scan_failure,
      s
    })
  end else do
    return find_stop(ignore_char(width_1, ib));
  end end 
end end

function scan_chars_in_char_set(char_set, scan_indic, width, ib) do
  scan_chars = function(_i, stp) do
    while(true) do
      i = _i;
      c = peek_char(ib);
      if (i > 0 and not ib.ic_eof and CamlinternalFormat.is_in_char_set(char_set, c) and c ~= stp) then do
        store_char(Pervasives.max_int, ib, c);
        _i = i - 1 | 0;
        ::continue:: ;
      end else do
        return 0;
      end end 
    end;
  end end;
  if (scan_indic ~= undefined) then do
    c = scan_indic;
    scan_chars(width, c);
    if (ib.ic_eof) then do
      return 0;
    end else do
      ci = peek_char(ib);
      if (c == ci) then do
        ib.ic_current_char_is_valid = false;
        return --[[ () ]]0;
      end else do
        s = character_mismatch_err(c, ci);
        error({
          Scan_failure,
          s
        })
      end end 
    end end 
  end else do
    return scan_chars(width, -1);
  end end 
end end

function scanf_bad_input(ib, x) do
  s;
  if (x[0] == Scan_failure or x[0] == Caml_builtin_exceptions.failure) then do
    s = x[1];
  end else do
    error(x)
  end end 
  i = char_count(ib);
  s_1 = Curry._2(Printf.sprintf(--[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "scanf: bad input at char number ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_i ]]3,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ String_literal ]]Block.__(11, {
                        ": ",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ End_of_format ]]0
                          })
                      })
                  })
              }),
            "scanf: bad input at char number %i: %s"
          }), i, s);
  error({
    Scan_failure,
    s_1
  })
end end

function get_counter(ib, counter) do
  local ___conditional___=(counter);
  do
     if ___conditional___ == 0--[[ Line_counter ]] then do
        return ib.ic_line_count; end end 
     if ___conditional___ == 1--[[ Char_counter ]] then do
        return char_count(ib); end end 
     if ___conditional___ == 2--[[ Token_counter ]] then do
        return ib.ic_token_count; end end 
    
  end
end end

function width_of_pad_opt(pad_opt) do
  if (pad_opt ~= undefined) then do
    return pad_opt;
  end else do
    return Pervasives.max_int;
  end end 
end end

function stopper_of_formatting_lit(fmting) do
  if (fmting == --[[ Escaped_percent ]]6) then do
    return --[[ tuple ]]{
            --[[ "%" ]]37,
            ""
          };
  end else do
    str = CamlinternalFormat.string_of_formatting_lit(fmting);
    stp = Caml_string.get(str, 1);
    sub_str = __String.sub(str, 2, #str - 2 | 0);
    return --[[ tuple ]]{
            stp,
            sub_str
          };
  end end 
end end

function take_format_readers(k, _fmt) do
  while(true) do
    fmt = _fmt;
    if (typeof fmt == "number") then do
      return Curry._1(k, --[[ Nil ]]0);
    end else do
      local ___conditional___=(fmt.tag | 0);
      do
         if ___conditional___ == 4--[[ Int ]]
         or ___conditional___ == 5--[[ Int32 ]]
         or ___conditional___ == 6--[[ Nativeint ]]
         or ___conditional___ == 7--[[ Int64 ]]
         or ___conditional___ == 8--[[ Float ]] then do
            _fmt = fmt[3];
            ::continue:: ; end end 
         if ___conditional___ == 14--[[ Format_subst ]] then do
            return take_fmtty_format_readers(k, CamlinternalFormatBasics.erase_rel(CamlinternalFormat.symm(fmt[1])), fmt[2]); end end 
         if ___conditional___ == 18--[[ Formatting_gen ]] then do
            _fmt = CamlinternalFormatBasics.concat_fmt(fmt[0][0][0], fmt[1]);
            ::continue:: ; end end 
         if ___conditional___ == 19--[[ Reader ]] then do
            fmt_rest = fmt[0];
            return (function(fmt_rest)do
            return function (reader) do
              new_k = function(readers_rest) do
                return Curry._1(k, --[[ Cons ]]{
                            reader,
                            readers_rest
                          });
              end end;
              return take_format_readers(new_k, fmt_rest);
            end end
            end end)(fmt_rest); end end 
         if ___conditional___ == 0--[[ Char ]]
         or ___conditional___ == 1--[[ Caml_char ]]
         or ___conditional___ == 10--[[ Flush ]]
         or ___conditional___ == 15--[[ Alpha ]]
         or ___conditional___ == 16--[[ Theta ]]
         or ___conditional___ == 22--[[ Scan_next_char ]] then do
            _fmt = fmt[0];
            ::continue:: ; end end 
         if ___conditional___ == 23--[[ Ignored_param ]] then do
            k_1 = k;
            ign = fmt[0];
            fmt_1 = fmt[1];
            if (typeof ign == "number") then do
              if (ign == --[[ Ignored_reader ]]2) then do
                return (function(k_1,fmt_1)do
                return function (reader) do
                  new_k = function(readers_rest) do
                    return Curry._1(k_1, --[[ Cons ]]{
                                reader,
                                readers_rest
                              });
                  end end;
                  return take_format_readers(new_k, fmt_1);
                end end
                end end)(k_1,fmt_1);
              end else do
                return take_format_readers(k_1, fmt_1);
              end end 
            end else if (ign.tag == --[[ Ignored_format_subst ]]9) then do
              return take_fmtty_format_readers(k_1, ign[1], fmt_1);
            end else do
              return take_format_readers(k_1, fmt_1);
            end end  end  end end 
         if ___conditional___ == 13--[[ Format_arg ]]
         or ___conditional___ == 20--[[ Scan_char_set ]]
         or ___conditional___ == 24--[[ Custom ]] then do
            _fmt = fmt[2];
            ::continue:: ; end end 
        _fmt = fmt[1];
          ::continue:: ;
          
      end
    end end 
  end;
end end

function take_fmtty_format_readers(k, _fmtty, fmt) do
  while(true) do
    fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return take_format_readers(k, fmt);
    end else do
      local ___conditional___=(fmtty.tag | 0);
      do
         if ___conditional___ == 8--[[ Format_arg_ty ]] then do
            _fmtty = fmtty[1];
            ::continue:: ; end end 
         if ___conditional___ == 9--[[ Format_subst_ty ]] then do
            ty = CamlinternalFormat.trans(CamlinternalFormat.symm(fmtty[0]), fmtty[1]);
            _fmtty = CamlinternalFormatBasics.concat_fmtty(ty, fmtty[2]);
            ::continue:: ; end end 
         if ___conditional___ == 13--[[ Reader_ty ]] then do
            fmt_rest = fmtty[0];
            return (function(fmt_rest)do
            return function (reader) do
              new_k = function(readers_rest) do
                return Curry._1(k, --[[ Cons ]]{
                            reader,
                            readers_rest
                          });
              end end;
              return take_fmtty_format_readers(new_k, fmt_rest, fmt);
            end end
            end end)(fmt_rest); end end 
         if ___conditional___ == 14--[[ Ignored_reader_ty ]] then do
            fmt_rest_1 = fmtty[0];
            return (function(fmt_rest_1)do
            return function (reader) do
              new_k = function(readers_rest) do
                return Curry._1(k, --[[ Cons ]]{
                            reader,
                            readers_rest
                          });
              end end;
              return take_fmtty_format_readers(new_k, fmt_rest_1, fmt);
            end end
            end end)(fmt_rest_1); end end 
        _fmtty = fmtty[0];
          ::continue:: ;
          
      end
    end end 
  end;
end end

function make_scanf(ib, _fmt, readers) do
  while(true) do
    fmt = _fmt;
    if (typeof fmt == "number") then do
      return --[[ Nil ]]0;
    end else do
      local ___conditional___=(fmt.tag | 0);
      do
         if ___conditional___ == 0--[[ Char ]] then do
            scan_char(0, ib);
            c = Caml_string.get(token(ib), 0);
            return --[[ Cons ]]{
                    c,
                    make_scanf(ib, fmt[0], readers)
                  }; end end 
         if ___conditional___ == 1--[[ Caml_char ]] then do
            scan_caml_char(0, ib);
            c_1 = Caml_string.get(token(ib), 0);
            return --[[ Cons ]]{
                    c_1,
                    make_scanf(ib, fmt[0], readers)
                  }; end end 
         if ___conditional___ == 2--[[ String ]] then do
            rest = fmt[1];
            pad = fmt[0];
            if (typeof rest ~= "number") then do
              local ___conditional___=(rest.tag | 0);
              do
                 if ___conditional___ == 17--[[ Formatting_lit ]] then do
                    match = stopper_of_formatting_lit(rest[0]);
                    stp = match[0];
                    scan = (function(stp)do
                    return function scan(width, param, ib) do
                      return scan_string(stp, width, ib);
                    end end
                    end end)(stp);
                    str_rest_000 = match[1];
                    str_rest_001 = rest[1];
                    str_rest = --[[ String_literal ]]Block.__(11, {
                        str_rest_000,
                        str_rest_001
                      });
                    return pad_prec_scanf(ib, str_rest, readers, pad, --[[ No_precision ]]0, scan, token); end end 
                 if ___conditional___ == 18--[[ Formatting_gen ]] then do
                    match_1 = rest[0];
                    if (match_1.tag) then do
                      scan_1 = function(width, param, ib) do
                        return scan_string(--[[ "[" ]]91, width, ib);
                      end end;
                      return pad_prec_scanf(ib, CamlinternalFormatBasics.concat_fmt(match_1[0][0], rest[1]), readers, pad, --[[ No_precision ]]0, scan_1, token);
                    end else do
                      scan_2 = function(width, param, ib) do
                        return scan_string(--[[ "{" ]]123, width, ib);
                      end end;
                      return pad_prec_scanf(ib, CamlinternalFormatBasics.concat_fmt(match_1[0][0], rest[1]), readers, pad, --[[ No_precision ]]0, scan_2, token);
                    end end  end end 
                
              end
            end
             end 
            scan_3 = function(width, param, ib) do
              return scan_string(undefined, width, ib);
            end end;
            return pad_prec_scanf(ib, rest, readers, pad, --[[ No_precision ]]0, scan_3, token); end end 
         if ___conditional___ == 3--[[ Caml_string ]] then do
            scan_4 = function(width, param, ib) do
              return scan_caml_string(width, ib);
            end end;
            return pad_prec_scanf(ib, fmt[1], readers, fmt[0], --[[ No_precision ]]0, scan_4, token); end end 
         if ___conditional___ == 4--[[ Int ]] then do
            c_2 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            scan_5 = (function(c_2)do
            return function scan_5(width, param, ib) do
              return scan_int_conversion(c_2, width, ib);
            end end
            end end)(c_2);
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_5, (function(c_2)do
                      return function (param) do
                        return Caml_format.caml_int_of_string(token_int_literal(c_2, param));
                      end end
                      end end)(c_2)); end end 
         if ___conditional___ == 5--[[ Int32 ]] then do
            c_3 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            scan_6 = (function(c_3)do
            return function scan_6(width, param, ib) do
              return scan_int_conversion(c_3, width, ib);
            end end
            end end)(c_3);
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_6, (function(c_3)do
                      return function (param) do
                        return Caml_format.caml_int32_of_string(token_int_literal(c_3, param));
                      end end
                      end end)(c_3)); end end 
         if ___conditional___ == 6--[[ Nativeint ]] then do
            c_4 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            scan_7 = (function(c_4)do
            return function scan_7(width, param, ib) do
              return scan_int_conversion(c_4, width, ib);
            end end
            end end)(c_4);
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_7, (function(c_4)do
                      return function (param) do
                        return Caml_format.caml_nativeint_of_string(token_int_literal(c_4, param));
                      end end
                      end end)(c_4)); end end 
         if ___conditional___ == 7--[[ Int64 ]] then do
            c_5 = integer_conversion_of_char(CamlinternalFormat.char_of_iconv(fmt[0]));
            scan_8 = (function(c_5)do
            return function scan_8(width, param, ib) do
              return scan_int_conversion(c_5, width, ib);
            end end
            end end)(c_5);
            return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_8, (function(c_5)do
                      return function (param) do
                        return Caml_format.caml_int64_of_string(token_int_literal(c_5, param));
                      end end
                      end end)(c_5)); end end 
         if ___conditional___ == 8--[[ Float ]] then do
            match_2 = fmt[0];
            if (match_2 ~= 15) then do
              if (match_2 >= 16) then do
                return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_hex_float, token_float);
              end else do
                return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_float, token_float);
              end end 
            end else do
              return pad_prec_scanf(ib, fmt[3], readers, fmt[1], fmt[2], scan_caml_float, token_float);
            end end  end end 
         if ___conditional___ == 9--[[ Bool ]] then do
            scan_9 = function(param, param_1, ib) do
              ib_1 = ib;
              c = checked_peek_char(ib_1);
              m;
              if (c ~= 102) then do
                if (c ~= 116) then do
                  s = Curry._1(Printf.sprintf(--[[ Format ]]{
                            --[[ String_literal ]]Block.__(11, {
                                "the character ",
                                --[[ Caml_char ]]Block.__(1, {--[[ String_literal ]]Block.__(11, {
                                        " cannot start a boolean",
                                        --[[ End_of_format ]]0
                                      })})
                              }),
                            "the character %C cannot start a boolean"
                          }), c);
                  error({
                    Scan_failure,
                    s
                  })
                end else do
                  m = 4;
                end end 
              end else do
                m = 5;
              end end 
              return scan_string(undefined, m, ib_1);
            end end;
            return pad_prec_scanf(ib, fmt[1], readers, fmt[0], --[[ No_precision ]]0, scan_9, token_bool); end end 
         if ___conditional___ == 10--[[ Flush ]] then do
            if (end_of_input(ib)) then do
              _fmt = fmt[0];
              ::continue:: ;
            end else do
              error({
                Scan_failure,
                "end of input not found"
              })
            end end  end end 
         if ___conditional___ == 11--[[ String_literal ]] then do
            __String.iter((function(param) do
                    return check_char(ib, param);
                  end end), fmt[0]);
            _fmt = fmt[1];
            ::continue:: ; end end 
         if ___conditional___ == 12--[[ Char_literal ]] then do
            check_char(ib, fmt[0]);
            _fmt = fmt[1];
            ::continue:: ; end end 
         if ___conditional___ == 13--[[ Format_arg ]] then do
            scan_caml_string(width_of_pad_opt(fmt[0]), ib);
            s = token(ib);
            fmt_1;
            xpcall(function() do
              fmt_1 = CamlinternalFormat.format_of_string_fmtty(s, fmt[1]);
            end end,function(raw_exn) do
              exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
              if (exn[0] == Caml_builtin_exceptions.failure) then do
                error({
                  Scan_failure,
                  exn[1]
                })
              end
               end 
              error(exn)
            end end)
            return --[[ Cons ]]{
                    fmt_1,
                    make_scanf(ib, fmt[2], readers)
                  }; end end 
         if ___conditional___ == 14--[[ Format_subst ]] then do
            fmtty = fmt[1];
            scan_caml_string(width_of_pad_opt(fmt[0]), ib);
            s_1 = token(ib);
            match_3;
            xpcall(function() do
              match_4 = CamlinternalFormat.fmt_ebb_of_string(undefined, s_1);
              match_5 = CamlinternalFormat.fmt_ebb_of_string(undefined, s_1);
              match_3 = --[[ tuple ]]{
                CamlinternalFormat.type_format(match_4[0], CamlinternalFormatBasics.erase_rel(fmtty)),
                CamlinternalFormat.type_format(match_5[0], CamlinternalFormatBasics.erase_rel(CamlinternalFormat.symm(fmtty)))
              };
            end end,function(raw_exn_1) do
              exn_1 = Caml_js_exceptions.internalToOCamlException(raw_exn_1);
              if (exn_1[0] == Caml_builtin_exceptions.failure) then do
                error({
                  Scan_failure,
                  exn_1[1]
                })
              end
               end 
              error(exn_1)
            end end)
            return --[[ Cons ]]{
                    --[[ Format ]]{
                      match_3[0],
                      s_1
                    },
                    make_scanf(ib, CamlinternalFormatBasics.concat_fmt(match_3[1], fmt[2]), readers)
                  }; end end 
         if ___conditional___ == 15--[[ Alpha ]] then do
            error({
              Caml_builtin_exceptions.invalid_argument,
              "scanf: bad conversion \"%a\""
            }) end end 
         if ___conditional___ == 16--[[ Theta ]] then do
            error({
              Caml_builtin_exceptions.invalid_argument,
              "scanf: bad conversion \"%t\""
            }) end end 
         if ___conditional___ == 17--[[ Formatting_lit ]] then do
            __String.iter((function(param) do
                    return check_char(ib, param);
                  end end), CamlinternalFormat.string_of_formatting_lit(fmt[0]));
            _fmt = fmt[1];
            ::continue:: ; end end 
         if ___conditional___ == 18--[[ Formatting_gen ]] then do
            match_6 = fmt[0];
            check_char(ib, --[[ "@" ]]64);
            if (match_6.tag) then do
              check_char(ib, --[[ "[" ]]91);
              _fmt = CamlinternalFormatBasics.concat_fmt(match_6[0][0], fmt[1]);
              ::continue:: ;
            end else do
              check_char(ib, --[[ "{" ]]123);
              _fmt = CamlinternalFormatBasics.concat_fmt(match_6[0][0], fmt[1]);
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 19--[[ Reader ]] then do
            if (readers) then do
              x = Curry._1(readers[0], ib);
              return --[[ Cons ]]{
                      x,
                      make_scanf(ib, fmt[0], readers[1])
                    };
            end else do
              error({
                Caml_builtin_exceptions.invalid_argument,
                "scanf: missing reader"
              })
            end end  end end 
         if ___conditional___ == 20--[[ Scan_char_set ]] then do
            rest_1 = fmt[2];
            char_set = fmt[1];
            width_opt = fmt[0];
            if (typeof rest_1 ~= "number" and rest_1.tag == --[[ Formatting_lit ]]17) then do
              match_7 = stopper_of_formatting_lit(rest_1[0]);
              width = width_of_pad_opt(width_opt);
              scan_chars_in_char_set(char_set, match_7[0], width, ib);
              s_2 = token(ib);
              str_rest_000_1 = match_7[1];
              str_rest_001_1 = rest_1[1];
              str_rest_1 = --[[ String_literal ]]Block.__(11, {
                  str_rest_000_1,
                  str_rest_001_1
                });
              return --[[ Cons ]]{
                      s_2,
                      make_scanf(ib, str_rest_1, readers)
                    };
            end
             end 
            width_1 = width_of_pad_opt(width_opt);
            scan_chars_in_char_set(char_set, undefined, width_1, ib);
            s_3 = token(ib);
            return --[[ Cons ]]{
                    s_3,
                    make_scanf(ib, rest_1, readers)
                  }; end end 
         if ___conditional___ == 21--[[ Scan_get_counter ]] then do
            count = get_counter(ib, fmt[0]);
            return --[[ Cons ]]{
                    count,
                    make_scanf(ib, fmt[1], readers)
                  }; end end 
         if ___conditional___ == 22--[[ Scan_next_char ]] then do
            c_6 = checked_peek_char(ib);
            return --[[ Cons ]]{
                    c_6,
                    make_scanf(ib, fmt[0], readers)
                  }; end end 
         if ___conditional___ == 23--[[ Ignored_param ]] then do
            match_8 = CamlinternalFormat.param_format_of_ignored_format(fmt[0], fmt[1]);
            match_9 = make_scanf(ib, match_8[0], readers);
            if (match_9) then do
              return match_9[1];
            end else do
              error({
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]]{
                  "scanf.ml",
                  1455,
                  13
                }
              })
            end end  end end 
         if ___conditional___ == 24--[[ Custom ]] then do
            error({
              Caml_builtin_exceptions.invalid_argument,
              "scanf: bad conversion \"%?\" (custom converter)"
            }) end end 
        
      end
    end end 
  end;
end end

function pad_prec_scanf(ib, fmt, readers, pad, prec, scan, token) do
  if (typeof pad == "number") then do
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "scanf: bad conversion \"%*\""
        })
      end
       end 
      Curry._3(scan, Pervasives.max_int, Pervasives.max_int, ib);
      x = Curry._1(token, ib);
      return --[[ Cons ]]{
              x,
              make_scanf(ib, fmt, readers)
            };
    end else do
      Curry._3(scan, Pervasives.max_int, prec[0], ib);
      x_1 = Curry._1(token, ib);
      return --[[ Cons ]]{
              x_1,
              make_scanf(ib, fmt, readers)
            };
    end end 
  end else if (pad.tag) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "scanf: bad conversion \"%*\""
    })
  end else if (pad[0] ~= 0) then do
    w = pad[1];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "scanf: bad conversion \"%*\""
        })
      end
       end 
      Curry._3(scan, w, Pervasives.max_int, ib);
      x_2 = Curry._1(token, ib);
      return --[[ Cons ]]{
              x_2,
              make_scanf(ib, fmt, readers)
            };
    end else do
      Curry._3(scan, w, prec[0], ib);
      x_3 = Curry._1(token, ib);
      return --[[ Cons ]]{
              x_3,
              make_scanf(ib, fmt, readers)
            };
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "scanf: bad conversion \"%-\""
    })
  end end  end  end 
end end

function kscanf(ib, ef, param) do
  str = param[1];
  fmt = param[0];
  k = function(readers, f) do
    __Buffer.reset(ib.ic_token_buffer);
    match;
    xpcall(function() do
      match = --[[ Args ]]Block.__(0, {make_scanf(ib, fmt, readers)});
    end end,function(raw_exc) do
      exc = Caml_js_exceptions.internalToOCamlException(raw_exc);
      if (exc[0] == Scan_failure or exc[0] == Caml_builtin_exceptions.failure or exc == Caml_builtin_exceptions.end_of_file) then do
        match = --[[ Exc ]]Block.__(1, {exc});
      end else if (exc[0] == Caml_builtin_exceptions.invalid_argument) then do
        s = exc[1] .. (" in format \"" .. (__String.escaped(str) .. "\""));
        error({
          Caml_builtin_exceptions.invalid_argument,
          s
        })
      end else do
        error(exc)
      end end  end 
    end end)
    if (match.tag) then do
      return Curry._2(ef, ib, match[0]);
    end else do
      _f = f;
      _args = match[0];
      while(true) do
        args = _args;
        f_1 = _f;
        if (args) then do
          _args = args[1];
          _f = Curry._1(f_1, args[0]);
          ::continue:: ;
        end else do
          return f_1;
        end end 
      end;
    end end 
  end end;
  return take_format_readers(k, fmt);
end end

function bscanf(ib, fmt) do
  return kscanf(ib, scanf_bad_input, fmt);
end end

function ksscanf(s, ef, fmt) do
  return kscanf(from_string(s), ef, fmt);
end end

function sscanf(s, fmt) do
  return kscanf(from_string(s), scanf_bad_input, fmt);
end end

function scanf(fmt) do
  return kscanf(stdin, scanf_bad_input, fmt);
end end

function bscanf_format(ib, format, f) do
  scan_caml_string(Pervasives.max_int, ib);
  str = token(ib);
  tmp;
  xpcall(function() do
    tmp = CamlinternalFormat.format_of_string_format(str, format);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      error({
        Scan_failure,
        exn[1]
      })
    end
     end 
    error(exn)
  end end)
  return Curry._1(f, tmp);
end end

function sscanf_format(s, format, f) do
  return bscanf_format(from_string(s), format, f);
end end

function string_to_String(s) do
  l = #s;
  b = __Buffer.create(l + 2 | 0);
  __Buffer.add_char(b, --[[ "\"" ]]34);
  for i = 0 , l - 1 | 0 , 1 do
    c = Caml_string.get(s, i);
    if (c == --[[ "\"" ]]34) then do
      __Buffer.add_char(b, --[[ "\\" ]]92);
    end
     end 
    __Buffer.add_char(b, c);
  end
  __Buffer.add_char(b, --[[ "\"" ]]34);
  return __Buffer.contents(b);
end end

function format_from_string(s, fmt) do
  return sscanf_format(string_to_String(s), fmt, (function(x) do
                return x;
              end end));
end end

function unescaped(s) do
  return Curry._1(sscanf("\"" .. (s .. "\""), --[[ Format ]]{
                  --[[ Caml_string ]]Block.__(3, {
                      --[[ No_padding ]]0,
                      --[[ Flush ]]Block.__(10, {--[[ End_of_format ]]0})
                    }),
                  "%S%!"
                }), (function(x) do
                return x;
              end end));
end end

function kfscanf(ic, ef, fmt) do
  return kscanf(memo_from_ic(scan_raise_at_end, ic), ef, fmt);
end end

function fscanf(ic, fmt) do
  return kscanf(memo_from_ic(scan_raise_at_end, ic), scanf_bad_input, fmt);
end end

Scanning = {
  stdin = stdin,
  open_in = open_in,
  open_in_bin = open_in_bin,
  close_in = close_in,
  from_file = open_in,
  from_file_bin = open_in_bin,
  from_string = from_string,
  from_function = from_function,
  from_channel = from_channel,
  end_of_input = end_of_input,
  beginning_of_input = beginning_of_input,
  name_of_input = name_of_input,
  stdib = stdin
};

exports = {}
exports.Scanning = Scanning;
exports.Scan_failure = Scan_failure;
exports.bscanf = bscanf;
exports.sscanf = sscanf;
exports.scanf = scanf;
exports.kscanf = kscanf;
exports.ksscanf = ksscanf;
exports.bscanf_format = bscanf_format;
exports.sscanf_format = sscanf_format;
exports.format_from_string = format_from_string;
exports.unescaped = unescaped;
exports.fscanf = fscanf;
exports.kfscanf = kfscanf;
--[[ stdin Not a pure module ]]
