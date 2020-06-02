--[['use strict';]]

Curry = require "../../lib/js/curry.lua";
Caml_io = require "../../lib/js/caml_io.lua";
Caml_obj = require "../../lib/js/caml_obj.lua";
Caml_sys = require "../../lib/js/caml_sys.lua";
Caml_bytes = require "../../lib/js/caml_bytes.lua";
Caml_int64 = require "../../lib/js/caml_int64.lua";
Caml_format = require "../../lib/js/caml_format.lua";
Caml_string = require "../../lib/js/caml_string.lua";
Caml_exceptions = require "../../lib/js/caml_exceptions.lua";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";
CamlinternalFormatBasics = require "../../lib/js/camlinternalFormatBasics.lua";

function failwith(s) do
  throw [
        Caml_builtin_exceptions.failure,
        s
      ];
end end

function invalid_arg(s) do
  throw [
        Caml_builtin_exceptions.invalid_argument,
        s
      ];
end end

Exit = Caml_exceptions.create("Test_per.Exit");

function min(x, y) do
  if (Caml_obj.caml_lessequal(x, y)) then do
    return x;
  end else do
    return y;
  end end 
end end

function max(x, y) do
  if (Caml_obj.caml_greaterequal(x, y)) then do
    return x;
  end else do
    return y;
  end end 
end end

function abs(x) do
  if (x >= 0) then do
    return x;
  end else do
    return -x | 0;
  end end 
end end

function lnot(x) do
  return x ^ -1;
end end

min_int = -2147483648;

infinity = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]2146435072,
      --[[ lo ]]0
    ]);

neg_infinity = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]-1048576,
      --[[ lo ]]0
    ]);

nan = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]2146435072,
      --[[ lo ]]1
    ]);

max_float = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]2146435071,
      --[[ lo ]]4294967295
    ]);

min_float = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]1048576,
      --[[ lo ]]0
    ]);

epsilon_float = Caml_int64.float_of_bits(--[[ int64 ]][
      --[[ hi ]]1018167296,
      --[[ lo ]]0
    ]);

function $caret(s1, s2) do
  l1 = #s1;
  l2 = #s2;
  s = Caml_bytes.caml_create_bytes(l1 + l2 | 0);
  Caml_bytes.caml_blit_string(s1, 0, s, 0, l1);
  Caml_bytes.caml_blit_string(s2, 0, s, l1, l2);
  return s;
end end

function char_of_int(n) do
  if (n < 0 or n > 255) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "char_of_int"
        ];
  end
   end 
  return n;
end end

function string_of_bool(b) do
  if (b) then do
    return "true";
  end else do
    return "false";
  end end 
end end

function bool_of_string(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = "false" then do
        return false;end end end 
     if ___conditional___ = "true" then do
        return true;end end end 
     do
    else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "bool_of_string"
          ];
      end end
      
  end
end end

function string_of_int(n) do
  return Caml_format.caml_format_int("%d", n);
end end

function valid_float_lexem(s) do
  l = #s;
  _i = 0;
  while(true) do
    i = _i;
    if (i >= l) then do
      return $caret(s, ".");
    end else do
      match = Caml_string.get(s, i);
      if (match >= 48) then do
        if (match >= 58) then do
          return s;
        end else do
          _i = i + 1 | 0;
          continue ;
        end end 
      end else if (match ~= 45) then do
        return s;
      end else do
        _i = i + 1 | 0;
        continue ;
      end end  end 
    end end 
  end;
end end

function string_of_float(f) do
  return valid_float_lexem(Caml_format.caml_format_float("%.12g", f));
end end

function $at(l1, l2) do
  if (l1) then do
    return --[[ :: ]][
            l1[0],
            $at(l1[1], l2)
          ];
  end else do
    return l2;
  end end 
end end

stdin = Caml_io.stdin;

stdout = Caml_io.stdout;

stderr = Caml_io.stderr;

function open_out_gen(mode, perm, name) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_out")(Caml_external_polyfill.resolve("caml_sys_open")(name, mode, perm));
end end

function open_out(name) do
  return open_out_gen(--[[ :: ]][
              --[[ Open_wronly ]]1,
              --[[ :: ]][
                --[[ Open_creat ]]3,
                --[[ :: ]][
                  --[[ Open_trunc ]]4,
                  --[[ :: ]][
                    --[[ Open_text ]]7,
                    --[[ [] ]]0
                  ]
                ]
              ]
            ], 438, name);
end end

function open_out_bin(name) do
  return open_out_gen(--[[ :: ]][
              --[[ Open_wronly ]]1,
              --[[ :: ]][
                --[[ Open_creat ]]3,
                --[[ :: ]][
                  --[[ Open_trunc ]]4,
                  --[[ :: ]][
                    --[[ Open_binary ]]6,
                    --[[ [] ]]0
                  ]
                ]
              ]
            ], 438, name);
end end

function flush_all(param) do
  _param = Caml_io.caml_ml_out_channels_list(--[[ () ]]0);
  while(true) do
    param$1 = _param;
    if (param$1) then do
      try do
        Caml_io.caml_ml_flush(param$1[0]);
      end
      catch (exn)do
        
      end
      _param = param$1[1];
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function output_bytes(oc, s) do
  return Caml_io.caml_ml_output(oc, s, 0, #s);
end end

function output_string(oc, s) do
  return Caml_io.caml_ml_output(oc, s, 0, #s);
end end

function output(oc, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "output"
        ];
  end
   end 
  return Caml_io.caml_ml_output(oc, s, ofs, len);
end end

function output_substring(oc, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "output_substring"
        ];
  end
   end 
  return Caml_io.caml_ml_output(oc, s, ofs, len);
end end

function output_value(chan, v) do
  return Caml_external_polyfill.resolve("caml_output_value")(chan, v, --[[ [] ]]0);
end end

function close_out(oc) do
  Caml_io.caml_ml_flush(oc);
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
end end

function close_out_noerr(oc) do
  try do
    Caml_io.caml_ml_flush(oc);
  end
  catch (exn)do
    
  end
  try do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
  end
  catch (exn$1)do
    return --[[ () ]]0;
  end
end end

function open_in_gen(mode, perm, name) do
  return Caml_external_polyfill.resolve("caml_ml_open_descriptor_in")(Caml_external_polyfill.resolve("caml_sys_open")(name, mode, perm));
end end

function open_in(name) do
  return open_in_gen(--[[ :: ]][
              --[[ Open_rdonly ]]0,
              --[[ :: ]][
                --[[ Open_text ]]7,
                --[[ [] ]]0
              ]
            ], 0, name);
end end

function open_in_bin(name) do
  return open_in_gen(--[[ :: ]][
              --[[ Open_rdonly ]]0,
              --[[ :: ]][
                --[[ Open_binary ]]6,
                --[[ [] ]]0
              ]
            ], 0, name);
end end

function input(ic, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "input"
        ];
  end
   end 
  return Caml_external_polyfill.resolve("caml_ml_input")(ic, s, ofs, len);
end end

function unsafe_really_input(ic, s, _ofs, _len) do
  while(true) do
    len = _len;
    ofs = _ofs;
    if (len <= 0) then do
      return --[[ () ]]0;
    end else do
      r = Caml_external_polyfill.resolve("caml_ml_input")(ic, s, ofs, len);
      if (r == 0) then do
        throw Caml_builtin_exceptions.end_of_file;
      end
       end 
      _len = len - r | 0;
      _ofs = ofs + r | 0;
      continue ;
    end end 
  end;
end end

function really_input(ic, s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "really_input"
        ];
  end
   end 
  return unsafe_really_input(ic, s, ofs, len);
end end

function really_input_string(ic, len) do
  s = Caml_bytes.caml_create_bytes(len);
  really_input(ic, s, 0, len);
  return s;
end end

function input_line(chan) do
  build_result = function (buf, _pos, _param) do
    while(true) do
      param = _param;
      pos = _pos;
      if (param) then do
        hd = param[0];
        len = #hd;
        Caml_bytes.caml_blit_string(hd, 0, buf, pos - len | 0, len);
        _param = param[1];
        _pos = pos - len | 0;
        continue ;
      end else do
        return buf;
      end end 
    end;
  end end;
  _accu = --[[ [] ]]0;
  _len = 0;
  while(true) do
    len = _len;
    accu = _accu;
    n = Caml_external_polyfill.resolve("caml_ml_input_scan_line")(chan);
    if (n == 0) then do
      if (accu) then do
        return build_result(Caml_bytes.caml_create_bytes(len), len, accu);
      end else do
        throw Caml_builtin_exceptions.end_of_file;
      end end 
    end else if (n > 0) then do
      res = Caml_bytes.caml_create_bytes(n - 1 | 0);
      Caml_external_polyfill.resolve("caml_ml_input")(chan, res, 0, n - 1 | 0);
      Caml_external_polyfill.resolve("caml_ml_input_char")(chan);
      if (accu) then do
        len$1 = (len + n | 0) - 1 | 0;
        return build_result(Caml_bytes.caml_create_bytes(len$1), len$1, --[[ :: ]][
                    res,
                    accu
                  ]);
      end else do
        return res;
      end end 
    end else do
      beg = Caml_bytes.caml_create_bytes(-n | 0);
      Caml_external_polyfill.resolve("caml_ml_input")(chan, beg, 0, -n | 0);
      _len = len - n | 0;
      _accu = --[[ :: ]][
        beg,
        accu
      ];
      continue ;
    end end  end 
  end;
end end

function close_in_noerr(ic) do
  try do
    return Caml_external_polyfill.resolve("caml_ml_close_channel")(ic);
  end
  catch (exn)do
    return --[[ () ]]0;
  end
end end

function print_char(c) do
  return Caml_io.caml_ml_output_char(stdout, c);
end end

function print_string(s) do
  return output_string(stdout, s);
end end

function print_bytes(s) do
  return output_bytes(stdout, s);
end end

function print_int(i) do
  return output_string(stdout, Caml_format.caml_format_int("%d", i));
end end

function print_float(f) do
  return output_string(stdout, valid_float_lexem(Caml_format.caml_format_float("%.12g", f)));
end end

function print_endline(s) do
  output_string(stdout, s);
  Caml_io.caml_ml_output_char(stdout, --[[ "\n" ]]10);
  return Caml_io.caml_ml_flush(stdout);
end end

function print_newline(param) do
  Caml_io.caml_ml_output_char(stdout, --[[ "\n" ]]10);
  return Caml_io.caml_ml_flush(stdout);
end end

function prerr_char(c) do
  return Caml_io.caml_ml_output_char(stderr, c);
end end

function prerr_string(s) do
  return output_string(stderr, s);
end end

function prerr_bytes(s) do
  return output_bytes(stderr, s);
end end

function prerr_int(i) do
  return output_string(stderr, Caml_format.caml_format_int("%d", i));
end end

function prerr_float(f) do
  return output_string(stderr, valid_float_lexem(Caml_format.caml_format_float("%.12g", f)));
end end

function prerr_endline(s) do
  output_string(stderr, s);
  Caml_io.caml_ml_output_char(stderr, --[[ "\n" ]]10);
  return Caml_io.caml_ml_flush(stderr);
end end

function prerr_newline(param) do
  Caml_io.caml_ml_output_char(stderr, --[[ "\n" ]]10);
  return Caml_io.caml_ml_flush(stderr);
end end

function read_line(param) do
  Caml_io.caml_ml_flush(stdout);
  return input_line(stdin);
end end

function read_int(param) do
  return Caml_format.caml_int_of_string((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end end

function read_float(param) do
  return Caml_format.caml_float_of_string((Caml_io.caml_ml_flush(stdout), input_line(stdin)));
end end

LargeFile = { };

function string_of_format(param) do
  return param[1];
end end

function $caret$caret(param, param$1) do
  return --[[ Format ]][
          CamlinternalFormatBasics.concat_fmt(param[0], param$1[0]),
          $caret(param[1], $caret("%,", param$1[1]))
        ];
end end

exit_function = do
  contents: flush_all
end;

function at_exit(f) do
  g = exit_function[0];
  exit_function[0] = (function (param) do
      Curry._1(f, --[[ () ]]0);
      return Curry._1(g, --[[ () ]]0);
    end end);
  return --[[ () ]]0;
end end

function do_at_exit(param) do
  return Curry._1(exit_function[0], --[[ () ]]0);
end end

function exit(retcode) do
  Curry._1(exit_function[0], --[[ () ]]0);
  return Caml_sys.caml_sys_exit(retcode);
end end

max_int = 2147483647;

exports.failwith = failwith;
exports.invalid_arg = invalid_arg;
exports.Exit = Exit;
exports.min = min;
exports.max = max;
exports.abs = abs;
exports.lnot = lnot;
exports.max_int = max_int;
exports.min_int = min_int;
exports.infinity = infinity;
exports.neg_infinity = neg_infinity;
exports.nan = nan;
exports.max_float = max_float;
exports.min_float = min_float;
exports.epsilon_float = epsilon_float;
exports.$caret = $caret;
exports.char_of_int = char_of_int;
exports.string_of_bool = string_of_bool;
exports.bool_of_string = bool_of_string;
exports.string_of_int = string_of_int;
exports.valid_float_lexem = valid_float_lexem;
exports.string_of_float = string_of_float;
exports.$at = $at;
exports.stdin = stdin;
exports.stdout = stdout;
exports.stderr = stderr;
exports.open_out_gen = open_out_gen;
exports.open_out = open_out;
exports.open_out_bin = open_out_bin;
exports.flush_all = flush_all;
exports.output_bytes = output_bytes;
exports.output_string = output_string;
exports.output = output;
exports.output_substring = output_substring;
exports.output_value = output_value;
exports.close_out = close_out;
exports.close_out_noerr = close_out_noerr;
exports.open_in_gen = open_in_gen;
exports.open_in = open_in;
exports.open_in_bin = open_in_bin;
exports.input = input;
exports.unsafe_really_input = unsafe_really_input;
exports.really_input = really_input;
exports.really_input_string = really_input_string;
exports.input_line = input_line;
exports.close_in_noerr = close_in_noerr;
exports.print_char = print_char;
exports.print_string = print_string;
exports.print_bytes = print_bytes;
exports.print_int = print_int;
exports.print_float = print_float;
exports.print_endline = print_endline;
exports.print_newline = print_newline;
exports.prerr_char = prerr_char;
exports.prerr_string = prerr_string;
exports.prerr_bytes = prerr_bytes;
exports.prerr_int = prerr_int;
exports.prerr_float = prerr_float;
exports.prerr_endline = prerr_endline;
exports.prerr_newline = prerr_newline;
exports.read_line = read_line;
exports.read_int = read_int;
exports.read_float = read_float;
exports.LargeFile = LargeFile;
exports.string_of_format = string_of_format;
exports.$caret$caret = $caret$caret;
exports.exit_function = exit_function;
exports.at_exit = at_exit;
exports.do_at_exit = do_at_exit;
exports.exit = exit;
--[[ No side effect ]]
